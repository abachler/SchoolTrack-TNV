//%attributes = {}
C_LONGINT:C283(vlACT_paginaPagares)
If (Count parameters:C259>=1)
	vlACT_paginaPagares:=$1
End if 
If (vlACT_paginaPagares=0)
	vlACT_paginaPagares:=1
End if 

QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Pagares:184]ID_Cta:18)
QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Pagares:184]ID_Apdo:17)

PP_SetIdentificadorPrincipal 

OBJECT SET VISIBLE:C603(*;"devolucion@";True:C214)
OBJECT SET VISIBLE:C603(*;"anulacion@";True:C214)
OBJECT SET VISIBLE:C603(*;"protesto@";True:C214)
  //SET VISIBLE(*;"protesto@";False)

ACTcfg_OpcionesPagares ("CargaDatosEstado";->vdACT_fechaCambioEstado;->vtACT_RealizadoPor)

  //$vl_pos:=Find in array(alACT_IdsEstadosPagares;[ACT_Pagares]ID_Estado)
COPY ARRAY:C226(atACT_EstadosPagares;atACT_EstadosPagares2)
  //If ($vl_pos>0)
  //atACT_EstadosPagares2:=$vl_pos
  //Else 
  //atACT_EstadosPagares2:=0
  //End if 

vlACT_estadoArray:=[ACT_Pagares:184]ID_Estado:6
$vl_pos:=Find in array:C230(alACT_IdsEstadosPagares;vlACT_estadoArray)
If ($vl_pos>0)
	atACT_EstadosPagares2:=$vl_pos
	vtACT_estadoArray:=atACT_EstadosPagares2{atACT_EstadosPagares2}
Else 
	atACT_EstadosPagares2:=0
	vtACT_estadoArray:=""
End if 

  //cs_protestado:=1
  //cs_devuelto:=1
  //cs_anulado:=1
  //If ([ACT_Pagares]Fecha_Devolucion=!00-00-00!)
  //cs_devuelto:=0
  //End if 
  //If ([ACT_Pagares]Fecha_Anulacion=!00-00-00!)
  //cs_anulado:=0
  //End if 
  //If ([ACT_Pagares]Fecha_Protesto=!00-00-00!)
  //cs_protestado:=0
  //End if 
vtACT_Estado:=ACTcfg_OpcionesPagares ("ObtieneEstadoXID";->[ACT_Pagares:184]ID_Estado:6)
ACTcfg_OpcionesPagares ("SetObjetosPag2")

ACTio_OpcionesArchivos ("CargaPagaresDesdeFicha")

ACTcfg_OpcionesPagares ("SetObjetosPag2")

Case of 
	: (vlACT_paginaPagares=2)
		AL_UpdateArrays (xALP_Documentos;0)
		AL_UpdateArrays (ALP_CargosXPagar;0)
		ACTcc_FormArraysDeclarations ("ArreglosAvisos")
		ACTcc_FormArraysDeclarations ("CargosAvisos")
		
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		
		  //20120723 RCH se cambian campos por list box
		If ([ACT_Pagares:184]ID_Cta:18#0)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Pagares:184]ID_Cta:18)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			
			  // Modificado por: Saul Ponce (05/02/2018) Ticket 198412, para cargar la información del aviso relacionado al pagaré.
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=[ACT_Pagares:184]ID_Cta:18)
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=[ACT_Pagares:184]ID:12)
		Else 
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=[ACT_Pagares:184]ID:12)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;"")
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		End if 
		
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;<)
		
		
		  // Modificado por: Saul Ponce (05/02/2018) Ticket 198412, Al intercambiar entre pestañas, dentro del pagaré, en laparte de avisos se mostraban datos erróneos.
		AT_Initialize (->alACT_ApdosDCPagares)
		
		ARRAY LONGINT:C221($alACT_ApdosDCPagares;0)
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aACT_ApdosDCNoComprobante;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;aACT_ApdosDCFechaEmision;[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;aACT_ApdosDCNeto;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;aACT_ApdosDCSaldo;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;aACT_ApdosDCID;[ACT_Avisos_de_Cobranza:124]Moneda:17;aACT_ApdosDCMoneda;[ACT_Avisos_de_Cobranza:124]Intereses:13;aACT_ApdosDCIntereses;[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;$alACT_ApdosDCPagares)
		For ($i;1;Size of array:C274($alACT_ApdosDCPagares))
			AT_Insert ($i;1;->alACT_ApdosDCPagares)
			$vl_idPagare:=$alACT_ApdosDCPagares{$i}
			If ($vl_idPagare#0)
				READ ONLY:C145([ACT_Pagares:184])
				KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$vl_idPagare)
				alACT_ApdosDCPagares{$i}:=[ACT_Pagares:184]Numero_Pagare:11
			End if 
		End for 
		
		If (Size of array:C274(aACT_ApdosDCID)>0)
			ACTac_CargaCargosAviso ("";aACT_ApdosDCID{1};"";0)
		End if 
		
		AL_UpdateArrays (xALP_Documentos;-2)
		AL_UpdateArrays (ALP_CargosXPagar;-2)
		
		
		SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_Pagares;vlACT_paginaPagares)
		FORM GOTO PAGE:C247(vlACT_paginaPagares)
		
End case 

If (Record number:C243([ACT_Pagares:184])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo Pagaré"))
Else 
	If ([ACT_Pagares:184]ID_Cta:18=0)
		SET WINDOW TITLE:C213(__ ("Pagaré N° ")+String:C10([ACT_Pagares:184]Numero_Pagare:11)+": "+[Personas:7]Apellidos_y_nombres:30)
	Else 
		SET WINDOW TITLE:C213(__ ("Pagaré N° ")+String:C10([ACT_Pagares:184]Numero_Pagare:11)+": "+[Alumnos:2]apellidos_y_nombres:40)
	End if 
End if 