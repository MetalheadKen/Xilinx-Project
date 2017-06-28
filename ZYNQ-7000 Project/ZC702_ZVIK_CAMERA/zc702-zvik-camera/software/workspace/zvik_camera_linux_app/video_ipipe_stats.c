#include "xparameters.h"

#if defined(XPAR_STATS_0_BASEADDR)

#include "stats.h"
#include "video_ipipe_stats.h"

Xuint32 r_hist[STATS_HIST_DEPTH];
Xuint32 g_hist[STATS_HIST_DEPTH];
Xuint32 b_hist[STATS_HIST_DEPTH];
Xuint32 y_hist[STATS_HIST_DEPTH];
Xuint32 cc_hist[STATS_HIST_DEPTH];
Xuint32 hifreq_lo[16];
Xuint32 hifreq_hi[16];
Xuint32 lofreq_lo[16];
Xuint32 lofreq_hi[16];
Xuint32 HSobel_lo[16];
Xuint32 HSobel_hi[16];
Xuint32 VSobel_lo[16];
Xuint32 VSobel_hi[16];
Xuint32 RSobel_lo[16];
Xuint32 RSobel_hi[16];
Xuint32 LSobel_lo[16];
Xuint32 LSobel_hi[16];
Xuint32 sum_lo[16][3];
Xuint32 sum_hi[16][3];
Xuint32 pow_lo[16][3];
Xuint32 pow_hi[16][3];
Xuint32 max[16][3];
Xuint32 min[16][3];

Xuint32 stats_read_data_reg(Xuint32 BaseAddress, Xuint32 RegOffset) {
	Xuint32 reg_val;
	// assert address is valid
	Stats_AddrValidate(BaseAddress);

	// wait for data valid response
	// while (!Stats_DataValid(BaseAddress));

	// read register
	reg_val = Stats_ReadReg(BaseAddress, RegOffset);

	// de-assert address valid
	Stats_AddrInvalidate(BaseAddress);

	return reg_val;
}

Xuint32 read_stats(Xuint32 BaseAddress) {
	Xuint32 color;
	Xuint32 region;

	stats_get_chrom_hist(XPAR_STATS_0_BASEADDR);

/*
	for (region = 0; region < 16; ++region) {
		Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);
		for (color = 0; color < 3; ++color) {
			Stats_WriteReg(BaseAddress, STATS_COLOR_ADDR, color);
			sum[region][color].Lower = Stats_ReadReg(BaseAddress, STATS_SUM_LO);
			sum[region][color].Upper = Stats_ReadReg(BaseAddress, STATS_SUM_HI);
			max[region][color]  = Stats_ReadReg(BaseAddress, STATS_MAX);
			min[region][color]  = Stats_ReadReg(BaseAddress, STATS_MIN);
		}
	}
*/
	return 0;
}



/*****************************************************************************/
/**
*
* Returns the current horizontal and vertical positions delineating
* the zone boundaries for the Image Statistics core.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param zones is a pointer to a Zone_Delineator structure to store the data read
*
* @return   None.
*
******************************************************************************/
void stats_get_zones(Xuint32 BaseAddress, STATS_Zone_Delineator* zones) {
	zones->hmax0 = Stats_ReadReg(BaseAddress, STATS_HMAX0);
	zones->hmax1 = Stats_ReadReg(BaseAddress, STATS_HMAX1);
	zones->hmax2 = Stats_ReadReg(BaseAddress, STATS_HMAX2);
	zones->vmax0 = Stats_ReadReg(BaseAddress, STATS_VMAX0);
	zones->vmax1 = Stats_ReadReg(BaseAddress, STATS_VMAX1);
	zones->vmax2 = Stats_ReadReg(BaseAddress, STATS_VMAX2);
}

/*****************************************************************************/
/**
*
* Sets the delineation lines for the zones in the Image Statistics core to
* those specified in zones.  Values will be updated into the core on the
* next rising edge of vblank only when the control register's register
* update bit is set.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param zones is a pointer to a Zone_Delineator structure containing information to write
*
* @return   None.
*
* @note
* The register update bit in the control register must be asserted for the
*    values to be read in.
*
******************************************************************************/
void stats_set_zones(Xuint32 BaseAddress,STATS_Zone_Delineator* zones) {
	Stats_WriteReg(BaseAddress, STATS_HMAX0, zones->hmax0);
	Stats_WriteReg(BaseAddress, STATS_HMAX1, zones->hmax1);
	Stats_WriteReg(BaseAddress, STATS_HMAX2, zones->hmax2);
	Stats_WriteReg(BaseAddress, STATS_VMAX0, zones->vmax0);
	Stats_WriteReg(BaseAddress, STATS_VMAX1, zones->vmax1);
	Stats_WriteReg(BaseAddress, STATS_VMAX2, zones->vmax2);
}

/*****************************************************************************/
/**
*
* Gets the current zoom factor used for the chrominance histogram data.  The
* zoom factor allows for increased precision in the cc histogram at the expense
* of range.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return   The current zoom factor used by the statistics core
*
* @note
* Valid zoom factors may be found in ivk_stats.h
*
*
******************************************************************************/
inline Xuint32 stats_get_chrom_hist_zoom(Xuint32 BaseAddress) {
	return Stats_ReadReg(BaseAddress, STATS_HIST_ZOOM_FACTOR);
}

/*****************************************************************************/
/**
*
* Sets the zoom factor for the chrominance histogram data.  The zoom factor
* allows for increased precision in the cc histogram at the expense of range.
* The value will be updated on the next rising edge of vblank.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param zoom_factor is the 32 bit value (2 bits utilized) to be written
*
* @return   None
*
* @note
* Valid zoom factors may be found in ivk_stats.h
*
* @note
* The register update bit in the control register must be asserted for the
*    values to be read in.
*
******************************************************************************/
inline void stats_set_chrom_hist_zoom(Xuint32 BaseAddress, Xuint32 zoom_factor) {
	Stats_WriteReg(BaseAddress, STATS_HIST_ZOOM_FACTOR, zoom_factor);
}

/*****************************************************************************/
/**
*
* Gets the zones currently used in the rgb histogram measurements.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return   The 32 bit register containing the zones used, specified by set bits in the lower 16 bits.
*
* @note
* Zone masks may be found in ivk_stats.h
*
******************************************************************************/
inline Xuint32 stats_get_rgb_hist_zones(Xuint32 BaseAddress) {
	return Stats_ReadReg(BaseAddress, STATS_RGB_HIST_ZONE_EN);
}

/*****************************************************************************/
/**
*
* Sets the zones to be used in the rgb histogram measurements.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param zones is the zone numbers to be used.  A bit set at each bit location (lower 16 bits) specifies that zone will be used.
*
* @return   None
*
* @note
* Zone masks may be found in ivk_stats.h
*
* @note
* The register update bit in the control register must be asserted for the
*    values to be read in.
*
******************************************************************************/
inline void stats_set_rgb_hist_zones(Xuint32 BaseAddress, Xuint32 zones) {
	Stats_WriteReg(BaseAddress, STATS_RGB_HIST_ZONE_EN, zones);
}

/*****************************************************************************/
/**
*
* Gets the zones currently used in the y and cc histogram measurements.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
*
* @return   The 32 bit register containing the zones used, specified by set bits in the lower 16 bits.
*
* @note
* Zone masks may be found in ivk_stats.h
*
******************************************************************************/
inline Xuint32 stats_get_ycc_hist_zones(Xuint32 BaseAddress) {
	return Stats_ReadReg(BaseAddress, STATS_YCC_HIST_ZONE_EN);
}

/*****************************************************************************/
/**
*
* Sets the zones to be used in the y and cc histogram measurements.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param zones is the zone numbers to be used.  A bit set at each bit location (lower 16 bits) specifies that zone will be used.
*
* @return   None
*
* @note
* Zone masks may be found in ivk_stats.h
*
* @note
* The register update bit in the control register must be asserted for the
*    values to be read in.
*
******************************************************************************/
inline  void stats_set_ycc_hist_zones(Xuint32 BaseAddress, Xuint32 zones) {
	Stats_WriteReg(BaseAddress, STATS_YCC_HIST_ZONE_EN, zones);
}

/*****************************************************************************/
/**
*
* Gets the maximum values measured in the red, green, and blue color channels.
* Values are obtained for all color channels and regions and are stored in the
* 2d array max.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param max is the 2d array containing the read data.  Value are accessed by max[zone][color_channel]
*
* @return   0 on success, 1 on failure
*
* @note
* Color channel offsets may be found in ivk_stats.h
*
******************************************************************************/
Xuint32 stats_get_max(Xuint32 BaseAddress) {
	Xuint32 color;
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		for (color = 0; color < 3; ++color) {
			Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);
			Stats_WriteReg(BaseAddress, STATS_COLOR_ADDR, color);

			max[region][color] = stats_read_data_reg(BaseAddress, STATS_MAX);
		}
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the minimum values measured in the red, green, and blue color channels.
* Values are obtained for all color channels and regions and are stored in the
* 2d array min.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param min is the 2d array containing the read data.  Value are accessed by min[zone][color_channel]
*
* @return   0 on success, 1 on failure
*
* @note
* Color channel offsets may be found in ivk_stats.h
*
******************************************************************************/
Xuint32 stats_get_min(Xuint32 BaseAddress) {
	Xuint32 color;
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		for (color = 0; color < 3; ++color) {
			Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);
			Stats_WriteReg(BaseAddress, STATS_COLOR_ADDR, color);

			min[region][color] = stats_read_data_reg(BaseAddress, STATS_MIN);
		}
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the sum of all values measured for each zone and color channel.
* Values are obtained for all color channels and regions and are stored in the
* 2d array sum.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param sum is the 2d array containing the read data.  Value are accessed by sum[zone][color_channel]
*
* @return   0 on success, 1 on failure
*
* @note
* Color channel offsets may be found in ivk_stats.h
*
* @note
* average color levels can be obtained by dividing the sum value by the
* number of pixels in the region.
*
******************************************************************************/
Xuint32 stats_get_sum(Xuint32 BaseAddress) {
	Xuint32 color;
	Xuint32 region;
	Xuint64 data;
	for (region = 0; region < 16; ++region) {
		for (color = 0; color < 3; ++color) {
			Stats_WriteReg(BaseAddress, STATS_ADDR_VALID, 0x0);
			while(Stats_ReadReg(BaseAddress, STATS_DATA_VALID)!=0);	  // Handshaking - waiting for DataValid == 0
			Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);
			Stats_WriteReg(BaseAddress, STATS_COLOR_ADDR, color);

			Stats_WriteReg(BaseAddress, STATS_ADDR_VALID, 0xFFFFFFFF); // Handshaking - waiting for DataValid == 1
			while(Stats_ReadReg(BaseAddress, STATS_DATA_VALID)==0);


			sum_lo[region][color]=stats_read_data_reg(BaseAddress, STATS_SUM_LO);
			sum_hi[region][color]=stats_read_data_reg(BaseAddress, STATS_SUM_HI);
		}
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the power of all values measured for each zone and color channel.
* Values are obtained for all color channels and regions and are stored in the
* 2d array pow.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param pow is the 2d array containing the read data.  Value are accessed by pow[zone][color_channel]
*
* @return   0 on success, 1 on failure
*
* @note
* Color channel offsets may be found in ivk_stats.h
*
* @note
* variances can be obtained by dividing the sum value by the
* number of pixels in the region.
*
******************************************************************************/
Xuint32 stats_get_pow(Xuint32 BaseAddress) {
	Xuint32 color;
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		for (color = 0; color < 3; ++color) {
			Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);
			Stats_WriteReg(BaseAddress, STATS_COLOR_ADDR, color);

			pow_lo[region][color]= stats_read_data_reg(BaseAddress, STATS_POW_LO);
			pow_hi[region][color]= stats_read_data_reg(BaseAddress, STATS_POW_HI);
		}
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the sum of luminosity values filtered by a horizontal Sobel Filter
* Values are obtained for all regions and are stored in the array HSobel
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param HSobel is the array containing the read data.  Value for a desired zone are accessed by HSobel[zone]
*
* @return   0 on success, 1 on failure
*
******************************************************************************/
Xuint32 stats_get_HSobel(Xuint32 BaseAddress) {
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);

		HSobel_lo[region] = stats_read_data_reg(BaseAddress, STATS_HSOBEL_LO);
		HSobel_hi[region] = stats_read_data_reg(BaseAddress, STATS_HSOBEL_HI);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the sum of luminosity values filtered by a vertical Sobel Filter
* Values are obtained for all regions and are stored in the array VSobel
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param VSobel is the array containing the read data.  Value for a desired zone are accessed by VSobel[zone]
*
* @return   0 on success, 1 on failure
*
******************************************************************************/
Xuint32 stats_get_VSobel(Xuint32 BaseAddress) {
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);

		VSobel_lo[region] = stats_read_data_reg(BaseAddress, STATS_VSOBEL_LO);
		VSobel_hi[region] = stats_read_data_reg(BaseAddress, STATS_VSOBEL_HI);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the sum of luminosity values filtered by a diagonal Sobel Filter
* Values are obtained for all regions and are stored in the array LSobel
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param LSobel is the array containing the read data.  Value for a desired zone are accessed by LSobel[zone]
*
* @return   0 on success, 1 on failure
*
******************************************************************************/
Xuint32 stats_get_LSobel(Xuint32 BaseAddress) {
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);

		LSobel_lo[region] = stats_read_data_reg(BaseAddress, STATS_LSOBEL_LO);
		LSobel_hi[region] = stats_read_data_reg(BaseAddress, STATS_LSOBEL_HI);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the sum of luminosity values filtered by a anti-diagonal Sobel Filter
* Values are obtained for all regions and are stored in the array RSobel
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param RSobel is the array containing the read data.  Value for a desired zone are accessed by RSobel[zone]
*
* @return   0 on success, 1 on failure
*
******************************************************************************/
Xuint32 stats_get_RSobel(Xuint32 BaseAddress) {
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);

		RSobel_lo[region] = stats_read_data_reg(BaseAddress, STATS_RSOBEL_LO);
		RSobel_hi[region] = stats_read_data_reg(BaseAddress, STATS_RSOBEL_HI);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the sum of absolute values of the High Frequency filter output.
* Values are obtained for all regions and are stored in the array hifreq
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param hifreq is the array containing the read data.  Value for a desired zone are accessed by hifreq[zone]
*
* @return   0 on success, 1 on failure
*
******************************************************************************/
Xuint32 stats_get_hifreq(Xuint32 BaseAddress) {
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);

		hifreq_lo[region] = stats_read_data_reg(BaseAddress, STATS_HIFREQ_LO);
		hifreq_hi[region] = stats_read_data_reg(BaseAddress, STATS_HIFREQ_HI);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Gets the sum of absolute values of the Low Frequency filter output.
* Values are obtained for all regions and are stored in the array lofreq
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param lofreq is the array containing the read data.  Value for a desired zone are accessed by lofreq[zone]
*
* @return   0 on success, 1 on failure
*
******************************************************************************/
Xuint32 stats_get_lofreq(Xuint32 BaseAddress) {
	Xuint32 region;

	for (region = 0; region < 16; ++region) {
		Stats_WriteReg(BaseAddress, STATS_ZONE_ADDR, region);

		lofreq_lo[region] = stats_read_data_reg(BaseAddress, STATS_LOFREQ_LO);
		lofreq_hi[region] = stats_read_data_reg(BaseAddress, STATS_LOFREQ_HI);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Reads the red, green, and blue histogram values into the arrays r_hist,
* g_hist, and b_hist respectively.
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param r_hist is the array were the red histogram data is stored
* @param g_hist is the array were the green histogram data is stored
* @param b_hist is the array were the blue histogram data is stored
*
* @return   0 on success, 1 on failure
*
* @note
* r_hist, g_hist, and b_hist must be the at least the size of HIST_DEPTH
*    or 2^DATA_WIDTH
*
******************************************************************************/
Xuint32 stats_get_rgb_hist(Xuint32 BaseAddress) {
	Xuint32 addr;

	for (addr = 0; addr < STATS_HIST_DEPTH; ++addr) {
		Stats_WriteReg(BaseAddress, STATS_HIST_ADDR, addr);

		r_hist[addr] = stats_read_data_reg(BaseAddress, STATS_RHIST);
		g_hist[addr] = stats_read_data_reg(BaseAddress, STATS_GHIST);
		b_hist[addr] = stats_read_data_reg(BaseAddress, STATS_BHIST);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Reads the luminance histogram values into the array y_hist
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param y_hist is the array were the luminace histogram data is stored
*
* @return   0 on success, 1 on failure
*
* @note
* y_hist must be the at least the size of HIST_DEPTH or 2^DATA_WIDTH
*
******************************************************************************/
Xuint32 stats_get_lum_hist(Xuint32 BaseAddress) {
	Xuint32 addr;

	for (addr = 0; addr < STATS_HIST_DEPTH; ++addr) {
		Stats_WriteReg(BaseAddress, STATS_HIST_ADDR, addr);
		y_hist[addr] = stats_read_data_reg(BaseAddress, STATS_YHIST);
	}

	return 0;
}

/*****************************************************************************/
/**
*
* Reads the chrominance histogram values into the array cc_hist
*
* @param BaseAddress is the Xilinx EDK base address of the Statistics core (from xparameters.h)
* @param cc_hist is the array were the chrominance histogram data is stored
*
* @return   0 on success, 1 on failure
*
* @note
* cc_hist must be the at least the size of HIST_DEPTH or 2^DATA_WIDTH
*
******************************************************************************/
Xuint32 stats_get_chrom_hist(Xuint32 BaseAddress) {
	Xuint32 addr;

	for (addr = 0; addr < STATS_HIST_DEPTH; ++addr) {
		Stats_WriteReg(BaseAddress, STATS_HIST_ADDR, addr);
		cc_hist[addr] = stats_read_data_reg(BaseAddress, STATS_CCHIST);
	}

	return 0;
}

#endif // #if defined(XPAR_STATS_0_BASEADDR)
