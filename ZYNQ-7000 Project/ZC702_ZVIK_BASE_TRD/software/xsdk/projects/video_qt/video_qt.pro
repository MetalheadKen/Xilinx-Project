#-------------------------------------------------
#
# Project created by QtCreator 2011-11-29T15:51:32
#
#-------------------------------------------------

QT    += core gui widgets

TARGET = video_qt
TEMPLATE = app

FORMS    += \
    ui/mainwindow.ui 

SOURCES += \
    src/mainwindow.cpp \
    src/main.cpp \
    src/cpustat.cpp \
    src/cpuplot.cpp \
    src/membwplot.cpp

HEADERS += \
    include/mainwindow.h \
    include/cpustat.h \
    include/cpuplot.h \
    include/membwplot.h 

MOC_DIR = moc

OBJECTS_DIR = obj

UI_DIR = ui

mkdirs.commands = $(MKDIR) $$MOC_DIR $$OBJECTS_DIR

QMAKE_EXTRA_TARGETS += mkdirs

INCLUDEPATH += \
    include \
    ../filter_lib/include \
    ../perfmon_lib/include \
    ../video_lib/include

QMAKE_LIBDIR_FLAGS += \
    -L../video_lib/lib \
    -L../filter_lib/lib \
    -L../perfmon_lib/lib \
    -L../../lib \
    -L$(XILINX_SDK)/data/embeddedsw/ThirdParty/opencv/lib

LIBS += \
    -lqwt \
    -lvideo \
    -lfilter \
    -lperfmon \
    -ldrm \
    -lv4l2subdev \
    -lmediactl \
    -lavcodec \
    -lavformat \
    -lavutil \
    -lswscale \
    -lopencv_calib3d \
    -lopencv_contrib \
    -lopencv_core \
    -lopencv_features2d \
    -lopencv_flann \
    -lopencv_gpu \
    -lopencv_highgui \
    -lopencv_imgproc \
    -lopencv_legacy \
    -lopencv_ml \
    -lopencv_objdetect \
    -lopencv_photo \
    -lopencv_stitching \
    -lopencv_video \
    -lopencv_videostab

CONFIG += "release"

QMAKE_CXXFLAGS_RELEASE -= -O2
QMAKE_CFLAGS_RELEASE -= -O2
QMAKE_CFLAGS_RELEASE += -O3
QMAKE_CXXFLAGS_RELEASE += -O3

RESOURCES += \
    resourcefile.qrc


