//%attributes = {}
  //dhBWR_OnDeleteRecord

  // ===============================================================================
  // Usuario (OS): abachler
  // Fecha y Hora: 15/07/03, 16:30:43
  // -------------------------------------------------------------------------------
  // Metodo: Método: dhBWR_OnDeleteRecord
  // Descripcion
  // 
  //
  // Parametros
  //
  // ===============================================================================
  //if you use this trap you must return:
  // 0 if the record is not deleted
  // 1 if the record is deleted



  // DECLARACIONES
  // -------------------------------------------------------------------------------

C_POINTER:C301($tablePointer;$1)
_O_C_INTEGER:C282($deleted;$0)

  // INICIALIZACIONES
  // -------------------------------------------------------------------------------
If (Count parameters:C259=1)
	$tablePointer:=$1
Else 
	$tablePointer:=yBWR_currentTable
End if 

  // CUERPO DEL METODO
  // -------------------------------------------------------------------------------
$deleted:=-1  //No trap, deletion is handled by the main deletion rutine (BWR_OnDeleteRecord)
Case of 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
		$deleted:=AL_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Cursos:3]))
		$deleted:=CU_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
		$deleted:=PF_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
		$deleted:=PP_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Asignaturas:18]))
		$deleted:=AS_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Actividades:29]))
		$deleted:=XCR_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
		$deleted:=fm_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61]))
		$deleted:=BBL_dcDelete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Subscripciones:117]))
		$deleted:=BBLss_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Lectores:72]))
		$deleted:=BBLus_Delete 
	: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Registros:66]))
		$deleted:=BBLcpy_OnDeleteRecord 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		$deleted:=ACTav_Delete 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
		$deleted:=ACTpgs_Delete 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		$deleted:=ACTdc_Delete 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		CD_Dlog (0;__ ("Para eliminar un documento depositado anule el depósito y elimine el pago correspondiente."))
		$deleted:=0
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		$deleted:=ACTcc_Delete 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
		CD_Dlog (0;__ ("La eliminación de documentos tributarios no está permitida. Sólo puede anular un documento tributario."))
		$deleted:=0
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ADT_Candidatos:49]))
		$deleted:=ADTcdd_Delete 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ADT_Contactos:95]))
		$deleted:=ADTcon_Delete 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
		$deleted:=ACTter_Delete 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagares:184]))
		$deleted:=ACTpagares_Delete 
		
End case 
  //Mono : 7-04-2011, el log de eliminación de items se crea en el método BBL_dcDelete de manera más detallada
  //Mono : 7-04-2011, el log de eliminación de Registros se crea en el método BBLcpy_OnDeleteRecord de manera más detallada
If (($deleted=1) & (Table:C252(yBWR_currentTable)#66) & (Table:C252(yBWR_currentTable)#61))
	LOG_RegisterEvt ("Eliminación de un registro de la tabla "+API Get Virtual Table Name (Table:C252(yBWR_currentTable));Table:C252(yBWR_currentTable))
End if 
$0:=$deleted

  // LIBERACION DE MEMORIA
  // -------------------------------------------------------------------------------


  // FIN DEL METODO
  // -------------------------------------------------------------------------------

