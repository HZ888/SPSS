*analyses were done with outdated IESR score.

LOGISTIC REGRESSION VARIABLES Questionnaire_Nonrighthanded10
  /METHOD=ENTER IF100_OUT_LN 
  /METHOD=ENTER IESR_OUT_LN
  /METHOD=ENTER Exposuredays_269_OUT
  /METHOD=ENTER Sexbebe 
  /METHOD=ENTER Fetalrisk2_Modified
  /METHOD=FSTEP IF100_IESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES Questionnaire_Nonrighthanded10
  /METHOD=ENTER IF100_OUT_LN 
  /METHOD=ENTER IESR_OUT_LN
  /METHOD=ENTER Exposuredays_269_OUT
  /METHOD=ENTER Sexbebe 
  /METHOD=ENTER Fetalrisk2_Modified
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES 
  /METHOD=ENTER IF100_OUT_LN 
  /METHOD=ENTER IESR_OUT_LN 
  /METHOD=ENTER Exposuredays_269_OUT
  /METHOD=ENTER Sexbebe 
  /METHOD=FSTEP IF100_IESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

LOGISTIC REGRESSION VARIABLES 
  /METHOD=ENTER IF100_OUT_LN
  /METHOD=ENTER IESR_OUT_LN 
  /METHOD=ENTER Exposuredays_269_OUT
  /METHOD=ENTER Sexbebe 
  /METHOD=ENTER Fetalrisk2_Modified
  /METHOD=FSTEP IF100_IESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

*with updated IESR scores and updated exposuredays*

*create variable Questionnaires_Nonrighthanded10.

IF (Questionnaires_R GT 0.5) Questionnaires_Nonrighthanded10=0.
IF (Questionnaires_R LE 0.5) Questionnaires_Nonrighthanded10=1.
EXECUTE.

LOGISTIC REGRESSION VARIABLES Questionnaires_Nonrighthanded10
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe 
  /METHOD=ENTER FETALRISK10
  /METHOD=ENTER P1_Nonrighthanded10
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).


*create variable VMI_Nonrighthanded10.

IF (VMI_R EQ 0) VMI_Nonrighthanded10=1.
IF (VMI_R GT 0) VMI_Nonrighthanded10=0.
IF (VMI_R LT 0) VMI_Nonrighthanded10=1.
EXECUTE.

LOGISTIC REGRESSION VARIABLES VMI_Nonrighthanded10
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe
  /METHOD=ENTER FETALRISK10
  /METHOD=ENTER P1_Nonrighthanded10
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).


*create variable Communication_Nonrighthanded10.

IF (CommunicationR LE 0.5) Communication_Nonrighthanded10=1.
IF (CommunicationR GT 0.5) Communication_Nonrighthanded10=0.
EXECUTE.


LOGISTIC REGRESSION VARIABLES Communication_Nonrighthanded10
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM 
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe 
  /METHOD=ENTER FETALRISK10
  /METHOD=ENTER P1_Nonrighthanded10
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

*create variable Manipulation_Nonrighthanded10.

IF (Manipulation_R GT 0.5) Manipulation_Nonrighthanded10=0.
IF (Manipulation_R LE 0.5) Manipulation_Nonrighthanded10=1.
EXECUTE.

LOGISTIC REGRESSION VARIABLES Manipulation_Nonrighthanded10
  /METHOD=ENTER IF100_log
  /METHOD=ENTER IESR_log_IM 
  /METHOD=ENTER exposuredays_280
  /METHOD=ENTER Sexbebe 
  /METHOD=ENTER FETALRISK10
  /METHOD=ENTER P1_Nonrighthanded10
  /METHOD=FSTEP IF100byIESR IF100_Exposuredays IF100_Sexbebe IESR_Exposuredays IESR_Sexbebe Exposuredays_sexbebe
  /PRINT=CI(95)
  /CRITERIA=PIN(.05) POUT(.10) ITERATE(20) CUT(.5).

*create variable P1_Nonrighthanded.

IF (P1_R GT 0.5) P1_Nonrighthanded10=0.
IF (P1_R LE 0.5) P1_Nonrighthanded10=1.
EXECUTE.
