//%attributes = {}
  //FM_OnLoad

ARRAY TEXT:C222(aUFItmName;0)
ARRAY TEXT:C222(aUFItmVal;0)
xALSet_AreasCamposUsuario (xALP_FamUFields)
xALSet_FM_AreaEventos 
If (USR_checkRights ("M";->[Familia:78]))
	OBJECT SET VISIBLE:C603(*;"choicesFamilia@";True:C214)
	_O_ENABLE BUTTON:C192(*;"buttonFamilia@")
	OBJECT SET ENTERABLE:C238(*;"fieldFamilia@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"choicesFamilia@";False:C215)
	_O_DISABLE BUTTON:C193(*;"buttonFamilia@")
	OBJECT SET ENTERABLE:C238(*;"fieldFamilia@";False:C215)
End if 

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
C_BOOLEAN:C305(vb_guardarCambios)