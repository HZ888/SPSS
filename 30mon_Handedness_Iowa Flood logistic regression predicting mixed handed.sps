
*14 Jan 2014.
*add data for the 6 removed participants upon reusing 280 exposure days. 
*

MATCH FILES /FILE=*
  /FILE='DataSet5'
  /RENAME (Communication_A Communication_R Manipulation_A Manipulation_R VMI_A VMI_R = d0 d1 d2 d3 
    d4 d5) 
  /BY ID
  /DROP= d0 d1 d2 d3 d4 d5.
EXECUTE.

*IESR

GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and manuscripts\SPSS DATA\SPSS '+
    'DATA FILES ORIGINAL\Current_Iowa_Flood_Predictors_SYS.sav'.
DATASET NAME IESR WINDOW=FRONT.


GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and '+
    'manuscripts\Analyses\30mon_Handedness_Iowa Flood.sav'.
DATASET NAME Handedness WINDOW=FRONT.


SORT CASES BY ID.

MATCH FILES /FILE=*
  /FILE='DataSet10'
  /RENAME (IESR_T_IM sexbebe IF100 = d0 d1 d2) 
  /BY ID
  /DROP= d0 d1 d2.
EXECUTE.

*SEXBEBE

MATCH FILES /FILE=*
  /FILE='DataSet10'
  /RENAME (IF100_log IESR_T_IM IESR_log_IM IF100 = d0 d1 d2 d3) 
  /BY ID
  /DROP= d0 d1 d2 d3.
EXECUTE.

*FETAL RISK.

MATCH FILES /FILE=*
  /FILE='DataSet20'
  /BY ID.
EXECUTE.

*EXPOSUREDAYS280.

MATCH FILES /FILE=*
  /FILE='DataSet23'
  /BY ID.
EXECUTE.

*Jan 17 2014 add parental handedness, which were removed from the database.


GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and '+
    'manuscripts\Analyses\30mon_Handedness_Iowa Flood.sav'.
DATASET NAME Handedness_30mon_IOWA WINDOW=FRONT.



DATASET ACTIVATE Handedness_30mon_IOWA WINDOW=FRONT.
MATCH FILES /FILE=*
  /FILE='DataSet2'
  /BY ID.
EXECUTE.


*Jan 21ST 2014.

GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and manuscripts\SPSS DATA\SPSS DATA FILES ORIGINAL\30 mon_child_handedness_scoring handednessSYS.sav'.
DATASET NAME ChildHandedness WINDOW=FRONT.

GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and manuscripts\Analyses\30mon_Handedness_Iowa Flood.sav'.
DATASET NAME HandednessData WINDOW=FRONT.


DATASET ACTIVATE HandednessData.
SORT CASES BY ID(A).

DATASET ACTIVATE ChildHandedness.
SORT CASES BY ID(A).

MATCH FILES /FILE=*
  /FILE='ChildHandedness'
  /BY ID.
EXECUTE.

*Create binary variable to represent fetal risk factors.

IF (FETALRISK EQ 0) FETALRISK10=0.
IF (FETALRISK GT 1) FETALRISK10=1.



DESCRIPTIVES VARIABLES=Questionnaires_A VMI_A Communication_A Manipulation_A Questionnaires_R VMI_R 
    Communication_R Manipulation_R
  /STATISTICS=MEAN STDDEV MIN MAX.



FREQUENCIES VARIABLES=Questionnaires_A VMI_A Communication_A Manipulation_A Questionnaires_R VMI_R 
    Communication_R Manipulation_R
  /ORDER=ANALYSIS.

*compute interactions with updated variables.
 
COMPUTE IF100byIESRR=IF100_log * IESR_log_IM.
VARIABLE LABELS  IF100byIESRR 'COMPUTE IF100byIESRR=IF100_log * IESR_log_IM'.
EXECUTE.

COMPUTE IF100_Exposuredays=IF100_log * exposuredays_280.
VARIABLE LABELS  IF100_Exposuredays 'COMPUTE IF100_Exposuredays=IF100_log * exposuredays_280'.
EXECUTE.

COMPUTE IESR_Exposuredays=IESR_log_IM * exposuredays_280.
VARIABLE LABELS  IESR_Exposuredays 'COMPUTE IESR_Exposuredays=IESR_log_IM * exposuredays_280'.
EXECUTE.

COMPUTE IF100_Sexbebe=IF100_log * SEXBEBE.
VARIABLE LABELS  IF100_Sexbebe 'COMPUTE IF100_Sexbebe=IF100_log * SEXBEBE'.
EXECUTE.

COMPUTE IESR_Sexbebe=IESR_log_IM * SEXBEBE.
VARIABLE LABELS  IESR_Sexbebe 'COMPUTE IESR_Sexbebe=IESR_log_IM * SEXBEBE'.
EXECUTE.

COMPUTE Exposuredays_sexbebe=exposuredays_280 * SEXBEBE.
VARIABLE LABELS  Exposuredays_sexbebe 'COMPUTE Exposuredays_sexbebe=exposuredays_280 * SEXBEBE'.
EXECUTE.

*Compute Nonrighthanded10.

IF (CommunicationR GT .50) CommunicationNonrighthandedB=0.
IF (CommunicationR EQ .50) CommunicationNonrighthandedB=0.
IF (CommunicationR LE .50) CommunicationNonrighthandedB=1.


DATASET ACTIVATE Handedness.
SORT CASES BY Questionnaires_A(A).

*Jan 22 2014.

DATASET ACTIVATE Handedness.
FREQUENCIES VARIABLES=Questionnaires_R Q_PercentageRightHandedness Questionnaire_Nonrighthanded10 
    VMI_R CommunicationR CommunicationNonrighthandedB Manipulation_R Questionnaires_A VMI_A 
    Communication_A Manipulation_A
  /ORDER=ANALYSIS.

*recode questionnaire report into 0 mixed handed, 1 right/left handed.

IF (Questionnaires_A GT .5) Questionnaires_A01=0.
IF (Questionnaires_A EQ .5) Questionnaires_A01=1.
IF (Questionnaires_A LE .5) Questionnaires_A01=1.
EXECUTE.

*Maternal hand preference.

IF (P1_A GT .5) P1_A01Mixed=0.
IF (P1_A EQ .5) P1_A01Mixed=0.
IF (P1_A LE .5) P1_A01Mixed=1.
EXECUTE.

*VMI/drawing tasks.

IF (VMI_A GT .5) VMI_A01Mixed=0.
IF (VMI_A EQ .5) VMI_A01Mixed=0.
IF (VMI_A LE .5) VMI_A01Mixed=1.
EXECUTE.

*Communication.

IF (Communication_A GT .5) Communication_A01Mixed=0.
IF (Communication_A EQ .5) Communication_A01Mixed=0.
IF (Communication_A LE .5) Communication_A01Mixed=1.
EXECUTE.

*Manipulation.

IF (Manipulation_A GT .5) Manipulation_A01Mixed=0.
IF (Manipulation_A EQ .5) Manipulation_A01Mixed=0.
IF (Manipulation_A LE .5) Manipulation_A01Mixed=1.
EXECUTE.

*sorting cases.

SORT CASES BY Questionnaires_A.

SORT CASES BY P1_A.

SORT CASES BY VMI_A.

SORT CASES BY Communication_A.

SORT CASES BY Manipulation_A.



DATASET ACTIVATE Handedness.
MATCH FILES /FILE=*
  /FILE='IESR'
  /BY ID.
EXECUTE.


FREQUENCIES VARIABLES=IESR_log_IM
  /ORDER=ANALYSIS.

DESCRIPTIVES VARIABLES=IESR_log_IM.

DESCRIPTIVES VARIABLES=IESR_log_IM
  /STATISTICS=MEAN STDDEV MIN MAX KURTOSIS SKEWNESS.

FREQUENCIES VARIABLES=IESR_log_IM
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

*calculating the requency of left, mixed, and right handedness.

*Questionnaires101.

IF (Questionnaires_R GT 0.5) Questionnaires101=1.
IF (Questionnaires_R LE 0.5) AND (Questionnaires_R GE -0.5) Questionnaires101=0.
IF (Questionnaires_R LT -0.5) Questionnaires101=-1.
EXECUTE.

*VMI101.

IF (VMI_R GT 0.5) VMI101=1.
IF (VMI_R LE 0.5) AND (VMI_R GE -0.5) VMI101=0.
IF (VMI_R LT -0.5) VMI101=-1.
EXECUTE.

*CommunicationR.

IF (CommunicationR GT 0.5) Communication101=1.
IF (CommunicationR LE 0.5) AND (CommunicationR GE -0.5) Communication101=0.
IF (CommunicationR LT -0.5) Communication101=-1.
EXECUTE.

SORT CASES CommunicationR.

*Manipulation101.

IF (Manipulation_R GT 0.5) Manipulation101=1.
IF (Manipulation_R LE 0.5) AND (Manipulation_R GE -0.5) Manipulation101=0.
IF (Manipulation_R LT -0.5) Manipulation101=-1.
EXECUTE.

SORT CASES Manipulation_R.

*Logistic Regression analyses.

LOGISTIC REGRESSION VARIABLES Questionnaires_A01Mixed
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM 
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe
  /METHOD=ENTER Fetalrisk10
 /METHOD=ENTER P1_A01Mixed
 /METHOD=ENTER IDASGENDEP
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES VMI_A01Mixed
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM 
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe
  /METHOD=ENTER Fetalrisk10
 /METHOD=ENTER P1_A01Mixed
 /METHOD=ENTER IDASGENDEP
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES Communication_A01Mixed
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM 
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe
  /METHOD=ENTER Fetalrisk10
 /METHOD=ENTER P1_A01Mixed
 /METHOD=ENTER IDASGENDEP
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES Manipulation_A01Mixed
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM 
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe
  /METHOD=ENTER Fetalrisk10
 /METHOD=ENTER P1_A01Mixed
 /METHOD=ENTER IDASGENDEP
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

*Linear regression.

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.1) POUT(.2)
  /NOORIGIN 
  /DEPENDENT Questionnaires_R
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe
  /METHOD=STEPWISE Fetalrisk10
 /METHOD=STEPWISE P1_A01Mixed
  /RESIDUALS HISTOGRAM(ZRESID).

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.1) POUT(.2)
  /NOORIGIN 
  /DEPENDENT Questionnaires_A
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe
  /METHOD=STEPWISE IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /METHOD=STEPWISE Fetalrisk10
 /METHOD=STEPWISE P1_A01Mixed
  /RESIDUALS HISTOGRAM(ZRESID).

*frequency.

FREQUENCIES VARIABLES=Questionnaires101.

FREQUENCIES VARIABLES=VMI101.

FREQUENCIES VARIABLES=Communication101.

FREQUENCIES VARIABLES=Manipulation101.

*bivariate correlation. jan 27 2014.

*correlation for handedness direction based on raw scores.

CORRELATIONS
  /VARIABLES=Questionnaires_R CommunicationR Manipulation_R VMI_R 
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*correlation for mixed handedness.

CORRELATIONS
  /VARIABLES=Questionnaires_A01Mixed VMI_A01Mixed Communication_A01Mixed Manipulation_A01Mixed  
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*descriptive data about mixed handedness variables.

DESCRIPTIVES VARIABLES=Questionnaires_A01Mixed VMI_A01Mixed Communication_A01Mixed Manipulation_A01Mixed.

*ADD ses, depression, birthweight, and life events to the database.

SAVE OUTFILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and manuscripts\SPSS DATA\SPSS DATA FILES ORIGINAL\30mon_Handedness_Iowa Flood_with All variables_SES, BIRTHWEIGHT,SYS.sav'
  /COMPRESSED.


GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and manuscripts\SPSS DATA\SPSS '+
    'DATA FILES ORIGINAL\30mon_Handedness_Iowa Flood_with All variables_SES, BIRTHWEIGHT,SYS.sav'.
DATASET NAME SES WINDOW=FRONT.

GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and '+
    'manuscripts\Analyses\30mon_Handedness_Iowa Flood.sav'.
DATASET NAME Handedness WINDOW=FRONT.

SORT CASES by ID.

DATASET ACTIVATE Handedness.
MATCH FILES /FILE=*
  /FILE='SES'
  /BY ID.
EXECUTE.


SAVE OUTFILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and manuscripts\Analyses\30mon_Handedness_Iowa Flood.sav'
  /COMPRESSED.

*correlations between flood variables and independent variables.

CORRELATIONS
  /VARIABLES=IF100_log IESR_log_IM exposuredays_280 SEXBEBE FETALRISK10 P1_A01Mixed P2_A01Mixed BIRTHWEIGHT 
IDASGENDEP LES_TOT HOUSESES_H WITH Questionnaires_A01Mixed VMI_A01Mixed Communication_A01Mixed Manipulation_A01Mixed
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.

*compute P2_A01Mixed.

IF (P2_R LT -0.5) P2_A01Mixed=0.
IF (P2_R GT 0.5) P2_A01Mixed=0.
IF (P2_R LE 0.5) AND (P2_R GE -0.5) P2_A01Mixed=1.
EXECUTE.

*frequency.

FREQUENCIES VARIABLES=trimester_280_Out_old.

FREQUENCIES VARIABLES=SEXBEBE.

FREQUENCIES VARIABLES=P1_A.

FREQUENCIES VARIABLES=P1_A01Mixed.

*compute maternal hand preference.

IF (P1_R LT -0.5) P1_101=-1.
IF (P1_R LE 0.5) AND (P1_R GE -0.5) P1_101=0.
IF (P1_R GT 0.5) P1_101=1.
EXECUTE.

*frequency.
FREQUENCIES VARIABLES=P1_101.

*compute paternal hand preference.

IF (P2_R LT -0.5) P2_101=-1.
IF (P2_R LE 0.5) AND (P2_R GE -0.5) P2_101=0.
IF (P2_R GT 0.5) P2_101=1.
EXECUTE.

*frequency.
FREQUENCIES VARIABLES=P2_101.


*Chi-square test about the effect of sex of mixed handedness.

DATASET ACTIVATE Handedness.
CROSSTABS
  /TABLES=Questionnaires_A01Mixed BY SEXBEBE
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

DATASET ACTIVATE Handedness.
CROSSTABS
  /TABLES=VMI_A01Mixed BY SEXBEBE
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

DATASET ACTIVATE Handedness.
CROSSTABS
  /TABLES=Communication_A01Mixed BY SEXBEBE
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

DATASET ACTIVATE Handedness.
CROSSTABS
  /TABLES=Manipulation_A01Mixed BY SEXBEBE
  /FORMAT=AVALUE TABLES
  /STATISTICS=CHISQ 
  /CELLS=COUNT
  /COUNT ROUND CELL.

* get girls`and boys`handedness.

GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and manuscripts\Analyses\30mon_Handedness_Iowa Flood_GIRLS.sav'.
DATASET NAME GIRLS WINDOW=FRONT.

GET
  FILE='Y:\Rech\SKing\RA\Research Staff\HZ\Handedness\Analysis and '+
    'manuscripts\Analyses\30mon_Handedness_Iowa Flood_GUYS.sav'.
DATASET NAME GUYS WINDOW=FRONT.
