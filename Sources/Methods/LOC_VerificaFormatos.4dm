//%attributes = {}
  //LOC_VerificaFormatos

C_TEXT:C284($t_idioma)

SET DATABASE LOCALIZATION:C1104("es")
SYS_SetFormatResources 
$t_idioma:=LOC_ObtieneReferencia 
SET DATABASE LOCALIZATION:C1104($t_idioma)
