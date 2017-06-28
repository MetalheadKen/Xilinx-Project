
6
Command: %s
53*	vivadotcl2
route_designZ4-113
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
route_designZ4-22
5
Running DRC with %s threads
24*drc2
4Z23-27
;

Starting %s Task
103*constraints2	
RoutingZ18-103
^
BMultithreading enabled for route_design using a maximum of %s CPUs97*route2
4Z35-254
9

Starting %s Task
103*constraints2
RouteZ18-103
C

Phase %s%s
101*constraints2
1 2
Build RT DesignZ18-101
T

Phase %s%s
101*constraints2
1.1 2 
Build Netlist & NodeGraph (MT)Z18-101
¯
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2
00:00:00.012

00:00:002	
790.4022
0.000Z17-268
C
7Phase 1.1 Build Netlist & NodeGraph (MT) | Checksum: 0
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:27 . Memory (MB): peak = 909.750 ; gain = 119.348
2
&Phase 1 Build RT Design | Checksum: 0
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:27 . Memory (MB): peak = 909.750 ; gain = 119.348
I

Phase %s%s
101*constraints2
2 2
Router InitializationZ18-101
r
\No timing constraints were detected. The router will operate in resource-optimization mode.
64*routeZ35-64
Q
3Estimated Global Vertical Wire Utilization = %s %%
23*route2
0.03Z35-23
S
5Estimated Global Horizontal Wire Utilization = %s %%
22*route2
0.01Z35-22
E

Phase %s%s
101*constraints2
2.1 2
Restore RoutingZ18-101
:
Design has %s routable nets.
92*route2
65Z35-249
?
#Restored %s nets from the routeDb.
95*route2
0Z35-252
E
)Found %s nets with FIXED_ROUTE property.
94*route2
0Z35-251
;
/Phase 2.1 Restore Routing | Checksum: b5bb398a
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:27 . Memory (MB): peak = 917.781 ; gain = 127.379
I

Phase %s%s
101*constraints2
2.2 2
Special Net RoutingZ18-101
?
3Phase 2.2 Special Net Routing | Checksum: 7e78d8c3
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
M

Phase %s%s
101*constraints2
2.3 2
Local Clock Net RoutingZ18-101
C
7Phase 2.3 Local Clock Net Routing | Checksum: 7e78d8c3
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
?
3Phase 2 Router Initialization | Checksum: 7e78d8c3
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
C

Phase %s%s
101*constraints2
3 2
Initial RoutingZ18-101
9
-Phase 3 Initial Routing | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
F

Phase %s%s
101*constraints2
4 2
Rip-up And RerouteZ18-101
H

Phase %s%s
101*constraints2
4.1 2
Global Iteration 0Z18-101
>
2Phase 4.1 Global Iteration 0 | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
H

Phase %s%s
101*constraints2
4.2 2
Global Iteration 1Z18-101
>
2Phase 4.2 Global Iteration 1 | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
H

Phase %s%s
101*constraints2
4.3 2
Global Iteration 2Z18-101
>
2Phase 4.3 Global Iteration 2 | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
H

Phase %s%s
101*constraints2
4.4 2
Global Iteration 3Z18-101
>
2Phase 4.4 Global Iteration 3 | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
H

Phase %s%s
101*constraints2
4.5 2
Global Iteration 4Z18-101
>
2Phase 4.5 Global Iteration 4 | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
<
0Phase 4 Rip-up And Reroute | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
A

Phase %s%s
101*constraints2
5 2
Post Hold FixZ18-101
7
+Phase 5 Post Hold Fix | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
I

Phase %s%s
101*constraints2
6 2
Verifying routed netsZ18-101
?
3Phase 6 Verifying routed nets | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
E

Phase %s%s
101*constraints2
7 2
Depositing RoutesZ18-101
;
/Phase 7 Depositing Routes | Checksum: 68fa618d
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
4
Router Completed Successfully
16*routeZ35-16
,
 Ending Route Task | Checksum: 0
*common
u

%s
*constraints2^
\Time (s): cpu = 00:00:35 ; elapsed = 00:00:28 . Memory (MB): peak = 921.781 ; gain = 131.379
:
Feature available: %s
81*common2
	V_WebPACKZ17-81
j
QWebTalk data collection is enabled (User setting is ON. Install Setting is ON.).
118*projectZ1-118
u

%s
*constraints2^
\Time (s): cpu = 00:00:38 ; elapsed = 00:00:31 . Memory (MB): peak = 921.789 ; gain = 131.387
?
Releasing license: %s
83*common2
ImplementationZ17-83
u
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
352
02
02
0Z4-41
C
%s completed successfully
29*	vivadotcl2
route_designZ4-42
¢
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
route_design: 2

00:00:402

00:00:332	
921.7892	
137.039Z17-268
5
Running DRC with %s threads
24*drc2
4Z23-27
¥
#The results of DRC are in file %s.
168*coretcl2ä
o/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.runs/impl_1/zc702_hdmi_out_drc_routed.rpto/group/mvico/users/elzinga/designs/zc702_hdmi_out/project_1/project_1.runs/impl_1/zc702_hdmi_out_drc_routed.rpt8Z2-168
B
,Running Vector-less Activity Propagation...
51*powerZ33-51
G
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1
n
UpdateTimingParams:%s.
91*timing2>
< Speed grade: -1, Delay Type: min_max, Constraints type: SDCZ38-91
a
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
4Z38-191
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
00:00:00.162
00:00:00.172	
931.7932
0.000Z17-268


End Record