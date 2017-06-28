
4
Command: %s
53*	vivadotcl2

opt_designZ4-113
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
S
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_designZ4-22
5
Running DRC with %s threads
24*drc2
4Z23-27
<
%Done setting XDC timing constraints.
35*timingZ38-35
F

Starting %s Task
103*constraints2
Logic OptimizationZ18-103
4
(Logic Optimization | Checksum: bae6b490
*common
<

Phase %s%s
101*constraints2
1 2

RetargetZ18-101
0
Retargeted %s cell(s).
49*opt2
0Z31-49
2
&Phase 1 Retarget | Checksum: bae6b490
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.04 ; elapsed = 00:00:00.04 . Memory (MB): peak = 729.699 ; gain = 0.000
H

Phase %s%s
101*constraints2
2 2
Constant PropagationZ18-101
.
Eliminated %s cells.
10*opt2
0Z31-10
>
2Phase 2 Constant Propagation | Checksum: bae6b490
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.04 ; elapsed = 00:00:00.05 . Memory (MB): peak = 729.699 ; gain = 0.000
9

Phase %s%s
101*constraints2
3 2
SweepZ18-101
9
 Eliminated %s unconnected nets.
12*opt2
0Z31-12
:
!Eliminated %s unconnected cells.
11*opt2
0Z31-11
/
#Phase 3 Sweep | Checksum: bae6b490
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.05 ; elapsed = 00:00:00.05 . Memory (MB): peak = 729.699 ; gain = 0.000
@
4Ending Logic Optimization Task | Checksum: bae6b490
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.05 ; elapsed = 00:00:00.05 . Memory (MB): peak = 729.699 ; gain = 0.000
<
%Done setting XDC timing constraints.
35*timingZ38-35
F

Starting %s Task
103*constraints2
Power OptimizationZ18-103
S
:Power Optimization is not supported for this architecture.151*pwroptZ34-196
@
4Ending Power Optimization Task | Checksum: bae6b490
*common
y

%s
*constraints2b
`Time (s): cpu = 00:00:00.01 ; elapsed = 00:00:00.01 . Memory (MB): peak = 729.699 ; gain = 0.000
?
Releasing license: %s
83*common2
ImplementationZ17-83
u
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
142
02
02
0Z4-41
A
%s completed successfully
29*	vivadotcl2

opt_designZ4-42


End Record