//%attributes = {}
  // MÉTODO: dhBWR_OnCancelRecordEdition
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 16/08/11, 09:58:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // dhBWR_OnCancelRecordEdition()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BOOLEAN:C305($trapped)
C_POINTER:C301($tablePointer)

If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 
$trapped:=False:C215

  // CODIGO PRINCIPAL
Case of 
		
		  //ADT Candidatos
	: (Table:C252($tablePointer)=Table:C252(->[ADT_Candidatos:49]))
		If ((vbBWR_IsNewRecord) & (In transaction:C397))  //la creación de registros de postulantes se hace en una transacción. Si el usuario cancela se cancela todo
			$trapped:=True:C214
			$l_choice:=CD_Dlog (0;__ ("Usted utilizó la opción Cancelar. Si continúa perderá toda la información que registró para ")+[Alumnos:2]apellidos_y_nombres:40+" y sus relaciones familiares\r\r¿Está seguro(a)?";"";__ ("Continuar registro");__ ("Cancelar registro"))
			If ($l_choice=2)
				CANCEL TRANSACTION:C241
				CANCEL:C270
			End if 
		End if 
		
		
		
		  // BBL Registros
	: (Table:C252($tablePointer)=Table:C252(->[BBL_Registros:66]))  //ABK 20110816 este código estaba en en el metodo BWR_InputFormButtonsHandler. Ese método no debe llamar a nada que no esté en xShell.
		If (Is new record:C668([BBL_Registros:66]))
			LOG_RegisterEvt ("Numero de registro "+String:C10([BBL_Registros:66]No_Registro:25)+" cancelado.")
		End if 
		
		
	: (Table:C252($tablePointer)=Table:C252(->[ACT_Boletas:181]))
		KRL_ReloadAsReadOnly (->[ACT_Boletas:181])
		
End case 


$0:=$trapped