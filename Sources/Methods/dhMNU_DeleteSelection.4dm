//%attributes = {}
  //dhMNU_DeleteSelection

  // mnTrap_Deleteselection
  // by: Alberto
  // 21/5/03
  // purpose:
If (False:C215)
	<>xShellModificationDate:=!1903-05-21!
End if 

$deleted:=-1
Case of 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[Alumnos:2])))
		$deleted:=AL_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[Asignaturas:18])))
		$deleted:=AS_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[Profesores:4])))
		$deleted:=PF_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[Personas:7])))
		$deleted:=PP_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
		$deleted:=ACTac_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
		$deleted:=ACTpgs_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		$deleted:=ACTdc_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		CD_Dlog (0;__ ("Para eliminar documentos depositados debe primero anular los depósitos y luego eliminar los pagos correspondientes."))
		$deleted:=0
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
		$deleted:=ACTcc_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
		  //CD_Dlog (0;__ ("La eliminación de documentos tributarios no está permitida. Sólo puede anular un documento tributario."))
		  //$deleted:=0
		$deleted:=ACTbol_DeleteSelection   //20160414 RCH Ahora se puede agrupar
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ADT_Candidatos:49]))
		$deleted:=ADTcdd_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[BBL_Items:61])))
		$deleted:=BBLdc_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[BBL_Lectores:72])))
		$deleted:=BBLusr_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[ADT_Contactos:95])))
		$deleted:=ADTcon_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[ACT_Terceros:138])))
		$deleted:=ACTter_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[Familia:78])))  //20110518 RCH Se agrega caso...
		$deleted:=FM_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[Cursos:3])))  //20110518 RCH Se agrega caso...
		$deleted:=CU_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[Actividades:29])))  //20110518 RCH Se agrega caso...
		$deleted:=XCR_DeleteSelection 
	: (Table:C252(yBWR_CurrentTable)=(Table:C252(->[ACT_Pagares:184])))  //20110804 RCH Se agrega caso...
		$deleted:=ACTpagares_DeleteSelection 
End case 
  //Mono : 7-04-2011, el log de eliminación de items se crea en el método BBLdc_DeleteSelection de manera más detallada
If (($deleted=1) & (Table:C252(yBWR_currentTable)#61))
	LOG_RegisterEvt ("Eliminación de selección de registros de la tabla "+API Get Virtual Table Name (Table:C252(yBWR_currentTable));Table:C252(yBWR_currentTable))
End if 
$0:=$deleted