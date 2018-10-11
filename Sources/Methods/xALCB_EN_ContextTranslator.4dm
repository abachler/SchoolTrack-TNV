//%attributes = {}
  //xALCB_EN_ContextTranslator

C_LONGINT:C283($1;$2)
AL_GetCurrCell (xALP_Translator;$col;$line)
If ($line#0)
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimTop;alXS_Top{$line}-3)
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimLeft;alXS_Left{$line}-3)
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimBottom;alXS_Bottom{$line}+3)
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimRight;alXS_Right{$line}+3)
Else 
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimTop;-1)
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimLeft;-1)
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimBottom;-1)
	SET PROCESS VARIABLE:C370(vlXS_ProcInTranslation;vlXS_DelimRight;-1)
End if 
DELAY PROCESS:C323(Current process:C322;15)
POST OUTSIDE CALL:C329(vlXS_ProcInTranslation)