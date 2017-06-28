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

#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QtWidgets>
#include <QCursor>
#include <qprocess.h>
#include <QDialog>
#include <QDesktopWidget>

#include <stdlib.h>
#include <getopt.h>
#include <pthread.h>

#include "video.h"


#define RELEASE_VERSION "2015.4"

#define MAX_TEXT "Max"
#define MIN_TEXT "Min"

#define CURSOR_INACTIVITY_TIME_MSEC 5000

#define PIXMAP_INDEX_ZYNQ 6
#define PIXMAP_OFFSET_EXT 3

#define LAYER0_X_POS 0
#define LAYER0_Y_POS 0

#define LAYER0_TRANSPARENCY 0
#define TRANSPARENCY_FACTOR 3


namespace Ui
{
	class MainWindow;
}

/** Main application class where the ZYNQ HMI functionality is connected in a simple application*/
class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	explicit MainWindow(QWidget *parent = 0, bool apm_enable = true, int pr_enable = 0);
	~MainWindow();

private slots:
	// GUI Transparency
	void on_sliderGuiTransparency_valueChanged(int);

	// Video Controls
	void on_radioButtonVideoControlsOff_clicked(bool checked);
	void on_radioButtonVideoControlsOn_clicked(bool checked);
	void on_radioButtonVideoControlsAuto_clicked(bool checked);

	// Video Source
	void on_comboBoxVideoSource_currentIndexChanged(int);

	// Test Pattern
	void on_comboBoxTestPattern_currentIndexChanged(int);

	// Filter Type
	void on_comboBoxFilterType_currentIndexChanged(int);

	// Filter Mode
	void on_radioButtonFilterModeOff_clicked(bool checked);
	void on_radioButtonFilterModeSw_clicked(bool checked);
	void on_radioButtonFilterModeHw_clicked(bool checked);

	// Sobel Controls
	void on_checkBoxSobelControlsInvert_clicked(bool checked);
	void on_sliderSobelControlsThreshold_valueChanged(int);

	// Misc Buttons
	void on_pushButtonMinMax_clicked();

	// Others
	void CheckCursorActivity();

private:
	QCursor *cursor;
	QTimer *checkCursorTimer;
	QPoint cursorPos;
	QVector<QString> pixmapVec;

	video_ctrl videoCtrl;
	vlib_config config;

	pthread_t autoloop;

	bool apm_enable;
	int pr_enable;
	bool isAppStateMaximized; // Max: 1, Min:0

	int iWindowHeightInMinMode; // Window height in minimized mode
	int iWindowHeightInMaxMode; // Window height in maximized mode

	Ui::MainWindow *ui;

protected:
	//Override mouse events to detect any mouse activity
	void mouseMoveEvent(QMouseEvent * event);
	void closeEvent(QCloseEvent* event);
};

#endif // MAINWINDOW_H
