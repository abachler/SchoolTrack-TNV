$item:=Selected list items:C379(hlTab_ACT_Transacciones)
$vl_recNumPersona:=Record number:C243([Personas:7])
Case of 
	: ($item=3)
		ACTcc_OpcionesCalculoCtaCte ("InitArrays")
		READ WRITE:C146([ACT_Cargos:173])
		READ WRITE:C146([ACT_Transacciones:178])
		READ WRITE:C146([ACT_Documentos_de_Cargo:174])
		READ WRITE:C146([xxACT_DesctosXItem:103])
		
		$line:=AL_GetLine (xALP_Transacciones)
		
		vrACT_Total_Proyectado:=vrACT_Total_Proyectado-aACT_ApdosTCredito{$line}
		
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID:1=aACT_ItemIDs{$line})
		ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)
		QUERY:C277([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]ID_Cargo:8=[ACT_Cargos:173]ID:1)
		DELETE RECORD:C58([xxACT_DesctosXItem:103])
		If (Not:C34(Locked:C147([ACT_Cargos:173])))
			LOG_RegisterEvt ("Eliminación de cargo proyectado "+[ACT_Cargos:173]Glosa:12+" para "+[Alumnos:2]apellidos_y_nombres:40+".")
			$DocdeCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
			DELETE RECORD:C58([ACT_Cargos:173])
		Else 
			BM_CreateRequest ("ACT_BorrarCargo";String:C10([ACT_Cargos:173]ID:1))
		End if 
		
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=aACT_ItemIDs{$line})
		If (Not:C34(Locked:C147([ACT_Transacciones:178])))
			DELETE RECORD:C58([ACT_Transacciones:178])
		Else 
			BM_CreateRequest ("ACT_BorrarTransaccion";String:C10([ACT_Transacciones:178]ID_Transaccion:1))
		End if 
		
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$DocdeCargo)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
		
		If (Records in selection:C76([ACT_Cargos:173])>0)
			$RecNumDC:=Record number:C243([ACT_Documentos_de_Cargo:174])
			If ($RecNumDC>0)
				ACTcc_CalculaDocumentoCargo ($RecNumDC)
			End if 
		Else 
			If (Not:C34(Locked:C147([ACT_Documentos_de_Cargo:174])))
				DELETE RECORD:C58([ACT_Documentos_de_Cargo:174])
			Else 
				BM_CreateRequest ("ACT_BorrarDocdeCargo";String:C10([ACT_Documentos_de_Cargo:174]ID_Documento:1))
			End if 
		End if 
		
		  // Modificado por: Saùl Ponce (27-09-2016) Ticket Nº 168397, para eliminar los cargos relacionados
		  //ARRAY LONGINT($alACT_recNumAC;0)
		  //ACTcar_EliminaCargosRelacionado (aACT_ItemIDs{$line};->$alACT_recNumAC;$DocdeCargo;True)
		
		  // Modificado por: Saúl Ponce (22-03-2017) Ticket 177887, ya no se usará el id del documento de cargo, se determina dentro del método
		ARRAY LONGINT:C221($alACT_recNumAC;0)
		ACTcar_EliminaCargosRelacionado (aACT_ItemIDs{$line};->$alACT_recNumAC)
		
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
		KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
		KRL_GotoRecord (->[Personas:7];$vl_recNumPersona;True:C214)
		AL_UpdateArrays (xALP_Transacciones;0)
		ACTpp_LoadTransacciones 
		AL_UpdateArrays (xALP_Transacciones;-2)
	: ($item=2)
		$line:=AL_GetLine (xALP_Transacciones)
		$vl_idCargo:=aACT_ItemIDs{$line}
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idCargo)
		$vl_retorno:=ACTcar_Delete (Record number:C243([ACT_Cargos:173]))
		If ($vl_retorno=0)
			KRL_GotoRecord (->[Personas:7];$vl_recNumPersona;True:C214)
			$ref:=Selected list items:C379(hlTab_ACT_Transacciones)
			AL_UpdateArrays (xALP_Transacciones;0)
			ACTpp_LoadTransacciones ($ref)
			AL_UpdateArrays (xALP_Transacciones;-2)
			AL_SetLine (xALP_Transacciones;0)
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			ACT_relacionaCtasyApdos (2)
			LOAD RECORD:C52([Personas:7])
			ORDER BY:C49([ACT_CuentasCorrientes:175];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
			FIRST RECORD:C50([ACT_CuentasCorrientes:175])
			
			ACTpp_FormArraysDeclarations ("ArreglosAlumnos")
			ARRAY REAL:C219(arACT_CCProyectadoEjercicio;0)
			ARRAY REAL:C219(arACT_CCPagado;0)
			
			ARRAY INTEGER:C220($aExApdode;0)
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([ACT_Apoderados_de_Cuenta:107])
			For ($o;1;Records in selection:C76([ACT_CuentasCorrientes:175]))
				AT_Insert (0;1;->arACT_CCFacturado;->arACT_CCVencido;->arACT_CCSaldo;->atACT_CCAlumno;->atACT_CCCurso;->arACT_CCProyectadoEjercicio;->arACT_CCPagado;->atACT_CCModoPago)
				ARRAY INTEGER:C220($aExApdode;Size of array:C274(arACT_CCVencido))
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				atACT_CCAlumno{Size of array:C274(atACT_CCAlumno)}:=[Alumnos:2]apellidos_y_nombres:40
				atACT_CCCurso{Size of array:C274(atACT_CCCurso)}:=[Alumnos:2]curso:20
				atACT_CCModoPago{Size of array:C274(atACT_CCModoPago)}:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_CuentasCorrientes:175]id_modo_de_pago:32)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EsRelativo:10=False:C215)
				CREATE SET:C116([ACT_Cargos:173];"todos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
				  //arACT_CCProyectadoEjercicio{Size of array(arACT_CCProyectadoEjercicio)}:=Sum([ACT_Cargos]Monto_Neto)+Sum([ACT_Cargos]Intereses)
				arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
				USE SET:C118("todos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
				  //arACT_CCFacturado{Size of array(arACT_CCFacturado)}:=Sum([ACT_Cargos]Monto_Neto)+Sum([ACT_Cargos]Intereses)
				arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
				arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}:=arACT_CCProyectadoEjercicio{Size of array:C274(arACT_CCProyectadoEjercicio)}+arACT_CCFacturado{Size of array:C274(arACT_CCFacturado)}
				arACT_CCPagado{Size of array:C274(arACT_CCPagado)}:=Sum:C1([ACT_Cargos:173]MontosPagados:8)
				arACT_CCSaldo{Size of array:C274(arACT_CCSaldo)}:=Sum:C1([ACT_Cargos:173]Saldo:23)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22<Current date:C33(*))
				arACT_CCVencido{Size of array:C274(arACT_CCVencido)}:=Sum:C1([ACT_Cargos:173]Saldo:23)
				QUERY:C277([ACT_Apoderados_de_Cuenta:107];[ACT_Apoderados_de_Cuenta:107]ID_CtaCte:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Apoderados_de_Cuenta:107]; & ;[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1=[Personas:7]No:1)
				If (Records in selection:C76([ACT_Apoderados_de_Cuenta:107])=1)
					$aExApdode{$o}:=1
				Else 
					$aExApdode{$o}:=0
				End if 
				NEXT RECORD:C51([ACT_CuentasCorrientes:175])
			End for 
			CLEAR SET:C117("todos")
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			AL_SetFormat (xALP_Alumnos;3;"|Despliegue_ACT")
			AL_SetFormat (xALP_Alumnos;4;"|Despliegue_ACT")
			AL_SetFormat (xALP_Alumnos;5;"|Despliegue_ACT")
			AL_UpdateArrays (xALP_Alumnos;-2)
			For ($oo;1;Size of array:C274(arACT_CCVencido))
				If ($aExApdode{$oo}=1)
					AL_SetRowColor (xALP_Alumnos;$oo;"Red";0)
					AL_SetRowStyle (xALP_Alumnos;$oo;2)
				Else 
					AL_SetRowColor (xALP_Alumnos;$oo;"";16)
					AL_SetRowStyle (xALP_Alumnos;$oo;0)
				End if 
			End for 
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			READ ONLY:C145([ACT_Pagos:172])
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
			$pagos:=Sum:C1([ACT_Pagos:172]Saldo:15)
			vrACT_Total_Proyectado:=AT_GetSumArray (->arACT_CCProyectadoEjercicio)
			vrACT_Total_Emitido:=AT_GetSumArray (->arACT_CCFacturado)
			vrACT_Deuda_Vencida:=AT_GetSumArray (->arACT_CCVencido)
			vrACT_Total_Pagado:=AT_GetSumArray (->arACT_CCPagado)+$pagos
			vrACT_Total_Saldo:=AT_GetSumArray (->arACT_CCSaldo)+$pagos
		End if 
		KRL_GotoRecord (->[Personas:7];$vl_recNumPersona;True:C214)
End case 