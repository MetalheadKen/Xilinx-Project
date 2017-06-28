
?
Feature available: %s
81*common2
ImplementationZ17-81
:
Feature available: %s
81*common2
	SynthesisZ17-81
˜
+Loading parts and site information from %s
36*device2T
R/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/arch.xmlZ21-36
¥
!Parsing RTL primitives file [%s]
14*netlist2j
h/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/xilinx/rtl/prims/rtl_prims.xmlZ29-14
®
*Finished parsing RTL primitives file [%s]
11*netlist2j
h/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/xilinx/rtl/prims/rtl_prims.xmlZ29-11
“
$Using Tcl App repository from '%s'.
323*common2T
R/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/XilinxTclStoreZ17-362
v
)Updating Tcl app persistent manifest '%s'325*common22
0/home/elzinga/.Xilinx/Vivado/tclapp/manifest.tclZ17-364
`
Command: %s
53*	vivadotcl28
6synth_design -top zc702_hdmi_out -part xc7z020clg484-1Z4-113
/

Starting synthesis...

3*	vivadotclZ4-3
q
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7z020Z17-347
a
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7z020Z17-349
ƒ
%s*synth2t
rstarting synthesize : Time (s): cpu = 00:00:19 ; elapsed = 00:00:22 . Memory (MB): peak = 195.078 ; gain = 66.812

Ò
synthesizing module '%s'638*oasys2
zc702_hdmi_out2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
828@Z8-638
G
%s*synth28
6	Parameter C_DATA_WIDTH bound to: 16 - type: integer 

G
%s*synth28
6	Parameter C_FAMILY bound to: virtex6 - type: string 

M
%s*synth2>
<	Parameter DDR_CLK_EDGE bound to: SAME_EDGE - type: string 

1
%s*synth2"
 	Parameter INIT bound to: 1'b1 

C
%s*synth24
2	Parameter SRTYPE bound to: ASYNC - type: string 

ñ
,binding component instance '%s' to cell '%s'113*oasys2
ODDR_hdmio_clk_o2
ODDR2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
2568@Z8-113
M
%s*synth2>
<	Parameter DDR_CLK_EDGE bound to: SAME_EDGE - type: string 

1
%s*synth2"
 	Parameter INIT bound to: 1'b1 

C
%s*synth24
2	Parameter SRTYPE bound to: ASYNC - type: string 

ñ
,binding component instance '%s' to cell '%s'113*oasys2
ODDR_hdmio_clk_t2
ODDR2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
2708@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_spdif2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
2928@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_video2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3008@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_vsync2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3088@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ó
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_hsync2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3158@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ð
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_de2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3228@Z8-113
L
%s*synth2=
;	Parameter CAPACITANCE bound to: DONT_CARE - type: string 

@
%s*synth21
/	Parameter DRIVE bound to: 12 - type: integer 

I
%s*synth2:
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 

@
%s*synth21
/	Parameter SLEW bound to: SLOW - type: string 

ñ
,binding component instance '%s' to cell '%s'113*oasys2
OBUFT_hdmio_clk2
OBUFT2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
3298@Z8-113
•
.merging register '%s' into '%s' in module '%s'3438*oasys2
hdmio_vsync_t_reg2
hdmio_spdif_t_reg2
zc702_hdmi_out2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
1808@Z8-3888
•
.merging register '%s' into '%s' in module '%s'3438*oasys2
hdmio_hsync_t_reg2
hdmio_spdif_t_reg2
zc702_hdmi_out2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
1818@Z8-3888
’
.merging register '%s' into '%s' in module '%s'3438*oasys2
hdmio_de_t_reg2
hdmio_spdif_t_reg2
zc702_hdmi_out2‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
1828@Z8-3888
é
%done synthesizing module '%s' (%s#%s)256*oasys2
zc702_hdmi_out2
12
42‚
~/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.srcs/sources_1/imports/zc702_hdmi_out/zc702_hdmi_out.vhd2
828@Z8-256
„
%s*synth2u
sfinished synthesize : Time (s): cpu = 00:00:39 ; elapsed = 00:00:43 . Memory (MB): peak = 342.355 ; gain = 214.090

)
%s*synth2
Report RTL Partitions: 

;
%s*synth2,
*-----+-------------+-----------+---------

;
%s*synth2,
*     |RTL Partition|Replication|Instances

;
%s*synth2,
*-----+-------------+-----------+---------

;
%s*synth2,
*-----+-------------+-----------+---------

«
Loading clock regions from %s
13*device2t
r/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/xilinx/zynq/zynq/xc7z020/ClockRegion.xmlZ21-13
¬
Loading clock buffers from %s
11*device2u
s/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/xilinx/zynq/zynq/xc7z020/ClockBuffers.xmlZ21-11
¬
&Loading clock placement rules from %s
318*place2l
j/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/xilinx/zynq/ClockPlacerRules.xmlZ30-318
ª
)Loading package pin functions from %s...
17*device2h
f/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/xilinx/zynq/PinFunctions.xmlZ21-17
¨
Loading package from %s
16*device2w
u/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/parts/xilinx/zynq/zynq/xc7z020/clg484/Package.xmlZ21-16
Ÿ
Loading io standards from %s
15*device2i
g/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/./parts/xilinx/zynq/IOStandards.xmlZ21-15
¦
/Loading list of drcs for the architecture : %s
17*drc2a
_/proj/xbuilds/2013.1_daily_latest/installs/lin64/Vivado/2013.1/data/./parts/xilinx/zynq/drc.xmlZ23-17
y
%s*synth2j
hPart Resources:
DSPs: 220 (col length:60)
BRAMs: 280 (col length: RAMB8 0 RAMB16 0 RAMB18 60 RAMB36 30)

Ÿ
%s*synth2
ŒFinished Loading Part and Timing Information : Time (s): cpu = 00:00:58 ; elapsed = 00:01:03 . Memory (MB): peak = 524.918 ; gain = 396.652

0
%s*synth2!
Detailed RTL Component Info : 

"
%s*synth2
+---Registers : 

?
%s*synth20
.	               16 Bit    Registers := 3     

?
%s*synth20
.	                1 Bit    Registers := 8     

4
%s*synth2%
#Hierarchical RTL Component report 

(
%s*synth2
Module zc702_hdmi_out 

0
%s*synth2!
Detailed RTL Component Info : 

"
%s*synth2
+---Registers : 

?
%s*synth20
.	               16 Bit    Registers := 3     

?
%s*synth20
.	                1 Bit    Registers := 8     

U
!design %s has unconnected port %s3331*oasys2
zc702_hdmi_out2
resetZ8-3331
]
!design %s has unconnected port %s3331*oasys2
zc702_hdmi_out2
xsvi_vblank_iZ8-3331
]
!design %s has unconnected port %s3331*oasys2
zc702_hdmi_out2
xsvi_hblank_iZ8-3331
—
%s*synth2‡
„Finished Cross Boundary Optimization : Time (s): cpu = 00:00:58 ; elapsed = 00:01:03 . Memory (MB): peak = 524.918 ; gain = 396.652

“
%s*synth2ƒ
€---------------------------------------------------------------------------------
 Start RAM, DSP and Shift Register Reporting 

c
%s*synth2T
R---------------------------------------------------------------------------------

–
%s*synth2†
ƒ---------------------------------------------------------------------------------
 Finished RAM, DSP and Shift Register Reporting 

c
%s*synth2T
R---------------------------------------------------------------------------------

i
6propagating constant %s across sequential element (%s)3333*oasys2
02
hdmio_spdif_t_regZ8-3333
…
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
hdmio_spdif_t_reg2
zc702_hdmi_outZ8-3332
‹
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[14] 2
zc702_hdmi_outZ8-3332
‹
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[13] 2
zc702_hdmi_outZ8-3332
‹
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[12] 2
zc702_hdmi_outZ8-3332
‹
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[11] 2
zc702_hdmi_outZ8-3332
‹
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[10] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[9] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[8] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[7] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[6] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[5] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[4] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[3] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[2] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[1] 2
zc702_hdmi_outZ8-3332
Š
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[0] 2
zc702_hdmi_outZ8-3332
‹
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
\hdmio_video_t_reg[15] 2
zc702_hdmi_outZ8-3332
‹
%s*synth2|
zFinished Area Optimization : Time (s): cpu = 00:00:58 ; elapsed = 00:01:03 . Memory (MB): peak = 525.949 ; gain = 397.684


%s*synth2~
|Finished Timing Optimization : Time (s): cpu = 00:00:58 ; elapsed = 00:01:03 . Memory (MB): peak = 525.949 ; gain = 397.684

Œ
%s*synth2}
{Finished Technology Mapping : Time (s): cpu = 00:00:58 ; elapsed = 00:01:03 . Memory (MB): peak = 534.957 ; gain = 406.691

†
%s*synth2w
uFinished IO Insertion : Time (s): cpu = 00:01:00 ; elapsed = 00:01:05 . Memory (MB): peak = 534.957 ; gain = 406.691

(
%s*synth2
Report Check Netlist: 

R
%s*synth2C
A-----+-----------------+------+--------+------+-----------------

R
%s*synth2C
A     |Item             |Errors|Warnings|Status|Description      

R
%s*synth2C
A-----+-----------------+------+--------+------+-----------------

R
%s*synth2C
A1    |multi_driven_nets|     0|       0|Passed|Multi driven nets

R
%s*synth2C
A-----+-----------------+------+--------+------+-----------------

˜
%s*synth2ˆ
…Finished Renaming Generated Instances : Time (s): cpu = 00:01:00 ; elapsed = 00:01:05 . Memory (MB): peak = 534.957 ; gain = 406.691

•
%s*synth2…
‚Finished Rebuilding User Hierarchy : Time (s): cpu = 00:01:00 ; elapsed = 00:01:05 . Memory (MB): peak = 534.957 ; gain = 406.691

“
%s*synth2ƒ
€---------------------------------------------------------------------------------
 Start RAM, DSP and Shift Register Reporting 

c
%s*synth2T
R---------------------------------------------------------------------------------

–
%s*synth2†
ƒ---------------------------------------------------------------------------------
 Finished RAM, DSP and Shift Register Reporting 

c
%s*synth2T
R---------------------------------------------------------------------------------

%
%s*synth2
Report BlackBoxes: 

/
%s*synth2 
-----+-------------+---------

/
%s*synth2 
     |BlackBox name|Instances

/
%s*synth2 
-----+-------------+---------

/
%s*synth2 
-----+-------------+---------

%
%s*synth2
Report Cell Usage: 

#
%s*synth2
-----+-----+-----

#
%s*synth2
     |Cell |Count

#
%s*synth2
-----+-----+-----

#
%s*synth2
1    |BUFG |    1

#
%s*synth2
2    |ODDR |    2

#
%s*synth2
3    |FDRE |   39

#
%s*synth2
4    |IBUF |   21

#
%s*synth2
5    |OBUFT|   21

#
%s*synth2
-----+-----+-----

)
%s*synth2
Report Instance Areas: 

-
%s*synth2
-----+--------+------+-----

-
%s*synth2
     |Instance|Module|Cells

-
%s*synth2
-----+--------+------+-----

-
%s*synth2
1    |top     |      |   84

-
%s*synth2
-----+--------+------+-----

”
%s*synth2„
Finished Writing Synthesis Report : Time (s): cpu = 00:01:00 ; elapsed = 00:01:05 . Memory (MB): peak = 534.957 ; gain = 406.691

X
%s*synth2I
GSynthesis finished with 0 errors, 0 critical warnings and 20 warnings.

‘
%s*synth2
Synthesis Optimization Complete : Time (s): cpu = 00:01:00 ; elapsed = 00:01:05 . Memory (MB): peak = 534.957 ; gain = 406.691

K
-Analyzing %s Unisim elements for replacement
17*netlist2
23Z29-17
O
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28
c
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111
1
%Phase 0 | Netlist Checksum: ad08b594
*common
:
Releasing license: %s
83*common2
	SynthesisZ17-83
v
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
352
202
02
0Z4-41
C
%s completed successfully
29*	vivadotcl2
synth_designZ4-42
¢
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:01:012

00:01:082	
792.6022	
628.965Z17-268

ureport_utilization: Time (s): cpu = 00:00:00.03 ; elapsed = 00:00:00.53 . Memory (MB): peak = 792.602 ; gain = 0.000
*common
<
%Done setting XDC timing constraints.
35*timingZ38-35
n
UpdateTimingParams:%s.
91*timing2>
< Speed grade: -1, Delay Type: min_max, Constraints type: SDCZ38-91
a
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
4Z38-191
S
Exiting %s at %s...
206*common2
Vivado2
Mon Mar  4 16:34:06 2013Z17-206