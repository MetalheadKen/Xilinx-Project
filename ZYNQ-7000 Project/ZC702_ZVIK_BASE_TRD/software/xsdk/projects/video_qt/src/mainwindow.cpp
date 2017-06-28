/*
   (c) Copyright 2012  Xylon d.o.o.

   This file is subject to the terms and conditions of the MIT License:

   Permission is hereby granted, free of charge, to any person
   obtaining a copy of this software and associated documentation
   files (the "Software"), to deal in the Software without restriction,
   including without limitation the rights to use, copy, modify, merge,
   publish, distribute, sublicense, and/or sell copies of the Software,
   and to permit persons to whom the Software is furnished to do so,
   subject to the following conditions:

   The above copyright notice and this permission notice shall be
   included in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#include <unistd.h>
#include <errno.h>

#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "perfmon.h"
#include "filter.h"

//Macros Definition
#define CURSOR_TIMER_INTERVAL 500

//Default GUI win.
#define APP_HEIGHT_1920_MAX 300
#define APP_HEIGHT_1920_MIN  80

//Auto Mode
#define AUTO_MODE_SLEEP_TIME 2

MainWindow::MainWindow(QWidget *parent, bool apm_enable, int pr_enable) :
	QMainWindow(parent),
	apm_enable(apm_enable),
	pr_enable(pr_enable),
	ui(new Ui::MainWindow)
{
	int iret;
	int i, j;
	int height = vlib_get_active_height();

	iWindowHeightInMinMode = APP_HEIGHT_1920_MIN;
	iWindowHeightInMaxMode = APP_HEIGHT_1920_MAX;

	// Populate pixmap vector with the names of pixmap to attached GUI Label
	// using QT Resource file
	pixmapVec.push_back(":/zynq/images/TPG_Sobel_off.png"); //Index 0
	pixmapVec.push_back(":/zynq/images/TPG_software_sobel.png");
	pixmapVec.push_back(":/zynq/images/TPG_Hardware_sobel.png");
	pixmapVec.push_back(":/zynq/images/ExternalVideo_Sobel_off.png");
	pixmapVec.push_back(":/zynq/images/ExternalVideo_software_sobel.png");
	pixmapVec.push_back(":/zynq/images/ExternalVideo_Hardware_sobel.png");
	pixmapVec.push_back(":/zynq/images/default.png");

	// Splash screen show the default Zynq image located in images directory.
	QSplashScreen splash(QPixmap(pixmapVec.at(PIXMAP_INDEX_ZYNQ)));
	QRect rect = splash.geometry();
	splash.setGeometry(rect);
	splash.show();
	sleep(3);

	ui->setupUi(this);

	QWidget::setWindowFlags(Qt::FramelessWindowHint);

	//splash.finish(this);

	if (apm_enable) {
		/* Initialize perf-mon */
		iret = perf_monitor_init();
		if (iret != EXIT_SUCCESS) {
			printf("TRD :: perfmon_init failed\n");
			exit(EXIT_FAILURE);
		}
	} else {
		printf("TRD :: Skip AXI Performance monitoring\n");
	}

	vlib_drm_set_layer0_position (LAYER0_X_POS, height-this->height());

	/* set the cursor on top of window */
	cursor = new QCursor();
	cursor->setPos(0, 0);
	this->setCursor(*cursor);
	checkCursorTimer = new QTimer();

	/* Try to put cursor always on viewable area.*/
	connect(checkCursorTimer, SIGNAL(timeout()), this, SLOT(CheckCursorActivity()));
	checkCursorTimer->start(CURSOR_TIMER_INTERVAL);

	// Enable mouse move tracking
	setMouseTracking(true);
	centralWidget()->setMouseTracking(true);

	// By default app will be in maximized state.
	isAppStateMaximized = true;

	// Set the TRD application release version.
	ui->labelBaseTrdReleaseVersion->setText(RELEASE_VERSION);

	// Video Source
	ui->groupBoxVideoSource->setEnabled(false);
	ui->comboBoxVideoSource->blockSignals(true);
	for (i = 0, j = 0; i < VIDEO_SRC_CNT; i++) {
		if (vlib_video_src_get_enabled((video_src) i)) {
			ui->comboBoxVideoSource->addItem(QString::fromUtf8(vlib_video_src_display_text((video_src) i)));
			vlib_video_src_set_index((video_src) i, j++);
		}
	}
	ui->comboBoxVideoSource->setCurrentIndex(vlib_video_src_get_index(VIDEO_SRC_TPG));
	ui->comboBoxVideoSource->blockSignals(false);

	// Test Pattern
	ui->groupBoxTestPattern->setEnabled(false);
	ui->comboBoxTestPattern->blockSignals(true);
	// start with i=1 to omit passthrough
	for (i = 1; i < TPG_TEST_PATTERN_CNT; i++)
		ui->comboBoxTestPattern->addItem(QString::fromUtf8(vlib_tpg_get_pattern_menu_name(i)));
	ui->comboBoxTestPattern->setCurrentIndex(TPG_TEST_PATTERN_DEFAULT-1);
	ui->comboBoxTestPattern->blockSignals(false);
	vlib_tpg_set_pattern(TPG_TEST_PATTERN_DEFAULT);

	// Filter Type
	ui->groupBoxFilterType->setEnabled(false);
	ui->comboBoxFilterType->blockSignals(true);
	for (i = 0, j = 0; i < FILTER_TYPE_CNT; i++) {
		if (filter_type_is_static((filter_type) i) || pr_enable) {
			ui->comboBoxFilterType->addItem(QString::fromUtf8(filter_type_display_text((filter_type) i)));
			filter_type_set_index((filter_type) i, j++);
		}
	}
	ui->comboBoxFilterType->setCurrentIndex(filter_type_get_index(FILTER_TYPE_SOBEL));
	ui->comboBoxFilterType->blockSignals(false);

	// Filter Mode
	ui->groupBoxFilterMode->setEnabled(false);
	ui->radioButtonFilterModeOff->setChecked(true);

	// Sobel Controls
	ui->groupBoxSobelControls->setEnabled(false);
	ui->labelSobelControlsThreshold->setText(QString::number(HLS_SOBEL_HIGH_THRESH_VAL));
	ui->sliderSobelControlsThreshold->setValue(HLS_SOBEL_HIGH_THRESH_VAL);
	if(HLS_SOBEL_INVERT_VAL)
		ui->checkBoxSobelControlsInvert->setChecked(true);
	else
		ui->checkBoxSobelControlsInvert->setChecked(false);

	// set new state
	videoCtrl = VIDEO_CTRL_OFF;
	config.src = VIDEO_SRC_TPG;
	config.type = FILTER_TYPE_SOBEL;
	config.mode = FILTER_MODE_OFF;

	// Set the default images on display panels.
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(PIXMAP_INDEX_ZYNQ)));
	ui->labelLogoDisplay->setPixmap(QPixmap(pixmapVec.at(PIXMAP_INDEX_ZYNQ)));

	// CPU Plot
	ui->plotCpu->cpu1Label = ui->labelPerformanceCpu0Val;
	ui->plotCpu->cpu2Label = ui->labelPerformanceCpu1Val;

	// Memory Plot
	ui->plotMemory->hpPort0 = ui->labelPerformanceHp0Val;
	ui->plotMemory->hpPort2 = ui->labelPerformanceHp2Val;
}

MainWindow::~MainWindow()
{
	checkCursorTimer->stop();
	delete checkCursorTimer;
	delete cursor;
	delete ui;
}

//Invoked when video controls On is clicked
void MainWindow::on_radioButtonVideoControlsOn_clicked(bool checked)
{
	if (!checked || videoCtrl == VIDEO_CTRL_ON)
		return;

	// stop autoloop
	if (videoCtrl == VIDEO_CTRL_AUTO && autoloop != 0) {
		pthread_cancel(autoloop);
		pthread_join(autoloop, NULL);
		autoloop = 0;
	}

	// set new state
	videoCtrl = VIDEO_CTRL_ON;

	// configure and start video pipeline
	vlib_change_mode(config);

	// update UI
	ui->groupBoxVideoSource->setEnabled(true);
	if (config.src == VIDEO_SRC_TPG)
		ui->groupBoxTestPattern->setEnabled(true);
	ui->groupBoxFilterType->setEnabled(true);
	ui->groupBoxFilterMode->setEnabled(true);
	if (config.type == FILTER_TYPE_SOBEL && config.mode != FILTER_MODE_OFF)
		ui->groupBoxSobelControls->setEnabled(true);
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(
			config.src * PIXMAP_OFFSET_EXT + config.mode)));
}

//Invoked when video controls Off is clicked
void MainWindow::on_radioButtonVideoControlsOff_clicked(bool checked)
{
	if (!checked || videoCtrl == VIDEO_CTRL_OFF)
		return;

	// stop autoloop
	if (videoCtrl == VIDEO_CTRL_AUTO && autoloop != 0) {
		pthread_cancel(autoloop);
		pthread_join(autoloop, NULL);
		autoloop = 0;
	}

	// set new state
	videoCtrl = VIDEO_CTRL_OFF;

	// stop video pipeline
	vlib_pipeline_stop();

	// update UI
	ui->groupBoxVideoSource->setEnabled(false);
	ui->groupBoxTestPattern->setEnabled(false);
	ui->groupBoxFilterType->setEnabled(false);
	ui->groupBoxFilterMode->setEnabled(false);
	ui->groupBoxSobelControls->setEnabled(false);
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(PIXMAP_INDEX_ZYNQ)));
}

static void *autoloop_fptr(void *ptr)
{
	unsigned int i, j;
	int ret;
	vlib_config config;
	int pr_enable = *((int *) ptr);

	while (1) {
		for (i = 0; i < VIDEO_SRC_CNT; i++) {
			if (vlib_video_src_get_enabled((video_src) i))
				config.src = (video_src) i;
			else
				continue;

			config.type = (filter_type) 0;
			config.mode = FILTER_MODE_OFF;
			ret = vlib_change_mode(config);
			if (ret)
				continue;

			sleep(AUTO_MODE_SLEEP_TIME);

			for (j = 0; j < FILTER_TYPE_CNT; j++) {
				if (filter_type_is_static((filter_type) j) || pr_enable)
					config.type = (filter_type) j;
				else
					continue;

				config.mode = FILTER_MODE_HW;
				vlib_change_mode(config);
				sleep(AUTO_MODE_SLEEP_TIME);
			}
		}
	}
	return NULL;
};

//Invoked when video controls Auto is clicked
void MainWindow::on_radioButtonVideoControlsAuto_clicked(bool checked)
{
	if (!checked || videoCtrl == VIDEO_CTRL_AUTO)
		return;

	// set new state
	videoCtrl = VIDEO_CTRL_AUTO;

	// update UI
	ui->groupBoxVideoSource->setEnabled(false);
	ui->groupBoxTestPattern->setEnabled(false);
	ui->groupBoxFilterType->setEnabled(false);
	ui->groupBoxFilterMode->setEnabled(false);
	ui->groupBoxSobelControls->setEnabled(false);
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(PIXMAP_INDEX_ZYNQ)));

	// create new thread that cycles through selected options
	pthread_create(&autoloop, NULL, autoloop_fptr, (void *) &pr_enable);
}

//Invoked if video source is changed
void MainWindow::on_comboBoxVideoSource_currentIndexChanged(int index)
{
	video_src src = config.src;
	config.src = vlib_video_src_from_index(index);

	// configure and start video pipeline
	int ret = vlib_change_mode(config);
	if (ret == VLIB_ERROR) {
		printf("Video Input Warning\n");

		config.src = src;
		ui->comboBoxVideoSource->blockSignals(true);
		ui->comboBoxVideoSource->setCurrentIndex(vlib_video_src_get_index(config.src));
		ui->comboBoxVideoSource->blockSignals(false);

		// switch to maximized mode to show message
		if(ui->pushButtonMinMax->text().compare(MIN_TEXT) != 0)
			on_pushButtonMinMax_clicked();

		// display pop-up message box
		QString msgBoxHeader = "Warning";
		QString warnContent = "Video input not supported.\n"
							  "Check if source is powered and connected.\n"
							  "Check if input resolution and stride are supported.\n"
							  "Continue with previous mode.";
		QMessageBox mb(msgBoxHeader, warnContent,
					   QMessageBox::Warning,
					   QMessageBox::Default,
					   QMessageBox::Ok,
					   QMessageBox::Escape);
		mb.setGeometry(500,110,100,100);
		mb.exec();

		return;
	}

	// update UI
	if (config.src == VIDEO_SRC_TPG)
		ui->groupBoxTestPattern->setEnabled(true);
	else
		ui->groupBoxTestPattern->setEnabled(false);
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(
			config.src * PIXMAP_OFFSET_EXT + config.mode)));
}

//Invoked if test pattern is changed
void MainWindow::on_comboBoxTestPattern_currentIndexChanged(int index)
{
	// set index+1 since passthrough pattern is omitted
	vlib_tpg_set_pattern(index+1);
}

//Invoked if filter type is changed
void MainWindow::on_comboBoxFilterType_currentIndexChanged(int index)
{
	filter_type type = config.type;
	config.type = filter_type_from_index(index);

	// don't reconfigure pipeline if filter mode is off
	if (config.mode == FILTER_MODE_OFF)
		return;

	// check if hw filter module is available
	if (config.mode == FILTER_MODE_HW) {
		// restore previous filter type
		if (pr_enable && filter_type_pr_buf(config.type) == NULL) {
			printf("HW module for filter '%s' not available\n",
				   filter_type_display_text(config.type));

			config.type = type;
			ui->comboBoxFilterType->blockSignals(true);
			ui->comboBoxFilterType->setCurrentIndex(filter_type_get_index(config.type));
			ui->comboBoxFilterType->blockSignals(false);

			// switch to maximized mode to show message
			if(ui->pushButtonMinMax->text().compare(MIN_TEXT) != 0)
				on_pushButtonMinMax_clicked();

			// display pop-up message box
			QString msgBoxHeader = "Warning";
			QString warnContent = "No hardware filter module found for current selection.\n"
								  "Continue with previous mode.";
			QMessageBox mb(msgBoxHeader, warnContent,
						   QMessageBox::Warning,
						   QMessageBox::Default,
						   QMessageBox::Ok,
						   QMessageBox::Escape);
			mb.setGeometry(800,110,100,100);
			mb.exec();

			return;
		}
	}

	// enable sobel controls if sobel filter is selected
	if (config.type == FILTER_TYPE_SOBEL)
		ui->groupBoxSobelControls->setEnabled(true);
	else
		ui->groupBoxSobelControls->setEnabled(false);

	// configure and start video pipeline
	vlib_change_mode(config);
}

//Invoked if filter mode is off
void MainWindow::on_radioButtonFilterModeOff_clicked(bool checked)
{
	if (!checked || config.mode == FILTER_MODE_OFF)
		return;

	// set new mode
	config.mode = FILTER_MODE_OFF;

	// configure and start video pipeline
	vlib_change_mode(config);

	// update UI
	ui->groupBoxSobelControls->setEnabled(false);
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(
			config.src * PIXMAP_OFFSET_EXT + config.mode)));
}


//Invoked if filter mode is sw
void MainWindow::on_radioButtonFilterModeSw_clicked(bool checked)
{
	if (!checked || config.mode == FILTER_MODE_SW)
		return;

	// set new mode
	config.mode = FILTER_MODE_SW;

	// configure and start video pipeline
	vlib_change_mode(config);
	if (config.type == FILTER_TYPE_SOBEL)
		ui->groupBoxSobelControls->setEnabled(true);

	// update UI
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(
			config.src * PIXMAP_OFFSET_EXT + config.mode)));
}


//Invoked if filter mode is hw
void MainWindow::on_radioButtonFilterModeHw_clicked(bool checked)
{
	if(!checked || config.mode == FILTER_MODE_HW)
		return;

	// set new mode
	filter_mode mode = config.mode;
	config.mode = FILTER_MODE_HW;

	// restore previous filter type
	if (pr_enable && filter_type_pr_buf(config.type) == NULL) {
		printf("HW module for filter '%s' not available\n",
			   filter_type_display_text(config.type));

		config.mode = mode;
		if (config.mode == FILTER_MODE_SW)
			ui->radioButtonFilterModeSw->setChecked(true);
		if (config.mode == FILTER_MODE_OFF)
			ui->radioButtonFilterModeOff->setChecked(true);

		// switch to maximized mode to show message
		if(ui->pushButtonMinMax->text().compare(MIN_TEXT) != 0)
			on_pushButtonMinMax_clicked();

		// display pop-up message box
		QString msgBoxHeader = "Warning";
		QString warnContent = "No hardware filter module found for current selection";
		QMessageBox mb(msgBoxHeader, warnContent,
					   QMessageBox::Warning,
					   QMessageBox::Default,
					   QMessageBox::Ok,
					   QMessageBox::Escape);
		mb.setGeometry(800,110,100,100);
		mb.exec();

		return;
	}

	// configure and start video pipeline
	vlib_change_mode(config);
	if (config.type == FILTER_TYPE_SOBEL)
		ui->groupBoxSobelControls->setEnabled(true);

	// update UI
	ui->labelDataFlowDisplay->setPixmap(QPixmap(pixmapVec.at(
			config.src * PIXMAP_OFFSET_EXT + config.mode)));
}

//called when the timer expires every 500 msec
void MainWindow::CheckCursorActivity()
{
	QPoint cursorCoords = this->mapFromGlobal(QCursor::pos());

	//Reset the cursor position if out of sync ie if user try to move the
	//mouse below the application display area , it just a hack to keep cursor always
	// in a viewable area.
	if(isAppStateMaximized && cursorCoords.y() >= iWindowHeightInMaxMode-10)
		cursor->setPos(cursorCoords.x(), iWindowHeightInMaxMode-10);

	if(!isAppStateMaximized && cursorCoords.y() >= iWindowHeightInMinMode-10)
		cursor->setPos(cursorCoords.x(), iWindowHeightInMinMode-10);

	//Update the current cursor position.
	this->setCursor(*cursor);
	cursorPos = cursorCoords;
}

//Invokes when transparency slider is moved.
void MainWindow::on_sliderGuiTransparency_valueChanged(int ival)
{
	int itransparencyVal=ival;

	ui->labelGuiTransparency->setText(QString::number(itransparencyVal));
	// Convert the GUI alpha range (0-50) to range (0-150)
	itransparencyVal = ival * TRANSPARENCY_FACTOR;
	vlib_drm_set_layer0_transparency(itransparencyVal);
}

//Invoked when Mainwindow is minimized or maximized
void MainWindow::on_pushButtonMinMax_clicked()
{
	int iscreenHeight=vlib_get_active_height();

	if((ui->pushButtonMinMax->text().compare(MIN_TEXT))==0) {
		//If current app state is to be minimized .
		vlib_drm_set_layer0_position (LAYER0_X_POS,iscreenHeight-iWindowHeightInMinMode);
		//Assuming X pixels is height of window in minimized mode.
		ui->pushButtonMinMax->setText(MAX_TEXT);
		isAppStateMaximized=false;
	} else {
		//currently application was maximized
		//Assuming X pixels is height of window in maximized mode.
		vlib_drm_set_layer0_position (LAYER0_X_POS,iscreenHeight-iWindowHeightInMaxMode);
		ui->pushButtonMinMax->setText(MIN_TEXT);
		isAppStateMaximized=true;
	}
}

//For handling window close event .
void MainWindow::closeEvent(QCloseEvent *event)
{
	/* Stop the video pipeline */
	vlib_pipeline_stop();
	vlib_drm_set_layer0_position(LAYER0_X_POS,LAYER0_Y_POS);
	vlib_drm_set_layer0_transparency(LAYER0_TRANSPARENCY);
	vlib_drm_uninit();
	vlib_uninit();
	if (apm_enable)
		perf_monitor_deinit();
	(void) event;
}

//Invoked on every mouse move.Monitor cursor position , If cursor reaches near any non-viewable
//area it is moved back to viewable area
void MainWindow::mouseMoveEvent(__attribute__((unused))QMouseEvent *event)
{
	QPoint cursorCoords;
	/* Get central widget cursor position coordinates */
	cursorCoords = this->mapFromGlobal(QCursor::pos());

	//Check if QT application is in maximized state
	if(isAppStateMaximized) {
		//If cursor position goes below the viewable area
		// bring it back.
		if(cursorCoords.y() >=iWindowHeightInMaxMode-10)
			cursor->setPos(cursorCoords.x(),iWindowHeightInMaxMode-10);
	} else {
		//If cursor position goes below the viewable area
		// bring it back.
		if(cursorCoords.y() >= iWindowHeightInMinMode-10)
			cursor->setPos(cursorCoords.x(),iWindowHeightInMinMode-10);
	}

	//Update the cursor position.
	this->setCursor(*cursor);
}

void MainWindow::on_checkBoxSobelControlsInvert_clicked(bool checked)
{
	if(ui->radioButtonFilterModeSw->isChecked() || ui->radioButtonFilterModeHw->isChecked())
		v4l2_sobel_invert(checked);
}

void MainWindow::on_sliderSobelControlsThreshold_valueChanged(int val)
{
	if(ui->radioButtonFilterModeSw->isChecked() || ui->radioButtonFilterModeHw->isChecked()) {
		v4l2_sobel_thresh(val, HLS_SOBEL_LOW_THRESH_VAL);
		ui->labelSobelControlsThreshold->setText(QString::number(val));
	}
}
