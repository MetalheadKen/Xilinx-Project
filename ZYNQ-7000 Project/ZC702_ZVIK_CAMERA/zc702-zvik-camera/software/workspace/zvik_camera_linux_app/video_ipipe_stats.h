#define STATS_DATA_WIDTH 8
#define STATS_HIST_DEPTH 256

#include "xbasic_types.h"
// DATA_WIDTH = 10 bits
//#define STATS_DATA_WIDTH 10
//#define STATS_HIST_DEPTH 1024

typedef struct {
	Xuint32 hmax0;
	Xuint32 hmax1;
	Xuint32 hmax2;
	Xuint32 vmax0;
	Xuint32 vmax1;
	Xuint32 vmax2;
} STATS_Zone_Delineator;

/*
 * Stats Control Register bit definition
 */
//#define STATS_CTL_EN_MASK    0x1
//#define STATS_CTL_RUE_MASK   0x2
//#define STATS_CTL_RO_MASK    0x4
//#define STATS_CTL_CS_MASK    0x8

/*
 * Stats Status Register bit definition
 */
#define STATS_ST_VSYNC_MASK          0x01
#define STATS_ST_DONE_MASK           0x02
#define STATS_ST_VBLANK_ERROR_MASK   0x04
#define STATS_ST_HBLANK_ERROR_MASK   0x08
#define STATS_ST_INIT_DONE_MASK      0x10

/*
 * Stats IRQ Register bit definition
 */
#define STATS_VSYNC_IRQ_MASK    0x001
#define STATS_VSYNC_IRQ_INTR        0
#define STATS_DONE_IRQ_MASK     0x002
#define STATS_DONE_IRQ_INTR         1
#define STATS_VBLANK_IRQ_MASK   0x004
#define STATS_VBLANK_IRQ_INTR       2
#define STATS_HBLANK_IRQ_MASK   0x008
#define STATS_HBLANK_IRQ_INTR       3
#define STATS_IRQ_MASK          0x100
#define STATS_IRQ_INTR              8


/*
 * CC histogram zoom Register options
 */
#define STATS_CC_ZOOM_X1 0x0
#define STATS_CC_ZOOM_X2 0x1
#define STATS_CC_ZOOM_X4 0x2
#define STATS_CC_ZOOM_X8 0x3

/*
 * Histogram Zone Enable bit definitions and options
 */
#define STATS_ZONE_0_MASK  0x0001
#define STATS_ZONE_1_MASK  0x0002
#define STATS_ZONE_2_MASK  0x0004
#define STATS_ZONE_3_MASK  0x0008
#define STATS_ZONE_4_MASK  0x0010
#define STATS_ZONE_5_MASK  0x0020
#define STATS_ZONE_6_MASK  0x0040
#define STATS_ZONE_7_MASK  0x0080
#define STATS_ZONE_8_MASK  0x0100
#define STATS_ZONE_9_MASK  0x0200
#define STATS_ZONE_10_MASK 0x0400
#define STATS_ZONE_11_MASK 0x0800
#define STATS_ZONE_12_MASK 0x1000
#define STATS_ZONE_13_MASK 0x2000
#define STATS_ZONE_14_MASK 0x4000
#define STATS_ZONE_15_MASK 0x8000
#define STATS_ZONE_MID     0x0660
#define STATS_ZONE_CORNER  0x9009
#define STATS_ZONE_EDGE    0x6996
#define STATS_ZONE_ALL     0xFFFF



/******************************************************************************
 *
 * Member variable declarations
 *
 ******************************************************************************/

extern Xuint32 r_hist[STATS_HIST_DEPTH];
extern Xuint32 g_hist[STATS_HIST_DEPTH];
extern Xuint32 b_hist[STATS_HIST_DEPTH];
extern Xuint32 y_hist[STATS_HIST_DEPTH];
extern Xuint32 cc_hist[STATS_HIST_DEPTH];
extern Xuint32 hifreq_lo[16];
extern Xuint32 hifreq_hi[16];
extern Xuint32 lofreq_lo[16];
extern Xuint32 lofreq_hi[16];
extern Xuint32 HSobel_lo[16];
extern Xuint32 HSobel_hi[16];
extern Xuint32 VSobel_lo[16];
extern Xuint32 VSobel_hi[16];
extern Xuint32 RSobel_lo[16];
extern Xuint32 RSobel_hi[16];
extern Xuint32 LSobel_lo[16];
extern Xuint32 LSobel_hi[16];
extern Xuint32 sum_lo[16][3];
extern Xuint32 sum_hi[16][3];
extern Xuint32 pow_lo[16][3];
extern Xuint32 pow_hi[16][3];
extern Xuint32 max[16][3];
extern Xuint32 min[16][3];

/******************************************************************************
 *

*
* function declarations
*
******************************************************************************/

void stats_get_zones(Xuint32 BaseAddress, STATS_Zone_Delineator* zones);
void stats_set_zones(Xuint32 BaseAddress, STATS_Zone_Delineator* zones);

Xuint32 stats_get_chrom_hist_zoom(Xuint32 BaseAddress);
void stats_set_chrom_hist_zoom(Xuint32 BaseAddress, Xuint32 zoom_factor);

Xuint32 stats_get_rgb_hist_zones(Xuint32 BaseAddress);
void stats_set_rgb_hist_zones(Xuint32 BaseAddress, Xuint32 zones);

Xuint32 stats_get_ycc_hist_zones(Xuint32 BaseAddress);
void stats_set_ycc_hist_zones(Xuint32 BaseAddress, Xuint32 zones);


Xuint32 stats_get_max(Xuint32 BaseAddress);
Xuint32 stats_get_min(Xuint32 BaseAddress);
Xuint32 stats_get_sum(Xuint32 BaseAddress);
Xuint32 stats_get_pow(Xuint32 BaseAddress);
Xuint32 stats_get_HSobel(Xuint32 BaseAddress);
Xuint32 stats_get_VSobel(Xuint32 BaseAddress);
Xuint32 stats_get_LSobel(Xuint32 BaseAddress);
Xuint32 stats_get_RSobel(Xuint32 BaseAddress);
Xuint32 stats_get_hifreq(Xuint32 BaseAddress);
Xuint32 stats_get_lofreq(Xuint32 BaseAddress);
Xuint32 stats_get_rgb_hist(Xuint32 BaseAddress);
Xuint32 stats_get_lum_hist(Xuint32 BaseAddress);
Xuint32 stats_get_chrom_hist(Xuint32 BaseAddress);


/*****************************************************************************/
/**
*
* This macro enables an Image Statistics device.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_Enable(u32 BaseAddress);
*
******************************************************************************/
#define Stats_Enable(BaseAddress) \
            Stats_WriteReg(BaseAddress, STATS_CONTROL, \
                Stats_ReadReg(BaseAddress, STATS_CONTROL) | \
                STATS_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro disables an Image Statistics device.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_Disable(u32 BaseAddress);
*
******************************************************************************/
#define Stats_Disable(BaseAddress) \
            Stats_WriteReg(BaseAddress, STATS_CONTROL, \
                Stats_ReadReg(BaseAddress, STATS_CONTROL) & \
                ~STATS_CTL_EN_MASK)

/*****************************************************************************/
/**
*
* This macro tells a Image Statistics device to pick up all the register value changes
* made so far by the software. The registers will be automatically updated
* on the next rising-edge of the VBlank_in signal on the core.
* It is up to the user to manually disable the register update after a sufficient
* amount if time.
*
* This function only works when the Statistics core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_RegUpdateEnable(u32 BaseAddress);
*
******************************************************************************/
#define Stats_RegUpdateEnable(BaseAddress) \
            Stats_WriteReg(BaseAddress, STATS_CONTROL, \
                Stats_ReadReg(BaseAddress, STATS_CONTROL) | \
                STATS_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro tells a Image Statistics device not to update it's configuration registers made
* so far by the software. When disabled, changes to other configuration registers
* are stored, but do not effect the core's behavior.
*
* This function only works when the Statistics core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_RegUpdateDisable(u32 BaseAddress);
*
******************************************************************************/
#define Stats_RegUpdateDisable(BaseAddress) \
            Stats_WriteReg(BaseAddress, STATS_CONTROL, \
                Stats_ReadReg(BaseAddress, STATS_CONTROL) & \
                ~STATS_CTL_RUE_MASK)

/*****************************************************************************/
/**
*
* This macro tells the Image Statistics device to enter and stay in its readout
* state.  The core will enter into readout mode once all data for the current
* frame has been collected and remain there for data to be read until
* the readout register is de-asserted.
*
* This function only works when the Statistics core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_ReadoutEnable(u32 BaseAddress);
*
******************************************************************************/
#define Stats_ReadoutEnable(BaseAddress) \
            Stats_WriteReg(BaseAddress, STATS_CONTROL, \
                Stats_ReadReg(BaseAddress, STATS_CONTROL) | \
                STATS_CTL_RO_MASK)

/*****************************************************************************/
/**
*
* This macro tells the Image Statistics device to de-assert the readout register.
* When deasserted the core will exit readout mode if it is currently there allowing
* for the collection of the next available data frame.  When de-asserted, the core
* will also bypass the readout state and immediately return to the initialization
* state after data acquisition is complete.
*
* This function only works when the Statistics core is enabled.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_ReadoutDisable(u32 BaseAddress);
*
******************************************************************************/
#define Stats_ReadoutDisable(BaseAddress) \
            Stats_WriteReg(BaseAddress, STATS_CONTROL, \
                Stats_ReadReg(BaseAddress, STATS_CONTROL) & \
                ~STATS_CTL_RO_MASK)

/*****************************************************************************/
/**
*
* Enables the cores interrupts
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param intr is the number of the interrupt to be enabled (see above definitions)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_EnableInterrupt(u32 BaseAddress);
*
* The general interrupt (Stats_IRQ_INTR) must be enabled for any interrupts to be active
*
******************************************************************************/
#define Stats_EnableInterrupt(BaseAddress, intr) \
			Stats_WriteReg(BaseAddress, STATS_IRQ_CONTROL, \
				Stats_ReadReg(BaseAddress, STATS_IRQ_CONTROL) \
					| (1 << (intr)));

/*****************************************************************************/
/**
*
* Disables the cores interrupts
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param intr is the number of the interrupt to be disabled (see above definitions)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_EnableInterrupt(u32 BaseAddress);
*
* All interrupts from the core may be blocked by disabling the general interrupt (Stats_IRQ_INTR)
*
******************************************************************************/
#define Stats_DisableInterrupt(BaseAddress, intr) \
			Stats_WriteReg(BaseAddress, STATS_IRQ_CONTROL, \
				Stats_ReadReg(BaseAddress, STATS_IRQ_CONTROL) \
					& ~(1 << (intr)));

/*****************************************************************************/
/**
*
* This macro tells the Image Statistics device to clear the state of all
* status registers.  Statuses will not update until ClrStatus register is
* de-asserted.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_ClrStatusSet(u32 BaseAddress);
*
******************************************************************************/
#define Stats_ClrStatusSet(BaseAddress) \
			Stats_WriteReg(BaseAddress, STATS_CONTROL, \
				Stats_ReadReg(BaseAddress, STATS_CONTROL) | \
				STATS_CTL_CS_MASK)

/*****************************************************************************/
/**
*
* This macro tells the Image Statistics device to de-assert the ClrStatus
* register enabling the collection of status information.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_ClrStatusUnset(u32 BaseAddress);
*
******************************************************************************/
#define Stats_ClrStatusUnset(BaseAddress) \
			Stats_WriteReg(BaseAddress, STATS_CONTROL, \
				Stats_ReadReg(BaseAddress, STATS_CONTROL) & \
				~STATS_CTL_CS_MASK)

/*****************************************************************************/
/**
*
* A convenience macro for checking the DONE status flag.  The DONE status will
* go high when frame data acquisition is complete.  This macro provides a
* simple method to check if data is ready to be read from the core.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return The 32-bit value of the register
*
* @note
* C-style signature:
*    Xuint32 Stats_DONE_Status(u32 BaseAddress);
*
******************************************************************************/
#define Stats_DONE_Status(BaseAddress) \
            (Stats_ReadReg(BaseAddress, STATS_STATUS) & 0x16)

/*****************************************************************************/
/**
*
* This macro tells the Image Statistics device that the current zone/color/histogram
* addresses are valid.  Once asserted, the core will fetch the requested data
* from the addresses provided make them available for reading.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_AddrValidate(u32 BaseAddress);
*
******************************************************************************/
#define Stats_AddrValidate(BaseAddress) \
			Stats_WriteReg(BaseAddress, STATS_ADDR_VALID, 0x1)

/*****************************************************************************/
/**
*
* This macro tells the Image Statistics device that the current zone/color/histogram
* addresses are no longer valid.  Reads from the core's data registers are no longer
* valid.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return None.
*
* @note
* C-style signature:
*    void Stats_AddrInvalidate(u32 BaseAddress);
*
******************************************************************************/
#define Stats_AddrInvalidate(BaseAddress) \
			Stats_WriteReg(BaseAddress, STATS_ADDR_VALID, 0x0)

/*****************************************************************************/
/**
*
* A convenience macro for reading the DataValid register.  Following the assertion
* of the AddrValid register, the core asserts the DataValid to inform the user that
* the requested data has been retrieved and is ready for reading.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return The 32-bit value of the register
*
* @note
* C-style signature:
*    Xuint32 Stats_DataValid(u32 BaseAddress);
*
******************************************************************************/
#define Stats_DataValid(BaseAddress) \
			Stats_ReadReg(BaseAddress, STATS_DATA_VALID)

/*****************************************************************************/
/**
*
* Read the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
*
* @return   The 32-bit value of the register
*
* @note
* C-style signature:
*    u32 Stats_ReadReg(u32 BaseAddress, u32 RegOffset)
*
******************************************************************************/
#define Stats_ReadReg(BaseAddress, RegOffset) \
			STATS_In32((BaseAddress) + (RegOffset))

/*****************************************************************************/
/**
*
* Write the given register.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param RegOffset is the register offset of the register (defined at top of this file)
* @param Data is the 32-bit value to write to the register
*
* @return   None.
*
* @note
* C-style signature:
*    void Stats_WriteReg(u32 BaseAddress, u32 RegOffset, u32 Data)
*
******************************************************************************/
#define Stats_WriteReg(BaseAddress, RegOffset, Data) \
			STATS_Out32((BaseAddress) + (RegOffset), (Data))

