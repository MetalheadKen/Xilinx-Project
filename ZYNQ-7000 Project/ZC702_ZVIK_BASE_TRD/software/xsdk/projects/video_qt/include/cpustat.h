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
#include <qdatetime.h>
#ifndef CPUSTAT_H
#define CPUSTAT_H
/**
* Class that reads the /proc/stat file (Linux only) and extracts the total CPU usage information
* This widget is based in part on the work of the Qwt project (http://qwt.sf.net).
*/
class CpuStat
{
public:
    CpuStat();
    CpuStat(const QString &name);
    void statistic(double &data);
    QTime upTime() const;
    bool isCpuValid(void) { return validCpu; }

    enum Value
    {
        User,
        Nice,
        System,
        Idle,
        NValues
    };

private:
    QString cpuname;
    bool validCpu;
    bool lookUp(double[NValues]) const;
    double procValues[NValues];
};
#endif // CPUSTAT_H

