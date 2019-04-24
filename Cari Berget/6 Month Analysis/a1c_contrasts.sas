1     /**********************************************************************
2     *   PRODUCT:   SAS
3     *   VERSION:   9.4
4     *   CREATOR:   External File Interface
5     *   DATE:      24APR19
6     *   DESC:      Generated SAS Datastep Code
7     *   TEMPLATE SOURCE:  (None Specified.)
8     ***********************************************************************/
9        data WORK.data_no_m1    ;
10       %let _EFIERR_ = 0; /* set the ERROR detection macro variable */
11       infile '\\Mac\Home\Desktop\cari.csv' delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2
11 !  ;
12          informat record_id $5. ;
13          informat date $10. ;
14          informat days best32. ;
15          informat tpoint $4. ;
16          informat hba1c best32. ;
17          informat am_time best32. ;
18          informat mm_time best32. ;
19          informat sensor_wear best32. ;
20          informat sensor_u54 best32. ;
21          informat sensor_55_69 best32. ;
22          informat sensor_70_180 best32. ;
23          informat sensor_181_250 best32. ;
24          informat sensor_g250 best32. ;
25          informat mean_sg best32. ;
26          informat sd best32. ;
27          informat bg_checks best32. ;
28          informat calibrations best32. ;
29          informat tdd best32. ;
30          informat basal best32. ;
31          informat bolus best32. ;
32          informat amexit best32. ;
33          informat amexit_day best32. ;
34          informat amexit_hyper best32. ;
35          informat amexit_hypo best32. ;
36          informat amexit_manual best32. ;
37          informat amexit_other best32. ;
38          informat automode_start $9. ;
39          informat cpaid_score best32. ;
40          informat cbehavior_score best32. ;
41          informat cworry_score best32. ;
42          informat ctotal_score best32. ;
43          informat yapaid_score best32. ;
44          informat yabehavior_score best32. ;
45          informat yaworry_score best32. ;
46          informat yatotal_score best32. ;
47          informat ppaid_score best32. ;
48          informat pbehavior_score best32. ;
49          informat pworry_score best32. ;
50          informat ptotal_score best32. ;
51          informat baseline_a1c best32. ;
52          informat age_group $6. ;
53          informat hba1c_clinical $9. ;
54          format record_id $5. ;
55          format date $10. ;
56          format days best12. ;
57          format tpoint $4. ;
58          format hba1c best12. ;
59          format am_time best12. ;
60          format mm_time best12. ;
61          format sensor_wear best12. ;
62          format sensor_u54 best12. ;
63          format sensor_55_69 best12. ;
64          format sensor_70_180 best12. ;
65          format sensor_181_250 best12. ;
66          format sensor_g250 best12. ;
67          format mean_sg best12. ;
68          format sd best12. ;
69          format bg_checks best12. ;
70          format calibrations best12. ;
71          format tdd best12. ;
72          format basal best12. ;
73          format bolus best12. ;
74          format amexit best12. ;
75          format amexit_day best12. ;
76          format amexit_hyper best12. ;
77          format amexit_hypo best12. ;
78          format amexit_manual best12. ;
79          format amexit_other best12. ;
80          format automode_start $9. ;
81          format cpaid_score best12. ;
82          format cbehavior_score best12. ;
83          format cworry_score best12. ;
84          format ctotal_score best12. ;
85          format yapaid_score best12. ;
86          format yabehavior_score best12. ;
87          format yaworry_score best12. ;
88          format yatotal_score best12. ;
89          format ppaid_score best12. ;
90          format pbehavior_score best12. ;
91          format pworry_score best12. ;
92          format ptotal_score best12. ;
93          format baseline_a1c best12. ;
94          format age_group $6. ;
95          format hba1c_clinical $9. ;
96       input
97                   record_id  $
98                   date  $
99                   days
100                  tpoint  $
101                  hba1c
102                  am_time
103                  mm_time
104                  sensor_wear
105                  sensor_u54
106                  sensor_55_69
107                  sensor_70_180
108                  sensor_181_250
109                  sensor_g250
110                  mean_sg
111                  sd
112                  bg_checks
113                  calibrations
114                  tdd
115                  basal
116                  bolus
117                  amexit
118                  amexit_day
119                  amexit_hyper
120                  amexit_hypo
121                  amexit_manual
122                  amexit_other
123                  automode_start  $
124                  cpaid_score
125                  cbehavior_score
126                  cworry_score
127                  ctotal_score
128                  yapaid_score
129                  yabehavior_score
130                  yaworry_score
131                  yatotal_score
132                  ppaid_score
133                  pbehavior_score
134                  pworry_score
135                  ptotal_score
136                  baseline_a1c
137                  age_group  $
138                  hba1c_clinical  $
139      ;
140      if _ERROR_ then call symputx('_EFIERR_',1);  /* set ERROR detection macro variable */
141      run;

proc mixed data=data_no_m1;
class record_id tpoint(ref="B") hba1c_clinical(ref="(0,7.5]");
model hba1c = tpoint hba1c_clinical tpoint*hba1c_clinical / s;
random intercept / subject = record_id;
run;

proc mixed data=data_no_m1;
class record_id tpoint(ref="B") hba1c_clinical(ref="(0,7.5]");
model hba1c = tpoint*hba1c_clinical / s noint;
random intercept / subject = record_id;
ESTIMATE "B. vs T1, Low A1c" tpoint*hba1c_clinical 0 0 1 0 0 0 0 0 -1/E;
ESTIMATE "B. vs T1, Medium A1c" tpoint*hba1c_clinical 1 0 0 0 0 0 -1 0 0/E;
ESTIMATE "B. vs T1, High A1c" tpoint*hba1c_clinical 0 1 0 0 0 0 0 -1 0/E;
ESTIMATE "B. vs T2, Low A1c" tpoint*hba1c_clinical 0 0 1 0 0 0 0 0 -1/E;
ESTIMATE "B. vs T2, Medium A1c" tpoint*hba1c_clinical 1 0 0 0 0 0 -1 0 0/E;
ESTIMATE "B. vs T2, High A1c" tpoint*hba1c_clinical 0 1 0 0 0 0 0 -1 0/E;
run;
