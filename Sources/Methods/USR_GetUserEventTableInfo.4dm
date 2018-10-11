//%attributes = {}
  // MÉTODO: USR_GetUserEventTableInfo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 05/07/11, 09:36:50
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // USR_GetUserEventTableInfo()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($0)


  // CODIGO PRINCIPAL
If ([xShell_UserEvents:282]TabNum:5#0)
	$t_tableName:=API Get Virtual Table Name ([xShell_UserEvents:282]TabNum:5)
	If ($t_tableName="")
		$t_tableName:=Table name:C256([xShell_UserEvents:282]TabNum:5)
	End if 
End if 
$0:=$t_tableName
