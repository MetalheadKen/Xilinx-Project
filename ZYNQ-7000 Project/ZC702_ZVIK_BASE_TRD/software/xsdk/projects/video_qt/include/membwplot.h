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
#include <qwt_plot.h>
#include<QLabel>
#ifndef MEMBWPLOT_H
#define MEMBWPLOT_H

#define HISTORY 60 // seconds

class QwtPlotCurve;
/**
* Widget that draws graphs of badwidth usage
* This widget is based in part on the work of the Qwt project (http://qwt.sf.net).
*/
class MemBwPlot : public QwtPlot
{
    Q_OBJECT
public:
    enum MemBwData
    {
        MemBw1,
        MemBw2,
        NMemBwData
    };

    MemBwPlot(QWidget * = 0);
    const QwtPlotCurve *cpuCurve(int id) const
        { return data[id].curve; }

protected:
    void timerEvent(QTimerEvent *e);

private Q_SLOTS:
    void showCurve(QwtPlotItem *, bool on);

private:
    struct
    {
        QwtPlotCurve *curve;
        double data[HISTORY];
    } data[NMemBwData];
    double timeData[HISTORY];

    int dataCount; /* counter of data samples, range from 0 to HISTORY */
public: //Added for displaying bandwidth for HPPort0 and HPPort2
    QLabel *hpPort0;
    QLabel *hpPort2;
};
#endif // MEMBWPLOT_H
