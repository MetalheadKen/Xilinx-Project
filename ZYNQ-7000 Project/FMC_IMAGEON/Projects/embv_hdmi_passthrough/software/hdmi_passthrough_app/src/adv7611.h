/*
 * adv7611.h
 *
 *  Created on: Jun 26, 2014
 *      Author: 910560
 */

#ifndef ADV7611_H_
#define ADV7611_H_

#include "xbasic_types.h"
#include "xiicps.h"

// Detailed ADV7611 I2C addresses
#define IIC_ADV7611_BASE_ADDR        0x98
#define IIC_ADV7611_CEC_ADDR         0x80
//#define IIC_ADV7611_INFOFRAME_ADDR   0x7C  => I2C Address conflict with ADV7511 (Fixed I2C Address at 0x7C)
#define IIC_ADV7611_INFOFRAME_ADDR   0x6A
#define IIC_ADV7611_DPLL_ADDR        0x4C
#define IIC_ADV7611_KSV_ADDR         0x64
#define IIC_ADV7611_EDID_ADDR        0x6C
#define IIC_ADV7611_HDMI_ADDR        0x68
#define IIC_ADV7611_CP_ADDR          0x44

static u8 adv7611_edid_content[256] =
{
		0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
		0x06, 0xD4, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x16, 0x01, 0x03, 0x81, 0x46, 0x27, 0x78,
		0x0A, 0x32, 0x30, 0xA1, 0x54, 0x52, 0x9E, 0x26,
		0x0A, 0x49, 0x4B, 0xA3, 0x08, 0x00, 0x81, 0xC0,
		0x81, 0x00, 0x81, 0x0F, 0x81, 0x40, 0x81, 0x80,
		0x95, 0x00, 0xB3, 0x00, 0x01, 0x01, 0x02, 0x3A,
		0x80, 0x18, 0x71, 0x38, 0x2D, 0x40, 0x58, 0x2C,
		0x45, 0x00, 0xC4, 0x8E, 0x21, 0x00, 0x00, 0x1E,
		0xA9, 0x1A, 0x00, 0xA0, 0x50, 0x00, 0x16, 0x30,
		0x30, 0x20, 0x37, 0x00, 0xC4, 0x8E, 0x21, 0x00,
		0x00, 0x1A, 0x00, 0x00, 0x00, 0xFC, 0x00, 0x41,
		0x56, 0x4E, 0x45, 0x54, 0x2D, 0x45, 0x4D, 0x42,
		0x56, 0x0A, 0x20, 0x20, 0x00, 0x00, 0x00, 0xFD,
		0x00, 0x38, 0x4B, 0x20, 0x44, 0x11, 0x00, 0x0A,
		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x01, 0x62,
		0x02, 0x03, 0x1F, 0x71, 0x4B, 0x90, 0x03, 0x04,
		0x05, 0x12, 0x13, 0x14, 0x1F, 0x20, 0x07, 0x16,
		0x26, 0x15, 0x07, 0x50, 0x09, 0x07, 0x01, 0x67,
		0x03, 0x0C, 0x00, 0x10, 0x00, 0x00, 0x1E, 0x01,
		0x1D, 0x00, 0x72, 0x51, 0xD0, 0x1E, 0x20, 0x6E,
		0x28, 0x55, 0x00, 0xC4, 0x8E, 0x21, 0x00, 0x00,
		0x1E, 0x01, 0x1D, 0x80, 0x18, 0x71, 0x1C, 0x16,
		0x20, 0x58, 0x2C, 0x25, 0x00, 0xC4, 0x8E, 0x21,
		0x00, 0x00, 0x9E, 0x8C, 0x0A, 0xD0, 0x8A, 0x20,
		0xE0, 0x2D, 0x10, 0x10, 0x3E, 0x96, 0x00, 0xC4,
		0x8E, 0x21, 0x00, 0x00, 0x18, 0x01, 0x1D, 0x80,
		0x3E, 0x73, 0x38, 0x2D, 0x40, 0x7E, 0x2C, 0x45,
		0x80, 0xC4, 0x8E, 0x21, 0x00, 0x00, 0x1E, 0x1A,
		0x36, 0x80, 0xA0, 0x70, 0x38, 0x1F, 0x40, 0x30,
		0x20, 0x25, 0x00, 0xC4, 0x8E, 0x21, 0x00, 0x00,
		0x1A, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01
};

static u8 adv7611_reset_table[][3] =
{
      IIC_ADV7611_BASE_ADDR>>1, 0xFF, 0x80,  // I2C reset
      0xDE, 0xAD, 0x00
};


static u8 adv7611_set_slave_table[][3] =
{
      IIC_ADV7611_BASE_ADDR>>1, 0xF4, IIC_ADV7611_CEC_ADDR, // CEC
      IIC_ADV7611_BASE_ADDR>>1, 0xF5, IIC_ADV7611_INFOFRAME_ADDR, // INFOFRAME
      IIC_ADV7611_BASE_ADDR>>1, 0xF8, IIC_ADV7611_DPLL_ADDR, // DPLL
      IIC_ADV7611_BASE_ADDR>>1, 0xF9, IIC_ADV7611_KSV_ADDR, // KSV
      IIC_ADV7611_BASE_ADDR>>1, 0xFA, IIC_ADV7611_EDID_ADDR, // EDID
      IIC_ADV7611_BASE_ADDR>>1, 0xFB, IIC_ADV7611_HDMI_ADDR, // HDMI
      IIC_ADV7611_BASE_ADDR>>1, 0xFD, IIC_ADV7611_CP_ADDR,  // CP
      0xDE, 0xAD, 0x00
};

static u8 adv7611_set_edid_0_table[][3] =
{
      IIC_ADV7611_KSV_ADDR>>1, 0x77, 0x00,  // Disable the Internal EDID
      0xDE, 0xAD, 0x00
};

static u8 adv7611_set_edid_1_table[][3] =
{
      IIC_ADV7611_KSV_ADDR>>1, 0x77, 0x00, // Set the Most Significant Bit of the SPA location to 0
      IIC_ADV7611_KSV_ADDR>>1, 0x52, 0x20, // Set the SPA for port B.
      IIC_ADV7611_KSV_ADDR>>1, 0x53, 0x00, // Set the SPA for port B.
      IIC_ADV7611_KSV_ADDR>>1, 0x70, 0x9E, // Set the Least Significant Byte of the SPA location
      IIC_ADV7611_KSV_ADDR>>1, 0x74, 0x03,  // Enable the Internal EDID for Ports
      0xDE, 0xAD, 0x00
};

static u8 adv7611_hdmi_config_table[][3] =
{
      IIC_ADV7611_BASE_ADDR>>1, 0x01, 0x06, // Prim_Mode =110b HDMI-GR
      IIC_ADV7611_BASE_ADDR>>1, 0x02, 0xF5, // Auto CSC, YCrCb out, Set op_656 bit
      IIC_ADV7611_BASE_ADDR>>1, 0x03, 0x80, // 16-Bit SDR ITU-R BT.656 4:2:2 Mode 0
      IIC_ADV7611_BASE_ADDR>>1, 0x04, 0x62, // OP_CH_SEL[2:0] = 011b - (P[15:8] Y, P[7:0] CrCb), XTAL_FREQ[1:0] = 01b (28.63636 MHz)
      IIC_ADV7611_BASE_ADDR>>1, 0x05, 0x2C, // AV Codes on

      IIC_ADV7611_CP_ADDR  >>1, 0x7B, 0x05, //

      IIC_ADV7611_BASE_ADDR>>1, 0x0B, 0x44, // Power up part
      IIC_ADV7611_BASE_ADDR>>1, 0x0C, 0x42, // Power up part
      IIC_ADV7611_BASE_ADDR>>1, 0x14, 0x7F, // Max Drive Strength
      IIC_ADV7611_BASE_ADDR>>1, 0x15, 0x80, // Disable Tristate of Pins
      IIC_ADV7611_BASE_ADDR>>1, 0x06, 0xA0, // LLC polarity (INV_LLC_POL = 1)
      IIC_ADV7611_BASE_ADDR>>1, 0x19, 0x80, // LLC DLL phase (delay = 0)
      IIC_ADV7611_BASE_ADDR>>1, 0x33, 0x40, // LLC DLL enable

      IIC_ADV7611_CP_ADDR  >>1, 0xBA, 0x01, // Set HDMI FreeRun

      IIC_ADV7611_KSV_ADDR >>1, 0x40, 0x81, // Disable HDCP 1.1 features

      IIC_ADV7611_HDMI_ADDR>>1, 0x9B, 0x03, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC1, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC2, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC3, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC4, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC5, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC6, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC7, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC8, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xC9, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xCA, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xCB, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0xCC, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0x00, 0x08, // Set HDMI Input Port A  (BG_MEAS_PORT_SEL = 001b)
      IIC_ADV7611_HDMI_ADDR>>1, 0x02, 0x03, // Enable Ports A & B in background mode
      IIC_ADV7611_HDMI_ADDR>>1, 0x83, 0xFC, // Enable clock terminators for port A & B
      IIC_ADV7611_HDMI_ADDR>>1, 0x6F, 0x0C, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0x85, 0x1F, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0x87, 0x70, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0x8D, 0x04, // LFG Port A
      IIC_ADV7611_HDMI_ADDR>>1, 0x8E, 0x1E, // HFG Port A
      IIC_ADV7611_HDMI_ADDR>>1, 0x1A, 0x8A, // Unmute audio
      IIC_ADV7611_HDMI_ADDR>>1, 0x57, 0xDA, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0x58, 0x01, // ADI recommended setting
      IIC_ADV7611_HDMI_ADDR>>1, 0x75, 0x10, // DDC drive strength
      IIC_ADV7611_HDMI_ADDR>>1, 0x90, 0x04, // LFG Port B
      IIC_ADV7611_HDMI_ADDR>>1, 0x91, 0x1E,  // HFG Port B
      0xDE, 0xAD, 0x00
};

static u8 adv7611_spdif_config_table[][3] =
{
      // For reference, default values are:
      //   ADV7611-HDMI[0x03] => 0x18
      //   ADV7611-HDMI[0x6E] => 0x04
      IIC_ADV7611_HDMI_ADDR>>1, 0x03, 0x78, // Raw SPDIF Mode
      IIC_ADV7611_HDMI_ADDR>>1, 0x6E, 0x0C,  // 0x6E[3]=MUX_SPDIF_TO_I2S_ENABLE
      0xDE, 0xAD, 0x00
};

void adv7611_configure(XIicPs *pInstance, u8 config_table[][3]);
void adv7611_configure2(XIicPs *pInstance, u8 config_table[][3], u8 llc_polarity, u8 llc_delay);
void adv7611_load_edid(XIicPs *pInstance);

#endif /* ADV7611_H_ */
