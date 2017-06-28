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
#include <qpainter.h>
#include <qwt_plot_layout.h>
#include <qwt_plot_curve.h>
#include <qwt_scale_draw.h>
#include <qwt_scale_widget.h>
#include <qwt_legend.h>
#include <qwt_plot_canvas.h>
#include "cpuplot.h"

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

class Background: public QwtPlotItem
{
public:
    Background()
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
        for ( int i = 110; i >= 0; i -= 10 )
        {
            if ((i == 100) || (i == 0))
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

class CpuCurve: public QwtPlotCurve
{
public:
    CpuCurve(const QString &title):
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

CpuPlot::CpuPlot(QWidget *parent):
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
    cpuStat1 = new CpuStat("cpu0 ");
    cpuStat2 = new CpuStat("cpu1 ");

    enableAxis( QwtPlot::xBottom, false );
    QwtScaleWidget *scaleWidget = axisWidget(QwtPlot::xBottom);
    const int fmh = QFontMetrics(scaleWidget->font()).height();
    scaleWidget->setMinBorderDist(0, fmh / 2);

    setAxisScale(QwtPlot::yLeft, 0, 100);
    Background *bg = new Background();
    bg->attach(this);

    CpuCurve *curve;

    curve = new CpuCurve("CPU 1");
    curve->setColor(Qt::blue);
    curve->setZ(curve->z() - 1);
    curve->attach(this);
    data[Cpu1].curve = curve;

    curve = new CpuCurve("CPU 2");
    curve->setColor(Qt::cyan);
    curve->setZ(curve->z() - 2);
    curve->attach(this);
    data[Cpu2].curve = curve;

    showCurve(data[Cpu1].curve, cpuStat1->isCpuValid());
    showCurve(data[Cpu2].curve, cpuStat2->isCpuValid());

    for ( int i = 0; i < HISTORY; i++ )
        timeData[HISTORY - 1 - i] = i;

    (void)startTimer(1000); // 1 second
}

void CpuPlot::timerEvent(QTimerEvent *)
{
    /* move the previous samples values up in the array,
       sample 0 is always the newest one  */
    for ( int i = dataCount; i > 0; i-- )
    {
        /* do this for all the curves*/
        for ( int c = 0; c < NCpuData; c++ )
        {
            if ( i < HISTORY )
                data[c].data[i] = data[c].data[i-1];
        }
    }

    /* collect the sample 0 for Cpu1*/
    cpuStat1->statistic(data[Cpu1].data[0]);



    QString cpu1usage;
    cpu1usage.sprintf("%03.2f",data[Cpu1].data[0]);

    cpu1Label->setText(cpu1usage);

    cpuStat2->statistic(data[Cpu2].data[0]);

    QString cpu2usage;
    cpu2usage.sprintf("%03.2f",data[Cpu2].data[0]);

    cpu2Label->setText(cpu2usage);

    /* calc Total and Idle*/
    //data[Total].data[0] = data[User].data[0] + data[System].data[0];
    //data[Idle].data[0] = 100.0 - data[Total].data[0];

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
    for ( int c = 0; c < NCpuData; c++ )
    {
        data[c].curve->setRawSamples(
            timeData, data[c].data, dataCount);
    }

    replot();
}

void CpuPlot::showCurve(QwtPlotItem *item, bool on)
{
    item->setVisible(on);
    replot();
}

