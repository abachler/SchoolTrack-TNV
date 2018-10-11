//%attributes = {}
  // MÉTODO: USR_GetUserEventDate
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 05/07/11, 10:35:52
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // USR_GetUserEventDate()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
C_TEXT:C284($0)


  // CODIGO PRINCIPAL
If ([xShell_UserEvents:282]DTS:3#"")
	$t_date:=DTS_GetDateTimeString ([xShell_UserEvents:282]DTS:3)
End if 
$0:=$t_date
