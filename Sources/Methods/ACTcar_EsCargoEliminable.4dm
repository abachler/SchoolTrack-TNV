//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 26-04-17, 09:20:48
  // ----------------------------------------------------
  // Método: ACTcar_EsCargoEliminable
  // Descripción
  // Metodo para comenzar a centralizar la consulta para permitir eliminar un cargo
  // Se verifica que esté o no asociado a pagaré. Si lo está, no se puede eliminar
  // Se verifica que esté o no asociado a DT. Si lo está, no es posible eliminar
  // Parámetros
  //$1 = Id cargo a testear
  // ----------------------------------------------------

  //TRACE

C_BOOLEAN:C305($0;$b_permitidoEliminar)
C_LONGINT:C283($l_idCargo;$1;$l_var;$l_idDC;$l_idAC;$l_idPagare)

$l_idCargo:=$1

$l_idDC:=KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$l_idCargo;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
If ($l_idDC#0)
	$l_idAC:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$l_idDC;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
	If ($l_idAC#0)
		$l_idPagare:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$l_idAC;->[ACT_Avisos_de_Cobranza:124]ID_Pagare:30)
	End if 
End if 

If ($l_idPagare=0)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_var)
	  //Se quita propiedad de ejecutar en el server porque dejaba registros tomados en el server y se cambia QUERY BY FORMULA ya que demoraba mucho
	  //QUERY BY FORMULA([ACT_Transacciones];(([ACT_Transacciones]ID_Item=$l_idCargo) & (([ACT_Transacciones]No_Boleta#0) | ([ACT_Transacciones]ID_DctoRelacionado#0))))
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$l_idCargo;*)
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
	If ($l_var=0)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$l_idCargo;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15#0)
	End if 
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$b_permitidoEliminar:=($l_var=0)
Else 
	$b_permitidoEliminar:=False:C215
End if 

$0:=$b_permitidoEliminar