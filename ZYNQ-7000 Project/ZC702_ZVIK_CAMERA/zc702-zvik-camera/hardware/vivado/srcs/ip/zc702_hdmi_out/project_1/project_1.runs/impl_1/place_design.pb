
6
Command: %s
53*	vivadotcl2
place_designZ4-113
v
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2	
xc7z020Z17-347
f
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2	
xc7z020Z17-349
U
,Running DRC as a precondition to command %s
22*	vivadotcl2
place_designZ4-22
5
Running DRC with %s threads
24*drc2
4Z23-27
:

Starting %s Task
103*constraints2
PlacerZ18-103
b
BMultithreading enabled for place_design using a maximum of %s CPUs12*	placeflow2
4Z30-611
P

Phase %s%s
101*constraints2
1 2
Mandatory Logic OptimizationZ18-101
¬
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002	
729.7032
0.000Z17-268
F
:Phase 1 Mandatory Logic Optimization | Checksum: a5af1b31
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.02 ; elapsed = 00:00:00.03 . Memory (MB): peak = 729.703 ; gain = 0.000
B

Phase %s%s
101*constraints2
2 2
Build SLR InfoZ18-101
8
,Phase 2 Build SLR Info | Checksum: a5af1b31
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.04 ; elapsed = 00:00:00.05 . Memory (MB): peak = 729.703 ; gain = 0.000
C

Phase %s%s
101*constraints2
3 2
Add ConstraintsZ18-101
9
-Phase 3 Add Constraints | Checksum: a5af1b31
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.04 ; elapsed = 00:00:00.05 . Memory (MB): peak = 729.703 ; gain = 0.000
@

Phase %s%s
101*constraints2
4 2
Build ShapesZ18-101
6
*Phase 4 Build Shapes | Checksum: a5af1b31
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.05 ; elapsed = 00:00:00.06 . Memory (MB): peak = 729.703 ; gain = 0.000
T

Phase %s%s
101*constraints2
5 2"
 Implementation Feasibility checkZ18-101
J
>Phase 5 Implementation Feasibility check | Checksum: a5af1b31
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.07 ; elapsed = 00:00:00.09 . Memory (MB): peak = 729.703 ; gain = 0.000
E

Phase %s%s
101*constraints2
6 2
PrePlace ElementsZ18-101
;
/Phase 6 PrePlace Elements | Checksum: a5af1b31
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.08 ; elapsed = 00:00:00.10 . Memory (MB): peak = 729.703 ; gain = 0.000
I

Phase %s%s
101*constraints2
7 2
Placer InitializationZ18-101
L

Phase %s%s
101*constraints2
7.1 2
IO & Clk Placer & InitZ18-101
B
6Phase 7.1 IO & Clk Placer & Init | Checksum: a5af1b31
*common
z

%s
*constraints2c
aTime (s): cpu = 00:00:00.54 ; elapsed = 00:00:00.41 . Memory (MB): peak = 763.746 ; gain = 34.043
J

Phase %s%s
101*constraints2
7.2 2
Build Placer NetlistZ18-101
I

Phase %s%s
101*constraints2
7.2.1 2
Place Init DesignZ18-101
@
4Phase 7.2.1 Place Init Design | Checksum: 154c9b0cc
*common
z

%s
*constraints2c
aTime (s): cpu = 00:00:00.66 ; elapsed = 00:00:00.54 . Memory (MB): peak = 764.746 ; gain = 35.043
A
5Phase 7.2 Build Placer Netlist | Checksum: 154c9b0cc
*common
z

%s
*constraints2c
aTime (s): cpu = 00:00:00.66 ; elapsed = 00:00:00.54 . Memory (MB): peak = 764.746 ; gain = 35.043
F

Phase %s%s
101*constraints2
7.3 2
Constrain ClocksZ18-101
=
1Phase 7.3 Constrain Clocks | Checksum: 154c9b0cc
*common
z

%s
*constraints2c
aTime (s): cpu = 00:00:00.66 ; elapsed = 00:00:00.54 . Memory (MB): peak = 764.746 ; gain = 35.043
@
4Phase 7 Placer Initialization | Checksum: 154c9b0cc
*common
z

%s
*constraints2c
aTime (s): cpu = 00:00:00.66 ; elapsed = 00:00:00.55 . Memory (MB): peak = 764.746 ; gain = 35.043
D

Phase %s%s
101*constraints2
8 2
Global PlacementZ18-101
:
.Phase 8 Global Placement | Checksum: 73551efb
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.80 . Memory (MB): peak = 769.746 ; gain = 40.043
D

Phase %s%s
101*constraints2
9 2
Detail PlacementZ18-101
P

Phase %s%s
101*constraints2
9.1 2
Commit Multi Column shapesZ18-101
F
:Phase 9.1 Commit Multi Column shapes | Checksum: 73551efb
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.80 . Memory (MB): peak = 769.746 ; gain = 40.043
R

Phase %s%s
101*constraints2
9.2 2
Commit Most Shapes & LUTRAMsZ18-101
H
<Phase 9.2 Commit Most Shapes & LUTRAMs | Checksum: c74e4e26
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.83 . Memory (MB): peak = 769.746 ; gain = 40.043
?

Phase %s%s
101*constraints2
9.3 2
	Area SwapZ18-101
5
)Phase 9.3 Area Swap | Checksum: d2cb8f63
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.85 . Memory (MB): peak = 769.746 ; gain = 40.043
D

Phase %s%s
101*constraints2
9.4 2
Path OptimizerZ18-101
:
.Phase 9.4 Path Optimizer | Checksum: d2cb8f63
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.85 . Memory (MB): peak = 769.746 ; gain = 40.043
I

Phase %s%s
101*constraints2
9.5 2
Commit Small ShapesZ18-101
?
3Phase 9.5 Commit Small Shapes | Checksum: 4277cbaf
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.94 . Memory (MB): peak = 784.750 ; gain = 55.047
E

Phase %s%s
101*constraints2
9.6 2
Assign LUT pinsZ18-101
;
/Phase 9.6 Assign LUT pins | Checksum: 4277cbaf
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.95 . Memory (MB): peak = 784.750 ; gain = 55.047
:
.Phase 9 Detail Placement | Checksum: 4277cbaf
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.95 . Memory (MB): peak = 784.750 ; gain = 55.047
F

Phase %s%s
101*constraints2
10 2
PostPlace CleanupZ18-101
<
0Phase 10 PostPlace Cleanup | Checksum: 4277cbaf
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.95 . Memory (MB): peak = 784.750 ; gain = 55.047
E

Phase %s%s
101*constraints2
11 2
Placer ReportingZ18-101
;
/Phase 11 Placer Reporting | Checksum: 4277cbaf
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.95 . Memory (MB): peak = 784.750 ; gain = 55.047
<

Phase %s%s
101*constraints2
12 2	
CleanupZ18-101
2
&Phase 12 Cleanup | Checksum: 4277cbaf
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.95 . Memory (MB): peak = 784.750 ; gain = 55.047
4
(Ending Placer Task | Checksum: a83dbbff
*common
w

%s
*constraints2`
^Time (s): cpu = 00:00:01 ; elapsed = 00:00:00.96 . Memory (MB): peak = 784.750 ; gain = 55.047
?
Releasing license: %s
83*common2
ImplementationZ17-83
u
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
192
02
02
0Z4-41
C
%s completed successfully
29*	vivadotcl2
place_designZ4-42
O

DEBUG : %s144*timing2*
(Generate clock report | CPU: 0.04 secs 
Z38-163

ureport_utilization: Time (s): cpu = 00:00:00.02 ; elapsed = 00:00:00.13 . Memory (MB): peak = 784.750 ; gain = 0.000
*common
X

DEBUG : %s134*designutils2.
,Generate Control Sets report | CPU: 0 secs 
Z20-134
4
Writing XDEF routing.
211*designutilsZ20-211
A
#Writing XDEF routing logical nets.
209*designutilsZ20-209
A
#Writing XDEF routing special nets.
210*designutilsZ20-210
­
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write XDEF Complete: 2
00:00:00.212
00:00:00.232	
784.7502
0.000Z17-268


End Record