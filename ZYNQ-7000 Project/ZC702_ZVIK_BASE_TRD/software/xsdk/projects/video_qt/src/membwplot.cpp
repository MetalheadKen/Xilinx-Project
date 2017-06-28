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
#include <qapplication.h>
#include <qlayout.h>
#include <qlabel.h>
#include <qdatetime.h>
#include <qpainter.h>
#include<qstring.h>
#include <qwt_plot_layout.h>
#include <qwt_plot_curve.h>
#include <qwt_scale_draw.h>
#include <qwt_scale_widget.h>
#include <qwt_legend.h>
#include <qwt_plot_canvas.h>
#include "perfmon.h"
#include "membwplot.h" 

#define MAX_MEMORY_BANDWITH_GB_S 10

class TimeScaleDraw: public QwtScaleDraw
{
public:
    TimeScaleDraw(const QTime &base):
        baseTime(base)
    {
    }
    virtual QwtText label(double v) const
    {
        QTime upTime = baseTime.addSecs((int)v);
        return upTime.toString();
    }
private:
    QTime baseTime;
};

class MemBackground: public QwtPlotItem
{
public:
    MemBackground()
    {
        setZ(0.0);
    }

    virtual int rtti() const
    {
        return QwtPlotItem::Rtti_PlotUserItem;
    }

    virtual void draw(QPainter *painter,
        const QwtScaleMap &, const QwtScaleMap &yMap,
        const QRectF &rect) const
    {
        QColor c(Qt::green);
        QRectF r = rect;
        for ( int i = MAX_MEMORY_BANDWITH_GB_S+1; i >= 0; i -= 1 )
        {
            if ((i == MAX_MEMORY_BANDWITH_GB_S) || (i == 0))
                painter->setPen(Qt::DashLine);
            else
                painter->setPen(Qt::DotLine);
            r.setBottom(yMap.transform(i - 10));
            r.setTop(yMap.transform(i));
            painter->fillRect(r, c);
            painter->drawLine(r.x(), yMap.transform(i), r.x()+r.width(), yMap.transform(i));
            c = c.darker(105);
        }
    }
};

class MemCurve: public QwtPlotCurve
{
public:
    MemCurve(const QString &title):
        QwtPlotCurve(title)
    {
        setRenderHint(QwtPlotItem::RenderAntialiased);
    }

    void setColor(const QColor &color)
    {
        QColor c = color;
        QPen pen = QPen(c);
        pen.setWidth(2);
        pen.setJoinStyle(Qt::RoundJoin);
        c.setAlpha(150);
        setPen(pen);
        //setBrush(c);
    }
};

MemBwPlot::MemBwPlot(QWidget *parent):
    QwtPlot(parent),
    dataCount(0)
{
    QwtPlotCanvas *pPlotCanvas = (QwtPlotCanvas*)canvas();
    setAutoReplot(false);
    pPlotCanvas->setBorderRadius( 10 );
    plotLayout()->setAlignCanvasToScales(false);
    QwtLegend *legend = new QwtLegend;
//    legend->setItemMode(QwtLegend::CheckableItem);
    insertLegend(legend, QwtPlot::BottomLegend);

    enableAxis( QwtPlot::xBottom, false );
    QwtScaleWidget *scaleWidget = axisWidget(QwtPlot::xBottom);
    const int fmh = QFontMetrics(scaleWidget->font()).height();
    scaleWidget->setMinBorderDist(0, fmh / 2);

    setAxisScale(QwtPlot::yLeft, 0, MAX_MEMORY_BANDWITH_GB_S);
    MemBackground *bg = new MemBackground();
    bg->attach(this);

    MemCurve *curve;

    curve = new MemCurve("HP Port 0 [Gb/s]");
    curve->setColor(Qt::red);
    curve->setZ(curve->z() - 1);
    curve->attach(this);
    data[MemBw1].curve = curve;

    curve = new MemCurve("HP Port 2 [Gb/s]");
    curve->setColor(Qt::yellow);
    curve->setZ(curve->z() - 1);
    curve->attach(this);
    data[MemBw2].curve = curve;

    showCurve(data[MemBw1].curve, true);
    showCurve(data[MemBw2].curve, true);

    for ( int i = 0; i < HISTORY; i++ )
        timeData[HISTORY - 1 - i] = i;

    (void)startTimer(1000); // 1 second
}

void MemBwPlot::timerEvent(QTimerEvent *)
{
    /* move the previous samples values up in the array,
       sample 0 is always the newest one  */
    for ( int i = dataCount; i > 0; i-- )
    {
        /* do this for all the curves*/
        for ( int c = 0; c < NMemBwData; c++ )
        {
            if ( i < HISTORY )
                data[c].data[i] = data[c].data[i-1];
        }
    }

    data[MemBw1].data[0] = (double)perf_monitor_get_rd_wr_cnt(E_HP_PORT_0);
    data[MemBw1].data[0] = data[MemBw1].data[0] * 8 / 1000000000;


    //Updating HP0 Usage on GUI.
    QString hp0usage;
    hp0usage.sprintf("%03.2f",data[MemBw1].data[0]);
    hpPort0->setText(hp0usage);


    data[MemBw2].data[0] = (double)perf_monitor_get_rd_wr_cnt(E_HP_PORT_2);
    data[MemBw2].data[0] = data[MemBw2].data[0] * 8 / 1000000000;

    QString hp2usage;
    hp2usage.sprintf("%03.2f",data[MemBw2].data[0]);
    hpPort2->setText(hp2usage);

    /* Increase samples counter */
    if ( dataCount < HISTORY )
        dataCount++;

    /* increase the seconds on the X axis
      On X we have initially: 60,59, ... 0
                   then     : 61,60, ... 1
         and so it increases
    */
    for ( int j = 0; j < HISTORY; j++ )
        timeData[j]++;

    /* set X scale (range) */
    setAxisScale(QwtPlot::xBottom,
        timeData[HISTORY - 1], timeData[0]);

    /* set the samples for x any y axis, for all curve */
    for ( int c = 0; c < NMemBwData; c++ )
    {
        data[c].curve->setRawSamples(
            timeData, data[c].data, dataCount);
    }

    replot();
}

void MemBwPlot::showCurve(QwtPlotItem *item, bool on)
{
    item->setVisible(on);
    replot();
}
