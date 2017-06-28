#ifndef _DEMO_H_
#define _DEMO_H_

#include "xparameters.h"
#include "sleep.h"

#include "fmc_iic.h"
#include "fmc_imageon.h"

#include "xaxivdma.h"
#include "xaxivdma_ext.h"
#include "xosd.h"
#include "onsemi_vita_sw.h"
#include "xcfa.h"

typedef struct {
	XAxiVdma axivdma0;
	XAxiVdma axivdma1;
	XOSD osd;
	XCfa cfa;
	fmc_iic_t fmc_imageon_iic;
	fmc_imageon_t fmc_imageon;
	onsemi_vita_t vita_receiver;
	onsemi_vita_status_t vita_status_t1;
	onsemi_vita_status_t vita_status_t2;

	XAxiVdma *paxivdma0;
	XAxiVdma *paxivdma1;
	XOSD *posd;
	XCfa *pcfa;
	fmc_iic_t *pfmc_imageon_iic;
	fmc_imageon_t *pfmc_imageon;
	onsemi_vita_t *pvita_receiver;

	Xuint32 hdmii_locked;
	Xuint32 hdmii_width;
	Xuint32 hdmii_height;
	fmc_imageon_video_timing_t hdmii_timing;

	Xuint32 hdmio_width;
	Xuint32 hdmio_height;
	fmc_imageon_video_timing_t hdmio_timing;

	u8 cam_alpha;
	u8 hdmi_alpha;

	int bVerbose;
} demo_t;

int demo_init_R( demo_t *pdemo );
int demo_init_L( demo_t *pdemo );
int demo_start_cam_R_in( demo_t *pdemo );
int demo_start_cam_L_in( demo_t *pdemo );
int demo_init_frame_buffer( demo_t *pdemo );
int demo_stop_frame_buffer( demo_t *pdemo, demo_t *pdemo2 );
int demo_start_frame_buffer( demo_t *pdemo, demo_t *pdemo2 );

#endif // _DEMO_H_
