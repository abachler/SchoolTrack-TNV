C_LONGINT:C283($vl_pos;vlACT_estadoArray)
C_TEXT:C284(vtACT_estadoArray)
Case of 
	: (Form event:C388=On Load:K2:1)
		
		
	: (Form event:C388=On Clicked:K2:4)
		$vl_pos:=Find in array:C230(atACT_EstadosPagares;atACT_EstadosPagares2{atACT_EstadosPagares2})
		If ($vl_pos>0)
			[ACT_Pagares:184]ID_Estado:6:=alACT_IdsEstadosPagares{$vl_pos}
		End if 
		
		If (vlACT_estadoArray#[ACT_Pagares:184]ID_Estado:6)
			  // si el pagare estaba anulado y ahora se elije otro estado
			$vb_regresaEstado:=False:C215
			Case of 
				: ((vlACT_estadoArray=-101) & ([ACT_Pagares:184]ID_Estado:6#-101))
					ACTcfg_OpcionesPagares ("DesProtestaDocumento")
					
				: ((vlACT_estadoArray=-105) & ([ACT_Pagares:184]ID_Estado:6#-105))
					ACTcfg_OpcionesPagares ("NoDevuelveDocumento")
					
				: ((vlACT_estadoArray=-102) & ([ACT_Pagares:184]ID_Estado:6#-102))
					$resp:=CD_Dlog (0;__ ("Para habilitar este pagaré usted deberá seleccionar Avisos de Cobranza dede la siguiente lista.")+"\r\r"+__ ("La suma de los Avisos de Cobranza seleccionados deberá ser igual al monto del pagaré.")+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
					If ($resp=1)
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						ARRAY LONGINT:C221(alACT_IDAviso;0)
						ARRAY DATE:C224(adACT_FechaEAviso;0)
						ARRAY DATE:C224(adACT_FechaVAviso;0)
						ARRAY REAL:C219(arACT_Monto;0)
						
						QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Pagares:184]ID_Apdo:17;*)
						QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Pagares:184]ID_Cta:18;*)
						QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)
						SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;adACT_FechaEAviso;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;adACT_FechaVAviso)
						SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_IDAviso;[ACT_Avisos_de_Cobranza:124]Monto_Neto:11;arACT_Monto)
						
						SORT ARRAY:C229(adACT_FechaEAviso;adACT_FechaVAviso;alACT_IDAviso;arACT_Monto;>)
						
						ARRAY POINTER:C280(<>aChoicePtrs;0)
						ARRAY POINTER:C280(<>aChoicePtrs;4)
						<>aChoicePtrs{1}:=->adACT_FechaEAviso
						<>aChoicePtrs{2}:=->adACT_FechaVAviso
						<>aChoicePtrs{3}:=->alACT_IDAviso
						<>aChoicePtrs{4}:=->arACT_Monto
						TBL_ShowChoiceList (0;__ ("Seleccione avisos");0;->vtACT_Estado;True:C214)
						If (ok=1)
							ARRAY LONGINT:C221($al_AvisosSelected;0)
							For ($i;1;Size of array:C274(aLinesSelected))
								APPEND TO ARRAY:C911($al_AvisosSelected;alACT_IDAviso{aLinesSelected{$i}})
							End for 
							$vr_monto:=ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMEmsion";->$al_AvisosSelected;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
							If ($vr_monto=[ACT_Pagares:184]Monto:8)
								ACTcfg_OpcionesGeneracionP ("AsignaIDPagareAAC1";->[ACT_Pagares:184]ID:12;->$al_AvisosSelected)
								ACTcfg_OpcionesPagares ("NoAnulaDocumento")
								$vt_evento:="Habilitación de Pagaré. Estado por defecto asignado."
								ACTcfg_OpcionesPagares ("Log";->$vt_evento)
								ACTpagares_fSave 
								FLUSH CACHE:C297
							Else 
								$vb_regresaEstado:=True:C214
								CD_Dlog (0;__ ("El monto de los avisos seleccionados no coincide con el monto del pagaré. El pagaré no puede ser habilitado."))
							End if 
						Else 
							$vb_regresaEstado:=True:C214
						End if 
					Else 
						$vb_regresaEstado:=True:C214
					End if 
					
			End case 
			
			If (Not:C34($vb_regresaEstado))
				Case of 
						  //: ([ACT_Pagares]ID_Estado=-101)
						  //ACTcfg_OpcionesPagares ("ProtestaDocumento")
						  //
						  //: ([ACT_Pagares]ID_Estado=-105)
						  //ACTcfg_OpcionesPagares ("DevuelveDocumento")
						
					: ([ACT_Pagares:184]ID_Estado:6=-102)
						If (([ACT_Pagares:184]Fecha_Protesto:20=!00-00-00!) & ([ACT_Pagares:184]Fecha_Devolucion:14=!00-00-00!))
							$resp:=CD_Dlog (0;__ ("¿Está seguro de anular el pagaré seleccionado?.")+"\r\r"+__ ("Esta acción no se puede deshacer.");"";__ ("Si");__ ("No"))
							If ($resp=1)
								ACTcfg_OpcionesPagares ("AnulaPagare";->[ACT_Pagares:184]ID:12)
							Else 
								$vb_regresaEstado:=True:C214
							End if 
						Else 
							$vb_regresaEstado:=True:C214
							CD_Dlog (0;"No puede anular un pagaré protestado ni devuelto.")
						End if 
						
					Else 
						ACTcfg_OpcionesPagares ("ActualizaDatosEstados")
						
				End case 
				ACTcfg_OpcionesPagares ("CargaDatosEstado";->vdACT_fechaCambioEstado;->vtACT_RealizadoPor)
			End if 
			
			If ($vb_regresaEstado)
				[ACT_Pagares:184]ID_Estado:6:=vlACT_estadoArray
				$vl_pos:=Find in array:C230(atACT_EstadosPagares2;vtACT_estadoArray)
				If ($vl_pos>0)
					atACT_EstadosPagares2:=$vl_pos
				End if 
			Else 
				vtACT_estadoArray:=atACT_EstadosPagares2{atACT_EstadosPagares2}
				vlACT_estadoArray:=[ACT_Pagares:184]ID_Estado:6
			End if 
			
			ACTcfg_OpcionesPagares ("SetObjetosPag2")
		End if 
		
End case 

