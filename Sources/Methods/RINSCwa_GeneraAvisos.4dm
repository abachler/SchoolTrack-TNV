//%attributes = {}
  //RINSCwa_GeneraAvisos

  //SET TEXT TO PASTEBOARD(<>tRINSC_debug)

C_TEXT:C284($t_principal;$t_err;$node;$t_avisos;$t_cargo;$json)
C_LONGINT:C283($l_indice;$l_pos;$l_idApp)
C_TEXT:C284($t_periodo;$0;$t_parametro;$t_llavePrivada;$t_hash)
C_BLOB:C604($blob)
C_REAL:C285($r_error)
C_LONGINT:C283($l_idItem)
C_REAL:C285($r_ordenCompra)
C_TEXT:C284($t_detalleVenta)  //20160525 RCH
C_BOOLEAN:C305(<>bRINSC_depurarRINSC)
C_TEXT:C284(<>tRINSC_debug)
C_TEXT:C284($t_descripcionError)
ARRAY LONGINT:C221($alACT_idsCtas;0)
C_TEXT:C284($t_usuario)
  // Modificado por: Saúl Ponce (14/11/2017), declaración de la variable, en interpretado aparecía error
C_LONGINT:C283(cbSolicitaMotivoCondonacion)

  //20180228 RCH Soporte para ticket 193173
ARRAY LONGINT:C221($alACT_idsPagosMatricula;0)
ARRAY LONGINT:C221($alACT_idsOCMatricula;0)
ARRAY TEXT:C222($atACT_idsSerieMatricula;0)

ARRAY LONGINT:C221($alACT_idsPagosColegiatura;0)
ARRAY LONGINT:C221($alACT_idsOCColegiatura;0)
ARRAY TEXT:C222($atACT_idsSerieColegiatura;0)

  //formas de pago que ingresan pagos. Se guarda en un blob por si se tienen que modificar posteriormente...
ARRAY LONGINT:C221($alACT_idsFDP;0)
APPEND TO ARRAY:C911($alACT_idsFDP;-3)  //efectivo
APPEND TO ARRAY:C911($alACT_idsFDP;-18)  //webpay
APPEND TO ARRAY:C911($alACT_idsFDP;-6)  //tarjeta de cré´dito
APPEND TO ARRAY:C911($alACT_idsFDP;-7)  //Contabilidad
APPEND TO ARRAY:C911($alACT_idsFDP;-13)  //Transferencia
APPEND TO ARRAY:C911($alACT_idsFDP;-14)  //depósito
APPEND TO ARRAY:C911($alACT_idsFDP;-15)  //Por caja
C_BLOB:C604($xBlob)
$l_offset:=BLOB_Variables2Blob (->$xBlob;0;->$alACT_idsFDP)
$xBlob:=PREF_fGetBlob (0;"ACT_BlobPagosReinscripciones";$xBlob)
$l_offset:=BLOB_Blob2Vars (->$xBlob;0;->$alACT_idsFDP)

READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([Colegio:31])

$t_usuario:="Reinscripciones"

If (USR_GetUserID <0)
	<>bRINSC_depurarRINSC:=True:C214
End if 

If (Count parameters:C259=1)
	$t_json:=$1
Else 
	$t_json:=RINSCwa_TestJSONPagos 
End if 

If (CONDOR_ValidaAutenticacion (4;$t_json))
	
	C_BLOB:C604($blob)
	C_LONGINT:C283($l_idApp)
	C_TEXT:C284($t_hashRec;$t_hashCalc;$t_parametro)
	ARRAY TEXT:C222(atRINSC_uuidAL;0)
	ARRAY TEXT:C222($atACT_uuidApdoCta;0)
	ARRAY LONGINT:C221($alACT_idRS;0)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	C_TEXT:C284($t_uuidApdo;$t_periodo)
	
	ARRAY TEXT:C222($atACT_uuidORG;0)
	
	ARRAY TEXT:C222($atACT_CargosUUIDAl;0)
	ARRAY TEXT:C222($atACT_CargosTipo;0)
	ARRAY LONGINT:C221($arACT_CargosIDACT;0)
	ARRAY TEXT:C222($atACT_CargosMontos;0)
	ARRAY BOOLEAN:C223($abACT_utilizarMonto;0)
	
	ARRAY LONGINT:C221($alACT_añoGeneracion;0)
	
	  //items con año 0
	ARRAY LONGINT:C221($alACT_idsItemsYear0;0)
	
	ARRAY TEXT:C222(aDeletedNames;0)
	ARRAY TEXT:C222(aMotivo;0)
	
	If (Semaphore:C143("ACT_IngresoReinscripcionesAvisos";300))
		$r_error:=-1
		$t_descripcionError:="Semáforo activado. Intentar nuevamente."
	End if 
	
	If ($r_error=0)
		
		C_OBJECT:C1216($ob)
		<>tRINSC_debug:=""
		  //<>tRINSC_debug:=<>tRINSC_debug+$t_json+"\r"
		
		If (Valida_json ($t_json))
			
			<>tRINSC_debug:=<>tRINSC_debug+"json recibido: "+$t_json+"\r"
			  //extrae info desde json
			C_OBJECT:C1216($ob_raiz)
			C_OBJECT:C1216($ob_nodoAlumnos;$ob_nodoCargos)
			C_LONGINT:C283($l_nodos)
			ARRAY TEXT:C222($at_nombreNodosAlumnos;0)
			ARRAY OBJECT:C1221($ao_nodoAlumnos;0)
			ARRAY OBJECT:C1221($ao_nodoCargos;0)
			
			$ob_raiz:=JSON Parse:C1218($t_json;Is object:K8:27)
			
			<>tRINSC_debug:=<>tRINSC_debug+JSON Stringify:C1217($ob_raiz;*)+"\r"
			
			OB_GET ($ob_raiz;->$t_periodo;"anio")
			OB_GET ($ob_raiz;->$r_ordenCompra;"ordencompra")
			
			ARRAY OBJECT:C1221($ao_arregloDetalle;0)
			OB GET ARRAY:C1229($ob_raiz;"detalleventa";$ao_arregloDetalle)
			If (Size of array:C274($ao_arregloDetalle)>0)
				$t_detalleVenta:=JSON Stringify:C1217($ao_arregloDetalle{1})
			Else 
				$t_detalleVenta:=""
			End if 
			
			C_TEXT:C284($t_fechaProceso)
			
			OB_GET ($ob_raiz;->$t_fechaProceso;"fecha")
			
			$d_fechaProceso:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_fechaProceso;1;2));Num:C11(Substring:C12($t_fechaProceso;4;2));Num:C11(Substring:C12($t_fechaProceso;7;4)))
			
			C_TEXT:C284($vtRINSC_uuidAL)
			
			OB_GET ($ob_raiz;->$ao_nodoAlumnos;"alumnos")
			
			For ($i;1;Size of array:C274($ao_nodoAlumnos))
				
				  //obtengo el Nodo CARGOS del Array NodoAlumnos
				OB_GET ($ao_nodoAlumnos{$i};->$ob_nodoCargos;"cargos")
				
				  //obtengo uuid del NodoAlumnos
				OB_GET ($ao_nodoAlumnos{$i};->$vtRINSC_uuidAL;"uuid")
				APPEND TO ARRAY:C911(atRINSC_uuidAL;$vtRINSC_uuidAL)
				
				$y_pointer:=Get pointer:C304("aQR_Longint"+String:C10($i))
				
				ARRAY OBJECT:C1221($ao_Mat;0)
				ARRAY OBJECT:C1221($ao_Col;0)
				
				OB_GET ($ob_nodoCargos;->$ao_Mat;"matricula")
				OB_GET ($ob_nodoCargos;->$ao_Col;"colegiatura")
				
				  //genere un ciclo para cada arreglo.
				For ($z;1;Size of array:C274($ao_Mat))
					C_LONGINT:C283($l_idACT)
					C_TEXT:C284($t_monto)
					C_BOOLEAN:C305($b_utilizarMonto)
					$t_monto:=""
					$l_idACT:=0
					
					OB_GET ($ao_Mat{$z};->$l_idACT;"id_ac")
					OB_GET ($ao_Mat{$z};->$t_monto;"monto")
					OB_GET ($ao_Mat{$z};->$b_utilizarMonto;"utilizar_monto")
					
					
					$t_monto:=Replace string:C233($t_monto;".";"")
					$t_monto:=Replace string:C233($t_monto;",";"")
					
					APPEND TO ARRAY:C911($y_pointer->;$l_idACT)
					APPEND TO ARRAY:C911($atACT_CargosUUIDAl;atRINSC_uuidAL{Size of array:C274(atRINSC_uuidAL)})
					APPEND TO ARRAY:C911($atACT_CargosTipo;"matricula")
					APPEND TO ARRAY:C911($arACT_CargosIDACT;$l_idACT)
					APPEND TO ARRAY:C911($atACT_CargosMontos;$t_monto)
					APPEND TO ARRAY:C911($abACT_utilizarMonto;$b_utilizarMonto)
				End for 
				
				For ($z;1;Size of array:C274($ao_Col))
					C_LONGINT:C283($l_idACT)
					C_TEXT:C284($t_monto)
					C_BOOLEAN:C305($b_utilizarMonto)
					$t_monto:=""
					$l_idACT:=0
					
					  //20171005 RCH
					OB_GET ($ao_Col{$z};->$l_idACT;"id_ac")
					OB_GET ($ao_Col{$z};->$t_monto;"monto")
					OB_GET ($ao_Col{$z};->$b_utilizarMonto;"utilizar_monto")
					
					$t_monto:=Replace string:C233($t_monto;".";"")
					$t_monto:=Replace string:C233($t_monto;",";"")
					
					APPEND TO ARRAY:C911($y_pointer->;$l_idACT)
					APPEND TO ARRAY:C911($atACT_CargosUUIDAl;atRINSC_uuidAL{Size of array:C274(atRINSC_uuidAL)})
					APPEND TO ARRAY:C911($atACT_CargosTipo;"colegiatura")
					APPEND TO ARRAY:C911($arACT_CargosIDACT;$l_idACT)
					APPEND TO ARRAY:C911($atACT_CargosMontos;$t_monto)
					APPEND TO ARRAY:C911($abACT_utilizarMonto;$b_utilizarMonto)
				End for 
			End for 
			
			C_REAL:C285($r_medioPagoMat;$r_medioPagoCol)
			C_OBJECT:C1216($ob_mediospago)
			
			$ob_mediospago:=OB_Create 
			OB_GET ($ob_raiz;->$ob_mediospago;"mediospago")
			OB_GET ($ob_mediospago;->$r_medioPagoMat;"matricula")
			OB_GET ($ob_mediospago;->$r_medioPagoCol;"colegiatura")
			
			
			  //obtiene datos pagos
			  //datos de cheques
			ARRAY TEXT:C222($atACT_tipo;0)
			ARRAY TEXT:C222($atACT_Banco;0)
			ARRAY TEXT:C222($atACT_Cuenta;0)
			ARRAY TEXT:C222($atACT_Numero;0)
			ARRAY TEXT:C222($atACT_Monto;0)
			ARRAY DATE:C224($adACT_Vencimiento;0)
			
			ARRAY TEXT:C222(at_nodes;0)
			ARRAY LONGINT:C221(al_tipos;0)
			ARRAY TEXT:C222(at_tipo;0)
			
			C_OBJECT:C1216($ob_cheques)
			
			ARRAY OBJECT:C1221($ao_matri;0)
			ARRAY OBJECT:C1221($ao_coleg;0)
			
			OB_GET ($ob_raiz;->$ob_cheques;"cheques")
			OB_GET ($ob_cheques;->$ao_matri;"matricula")
			OB_GET ($ob_cheques;->$ao_coleg;"colegiatura")
			
			For ($x;1;Size of array:C274($ao_matri))  //mat,
				C_TEXT:C284($t_valor)
				APPEND TO ARRAY:C911($atACT_tipo;"matricula")
				OB_GET ($ao_matri{$x};->$t_valor;"banco")
				APPEND TO ARRAY:C911($atACT_Banco;$t_valor)
				OB_GET ($ao_matri{$x};->$t_valor;"cuenta")
				APPEND TO ARRAY:C911($atACT_Cuenta;$t_valor)
				OB_GET ($ao_matri{$x};->$t_valor;"numero")
				APPEND TO ARRAY:C911($atACT_Numero;$t_valor)
				OB_GET ($ao_matri{$x};->$t_valor;"monto")
				$t_valor:=Replace string:C233($t_valor;".";"")
				$t_valor:=Replace string:C233($t_valor;",";"")
				APPEND TO ARRAY:C911($atACT_Monto;$t_valor)
				OB_GET ($ao_matri{$x};->$t_valor;"vencimiento")
				APPEND TO ARRAY:C911($adACT_Vencimiento;DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_valor;1;2));Num:C11(Substring:C12($t_valor;4;2));Num:C11(Substring:C12($t_valor;7;4))))
			End for 
			
			For ($x;1;Size of array:C274($ao_coleg))  //, col
				C_TEXT:C284($t_valor)
				APPEND TO ARRAY:C911($atACT_tipo;"colegiatura")
				OB_GET ($ao_coleg{$x};->$t_valor;"banco")
				APPEND TO ARRAY:C911($atACT_Banco;$t_valor)
				OB_GET ($ao_coleg{$x};->$t_valor;"cuenta")
				APPEND TO ARRAY:C911($atACT_Cuenta;$t_valor)
				OB_GET ($ao_coleg{$x};->$t_valor;"numero")
				APPEND TO ARRAY:C911($atACT_Numero;$t_valor)
				OB_GET ($ao_coleg{$x};->$t_valor;"monto")
				$t_valor:=Replace string:C233($t_valor;".";"")
				$t_valor:=Replace string:C233($t_valor;",";"")
				APPEND TO ARRAY:C911($atACT_Monto;$t_valor)
				OB_GET ($ao_coleg{$x};->$t_valor;"vencimiento")
				APPEND TO ARRAY:C911($adACT_Vencimiento;DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($t_valor;1;2));Num:C11(Substring:C12($t_valor;4;2));Num:C11(Substring:C12($t_valor;7;4))))
			End for 
			
			<>tRINSC_debug:=<>tRINSC_debug+"JSON CERRADO"+"\r"
			
			COPY ARRAY:C226(atRINSC_uuidAL;$atACT_uuidORG)
		Else 
			$r_error:=-3
			
			$t_descripcionError:="JSon no parseado. Se debe revisar json enviado."
		End if 
	End if 
	
	  //validaciones generales
	If ($r_error=0)
		  //verifica que se hayan obtenido correctamente informacion de alumnos
		If (Size of array:C274(atRINSC_uuidAL)=0)
			$r_error:=-5
		End if 
	End if 
	
	If ($r_error=0)
		ARRAY LONGINT:C221($alACT_idsItems;0)
		
		For ($l_indice;1;Size of array:C274(atRINSC_uuidAL))
			
			  //verifica alumnos
			If ($r_error=0)
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([Alumnos:2])
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atRINSC_uuidAL{$l_indice})
				If (Records in selection:C76([Alumnos:2])=1)
					APPEND TO ARRAY:C911($atACT_uuidApdoCta;KRL_GetTextFieldData (->[Personas:7]No:1;->[Alumnos:2]Apoderado_Cuentas_Número:28;->[Personas:7]Auto_UUID:36))
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
					If (Records in selection:C76([ACT_CuentasCorrientes:175])#1)
						$t_descripcionError:="uuid: "+atRINSC_uuidAL{$l_indice}
						
						$r_error:=-8
						$l_indice:=Size of array:C274(atRINSC_uuidAL)
					Else 
						APPEND TO ARRAY:C911($alACT_idsCtas;[ACT_CuentasCorrientes:175]ID:1)
					End if 
				Else 
					$t_descripcionError:="uuid: "+atRINSC_uuidAL{$l_indice}
					$r_error:=-7
					$l_indice:=Size of array:C274(atRINSC_uuidAL)
				End if 
			End if 
			
			AT_DistinctsArrayValues (->$alACT_idsCtas)
			
			  //verifica items
			If ($r_error=0)
				
				$y_pointer:=Get pointer:C304("aQR_Longint"+String:C10($l_indice))
				If (Size of array:C274($y_pointer->)>0)
					For ($i;1;Size of array:C274($y_pointer->))
						
						READ ONLY:C145([xxACT_Items:179])
						$l_idItem:=$y_pointer->{$i}
						KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem)
						If (Records in selection:C76([xxACT_Items:179])#1)
							<>tRINSC_debug:=<>tRINSC_debug+"id ítem: "+String:C10($l_idItem)+" no encontrado."+"\r"
							$t_descripcionError:="ID Ítem no encontrado: "+String:C10($l_idItem)
							
							$r_error:=-15
							$i:=Size of array:C274($y_pointer->)
							$l_indice:=Size of array:C274(atRINSC_uuidAL)
						Else 
							
							  //verifico que items sean del periodo que corresponde
							If ([xxACT_Items:179]ID:1>0)  //20171011 RCH Solo se validan los ítems no especiales
								If ([xxACT_Items:179]Periodo:42=$t_periodo)
									APPEND TO ARRAY:C911($alACT_idRS;[xxACT_Items:179]ID_RazonSocial:36)
									
									APPEND TO ARRAY:C911($alACT_idsItems;$l_idItem)
								Else 
									$t_descripcionError:="Período no corresponde. Período ítem: "+[xxACT_Items:179]Periodo:42+", período en json: "+$t_periodo+"."
									
									<>tRINSC_debug:=<>tRINSC_debug+"id ítem: "+String:C10($l_idItem)+". Período no corresponde. Período ítem: "+[xxACT_Items:179]Periodo:42+", período en json: "+$t_periodo+"."+"\r"
									$r_error:=-16
									$i:=Size of array:C274($y_pointer->)
									$l_indice:=Size of array:C274(atRINSC_uuidAL)
								End if 
							End if 
						End if 
						
					End for 
				End if 
			End if 
			
			
		End for 
		
		<>tRINSC_debug:=<>tRINSC_debug+"Verificaciones alumnos realizada..."+"\r"
		  //verifica que el apoderado exista
		If ($r_error=0)
			AT_DistinctsArrayValues (->$atACT_uuidApdoCta)
			If (Size of array:C274($atACT_uuidApdoCta)=1)
				If ($t_uuidApdo=$atACT_uuidApdoCta{1})
					READ ONLY:C145([Personas:7])
					KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
					If (Records in selection:C76([Personas:7])#1)
						
						$t_descripcionError:="UUID apdo: "+$atACT_uuidApdoCta{1}+"."
						
						$r_error:=-10
					End if 
				Else 
					  //$r_error:=-17 //por ahora no valido esto
				End if 
			Else 
				
				$t_descripcionError:="Apoderado no único para cuentas: UUID apdos"+AT_array2text (->$atACT_uuidApdoCta)+". Asocie el mismo apoderado en ACT."
				
				$r_error:=-11
			End if 
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Apoderado verificado..."+"\r"
		
		  //verifico cheques
		If ($r_error=0)
			  //verifico bancos
			ACTcfgmyt_CargaArreglos   //leo bancos
			
			For ($l_indiceB;1;Size of array:C274($atACT_Banco))
				$id:=Find in array:C230(atACT_BankName;$atACT_Banco{$l_indiceB})
				If ($id=-1)
					$t_descripcionError:="Banco no encontrado: "+$atACT_Banco{$l_indiceB}+"."
					
					<>tRINSC_debug:=<>tRINSC_debug+"Banco no encontrado: "+$atACT_Banco{$l_indiceB}+". Puede crearlo en la configuración."+"\r"
					$r_error:=-23
					$l_indiceB:=Size of array:C274($atACT_Banco)
				End if 
			End for 
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Cheques verificados..."+"\r"
		
		  //valida que pagos no existan
		If ($r_error=0)
			If ($r_ordenCompra#0)
				READ ONLY:C145([ACT_Pagos:172])
				$l_recNum:=Find in field:C653([ACT_Pagos:172]ID_WebpayOC:32;$r_ordenCompra)
				If ($l_recNum#-1)
					
					<>tRINSC_debug:=<>tRINSC_debug+"Orden de compra ya existe: "+String:C10($r_ordenCompra)+"."+"\r"
					
					$t_descripcionError:="Orden de compra ya existe: "+String:C10($r_ordenCompra)+". El pago no podrá ser ingresado con esta orden de compra."
					
					$r_error:=-31
				End if 
			End if 
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Pagos verificados..."+"\r"
		
		  //verifica cheques
		If ($r_error=0)
			
			  // 13/11/2017 Saúl Ponce O. Ticket 191466
			ARRAY TEXT:C222($at_keyCheques;0)
			ARRAY DATE:C224($ad_fechasCheques;0)
			ARRAY TEXT:C222($at_keyChequesMatCol;0)  //20171204 RCH
			
			For ($l_indice;1;Size of array:C274($atACT_tipo))
				C_LONGINT:C283($id;$l_recs)
				$id:=Find in array:C230(atACT_BankName;$atACT_Banco{$l_indice})
				
				C_TEXT:C284($noSerieDcto;$vt_cuenta;$vt_codigoBanco;$vt_cuentaSinFormato;$vt_serieSinFormato;$index)
				$noSerieDcto:=$atACT_Numero{$l_indice}
				$vt_cuenta:=$atACT_Cuenta{$l_indice}
				$vt_codigoBanco:=atACT_BankID{$id}
				
				$vt_cuentaSinFormato:=Replace string:C233($vt_cuenta;" ";"")
				$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;"-";"")
				$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;".";"")
				$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;",";"")
				$vt_cuentaSinFormato:=Replace string:C233($vt_cuentaSinFormato;",";"")
				$vt_cuentaSinFormato:=ST_DeleteCharsLeft ($vt_cuentaSinFormato;"0")
				$vt_serieSinFormato:=Replace string:C233($noSerieDcto;" ";"")
				$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;"-";"")
				$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;".";"")
				$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;",";"")
				$vt_serieSinFormato:=Replace string:C233($vt_serieSinFormato;",";"")
				$vt_serieSinFormato:=ST_DeleteCharsLeft ($vt_serieSinFormato;"0")
				$index:=$vt_codigoBanco+"."+$vt_cuentaSinFormato+"."+$vt_serieSinFormato
				$l_recs:=Find in field:C653([ACT_Documentos_de_Pago:176]indexDocDePago:45;$index)
				
				  // 13/11/2017 Saúl Ponce O. Ticket 191466, agrega datos de los cheques a un array de llaves para unicidad posterior 
				$t_llave:=$noSerieDcto+"."+$vt_cuenta+"."+$vt_codigoBanco
				APPEND TO ARRAY:C911($at_keyCheques;$t_llave)
				APPEND TO ARRAY:C911($ad_fechasCheques;$adACT_Vencimiento{$l_indice})
				
				If ($l_recs>=0)
					$t_descripcionError:=$t_descripcionError+"Documento ya existe: Serie: "+$atACT_Numero{$l_indice}+", cuenta: "+$atACT_Cuenta{$l_indice}+", id banco: "+atACT_BankID{$id}+". El pago no podrá ser ingresado."
					
					<>tRINSC_debug:=<>tRINSC_debug+"Documento ya existe: Serie: "+$atACT_Numero{$l_indice}+", cuenta: "+$atACT_Cuenta{$l_indice}+", id banco: "+atACT_BankID{$id}+"."+"\r"
					$r_error:=-32
					$l_indice:=Size of array:C274($atACT_tipo)
				Else 
					
					If ($adACT_Vencimiento{$l_indice}#!00-00-00!)  //20180122 RCH
						
						$t_llave:=$t_llave+"."+$atACT_tipo{$l_indice}
						If (Find in array:C230($at_keyChequesMatCol;$t_llave)=-1)
							APPEND TO ARRAY:C911($at_keyChequesMatCol;$t_llave)
						Else 
							$t_descripcionError:=$t_descripcionError+"Documento duplicado. Serie: "+$atACT_Numero{$l_indice}+", cuenta: "+$atACT_Cuenta{$l_indice}+", id banco: "+atACT_BankID{$id}+". El pago no podrá ser ingresado."
							<>tRINSC_debug:=<>tRINSC_debug+"Documento duplicado. Serie: "+$atACT_Numero{$l_indice}+", cuenta: "+$atACT_Cuenta{$l_indice}+", id banco: "+atACT_BankID{$id}+"."+"\r"
							$r_error:=-40
							$l_indice:=Size of array:C274($atACT_tipo)
						End if 
					Else 
						$t_descripcionError:=$t_descripcionError+"Fecha de documento no válida. Serie: "+$atACT_Numero{$l_indice}+", cuenta: "+$atACT_Cuenta{$l_indice}+", id banco: "+atACT_BankID{$id}+". El pago no podrá ser ingresado"
						<>tRINSC_debug:=<>tRINSC_debug+"Fecha de documento no válida. Serie: "+$atACT_Numero{$l_indice}+", cuenta: "+$atACT_Cuenta{$l_indice}+", id banco: "+atACT_BankID{$id}+"."+"\r"
						$r_error:=-42
						$l_indice:=Size of array:C274($atACT_tipo)
					End if 
				End if 
			End for 
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Cheques duplicados verificados..."+"\r"
		
		  // 13/11/2017 Saúl Ponce O. Ticket 191466, para registrar pagos de colegiatura y mensualidad con el mismo cheque y todos los datos sean iguales.
		If ($r_error=0)
			  // Modificado por: Saul Ponce (30/11/2017), se agrega el array $at_keyCheques2 para ser utlizado acá y no perder los datos de unicidad que serán utilizados en comparaciones posteriores
			ARRAY TEXT:C222($at_keyCheques2;0)
			COPY ARRAY:C226($at_keyCheques;$at_keyCheques2)
			AT_DistinctsArrayValues (->$at_keyCheques2)
			If (Size of array:C274($at_keyCheques2)=1)
				AT_DistinctsArrayValues (->$ad_fechasCheques)
				If (Size of array:C274($ad_fechasCheques)>1)
					$r_error:=-39
					<>tRINSC_debug:=<>tRINSC_debug+"Matrícula y Colegiatura canceladas con el mismo cheque y con distintas fechas de vencimiento: "+AT_array2text (->$ad_fechasCheques;"; ")+".\r"
				End if 
			End if 
		End if 
		
		  //verifica que avisos existan
		If ($r_error=0)
			  //busca deuda
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([Personas:7])
			KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtas)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!)
			If (Records in selection:C76([ACT_Cargos:173])>0)
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
				<>tRINSC_debug:=<>tRINSC_debug+"Hay "+String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))+" Avisos de Cobranza emitidos."+"\r"
				$r_error:=-35
				
				$t_descripcionError:="Hay "+String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))+" Aviso(s) de Cobranza ya emitido(s). Elimine los Avisos o marque el proceso como enviado."
			End if 
			
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Verificación avisos..."+"\r"
		
		  //verifica fecha
		If ($r_error=0)
			If ($d_fechaProceso=!00-00-00!)
				$r_error:=-34
				
				$t_descripcionError:="Fecha no válida."
			End if 
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Verifica fecha..."+"\r"
		
		If ($r_error=0)
			  //valida montos
			C_REAL:C285($r_montoPagos;$r_montoCargos)
			Case of 
				: (($r_medioPagoMat=-4) & ($r_medioPagoCol=-4))  // si ambos son cheques.
					$r_montoPagos:=0
					$r_montoCargos:=0
					For ($x;1;Size of array:C274($atACT_Monto))
						$r_montoPagos:=$r_montoPagos+Num:C11($atACT_Monto{$x})
					End for 
					
					For ($x;1;Size of array:C274($atACT_CargosMontos))
						$r_montoCargos:=$r_montoCargos+Num:C11($atACT_CargosMontos{$x})
					End for 
					
					If ($r_montoPagos#$r_montoCargos)
						<>tRINSC_debug:=<>tRINSC_debug+"Montos no coinciden. Monto cargos: "+String:C10($r_montoCargos)+". Monto pagos: "+String:C10($r_montoPagos)+"."+"\r"
						$r_error:=-24
						
						$t_descripcionError:="Montos no coinciden. Monto cargos: "+String:C10($r_montoCargos)+". Monto pagos: "+String:C10($r_montoPagos)+"."
					End if 
					
				: ($r_medioPagoMat=-4)
					$r_montoPagos:=0
					$r_montoCargos:=0
					ARRAY LONGINT:C221($alACT_pos;0)
					$atACT_tipo{0}:="matricula"
					AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
					For ($x;1;Size of array:C274($alACT_pos))
						$r_montoPagos:=$r_montoPagos+Num:C11($atACT_Monto{$alACT_pos{$x}})
					End for 
					ARRAY LONGINT:C221($atACT_CargosMontosPos;0)
					$atACT_CargosTipo{0}:="matricula"
					AT_SearchArray (->$atACT_CargosTipo;"=";->$atACT_CargosMontosPos)
					For ($x;1;Size of array:C274($atACT_CargosMontosPos))
						$r_montoCargos:=$r_montoCargos+Num:C11($atACT_CargosMontos{$atACT_CargosMontosPos{$x}})
					End for 
					If ($r_montoPagos#$r_montoCargos)
						<>tRINSC_debug:=<>tRINSC_debug+"Montos no coinciden. Monto cargos: "+String:C10($r_montoCargos)+". Monto pagos: "+String:C10($r_montoPagos)+"."+"\r"
						
						$t_descripcionError:="Montos no coinciden. Monto cargos: "+String:C10($r_montoCargos)+". Monto pagos: "+String:C10($r_montoPagos)+"."
						
						$r_error:=-29
					End if 
					
				: ($r_medioPagoCol=-4)
					$r_montoPagos:=0
					$r_montoCargos:=0
					ARRAY LONGINT:C221($alACT_pos;0)
					$atACT_tipo{0}:="colegiatura"
					AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
					For ($x;1;Size of array:C274($alACT_pos))
						$r_montoPagos:=$r_montoPagos+Num:C11($atACT_Monto{$alACT_pos{$x}})
					End for 
					ARRAY LONGINT:C221($atACT_CargosMontosPos;0)
					$atACT_CargosTipo{0}:="colegiatura"
					AT_SearchArray (->$atACT_CargosTipo;"=";->$atACT_CargosMontosPos)
					For ($x;1;Size of array:C274($atACT_CargosMontosPos))
						$r_montoCargos:=$r_montoCargos+Num:C11($atACT_CargosMontos{$atACT_CargosMontosPos{$x}})
					End for 
					If ($r_montoPagos#$r_montoCargos)
						<>tRINSC_debug:=<>tRINSC_debug+"Montos no coinciden. Monto cargos: "+String:C10($r_montoCargos)+". Monto pagos: "+String:C10($r_montoPagos)+"."+"\r"
						$r_error:=-30
						
						$t_descripcionError:="Montos no coinciden. Monto cargos: "+String:C10($r_montoCargos)+". Monto pagos: "+String:C10($r_montoPagos)+"."
					End if 
					
			End case 
			  //datos de cheques
			  //ARRAY TEXT($atACT_tipo;0)
			  //ARRAY TEXT($atACT_Banco;0)
			  //ARRAY TEXT($atACT_Cuenta;0)
			  //ARRAY TEXT($atACT_Numero;0)
			  //ARRAY TEXT($atACT_Monto;0)
			  //ARRAY DATE($adACT_Vencimiento;0)
			
			  //arreglos cargos
			  //APPEND TO ARRAY($atACT_CargosUUIDAl;atRINSC_uuidAL{Size of array(atRINSC_uuidAL)})
			  //APPEND TO ARRAY($atACT_CargosTipo;at_nombres3{$x})
			  //APPEND TO ARRAY($arACT_CargosIDACT;$l_idACT)
			  //APPEND TO ARRAY($atACT_CargosMontos;$t_monto)
			
		End if 
	End if 
	<>tRINSC_debug:=<>tRINSC_debug+"Verifica montos..."+"\r"
	
	  //si algun cargo no tiene mes asociado, se asigna el de la matrícula o colegiatura
	  //If ($r_error#0)
	If ($r_error=0)  //20160210 RCH si no hay error se continua
		For ($l_indice;1;Size of array:C274($arACT_CargosIDACT))
			  //APPEND TO ARRAY($y_pointer->;$l_idACT)
			  //APPEND TO ARRAY($atACT_CargosUUIDAl;atRINSC_uuidAL{Size of array(atRINSC_uuidAL)})
			  //APPEND TO ARRAY($atACT_CargosTipo;at_nombres3{$x})
			  //APPEND TO ARRAY($arACT_CargosIDACT;$l_idACT)
			  //APPEND TO ARRAY($atACT_CargosMontos;$t_monto)
			
			If ($arACT_CargosIDACT{$l_indice}>0)  //20171011 RCH
				
				$l_mesF:=0
				$l_yearF:=0
				
				READ ONLY:C145([xxACT_Items:179])
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$arACT_CargosIDACT{$l_indice})
				If ([xxACT_Items:179]Meses_de_cargo:9=0)
					
					  //Se buscan para el mismo tipo y alumno
					$t_tipo:=$atACT_CargosTipo{$l_indice}
					ARRAY LONGINT:C221($al_pos1;0)
					ARRAY LONGINT:C221($al_pos2;0)
					ARRAY LONGINT:C221($al_pos3;0)
					
					
					ARRAY REAL:C219($ar_montos;0)
					ARRAY LONGINT:C221($al_ids;0)
					
					  //mismo tipo
					$atACT_CargosTipo{0}:=$atACT_CargosTipo{$l_indice}
					AT_SearchArray (->$atACT_CargosTipo;"=";->$al_pos1)
					
					  //mismo alumno
					$atACT_CargosUUIDAl{0}:=$atACT_CargosUUIDAl{$l_indice}
					AT_SearchArray (->$atACT_CargosUUIDAl;"=";->$al_pos2)
					
					  //
					AT_intersect (->$al_pos1;->$al_pos2;->$al_pos3)
					
					$l_pos:=Find in array:C230($atACT_uuidORG;$atACT_CargosUUIDAl{$l_indice})
					If ($l_pos#0)
						$l_idCta:=$alACT_idsCtas{$l_pos}
					End if 
					
					For ($l_indiceSearch;1;Size of array:C274($al_pos3))
						APPEND TO ARRAY:C911($al_ids;$arACT_CargosIDACT{$al_pos3{$l_indiceSearch}})
						APPEND TO ARRAY:C911($ar_montos;Num:C11($atACT_CargosMontos{$al_pos3{$l_indiceSearch}}))
					End for 
					
					  //quito sobre el que estoy trabajando
					$l_pos:=Find in array:C230($al_ids;$arACT_CargosIDACT{$l_indice})
					If ($l_pos#0)
						AT_Delete ($l_pos;1;->$ar_montos;->$al_ids)
					End if 
					
					SORT ARRAY:C229($ar_montos;$al_ids;<)
					For ($l_indiceItems;1;Size of array:C274($al_ids))
						$l_mesF:=0
						
						READ ONLY:C145([ACT_Cargos:173])
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$al_ids{$l_indiceItems};*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]ID_CuentaCorriente:2=$l_idCta;*)
						QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7=!00-00-00!)
						ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							$l_mesF:=Month of:C24([ACT_Cargos:173]Fecha_de_generacion:4)
							$l_yearF:=Year of:C25([ACT_Cargos:173]Fecha_de_generacion:4)
						Else 
							READ ONLY:C145([xxACT_Items:179])
							QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$al_ids{$l_indiceItems})
							For ($l_meses;1;12)
								If ([xxACT_Items:179]Meses_de_cargo:9 ?? $l_meses)
									$l_mesF:=$l_meses
									$l_meses:=12
								End if 
							End for 
						End if 
						If ($l_mesF#0)
							$l_indiceItems:=Size of array:C274($al_ids)
						End if 
					End for 
					
					If ($l_mesF#0)
						READ WRITE:C146([xxACT_Items:179])
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$arACT_CargosIDACT{$l_indice})
						APPEND TO ARRAY:C911($alACT_idsItemsYear0;[xxACT_Items:179]ID:1)
						[xxACT_Items:179]Meses_de_cargo:9:=[xxACT_Items:179]Meses_de_cargo:9 ?+ $l_mesF
						SAVE RECORD:C53([xxACT_Items:179])
						KRL_UnloadReadOnly (->[xxACT_Items:179])
					End if 
					
				End if 
				
				If ($r_error=0)
					APPEND TO ARRAY:C911($alACT_añoGeneracion;$l_yearF)
				End if 
			Else 
				If ($r_error=0)
					APPEND TO ARRAY:C911($alACT_añoGeneracion;$l_yearF)
				End if 
			End if 
		End for 
	End if 
	
	  //si pasa las validaciones, se procesa la petición
	If ($r_error=0)
		
		  //20151203 RCH leo conf items matricula
		ACTcfg_ItemsMatricula ("InicializaYLee")
		
		<>tRINSC_debug:=<>tRINSC_debug+"Generación de cargos..."+"\r"
		  //busco items para el periodo
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Periodo:42=$t_periodo)
		
		ARRAY LONGINT:C221($alACT_CargosPeriodo;0)
		SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACT_CargosPeriodo)
		
		ARRAY LONGINT:C221($alACT_cargosOrg;0)
		ARRAY LONGINT:C221($alACT_cargosPost;0)
		ARRAY LONGINT:C221($alACT_idsNuevosCargos;0)
		ARRAY LONGINT:C221($alACT_idsNuevosCargosTemp;0)
		ARRAY LONGINT:C221($alACT_idsNuevosCargosFinal;0)
		
		  //busca deuda
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([Personas:7])
		KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtas)
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
		CREATE SET:C116([ACT_Cargos:173];"CargosApdo")
		
		<>tRINSC_debug:=<>tRINSC_debug+"Inicio transacción..."+"\r"
		START TRANSACTION:C239
		For ($l_indiceCta;1;Size of array:C274(atRINSC_uuidAL))
			USE SET:C118("CargosApdo")
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atRINSC_uuidAL{$l_indiceCta})
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_cargosOrg)
			
			ARRAY LONGINT:C221(aLong1;0)
			APPEND TO ARRAY:C911(aLong1;Record number:C243([ACT_CuentasCorrientes:175]))
			
			  //busco arreglo con cargos del alumno que corresponde
			$y_pointer:=Get pointer:C304("aQR_Longint"+String:C10($l_indiceCta))
			
			  //compara cargos que vienen
			ARRAY LONGINT:C221($alACT_CargosNoEmitidos;0)
			ARRAY REAL:C219($arACT_MontosNoEmitidos;0)
			
			ARRAY BOOLEAN:C223($ab_usarMontos;0)  //20161129 RCH
			
			ARRAY LONGINT:C221($alACT_añoGeneracion2;0)
			C_LONGINT:C283($l_recs)
			For ($l_indice;1;Size of array:C274($y_pointer->))
				If ($y_pointer->{$l_indice}>0)  //20171011 RCH
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$y_pointer->{$l_indice})
					If ($l_recs=0)
						APPEND TO ARRAY:C911($alACT_CargosNoEmitidos;$y_pointer->{$l_indice})
						
						  //AT_Insert (0;1;->$arACT_MontosNoEmitidos;->$alACT_añoGeneracion2)
						AT_Insert (0;1;->$arACT_MontosNoEmitidos;->$alACT_añoGeneracion2;->$ab_usarMontos)  //20161129 RCH
						
						ARRAY LONGINT:C221($alACT_posAlumnos;0)
						ARRAY LONGINT:C221($alACT_idsCargos;0)
						ARRAY LONGINT:C221($alACT_resultado;0)
						$atACT_CargosUUIDAl{0}:=$atACT_uuidORG{$l_indiceCta}
						AT_SearchArray (->$atACT_CargosUUIDAl;"=";->$alACT_posAlumnos)
						$arACT_CargosIDACT{0}:=$y_pointer->{$l_indice}
						AT_SearchArray (->$arACT_CargosIDACT;"=";->$alACT_idsCargos)
						AT_intersect (->$alACT_posAlumnos;->$alACT_idsCargos;->$alACT_resultado)
						If (Size of array:C274($alACT_resultado)>0)
							$arACT_MontosNoEmitidos{Size of array:C274($arACT_MontosNoEmitidos)}:=Num:C11($atACT_CargosMontos{$alACT_resultado{1}})
							
							$ab_usarMontos{Size of array:C274($ab_usarMontos)}:=$abACT_utilizarMonto{$alACT_resultado{1}}  //20161129 RCH
							
							If (Size of array:C274($alACT_resultado)>1)
								TRACE:C157
							End if 
						End if 
						
						  //para ver el año
						If (Size of array:C274($alACT_resultado)>0)
							$alACT_añoGeneracion2{Size of array:C274($alACT_añoGeneracion2)}:=$alACT_añoGeneracion{$alACT_resultado{1}}
						End if 
						
						
					End if 
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
				Else 
					If (Size of array:C274($alACT_resultado)>0)  //20171011
						$alACT_añoGeneracion2{Size of array:C274($alACT_añoGeneracion2)}:=$alACT_añoGeneracion{$alACT_resultado{1}}
					End if 
				End if 
			End for 
			<>tRINSC_debug:=<>tRINSC_debug+"Antes de cargos no emitidos..."+"\r"
			  //si hay cargos que proyectar, aquí se hace. Se proyectan desde Enero a Diciembre del año solicitado.
			If (Size of array:C274($alACT_CargosNoEmitidos)>0)
				
				ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
				
				For ($l_indiceItems;1;Size of array:C274($alACT_CargosNoEmitidos))
					vlACT_selectedItemId:=$alACT_CargosNoEmitidos{$l_indiceItems}
					KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vlACT_selectedItemId)
					
					  //meses de cobro
					  // defectos página 5 (periodos y fechas)
					ARRAY TEXT:C222(aMeses;0)
					COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
					COPY ARRAY:C226(aMeses;aMeses2)
					  //$thisYear:=Year of(Current date(*))
					If ($alACT_añoGeneracion2{$l_indiceItems}=0)
						  //20151221 RCH Para emitir proyectar para el año solicitado
						  //$thisYear:=<>gYear+1  //se debe emitir para el siguiente año
						$thisYear:=Num:C11($t_periodo)  //se debe emitir para el año solicitado. //20151221 RCH
						If (Not:C34(($thisYear>=2010) & ($thisYear<=2100)))
							$thisYear:=<>gYear+1
						End if 
						
					Else 
						$thisYear:=$alACT_añoGeneracion2{$l_indiceItems}
					End if 
					
					vdACT_AñoAviso:=$thisYear
					l1:=1
					l2:=0
					vs1:=aMeses{1}
					vs2:=aMeses{12}
					
					  //20160601 RCH Para calendario B
					vs1:=PREF_fGet (0;"ACT_RinscProyeccionMesInicio";vs1)
					vs2:=PREF_fGet (0;"ACT_RinscProyeccionMesFin";vs2)
					
					vdACT_AñoAviso2:=vdACT_AñoAviso
					
					viACT_DiaGeneracion:=viACT_DiaDeuda
					aMeses:=Find in array:C230(aMeses;vs1)
					aMeses2:=Find in array:C230(aMeses2;vs2)
					If (aMeses2<aMeses)
						vdACT_AñoAviso2:=vdACT_AñoAviso2+1
					End if 
					
					  //para monedas
					ACTcfg_LoadConfigData (6)
					ACTcfgmyt_OpcionesGenerales ("CargaListBoxEmision")
					C_TEXT:C284($vt_pref)
					$vt_pref:="0"
					cbMontosEnMonedaPago:=Num:C11(PREF_fGet (0;"ACTcfg_EmitirEnMontosFijos";$vt_pref))
					If (cbMontosEnMonedaPago=1)
						$b_bool:=True:C214
						AT_Populate (->abACT_MontosFijosEm;->$b_bool;Size of array:C274(abACT_MontosFijosEm))
					End if 
					
					$l_idItem:=0
					$r_montoOrg:=0
					$t_monedaOrg:=""
					
					vlACT_SelectedMatrixID:=0
					atACT_NombreMoneda:=1
					vsACT_Moneda:=atACT_NombreMoneda{atACT_NombreMoneda}
					prevMoneda:=vsACT_Moneda
					  //If (([xxACT_Items]EsDescuento) & ($arACT_MontosNoEmitidos{$l_indiceItems}<0))
					  //If ((([xxACT_Items]EsDescuento) & ($arACT_MontosNoEmitidos{$l_indiceItems}<0)) | ($abACT_utilizarMonto{$l_indiceItems}))
					If ((([xxACT_Items:179]EsDescuento:6) & ($arACT_MontosNoEmitidos{$l_indiceItems}<0)) | ($ab_usarMontos{$l_indiceItems}))  //20161129 RCH
						$l_idItem:=[xxACT_Items:179]ID:1
						$r_montoOrg:=[xxACT_Items:179]Monto:7
						$t_monedaOrg:=[xxACT_Items:179]Moneda:10
						
						  //20161129 RCH
						  //KRL_ReloadInReadWriteMode (->[xxACT_Items])
						KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem;True:C214)
						If (ok=1)
							[xxACT_Items:179]Monto:7:=Abs:C99($arACT_MontosNoEmitidos{$l_indiceItems})
							[xxACT_Items:179]Moneda:10:=ST_GetWord (ACT_DivisaPais ;1;";")  //Los descuentos se generan siempre en la moneda de pago
							SAVE RECORD:C53([xxACT_Items:179])
						Else 
							$r_error:=-38
						End if 
						KRL_ReloadAsReadOnly (->[xxACT_Items:179])
						vsACT_Moneda:=[xxACT_Items:179]Moneda:10
					End if 
					
					If ($r_error=0)  //20161129 RCH
						
						vrACT_Monto:=[xxACT_Items:179]Monto:7
						
						cbACT_EsDescuento:=Num:C11([xxACT_Items:179]EsDescuento:6)
						cbACT_Afecto_IVA:=Num:C11([xxACT_Items:179]Afecto_IVA:12)
						cbACT_NoDocTrib:=Num:C11([xxACT_Items:179]No_incluir_en_DocTributario:31)
						vrACT_ValorMoneda:=ACTut_fValorUF (Current date:C33(*))
						vrACT_MontoPesos:=0
						vsACT_CtaContable:=[xxACT_Items:179]No_de_Cuenta_Contable:15
						vsACT_CentroContable:=[xxACT_Items:179]Centro_de_Costos:21
						vsACT_CCtaContable:=[xxACT_Items:179]No_CCta_contable:22
						vsACT_CCentroContable:=[xxACT_Items:179]CCentro_de_costos:23
						vsACT_CodAuxCta:=[xxACT_Items:179]CodAuxCta:27
						vsACT_CodAuxCCta:=[xxACT_Items:179]CodAuxCCta:28
						vbACT_ImputacionUnica:=[xxACT_Items:179]Imputacion_Unica:24
						
						vsACT_SelectedItemName:=[xxACT_Items:179]Glosa:2
						atACT_ItemNames2Charge:=1
						vlACT_selectedItemId:=[xxACT_Items:179]ID:1
						
						vsACT_Glosa:=vsACT_SelectedItemName
						bc_ExecuteOnServer:=0
						vbACT_CargoEspecial:=False:C215
						vdACT_FechaUFSel:=Current date:C33(*)
						
						b1:=0
						b2:=1
						b3:=0
						
						f1:=1
						f2:=0
						f3:=0
						
						viACT_cuentas1:=Records in selection:C76([ACT_CuentasCorrientes:175])
						viACT_cuentas4:=viACT_cuentas1
						
						vi_PageNumber:=1
						vi_step:=1
						
						bc_EliminaDesctos:=0
						bc_ReplaceSameDescription:=0
						
						ARRAY LONGINT:C221($aLong1;0)
						COPY ARRAY:C226(aLong1;$aLong1)
						
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=vlACT_selectedItemId)
						  //20130611 RCH
						$l_idRazonSocial:=[xxACT_Items:179]ID_RazonSocial:36
						  //If ([xxACT_Items]EsDescuento)
						  //For ($r;1;Size of array(aLong1))
						  //GOTO RECORD([ACT_CuentasCorrientes];aLong1{$r})
						  //$go:=False
						  //If ([ACT_CuentasCorrientes]ID_Apoderado=0)
						  //$where:=Find in array($aLong1;aLong1{$r})
						  //DELETE FROM ARRAY($aLong1;$where;1)
						  //AT_Insert (1;1;->aDeletedNames;->aMotivo)
						  //QUERY([Alumnos];[Alumnos]Número=[ACT_CuentasCorrientes]ID_Alumno)
						  //aMotivo{1}:="La cuenta corriente no tiene asignado un apoderado de cuentas."
						  //aDeletedNames{1}:=[Alumnos]Apellidos_y_Nombres
						  //Else 
						  //$go:=True
						  //End if 
						  //If ($go)
						  //If ([xxACT_Items]Afecto_IVA)
						  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-0000!;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]EsRelativo=False;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]TasaIVA#0)
						  //Else 
						  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=[ACT_CuentasCorrientes]ID;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-0000!;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]EsRelativo=False;*)
						  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]TasaIVA=0)
						  //End if 
						  //
						  //  //20130611 RCH
						  //$l_recordsAntes:=Records in selection([ACT_Cargos])
						  //ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$l_idRazonSocial)
						  //If ($l_recordsAntes#Records in selection([ACT_Cargos]))
						  //$b_mensajeRazones:=True
						  //End if 
						  //CREATE SET([ACT_Cargos];"Cargos")
						  //
						  //$fromMonth:=aMeses
						  //$toMonth:=aMeses2
						  //$year:=vdACT_AñoAviso
						  //$year2:=vdACT_AñoAviso2
						  //If ($year#$year2)
						  //$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
						  //Else 
						  //$toMonth:=$toMonth-$fromMonth+1
						  //End if 
						  //$indexPrev:=0
						  //For ($j;1;$toMonth)  //Loop por los meses a generar
						  //If (Int(($j+$fromMonth+$indexPrev-1)/13)>$indexPrev)
						  //$indexPrev:=Int(($j+$fromMonth+$indexPrev-1)/13)
						  //$month:=$j-(12*$indexPrev)+$fromMonth-1
						  //$year:=$year+1
						  //Else 
						  //$month:=$j-(12*$indexPrev)+$fromMonth-1
						  //End if 
						  //USE SET("Cargos")
						  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Mes=$month;*)
						  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Año=$year)
						  //$monto:=Sum([ACT_Cargos]Monto_Neto)
						  //$monto:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Monto_Neto;->[ACT_Cargos]Monto_Neto;vdACT_FechaUFSel)
						  //$monto:=Round(ACTut_retornaMontoEnMoneda ($monto;ST_GetWord (ACT_DivisaPais ;1;";");vdACT_FechaUFSel;[xxACT_Items]Moneda);4)
						  //If ($monto<[xxACT_Items]Monto)
						  //$where:=Find in array($aLong1;aLong1{$r})
						  //DELETE FROM ARRAY($aLong1;$where;1)
						  //AT_Insert (1;1;->aDeletedNames;->aMotivo)
						  //QUERY([Alumnos];[Alumnos]Número=[ACT_CuentasCorrientes]ID_Alumno)
						  //aMotivo{1}:=__ ("Existe por lo menos un mes en el rango de fechas en el cual el monto del descuento es superior a los montos cargados.")+Choose($b_mensajeRazones;". "+__ ("Revise las Razones Sociales asociadas a los ítems.");"")
						  //aDeletedNames{1}:=[Alumnos]Apellidos_y_Nombres
						  //$j:=$toMonth+1
						  //End if 
						  //End for 
						  //SET_ClearSets ("Cargos")
						  //End if 
						  //  //End if 
						  //CD_THERMOMETREXSEC (0;$r/Size of array(aLong1)*100)
						  //End for 
						  //
						  //End if 
						
						  //emision
						If (cbMontosEnMonedaPago=0)
							AT_Initialize (->atACT_NombreMonedaEm;->adACT_fechasEm)
						Else 
							For ($i;Size of array:C274(atACT_NombreMonedaEm);1;-1)
								adACT_fechasEm{$i}:=$d_fechaProceso  //se asigna fecha de proceso para obtener valor
								If (Not:C34(abACT_MontosFijosEm{$i}))
									AT_Delete ($i;1;->atACT_NombreMonedaEm;->adACT_fechasEm)
								End if 
							End for 
						End if 
						COPY ARRAY:C226($aLong1;aLong1)
						vbACT_montoAnual:=False:C215
						vlACT_numeroCuotas:=0
						ACTcar_OpcionesGenerales ("CargaBlobParaGeneracion";->xBlob)
						
						  //genera cargos
						C_PICTURE:C286(vpXS_IconModule)
						C_TEXT:C284(vsBWR_CurrentModule)
						vsBWR_CurrentModule:=""
						
						ACTcc_GeneraCargos (xblob;vpXS_IconModule;vsBWR_CurrentModule;False:C215;False:C215)
						<>tRINSC_debug:=<>tRINSC_debug+"Término generación de cargos..."+"\r"
						
						  //retorna item a valores configurados
						If ($l_idItem#0)
							KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->$l_idItem;True:C214)
							[xxACT_Items:179]Monto:7:=$r_montoOrg
							[xxACT_Items:179]Moneda:10:=$t_monedaOrg
							SAVE RECORD:C53([xxACT_Items:179])
							KRL_UnloadReadOnly (->[xxACT_Items:179])
						End if 
						
						If (Size of array:C274(alACT_CuentasTomadas)>0)
							$r_error:=-20
							
							$t_descripcionError:="Registros de Cuentas Corrientes en uso. Intente nuevamente."
						End if 
						
						  //si hay error salgo del for
						If ($r_error#0)
							$l_indiceItems:=Size of array:C274($alACT_CargosNoEmitidos)
						End if 
						
					Else 
						$l_indiceItems:=Size of array:C274($alACT_CargosNoEmitidos)
					End if 
					
				End for 
				<>tRINSC_debug:=<>tRINSC_debug+"For cargos no emitidos "+String:C10($l_indiceItems)+"..."+"\r"
				  //busco nuevamente los cargos haya o no haya error para poder eliminarlos...
				  //If ($r_error=0)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtas)
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$y_pointer->)
				
				If (Records in selection:C76([ACT_Cargos:173])>0)
					KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->atRINSC_uuidAL{$l_indiceCta})
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
					SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_cargosPost)
					AT_Difference (->$alACT_cargosPost;->$alACT_cargosOrg;->$alACT_idsNuevosCargos)
					
					  //guardo todos los cargos en 1 arreglo
					COPY ARRAY:C226($alACT_idsNuevosCargosFinal;$alACT_idsNuevosCargosTemp)
					AT_Union (->$alACT_idsNuevosCargosTemp;->$alACT_idsNuevosCargos;->$alACT_idsNuevosCargosFinal)
					
					If (<>bRINSC_depurarRINSC)
						$r_montoCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fechaProceso)
						<>tRINSC_debug:=<>tRINSC_debug+"Montos generados "+String:C10($r_montoCargos)+"..."+"\r"
					End if 
					  //valido que se hayan creado los cargos
					ARRAY LONGINT:C221($alACT_refItem;0)
					DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$alACT_refItem)
					
					  //20171016 RCH
					ARRAY LONGINT:C221($al_arrayComparacion;0)
					COPY ARRAY:C226($y_pointer->;$al_arrayComparacion)
					AT_DistinctsArrayValues (->$al_arrayComparacion)
					
					  //If (Size of array($alACT_refItem)<Size of array($y_pointer->))
					If (Size of array:C274($alACT_refItem)<Size of array:C274($al_arrayComparacion))
						$r_error:=-18
						
						$t_descripcionError:="No fueron generados todos los cargos. Cargos generados: "+AT_array2text (->$alACT_refItem;";";"#########")+"."
					End if 
				Else 
					$r_error:=-26
					
					$t_descripcionError:="Cargos no encontrados."
					
				End if 
			End if 
			
			If ($r_error#0)
				$l_indiceCta:=Size of array:C274(atRINSC_uuidAL)
			End if 
		End for 
		
		<>tRINSC_debug:=<>tRINSC_debug+"Verifica cargos para iniciar emisión..."+"\r"
		  //VALDIAR MONTOS ANTES DE EMITIR LOS AVISOS
		KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
		  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$y_pointer->)
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtas)
		AT_DistinctsArrayValues (->$alACT_idsItems)
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
		CREATE SET:C116([ACT_Cargos:173];"cargosApdo")
		
		  //20171016 RCH busco cargos asociados
		ARRAY LONGINT:C221($al_idsCargos;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargos)
		QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargos)
		CREATE SET:C116([ACT_Cargos:173];"$CargosApdo1")
		UNION:C120("CargosApdo";"$CargosApdo1";"CargosApdo")
		USE SET:C118("CargosApdo")
		SET_ClearSets ("$CargosApdo1")
		
		  //20171119 RCH Verifico emisión de cargos de descuento. Problema conocido en donde no se emite el descuento por el monto completo
		If ($r_error=0)
			C_OBJECT:C1216($ob_validacion)
			OB SET ARRAY:C1227($ob_validacion;"uuidal";$atACT_CargosUUIDAl)
			OB SET ARRAY:C1227($ob_validacion;"idcargo";$arACT_CargosIDACT)
			OB SET ARRAY:C1227($ob_validacion;"montos";$atACT_CargosMontos)
			
			C_LONGINT:C283(vlACT_NumVerificacion)
			vlACT_NumVerificacion:=0  //se valida maximo 9 veces. Llamado recursivo
			RINSCwa_VerificaCargoDctoEmiti ("CargosApdo";$ob_validacion;$d_fechaProceso)
			vlACT_NumVerificacion:=0
			USE SET:C118("CargosApdo")
		End if 
		
		  //obtengo datos para emisión de avisos
		ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>)
		$l_mesI:=Month of:C24([ACT_Cargos:173]Fecha_de_generacion:4)
		$l_yearI:=Year of:C25([ACT_Cargos:173]Fecha_de_generacion:4)
		ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;<)
		$l_mesF:=Month of:C24([ACT_Cargos:173]Fecha_de_generacion:4)
		$l_yearF:=Year of:C25([ACT_Cargos:173]Fecha_de_generacion:4)
		<>tRINSC_debug:=<>tRINSC_debug+"Fechas de inicio y fin de emisión de A.C "+String:C10($l_mesI)+"."+String:C10($l_yearI)+" al "+String:C10($l_mesF)+"."+String:C10($l_yearF)+"...."+"\r"
		
		  //emite
		If ($r_error=0)
			<>tRINSC_debug:=<>tRINSC_debug+"Emisión de A.C...."+"\r"
			
			ACTcfg_ItemsMatricula ("InicializaYLee")
			
			ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
			ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")
			  //ACTcfg_LoadConfigData
			
			KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setACOrg")
			
			ARRAY TEXT:C222(aMeses;0)
			ARRAY TEXT:C222(aMeses2;0)
			COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
			COPY ARRAY:C226(aMeses;aMeses2)
			mAvisoApoderado:=bAvisoApoderado  //viene de las prefs. no sacar!!!
			mAvisoAlumno:=bAvisoAlumno
			Generar:=False:C215
			aMeses:=$l_mesI
			aMeses2:=$l_mesF
			vdACT_DiaAviso:=viACT_DiaDeuda
			vdACT_FechaUFSel:=$d_fechaProceso
			vdACT_AñoAviso:=Year of:C25(Current date:C33(*))
			vdACT_AñoAviso:=$l_yearI
			vdACT_AñoAviso2:=$l_yearF
			cbVctoSegunConf:=1
			vtACT_CurrentUser:="Reinscripciones web"
			cb_NoPrepagarAuto:=1
			
			<>tRINSC_debug:=<>tRINSC_debug+"Pre Emisión de A.C...."+"\r"
			
			  // Modificado por: Saúl Ponce (21-10-2016) - Ticket N° 169639
			  // En ACTcc_EmisionAvisos() se utilizan los rec num de ctas ctes, 
			  // si no están las siguientes 2 líneas todo el proceso se realizaba siempre para una sola cuenta corriente. 
			  // Generaba problemas cuando el colegio estaba configurado para emitir avisos de cobranza por cuentas... 
			QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;$alACT_idsCtas)
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
			ACTcc_EmisionAvisos (1;Generar;->$alACT_idsCtas)
			<>tRINSC_debug:=<>tRINSC_debug+"Post Emisión de A.C...."+"\r"
			
			KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setACPost")
			
			DIFFERENCE:C122("setACPost";"setACOrg";"setACPost")
			
			<>tRINSC_debug:=<>tRINSC_debug+"A.C. emitidos "+String:C10(Records in set:C195("setACPost"))+"..."+"\r"
			If (Records in set:C195("setACPost")=0)
				$r_error:=-33
				
				$t_descripcionError:="Avisos de Cobranza no emitidos."
				
			End if 
		End if 
		
		  //verifica montos emitidos
		If ($r_error=0)
			USE SET:C118("setACPost")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			$r_montoCargosAC:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fechaProceso)
			
			$r_montoCargos:=0
			For ($x;1;Size of array:C274($atACT_CargosMontos))
				$r_montoCargos:=$r_montoCargos+Num:C11($atACT_CargosMontos{$x})
			End for 
			
			<>tRINSC_debug:=<>tRINSC_debug+"Monto en Avisos: "+String:C10($r_montoCargosAC)+". Monto en JSON: "+String:C10($r_montoCargos)+"."+"\r"
			If ($r_montoCargosAC#$r_montoCargos)
				$r_error:=-36
				
				CREATE SET:C116([ACT_Cargos:173];"setCargos")
				ARRAY LONGINT:C221($alACT_idsCtasLog;0)
				ARRAY LONGINT:C221($alACT_idsItems;0)
				DISTINCT VALUES:C339([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtasLog)
				For ($l_indiceCta;1;Size of array:C274($alACT_idsCtasLog))
					USE SET:C118("setCargos")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$alACT_idsCtasLog{$l_indiceCta})
					DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
					CREATE SET:C116([ACT_Cargos:173];"setCargos2")
					For ($l_indiceItem;1;Size of array:C274($alACT_idsItems))
						USE SET:C118("setCargos2")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$alACT_idsItems{$l_indiceItem})
						KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
						<>tRINSC_debug:=<>tRINSC_debug+"Alumno: "+[Alumnos:2]apellidos_y_nombres:40+", uuid: "+[Alumnos:2]auto_uuid:72+", ref item: "+String:C10([ACT_Cargos:173]Ref_Item:16)+", Cargo: "+[ACT_Cargos:173]Glosa:12+", monto: "+String:C10(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fechaProceso))+"..."+"\r"
						
						$l_existe:=Find in array:C230($arACT_CargosIDACT;[ACT_Cargos:173]Ref_Item:16)
						If ($l_existe>0)
							$r_montoCargoJS:=Num:C11($atACT_CargosMontos{$l_existe})
						Else 
							$r_montoCargoJS:=0
						End if 
						$r_montoEnCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fechaProceso)
						
						If ($r_montoEnCargos#$r_montoCargoJS)
							$t_descripcionError:=$t_descripcionError+"Alumno: "+[Alumnos:2]apellidos_y_nombres:40+", uuid: "+[Alumnos:2]auto_uuid:72+", ref item: "+String:C10([ACT_Cargos:173]Ref_Item:16)+", Cargo: "+[ACT_Cargos:173]Glosa:12+", monto: "+String:C10($r_montoEnCargos)+", Monto Json: "+String:C10($r_montoCargoJS)+"..."+"\r"
						End if 
					End for 
					SET_ClearSets ("setCargos2")
				End for 
				SET_ClearSets ("setCargos")
			End if 
			
		End if 
		
		  //ingresa pagos
		If ($r_error=0)
			ACTcfg_ItemsMatricula ("InicializaYLee")
			<>tRINSC_debug:=<>tRINSC_debug+"Inicia ingreso de pagos..."+"\r"
			ARRAY LONGINT:C221(alACTpgs_idsCargos;0)
			ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
			
			  //si hay un pago con cheque, se paga aca
			<>tRINSC_debug:=<>tRINSC_debug+"id Pago Mat: "+String:C10($r_medioPagoMat)+". Id pago Col: "+String:C10($r_medioPagoCol)+"."+"\r"
			If (($r_medioPagoMat=-4) | ($r_medioPagoCol=-4))
				  // 13/11/2017 Saúl Ponce O. Ticket 191466, Registrar pagos de colegiatura y mensualidad con el mismo cheque
				If (True:C214)
					
					  //Modificado por: Saul Ponce (30/11/2017), cuando venía un solo cheque, por ejemplo, por matrícula y colegiatura sin medio de pago en el JSON, se ingresaba un único pago por el total. 
					  //If (Size of array($at_keyCheques)=1)
					  //If ((Size of array($at_keyCheques2)=1) & (Size of array($at_keyCheques)=2) )  
					If ((Size of array:C274($at_keyCheques2)=1) & (Size of array:C274($at_keyCheques)=2) & (($r_medioPagoMat=-4) & ($r_medioPagoCol=-4)))  //20171204 RCH .Se agrega condición que verifique que pague col y mat en cheque
						
						<>tRINSC_debug:=<>tRINSC_debug+"Matrícula y colegiatura están siendo pagadas con el mismo cheque.\r"
						<>tRINSC_debug:=<>tRINSC_debug+"Cheque Banco: "+$atACT_Banco{1}+", Cuenta Cheque: "+$atACT_Cuenta{1}+", Número Serie: "+$atACT_Numero{1}+", Fecha Cheque: "+String:C10($adACT_Vencimiento{1})+".\r"
						
						ARRAY LONGINT:C221(alACTpgs_idsCargos;0)
						ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
						
						USE SET:C118("cargosApdo")
						QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$arACT_CargosIDACT)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
							ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
							vbACTpgs_ArregloCargos:=True:C214
							
							KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
							RNApdo:=Record number:C243([Personas:7])
							RNTercero:=-1
							RNCta:=-1
							ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
							ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
							  //$alACT_idsItems
							vtACT_BancoNombre:=$atACT_Banco{1}
							vtACT_BancoCodigo:=atACT_BankID{Find in array:C230(atACT_BankName;vtACT_BancoNombre)}
							vtACT_NoSerie:=$atACT_Numero{1}
							vdACT_FechaDocumento:=$adACT_Vencimiento{1}
							vtACT_BancoCuenta:=$atACT_Cuenta{1}
							
							  //si no hay cheque el monto del pago es el de los cargos
							  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
							vrACT_MontoPago:=0
							For ($l_indicePagos;1;Size of array:C274($atACT_CargosMontos))
								vrACT_MontoPago:=vrACT_MontoPago+Num:C11($atACT_CargosMontos{$l_indicePagos})
							End for 
							$vrACT_MontoPago:=vrACT_MontoPago
							
							vtACT_ObservacionesPago:=""
							vlACT_FormasdePago:=$r_medioPagoMat
							vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
							vdACT_FechaPago:=$d_fechaProceso
							  //para que se ingrese el pago
							vtACT_TCDocumento:=""
							vtACT_TCTipo:=""
							vtACT_TCTitular:=""
							
							vtACT_RDocumento:=""
							vtACT_TDTipo:=""
							vtACT_TDTitular:=""
							
							vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
							
							  //ACTabc_ImportProcess
							ACTcfg_ItemsMatricula ("InicializaYLee")
							$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
							COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
							For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
								ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
							End for 
							
						End if 
						
						
						
					Else 
						
						
						ARRAY LONGINT:C221($alACT_pos;0)
						$atACT_tipo{0}:="matricula"
						AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
						
						  //busca y carga cargos
						ARRAY LONGINT:C221($alACT_refMat;0)
						ARRAY LONGINT:C221($alACT_posMatPagos;0)
						$atACT_CargosTipo{0}:="matricula"
						AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
						For ($l_indiceMat;1;Size of array:C274($alACT_posMatPagos))
							APPEND TO ARRAY:C911($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
						End for 
						AT_DistinctsArrayValues (->$alACT_refMat)
						USE SET:C118("cargosApdo")
						QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_refMat)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
							ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
							vbACTpgs_ArregloCargos:=True:C214
							
							KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
							RNApdo:=Record number:C243([Personas:7])
							RNTercero:=-1
							RNCta:=-1
							ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
							ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
							
							
							Case of 
								: ($r_medioPagoMat=-4)  //cheque
									
									For ($l_indicePagos;1;Size of array:C274($alACT_pos))
										  //busca y carga cargos
										$b_continuar:=True:C214
										If ($l_indicePagos>1)
											ARRAY LONGINT:C221($alACT_refMat;0)
											ARRAY LONGINT:C221($alACT_posMatPagos;0)
											$atACT_CargosTipo{0}:="matricula"
											AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
											For ($l_indiceMat;1;Size of array:C274($alACT_posMatPagos))
												APPEND TO ARRAY:C911($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
											End for 
											USE SET:C118("cargosApdo")
											QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_refMat)
											QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
											If (Records in selection:C76([ACT_Cargos:173])>0)
												  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
												ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
												SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
												vbACTpgs_ArregloCargos:=True:C214
												
												KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
												RNApdo:=Record number:C243([Personas:7])
												RNTercero:=-1
												RNCta:=-1
												ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
												ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
											Else 
												$b_continuar:=False:C215
											End if 
										End if 
										
										If ($b_continuar)
											  //ingresa pagos
											$id:=Find in array:C230(atACT_BankName;$atACT_Banco{$alACT_pos{$l_indicePagos}})
											If ($id#-1)
												vtACT_BancoNombre:=atACT_BankName{$id}
												vtACT_BancoCodigo:=atACT_BankID{$id}
											Else 
												vtACT_BancoNombre:=""
											End if 
											vtACT_NoSerie:=$atACT_Numero{$alACT_pos{$l_indicePagos}}
											vdACT_FechaDocumento:=$adACT_Vencimiento{$alACT_pos{$l_indicePagos}}
											vtACT_BancoCuenta:=$atACT_Cuenta{$alACT_pos{$l_indicePagos}}
											
											vrACT_MontoPago:=Num:C11($atACT_Monto{$alACT_pos{$l_indicePagos}})
											$vrACT_MontoPago:=vrACT_MontoPago
											vtACT_ObservacionesPago:=""
											vlACT_FormasdePago:=$r_medioPagoMat
											vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
											vdACT_FechaPago:=$d_fechaProceso
											
											  //para que se ingrese el pago
											  //para que se ingrese el pago
											vtACT_TCDocumento:=""
											vtACT_TCTipo:=""
											vtACT_TCTitular:=""
											vtACT_TCNumero:=""
											vtACT_TCBancoCodigo:=""
											vtACT_TCMesVencimiento:=""
											vtACT_TCAgnoVencimiento:=""
											
											vtACT_RDocumento:=""
											vtACT_TDTipo:=""
											vtACT_TDTitular:=""
											vtACT_TDNumero:=""
											vtACT_TDBancoCodigo:=""
											vtACT_TDMesVencimiento:=""
											vtACT_TDAgnoVencimiento:=""
											If ($r_medioPagoMat=-6)
												  //vtACT_TCDocumento:=String($r_medioPagoMat)
												  //ACTpgs_CreacionDocdePago 
												
												C_OBJECT:C1216($ob_tc)
												$ob_tc:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
												OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
												OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
												OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
												OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
												
												C_LONGINT:C283($l_mes;$l_year)
												OB_GET ($ob_tc;->$l_mes;"mes_vencimiento")
												OB_GET ($ob_tc;->$l_year;"anio_vencimiento")
												OB_GET ($ob_tc;->vtACT_TCBancoCodigo;"banco_emisor")
												OB_GET ($ob_tc;->vtACT_TCNumero;"numero_tarjeta")
												vtACT_TCMesVencimiento:=String:C10($l_mes)
												vtACT_TCAgnoVencimiento:=String:C10($l_year)
												
												
												If (vtACT_TCDocumento="")
													vtACT_TCDocumento:=String:C10($r_medioPagoMat)
												End if 
												
												If (vtACT_TCBancoCodigo#"")
													$l_pos:=Find in array:C230(atACT_BankID;vtACT_TCBancoCodigo)
													If ($l_pos>0)
														vtACT_TCBancoEmisor:=atACT_BankName{$l_pos}
													End if 
												End if 
												
											End if 
											If ($r_medioPagoMat=-7)
												  //vtACT_RDocumento:=String($r_medioPagoMat)
												  //ACTpgs_CreacionDocdePago 
												
												C_OBJECT:C1216($ob_td)
												$ob_td:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo el objeto para evitar errores en compilado
												OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
												OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
												OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
												OB_GET ($ob_td;->vtACT_TDTitular;"titular")
												
												C_LONGINT:C283($l_mes;$l_year)
												OB_GET ($ob_td;->$l_mes;"mes_vencimiento")
												OB_GET ($ob_td;->$l_year;"anio_vencimiento")
												OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
												OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
												vtACT_TDMesVencimiento:=String:C10($l_mes)
												vtACT_TDAgnoVencimiento:=String:C10($l_year)
												
												If (vtACT_RDocumento="")
													vtACT_RDocumento:=String:C10($r_medioPagoMat)
												End if 
												
												If (vtACT_TDBancoCodigo#"")
													$l_pos:=Find in array:C230(atACT_BankID;vtACT_TDBancoCodigo)
													If ($l_pos>0)
														vtACT_TDBancoEmisor:=atACT_BankName{$l_pos}
													End if 
												End if 
												
											End if 
											
											vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
											
											  //ACTabc_ImportProcess
											ACTcfg_ItemsMatricula ("InicializaYLee")
											vb_selectionMonth2Pay:=False:C215
											$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
											
											For ($r;1;Size of array:C274(alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
												APPEND TO ARRAY:C911($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$r})
											End for 
										End if 
									End for 
									
									  //recalcula
									AT_DistinctsArrayValues (->$alACTpgs_Avisos2Recalc)
									For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
										ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
									End for 
									
									  //: ($r_medioPagoMat=-3)  //efectivo
									
								: (Find in array:C230($alACT_idsFDP;$r_medioPagoMat)>0)
									vtACT_BancoNombre:=""
									vtACT_BancoCodigo:=""
									vtACT_NoSerie:=""
									vdACT_FechaDocumento:=!00-00-00!
									vtACT_BancoCuenta:=""
									
									vrACT_MontoPago:=0
									For ($l_indicePago;1;Size of array:C274($alACT_posMatPagos))
										vrACT_MontoPago:=vrACT_MontoPago+Num:C11($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePago}})
									End for 
									
									$vrACT_MontoPago:=vrACT_MontoPago
									vtACT_ObservacionesPago:=""
									vlACT_FormasdePago:=$r_medioPagoMat
									vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
									vdACT_FechaPago:=$d_fechaProceso
									
									  //para que se ingrese el pago
									  //para que se ingrese el pago
									vtACT_TCDocumento:=""
									vtACT_TCTipo:=""
									vtACT_TCTitular:=""
									vtACT_TCNumero:=""
									vtACT_TCBancoCodigo:=""
									vtACT_TCMesVencimiento:=""
									vtACT_TCAgnoVencimiento:=""
									
									vtACT_RDocumento:=""
									vtACT_TDTipo:=""
									vtACT_TDTitular:=""
									vtACT_TDNumero:=""
									vtACT_TDBancoCodigo:=""
									vtACT_TDMesVencimiento:=""
									vtACT_TDAgnoVencimiento:=""
									
									If ($r_medioPagoMat=-6)
										  //vtACT_TCDocumento:=String($r_medioPagoMat)
										
										C_OBJECT:C1216($ob_tc)
										$ob_tc:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo el objeto para evitar errores en compilado
										OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
										OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
										OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
										OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
										
										C_LONGINT:C283($l_mes;$l_year)
										OB_GET ($ob_tc;->$l_mes;"mes_vencimiento")
										OB_GET ($ob_tc;->$l_year;"anio_vencimiento")
										OB_GET ($ob_tc;->vtACT_TCBancoCodigo;"banco_emisor")
										OB_GET ($ob_tc;->vtACT_TCNumero;"numero_tarjeta")
										vtACT_TCMesVencimiento:=String:C10($l_mes)
										vtACT_TCAgnoVencimiento:=String:C10($l_year)
										
										If (vtACT_TCDocumento="")
											vtACT_TCDocumento:=String:C10($r_medioPagoMat)
										End if 
										
										If (vtACT_TCBancoCodigo#"")
											$l_pos:=Find in array:C230(atACT_BankID;vtACT_TCBancoCodigo)
											If ($l_pos>0)
												vtACT_TCBancoEmisor:=atACT_BankName{$l_pos}
											End if 
										End if 
									End if 
									If ($r_medioPagoMat=-7)
										  //vtACT_RDocumento:=String($r_medioPagoMat)
										
										C_OBJECT:C1216($ob_td)
										$ob_td:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo el objeto para evitar errores en compilado
										OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
										OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
										OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
										OB_GET ($ob_td;->vtACT_TDTitular;"titular")
										
										C_LONGINT:C283($l_mes;$l_year)
										OB_GET ($ob_td;->$l_mes;"mes_vencimiento")
										OB_GET ($ob_td;->$l_year;"anio_vencimiento")
										OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
										OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
										vtACT_TDMesVencimiento:=String:C10($l_mes)
										vtACT_TDAgnoVencimiento:=String:C10($l_year)
										
										If (vtACT_RDocumento="")
											vtACT_RDocumento:=String:C10($r_medioPagoMat)
										End if 
										
										If (vtACT_TDBancoCodigo#"")
											$l_pos:=Find in array:C230(atACT_BankID;vtACT_TDBancoCodigo)
											If ($l_pos>0)
												vtACT_TDBancoEmisor:=atACT_BankName{$l_pos}
											End if 
										End if 
										
									End if 
									
									vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
									
									  //ACTabc_ImportProcess
									ACTcfg_ItemsMatricula ("InicializaYLee")
									$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
									COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
									For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
										ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
									End for 
									
								Else 
									  //$r_error:=-22
							End case 
							
							  //colegiatura
							  //$r_medioPagoCol
							If ($r_error=0)
								
								ARRAY LONGINT:C221(alACTpgs_idsCargos;0)
								ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
								  //colegiatura
								ARRAY LONGINT:C221($alACT_pos;0)
								$atACT_tipo{0}:="colegiatura"
								AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
								
								  //busca y carga cargos
								ARRAY LONGINT:C221($alACT_refMat;0)
								ARRAY LONGINT:C221($alACT_posMatPagos;0)
								$atACT_CargosTipo{0}:="colegiatura"
								AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
								For ($l_indiceMat;1;Size of array:C274($alACT_posMatPagos))
									APPEND TO ARRAY:C911($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
								End for 
								AT_DistinctsArrayValues (->$alACT_refMat)
								USE SET:C118("cargosApdo")
								QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_refMat)
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
								If (Records in selection:C76([ACT_Cargos:173])>0)
									  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
									ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
									SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
									vbACTpgs_ArregloCargos:=True:C214
									
									KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
									RNApdo:=Record number:C243([Personas:7])
									RNTercero:=-1
									RNCta:=-1
									ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
									ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
									
									Case of 
										: ($r_medioPagoCol=-4)  //cheque
											
											For ($l_indicePagos;1;Size of array:C274($alACT_pos))
												  //busca y carga cargos
												$b_continuar:=True:C214
												If ($l_indicePagos>1)
													ARRAY LONGINT:C221($alACT_refMat;0)
													ARRAY LONGINT:C221($alACT_posMatPagos;0)
													$atACT_CargosTipo{0}:="colegiatura"
													AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
													For ($l_indiceMat;1;Size of array:C274($alACT_posMatPagos))
														APPEND TO ARRAY:C911($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
													End for 
													USE SET:C118("cargosApdo")
													QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_refMat)
													QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
													If (Records in selection:C76([ACT_Cargos:173])>0)
														  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
														ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
														SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
														vbACTpgs_ArregloCargos:=True:C214
														
														KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
														RNApdo:=Record number:C243([Personas:7])
														RNTercero:=-1
														RNCta:=-1
														ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
														ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
													End if 
												End if 
												
												If ($b_continuar)
													  //ingresa pagos
													$id:=Find in array:C230(atACT_BankName;$atACT_Banco{$alACT_pos{$l_indicePagos}})
													If ($id#-1)
														vtACT_BancoNombre:=atACT_BankName{$id}
														vtACT_BancoCodigo:=atACT_BankID{$id}
													Else 
														vtACT_BancoNombre:=""
													End if 
													vtACT_NoSerie:=$atACT_Numero{$alACT_pos{$l_indicePagos}}
													vdACT_FechaDocumento:=$adACT_Vencimiento{$alACT_pos{$l_indicePagos}}
													vtACT_BancoCuenta:=$atACT_Cuenta{$alACT_pos{$l_indicePagos}}
													
													vrACT_MontoPago:=Num:C11($atACT_Monto{$alACT_pos{$l_indicePagos}})
													$vrACT_MontoPago:=vrACT_MontoPago
													vtACT_ObservacionesPago:=""
													vlACT_FormasdePago:=$r_medioPagoCol
													vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
													vdACT_FechaPago:=$d_fechaProceso
													
													  //para que se ingrese el pago
													  //para que se ingrese el pago
													vtACT_TCDocumento:=""
													vtACT_TCTipo:=""
													vtACT_TCTitular:=""
													vtACT_TCNumero:=""
													vtACT_TCBancoCodigo:=""
													vtACT_TCMesVencimiento:=""
													vtACT_TCAgnoVencimiento:=""
													
													vtACT_RDocumento:=""
													vtACT_TDTipo:=""
													vtACT_TDTitular:=""
													vtACT_TDNumero:=""
													vtACT_TDBancoCodigo:=""
													vtACT_TDMesVencimiento:=""
													vtACT_TDAgnoVencimiento:=""
													If ($r_medioPagoCol=-6)
														  //vtACT_TCDocumento:=String($r_medioPagoCol)
														
														C_OBJECT:C1216($ob_tc)
														$ob_tc:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
														OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
														OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
														OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
														OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
														
														C_LONGINT:C283($l_mes;$l_year)
														OB_GET ($ob_tc;->$l_mes;"mes_vencimiento")
														OB_GET ($ob_tc;->$l_year;"anio_vencimiento")
														OB_GET ($ob_tc;->vtACT_TCBancoCodigo;"banco_emisor")
														OB_GET ($ob_tc;->vtACT_TCNumero;"numero_tarjeta")
														vtACT_TCMesVencimiento:=String:C10($l_mes)
														vtACT_TCAgnoVencimiento:=String:C10($l_year)
														
														If (vtACT_TCDocumento="")
															vtACT_TCDocumento:=String:C10($r_medioPagoCol)
														End if 
														
														If (vtACT_TCBancoCodigo#"")
															$l_pos:=Find in array:C230(atACT_BankID;vtACT_TCBancoCodigo)
															If ($l_pos>0)
																vtACT_TCBancoEmisor:=atACT_BankName{$l_pos}
															End if 
														End if 
														
													End if 
													If ($r_medioPagoCol=-7)
														  //vtACT_RDocumento:=String($r_medioPagoCol)
														
														C_OBJECT:C1216($ob_td)
														$ob_td:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
														OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
														OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
														OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
														OB_GET ($ob_td;->vtACT_TDTitular;"titular")
														
														C_LONGINT:C283($l_mes;$l_year)
														OB_GET ($ob_td;->$l_mes;"mes_vencimiento")
														OB_GET ($ob_td;->$l_year;"anio_vencimiento")
														OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
														OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
														vtACT_TDMesVencimiento:=String:C10($l_mes)
														vtACT_TDAgnoVencimiento:=String:C10($l_year)
														
														If (vtACT_RDocumento="")
															vtACT_RDocumento:=String:C10($r_medioPagoCol)
														End if 
														
														If (vtACT_TDBancoCodigo#"")
															$l_pos:=Find in array:C230(atACT_BankID;vtACT_TDBancoCodigo)
															If ($l_pos>0)
																vtACT_TDBancoEmisor:=atACT_BankName{$l_pos}
															End if 
														End if 
														
													End if 
													
													vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
													
													  //ACTabc_ImportProcess
													ACTcfg_ItemsMatricula ("InicializaYLee")
													vb_selectionMonth2Pay:=False:C215
													$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
													For ($r;1;Size of array:C274(alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
														APPEND TO ARRAY:C911($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$r})
													End for 
												End if 
												
											End for 
											
											  //recalcula
											AT_DistinctsArrayValues (->$alACTpgs_Avisos2Recalc)
											For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
												ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
											End for 
											
											  //: ($r_medioPagoCol=-3)  //efectivo
											
											  //: (($r_medioPagoCol=-3) | ($r_medioPagoCol=-18))  //webpay
										: (Find in array:C230($alACT_idsFDP;$r_medioPagoCol)>0)  //webpay
											vtACT_BancoNombre:=""
											vtACT_BancoCodigo:=""
											vtACT_NoSerie:=""
											vdACT_FechaDocumento:=!00-00-00!
											vtACT_BancoCuenta:=""
											
											vrACT_MontoPago:=0
											For ($l_indicePago;1;Size of array:C274($alACT_posMatPagos))
												vrACT_MontoPago:=vrACT_MontoPago+Num:C11($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePago}})
											End for 
											$vrACT_MontoPago:=vrACT_MontoPago
											vtACT_ObservacionesPago:=""
											vlACT_FormasdePago:=$r_medioPagoCol
											vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
											vdACT_FechaPago:=$d_fechaProceso
											
											  //para que se ingrese el pago
											
											  //para que se ingrese el pago
											vtACT_TCDocumento:=""
											vtACT_TCTipo:=""
											vtACT_TCTitular:=""
											vtACT_TCNumero:=""
											vtACT_TCBancoCodigo:=""
											vtACT_TCMesVencimiento:=""
											vtACT_TCAgnoVencimiento:=""
											
											vtACT_RDocumento:=""
											vtACT_TDTipo:=""
											vtACT_TDTitular:=""
											vtACT_TDNumero:=""
											vtACT_TDBancoCodigo:=""
											vtACT_TDMesVencimiento:=""
											vtACT_TDAgnoVencimiento:=""
											If ($r_medioPagoCol=-6)
												  //vtACT_TCDocumento:=String($r_medioPagoCol)
												
												C_OBJECT:C1216($ob_tc)
												$ob_tc:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
												OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
												OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
												OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
												OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
												
												C_LONGINT:C283($l_mes;$l_year)
												OB_GET ($ob_tc;->$l_mes;"mes_vencimiento")
												OB_GET ($ob_tc;->$l_year;"anio_vencimiento")
												OB_GET ($ob_tc;->vtACT_TCBancoCodigo;"banco_emisor")
												OB_GET ($ob_tc;->vtACT_TCNumero;"numero_tarjeta")
												vtACT_TCMesVencimiento:=String:C10($l_mes)
												vtACT_TCAgnoVencimiento:=String:C10($l_year)
												
												If (vtACT_TCDocumento="")
													vtACT_TCDocumento:=String:C10($r_medioPagoCol)
												End if 
												
												If (vtACT_TCBancoCodigo#"")
													$l_pos:=Find in array:C230(atACT_BankID;vtACT_TCBancoCodigo)
													If ($l_pos>0)
														vtACT_TCBancoEmisor:=atACT_BankName{$l_pos}
													End if 
												End if 
											End if 
											If ($r_medioPagoCol=-7)
												  //vtACT_RDocumento:=String($r_medioPagoCol)
												
												C_OBJECT:C1216($ob_td)
												$ob_td:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
												OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
												OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
												OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
												OB_GET ($ob_td;->vtACT_TDTitular;"titular")
												
												C_LONGINT:C283($l_mes;$l_year)
												OB_GET ($ob_td;->$l_mes;"mes_vencimiento")
												OB_GET ($ob_td;->$l_year;"anio_vencimiento")
												OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
												OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
												vtACT_TDMesVencimiento:=String:C10($l_mes)
												vtACT_TDAgnoVencimiento:=String:C10($l_year)
												
												If (vtACT_RDocumento="")
													vtACT_RDocumento:=String:C10($r_medioPagoCol)
												End if 
												
												If (vtACT_TDBancoCodigo#"")
													$l_pos:=Find in array:C230(atACT_BankID;vtACT_TDBancoCodigo)
													If ($l_pos>0)
														vtACT_TDBancoEmisor:=atACT_BankName{$l_pos}
													End if 
												End if 
												
											End if 
											
											vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
											
											  //ACTabc_ImportProcess
											ACTcfg_ItemsMatricula ("InicializaYLee")
											$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
											COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
											For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
												ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
											End for 
											
										Else 
											  //$r_error:=-22
									End case 
								End if 
							End if 
						End if 
					End if 
					
				End if 
				  // 13/11/2017 modificación
				
				  //matricula
				
				  //datos de cheques
				  //ARRAY TEXT($atACT_tipo;0)
				  //ARRAY TEXT($atACT_Banco;0)
				  //ARRAY TEXT($atACT_Cuenta;0)
				  //ARRAY TEXT($atACT_Numero;0)
				  //ARRAY TEXT($atACT_Monto;0)
				  //ARRAY DATE($adACT_Vencimiento;0)
				
				  //arreglos cargos
				  //APPEND TO ARRAY($atACT_CargosUUIDAl;atRINSC_uuidAL{Size of array(atRINSC_uuidAL)})
				  //APPEND TO ARRAY($atACT_CargosTipo;at_nombres3{$x})
				  //APPEND TO ARRAY($arACT_CargosIDACT;$l_idACT)
				  //APPEND TO ARRAY($atACT_CargosMontos;$t_monto)
				
				  // 13/11/2017 Saúl Ponce O. Ticket 191466, comenté esto
				
				If (False:C215)
					  //ARRAY LONGINT($alACT_pos;0)
					  //$atACT_tipo{0}:="matricula"
					  //AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
					
					  //  //busca y carga cargos
					  //ARRAY LONGINT($alACT_refMat;0)
					  //ARRAY LONGINT($alACT_posMatPagos;0)
					  //$atACT_CargosTipo{0}:="matricula"
					  //AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
					  //For ($l_indiceMat;1;Size of array($alACT_posMatPagos))
					  //APPEND TO ARRAY($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
					  //End for 
					  //AT_DistinctsArrayValues (->$alACT_refMat)
					  //USE SET("cargosApdo")
					  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$alACT_refMat)
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
					  //If (Records in selection([ACT_Cargos])>0)
					  //SELECTION TO ARRAY([ACT_Cargos]ID;alACTpgs_idsCargos)
					  //vbACTpgs_ArregloCargos:=True
					
					  //KRL_FindAndLoadRecordByIndex (->[Personas]Auto_UUID;->$atACT_uuidApdoCta{1})
					  //RNApdo:=Record number([Personas])
					  //RNTercero:=-1
					  //RNCta:=-1
					  //ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
					  //ACTpgs_CargaDatosPagoApdo (False;$d_fechaProceso)
					
					
					  //Case of 
					  //: ($r_medioPagoMat=-4)  //cheque
					
					  //For ($l_indicePagos;1;Size of array($alACT_pos))
					  //  //busca y carga cargos
					  //$b_continuar:=True
					  //If ($l_indicePagos>1)
					  //ARRAY LONGINT($alACT_refMat;0)
					  //ARRAY LONGINT($alACT_posMatPagos;0)
					  //$atACT_CargosTipo{0}:="matricula"
					  //AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
					  //For ($l_indiceMat;1;Size of array($alACT_posMatPagos))
					  //APPEND TO ARRAY($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
					  //End for 
					  //USE SET("cargosApdo")
					  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$alACT_refMat)
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
					  //If (Records in selection([ACT_Cargos])>0)
					  //SELECTION TO ARRAY([ACT_Cargos]ID;alACTpgs_idsCargos)
					  //vbACTpgs_ArregloCargos:=True
					
					  //KRL_FindAndLoadRecordByIndex (->[Personas]Auto_UUID;->$atACT_uuidApdoCta{1})
					  //RNApdo:=Record number([Personas])
					  //RNTercero:=-1
					  //RNCta:=-1
					  //ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
					  //ACTpgs_CargaDatosPagoApdo (False;$d_fechaProceso)
					  //Else 
					  //$b_continuar:=False
					  //End if 
					  //End if 
					
					  //If ($b_continuar)
					  //  //ingresa pagos
					  //$id:=Find in array(atACT_BankName;$atACT_Banco{$alACT_pos{$l_indicePagos}})
					  //If ($id#-1)
					  //vtACT_BancoNombre:=atACT_BankName{$id}
					  //vtACT_BancoCodigo:=atACT_BankID{$id}
					  //Else 
					  //vtACT_BancoNombre:=""
					  //End if 
					  //vtACT_NoSerie:=$atACT_Numero{$alACT_pos{$l_indicePagos}}
					  //vdACT_FechaDocumento:=$adACT_Vencimiento{$alACT_pos{$l_indicePagos}}
					  //vtACT_BancoCuenta:=$atACT_Cuenta{$alACT_pos{$l_indicePagos}}
					
					  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
					  //$vrACT_MontoPago:=vrACT_MontoPago
					  //vtACT_ObservacionesPago:=""
					  //vlACT_FormasdePago:=$r_medioPagoMat
					  //vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					  //vdACT_FechaPago:=$d_fechaProceso
					
					  //  //para que se ingrese el pago
					  //vtACT_TCDocumento:=""
					  //vtACT_TCTipo:=""
					  //vtACT_TCTitular:=""
					
					  //vtACT_RDocumento:=""
					  //vtACT_TDTipo:=""
					  //vtACT_TDTitular:=""
					  //If ($r_medioPagoMat=-6)
					  //  //vtACT_TCDocumento:=String($r_medioPagoMat)
					  //  //ACTpgs_CreacionDocdePago 
					
					  //C_OBJECT($ob_tc)
					  //OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
					  //OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
					  //OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
					  //OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
					  //  //ABC185803
					  //OB_GET ($ob_td;->vtACT_TCMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TCNumero;"numero_tarjeta")
					  //  //
					  //If (vtACT_TCDocumento="")
					  //vtACT_TCDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					  //If ($r_medioPagoMat=-7)
					  //  //vtACT_RDocumento:=String($r_medioPagoMat)
					  //  //ACTpgs_CreacionDocdePago 
					
					  //C_OBJECT($ob_td)
					  //OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
					  //OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
					  //OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
					  //OB_GET ($ob_td;->vtACT_TDTitular;"titular")
					  //  //ABC185803 
					  //OB_GET ($ob_td;->vtACT_TDMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
					  //  //agregados
					  //If (vtACT_RDocumento="")
					  //vtACT_RDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					
					  //vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String(Current date(*);5)
					
					  //  //ACTabc_ImportProcess
					  //ACTcfg_ItemsMatricula ("InicializaYLee")
					  //vb_selectionMonth2Pay:=False
					  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;False;vdACT_FechaPago;True;$t_usuario;"";$t_detalleVenta;String($r_ordenCompra))
					  //For ($r;1;Size of array(alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //APPEND TO ARRAY($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$r})
					  //End for 
					  //End if 
					  //End for 
					
					  //  //recalcula
					  //AT_DistinctsArrayValues (->$alACTpgs_Avisos2Recalc)
					  //For ($r;1;Size of array($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False;True)
					  //End for 
					
					  //  //: ($r_medioPagoMat=-3)  //efectivo
					
					  //: (Find in array($alACT_idsFDP;$r_medioPagoMat)>0)
					  //vtACT_BancoNombre:=""
					  //vtACT_BancoCodigo:=""
					  //vtACT_NoSerie:=""
					  //vdACT_FechaDocumento:=!00-00-00!
					  //vtACT_BancoCuenta:=""
					
					  //vrACT_MontoPago:=0
					  //For ($l_indicePago;1;Size of array($alACT_posMatPagos))
					  //vrACT_MontoPago:=vrACT_MontoPago+Num($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePago}})
					  //End for 
					
					  //$vrACT_MontoPago:=vrACT_MontoPago
					  //vtACT_ObservacionesPago:=""
					  //vlACT_FormasdePago:=$r_medioPagoMat
					  //vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					  //vdACT_FechaPago:=$d_fechaProceso
					
					  //  //para que se ingrese el pago
					  //vtACT_TCDocumento:=""
					  //vtACT_TCTipo:=""
					  //vtACT_TCTitular:=""
					
					  //vtACT_RDocumento:=""
					  //vtACT_TDTipo:=""
					  //vtACT_TDTitular:=""
					
					  //If ($r_medioPagoMat=-6)
					  //  //vtACT_TCDocumento:=String($r_medioPagoMat)
					
					  //C_OBJECT($ob_tc)
					  //OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
					  //OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
					  //OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
					  //OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
					  //  //ABC185803
					  //OB_GET ($ob_td;->vtACT_TCMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TCNumero;"numero_tarjeta")
					  //  //
					  //If (vtACT_TCDocumento="")
					  //vtACT_TCDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					  //If ($r_medioPagoMat=-7)
					  //  //vtACT_RDocumento:=String($r_medioPagoMat)
					
					  //C_OBJECT($ob_td)
					  //OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
					  //OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
					  //OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
					  //OB_GET ($ob_td;->vtACT_TDTitular;"titular")
					  //  //ABC185803 
					  //OB_GET ($ob_td;->vtACT_TDMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
					  //  //agregados
					  //If (vtACT_RDocumento="")
					  //vtACT_RDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					
					  //vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String(Current date(*);5)
					
					  //  //ACTabc_ImportProcess
					  //ACTcfg_ItemsMatricula ("InicializaYLee")
					  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;False;vdACT_FechaPago;True;$t_usuario;"";$t_detalleVenta;String($r_ordenCompra))
					  //COPY ARRAY(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
					  //For ($r;1;Size of array($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False;True)
					  //End for 
					
					  //Else 
					  //  //$r_error:=-22
					  //End case 
					
					  //  //colegiatura
					  //  //$r_medioPagoCol
					  //If ($r_error=0)
					
					  //ARRAY LONGINT(alACTpgs_idsCargos;0)
					  //ARRAY LONGINT($alACTpgs_Avisos2Recalc;0)
					  //  //colegiatura
					  //ARRAY LONGINT($alACT_pos;0)
					  //$atACT_tipo{0}:="colegiatura"
					  //AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
					
					  //  //busca y carga cargos
					  //ARRAY LONGINT($alACT_refMat;0)
					  //ARRAY LONGINT($alACT_posMatPagos;0)
					  //$atACT_CargosTipo{0}:="colegiatura"
					  //AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
					  //For ($l_indiceMat;1;Size of array($alACT_posMatPagos))
					  //APPEND TO ARRAY($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
					  //End for 
					  //AT_DistinctsArrayValues (->$alACT_refMat)
					  //USE SET("cargosApdo")
					  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$alACT_refMat)
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
					  //If (Records in selection([ACT_Cargos])>0)
					  //SELECTION TO ARRAY([ACT_Cargos]ID;alACTpgs_idsCargos)
					  //vbACTpgs_ArregloCargos:=True
					
					  //KRL_FindAndLoadRecordByIndex (->[Personas]Auto_UUID;->$atACT_uuidApdoCta{1})
					  //RNApdo:=Record number([Personas])
					  //RNTercero:=-1
					  //RNCta:=-1
					  //ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
					  //ACTpgs_CargaDatosPagoApdo (False;$d_fechaProceso)
					
					  //Case of 
					  //: ($r_medioPagoCol=-4)  //cheque
					
					  //For ($l_indicePagos;1;Size of array($alACT_pos))
					  //  //busca y carga cargos
					  //$b_continuar:=True
					  //If ($l_indicePagos>1)
					  //ARRAY LONGINT($alACT_refMat;0)
					  //ARRAY LONGINT($alACT_posMatPagos;0)
					  //$atACT_CargosTipo{0}:="colegiatura"
					  //AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
					  //For ($l_indiceMat;1;Size of array($alACT_posMatPagos))
					  //APPEND TO ARRAY($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
					  //End for 
					  //USE SET("cargosApdo")
					  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$alACT_refMat)
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
					  //If (Records in selection([ACT_Cargos])>0)
					  //SELECTION TO ARRAY([ACT_Cargos]ID;alACTpgs_idsCargos)
					  //vbACTpgs_ArregloCargos:=True
					
					  //KRL_FindAndLoadRecordByIndex (->[Personas]Auto_UUID;->$atACT_uuidApdoCta{1})
					  //RNApdo:=Record number([Personas])
					  //RNTercero:=-1
					  //RNCta:=-1
					  //ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
					  //ACTpgs_CargaDatosPagoApdo (False;$d_fechaProceso)
					  //End if 
					  //End if 
					
					  //If ($b_continuar)
					  //  //ingresa pagos
					  //$id:=Find in array(atACT_BankName;$atACT_Banco{$alACT_pos{$l_indicePagos}})
					  //If ($id#-1)
					  //vtACT_BancoNombre:=atACT_BankName{$id}
					  //vtACT_BancoCodigo:=atACT_BankID{$id}
					  //Else 
					  //vtACT_BancoNombre:=""
					  //End if 
					  //vtACT_NoSerie:=$atACT_Numero{$alACT_pos{$l_indicePagos}}
					  //vdACT_FechaDocumento:=$adACT_Vencimiento{$alACT_pos{$l_indicePagos}}
					  //vtACT_BancoCuenta:=$atACT_Cuenta{$alACT_pos{$l_indicePagos}}
					
					  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
					  //$vrACT_MontoPago:=vrACT_MontoPago
					  //vtACT_ObservacionesPago:=""
					  //vlACT_FormasdePago:=$r_medioPagoCol
					  //vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					  //vdACT_FechaPago:=$d_fechaProceso
					
					  //  //para que se ingrese el pago
					  //vtACT_TCDocumento:=""
					  //vtACT_TCTipo:=""
					  //vtACT_TCTitular:=""
					
					  //vtACT_RDocumento:=""
					  //vtACT_TDTipo:=""
					  //vtACT_TDTitular:=""
					  //If ($r_medioPagoCol=-6)
					  //  //vtACT_TCDocumento:=String($r_medioPagoCol)
					
					  //C_OBJECT($ob_tc)
					  //OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
					  //OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
					  //OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
					  //OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
					  //  //ABC185803
					  //OB_GET ($ob_td;->vtACT_TCMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TCNumero;"numero_tarjeta")
					  //  //
					  //If (vtACT_TCDocumento="")
					  //vtACT_TCDocumento:=String($r_medioPagoCol)
					  //End if 
					  //End if 
					  //If ($r_medioPagoCol=-7)
					  //  //vtACT_RDocumento:=String($r_medioPagoCol)
					
					  //C_OBJECT($ob_td)
					  //OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
					  //OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
					  //OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
					  //OB_GET ($ob_td;->vtACT_TDTitular;"titular")
					  //  //ABC185803 
					  //OB_GET ($ob_td;->vtACT_TDMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
					  //  //agregados
					  //If (vtACT_RDocumento="")
					  //vtACT_RDocumento:=String($r_medioPagoCol)
					  //End if 
					  //End if 
					
					  //vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String(Current date(*);5)
					
					  //  //ACTabc_ImportProcess
					  //ACTcfg_ItemsMatricula ("InicializaYLee")
					  //vb_selectionMonth2Pay:=False
					  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;False;vdACT_FechaPago;True;$t_usuario;"";$t_detalleVenta;String($r_ordenCompra))
					  //For ($r;1;Size of array(alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //APPEND TO ARRAY($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$r})
					  //End for 
					  //End if 
					
					  //End for 
					
					  //  //recalcula
					  //AT_DistinctsArrayValues (->$alACTpgs_Avisos2Recalc)
					  //For ($r;1;Size of array($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False;True)
					  //End for 
					
					  //  //: ($r_medioPagoCol=-3)  //efectivo
					
					  //  //: (($r_medioPagoCol=-3) | ($r_medioPagoCol=-18))  //webpay
					  //: (Find in array($alACT_idsFDP;$r_medioPagoCol)>0)  //webpay
					  //vtACT_BancoNombre:=""
					  //vtACT_BancoCodigo:=""
					  //vtACT_NoSerie:=""
					  //vdACT_FechaDocumento:=!00-00-00!
					  //vtACT_BancoCuenta:=""
					
					  //vrACT_MontoPago:=0
					  //For ($l_indicePago;1;Size of array($alACT_posMatPagos))
					  //vrACT_MontoPago:=vrACT_MontoPago+Num($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePago}})
					  //End for 
					  //$vrACT_MontoPago:=vrACT_MontoPago
					  //vtACT_ObservacionesPago:=""
					  //vlACT_FormasdePago:=$r_medioPagoCol
					  //vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					  //vdACT_FechaPago:=$d_fechaProceso
					
					  //  //para que se ingrese el pago
					
					  //vtACT_TCDocumento:=""
					  //vtACT_TCTipo:=""
					  //vtACT_TCTitular:=""
					
					  //vtACT_RDocumento:=""
					  //vtACT_TDTipo:=""
					  //vtACT_TDTitular:=""
					  //If ($r_medioPagoCol=-6)
					  //  //vtACT_TCDocumento:=String($r_medioPagoCol)
					
					  //C_OBJECT($ob_tc)
					  //OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
					  //OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
					  //OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
					  //OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
					  //  //ABC185803
					  //OB_GET ($ob_td;->vtACT_TCMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TCBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TCNumero;"numero_tarjeta")
					  //  //
					  //If (vtACT_TCDocumento="")
					  //vtACT_TCDocumento:=String($r_medioPagoCol)
					  //End if 
					  //End if 
					  //If ($r_medioPagoCol=-7)
					  //  //vtACT_RDocumento:=String($r_medioPagoCol)
					
					  //C_OBJECT($ob_td)
					  //OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
					  //OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
					  //OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
					  //OB_GET ($ob_td;->vtACT_TDTitular;"titular")
					  //  //ABC185803 
					  //OB_GET ($ob_td;->vtACT_TDMesVencimiento;"mes_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDAgnoVencimiento;"anio_vencimiento")
					  //OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
					  //OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
					  //  //agregados
					  //If (vtACT_RDocumento="")
					  //vtACT_RDocumento:=String($r_medioPagoCol)
					  //End if 
					  //End if 
					
					  //vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String(Current date(*);5)
					
					  //  //ACTabc_ImportProcess
					  //ACTcfg_ItemsMatricula ("InicializaYLee")
					  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;False;vdACT_FechaPago;True;$t_usuario;"";$t_detalleVenta;String($r_ordenCompra))
					  //COPY ARRAY(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
					  //For ($r;1;Size of array($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False;True)
					  //End for 
					
					  //Else 
					  //  //$r_error:=-22
					  //End case 
					  //End if 
					  //End if 
					
					  //End if 
				End if 
				
				
				  // 13/11/2017 Saúl Ponce O. Ticket 191466, fin del comentario
				
			Else 
				  //Código anterior... Modificado por: Saúl Ponce (23/10/2017) Ticket 170917, Se ejecutaba sólo un caso 
				  //y cuando venía un pago matricula con debito y colegiaturas con credito creaba un solo pago
				If (False:C215)
					  //si es otra forma, se revisa si se paga todo o solo matricula o solo colegiatura
					  //Case of 
					  //: ((Find in array($alACT_idsFDP;$r_medioPagoMat)>0) & (Find in array($alACT_idsFDP;$r_medioPagoCol)>0))
					
					  //If ($r_error=0)
					
					  //ARRAY LONGINT(alACTpgs_idsCargos;0)
					  //ARRAY LONGINT($alACTpgs_Avisos2Recalc;0)
					  //  //colegiatura
					
					  //USE SET("cargosApdo")
					  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$arACT_CargosIDACT)
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
					  //If (Records in selection([ACT_Cargos])>0)
					  //SELECTION TO ARRAY([ACT_Cargos]ID;alACTpgs_idsCargos)
					  //vbACTpgs_ArregloCargos:=True
					
					  //KRL_FindAndLoadRecordByIndex (->[Personas]Auto_UUID;->$atACT_uuidApdoCta{1})
					  //RNApdo:=Record number([Personas])
					  //RNTercero:=-1
					  //RNCta:=-1
					  //ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
					  //ACTpgs_CargaDatosPagoApdo (False;$d_fechaProceso)
					  //  //$alACT_idsItems
					  //vtACT_BancoNombre:=""
					  //vtACT_BancoCodigo:=""
					  //vtACT_NoSerie:=""
					  //vdACT_FechaDocumento:=!00-00-00!
					  //vtACT_BancoCuenta:=""
					
					  //  //si no hay cheque el monto del pago es el de los cargos
					  //  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
					  //vrACT_MontoPago:=0
					  //For ($l_indicePagos;1;Size of array($atACT_CargosMontos))
					  //vrACT_MontoPago:=vrACT_MontoPago+Num($atACT_CargosMontos{$l_indicePagos})
					  //End for 
					  //$vrACT_MontoPago:=vrACT_MontoPago
					
					  //vtACT_ObservacionesPago:=""
					  //vlACT_FormasdePago:=$r_medioPagoMat
					  //vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					  //vdACT_FechaPago:=$d_fechaProceso
					  //  //para que se ingrese el pago
					  //vtACT_TCDocumento:=""
					  //vtACT_TCTipo:=""
					  //vtACT_TCTitular:=""
					
					  //vtACT_RDocumento:=""
					  //vtACT_TDTipo:=""
					  //vtACT_TDTitular:=""
					  //If ($r_medioPagoMat=-6)
					  //  //vtACT_TCDocumento:=String($r_medioPagoMat)
					  //  //ACTpgs_CreacionDocdePago 
					
					  //C_OBJECT($ob_tc)
					  //OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
					  //OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
					  //OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
					  //OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
					  //If (vtACT_TCDocumento="")
					  //vtACT_TCDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					  //If ($r_medioPagoMat=-7)
					  //  //vtACT_RDocumento:=String($r_medioPagoMat)
					  //  //ACTpgs_CreacionDocdePago 
					
					  //C_OBJECT($ob_td)
					  //OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
					  //OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
					  //OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
					  //OB_GET ($ob_td;->vtACT_TDTitular;"titular")
					  //If (vtACT_RDocumento="")
					  //vtACT_RDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					
					  //vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String(Current date(*);5)
					
					  //  //ACTabc_ImportProcess
					  //ACTcfg_ItemsMatricula ("InicializaYLee")
					  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;False;vdACT_FechaPago;True;$t_usuario;"";$t_detalleVenta;String($r_ordenCompra))
					  //COPY ARRAY(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
					  //For ($r;1;Size of array($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False;True)
					  //End for 
					
					  //End if 
					
					  //End if 
					  //: (Find in array($alACT_idsFDP;$r_medioPagoMat)>0)
					  //  //matricula
					  //ARRAY LONGINT($alACT_pos;0)
					  //$atACT_tipo{0}:="matricula"
					  //AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
					
					  //  //busca y carga cargos
					  //ARRAY LONGINT($alACT_refMat;0)
					  //ARRAY LONGINT($alACT_posMatPagos;0)
					  //$atACT_CargosTipo{0}:="matricula"
					  //AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
					  //For ($l_indiceMat;1;Size of array($alACT_posMatPagos))
					  //APPEND TO ARRAY($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
					  //End for 
					  //AT_DistinctsArrayValues (->$alACT_refMat)
					  //USE SET("cargosApdo")
					  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$alACT_refMat)
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
					  //If (Records in selection([ACT_Cargos])>0)
					  //SELECTION TO ARRAY([ACT_Cargos]ID;alACTpgs_idsCargos)
					  //vbACTpgs_ArregloCargos:=True
					
					  //KRL_FindAndLoadRecordByIndex (->[Personas]Auto_UUID;->$atACT_uuidApdoCta{1})
					  //RNApdo:=Record number([Personas])
					  //RNTercero:=-1
					  //RNCta:=-1
					  //ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
					  //ACTpgs_CargaDatosPagoApdo (False;$d_fechaProceso)
					
					  //vtACT_BancoNombre:=""
					  //vtACT_BancoCodigo:=""
					  //vtACT_NoSerie:=""
					  //vdACT_FechaDocumento:=!00-00-00!
					  //vtACT_BancoCuenta:=""
					
					  //vrACT_MontoPago:=0
					  //  //si no hay cheque el monto del pago es el de los cargos
					  //  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
					  //vrACT_MontoPago:=0
					  //For ($l_indicePagos;1;Size of array($alACT_posMatPagos))
					  //vrACT_MontoPago:=vrACT_MontoPago+Num($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePagos}})
					  //End for 
					  //$vrACT_MontoPago:=vrACT_MontoPago
					
					  //vtACT_ObservacionesPago:=""
					  //vlACT_FormasdePago:=$r_medioPagoMat
					  //vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					  //vdACT_FechaPago:=$d_fechaProceso
					
					  //  //para que se ingrese el pago
					  //vtACT_TCDocumento:=""
					  //vtACT_TCTipo:=""
					  //vtACT_TCTitular:=""
					
					  //vtACT_RDocumento:=""
					  //vtACT_TDTipo:=""
					  //vtACT_TDTitular:=""
					  //If ($r_medioPagoMat=-6)
					  //  //vtACT_TCDocumento:=String($r_medioPagoMat)
					  //  //ACTpgs_CreacionDocdePago 
					
					  //C_OBJECT($ob_tc)
					  //OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
					  //OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
					  //OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
					  //OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
					  //If (vtACT_TCDocumento="")
					  //vtACT_TCDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					  //If ($r_medioPagoMat=-7)
					  //  //vtACT_RDocumento:=String($r_medioPagoMat)
					  //  //ACTpgs_CreacionDocdePago 
					
					  //C_OBJECT($ob_td)
					  //OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
					  //OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
					  //OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
					  //OB_GET ($ob_td;->vtACT_TDTitular;"titular")
					  //If (vtACT_RDocumento="")
					  //vtACT_RDocumento:=String($r_medioPagoMat)
					  //End if 
					  //End if 
					
					  //vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String(Current date(*);5)
					
					  //  //ACTabc_ImportProcess
					  //ACTcfg_ItemsMatricula ("InicializaYLee")
					  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;False;vdACT_FechaPago;True;$t_usuario;"";$t_detalleVenta;String($r_ordenCompra))
					  //COPY ARRAY(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
					  //For ($r;1;Size of array($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False;True)
					  //End for 
					
					  //End if 
					
					  //: (Find in array($alACT_idsFDP;$r_medioPagoCol)>0)
					
					  //ARRAY LONGINT(alACTpgs_idsCargos;0)
					  //ARRAY LONGINT($alACTpgs_Avisos2Recalc;0)
					  //  //colegiatura
					  //ARRAY LONGINT($alACT_pos;0)
					  //$atACT_tipo{0}:="colegiatura"
					  //AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
					
					  //  //busca y carga cargos
					  //ARRAY LONGINT($alACT_refMat;0)
					  //ARRAY LONGINT($alACT_posMatPagos;0)
					  //$atACT_CargosTipo{0}:="colegiatura"
					  //AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
					  //For ($l_indiceMat;1;Size of array($alACT_posMatPagos))
					  //APPEND TO ARRAY($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
					  //End for 
					  //AT_DistinctsArrayValues (->$alACT_refMat)
					  //USE SET("cargosApdo")
					  //QUERY SELECTION WITH ARRAY([ACT_Cargos]Ref_Item;$alACT_refMat)
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Saldo#0)
					  //If (Records in selection([ACT_Cargos])>0)
					  //SELECTION TO ARRAY([ACT_Cargos]ID;alACTpgs_idsCargos)
					  //vbACTpgs_ArregloCargos:=True
					
					  //KRL_FindAndLoadRecordByIndex (->[Personas]Auto_UUID;->$atACT_uuidApdoCta{1})
					  //RNApdo:=Record number([Personas])
					  //RNTercero:=-1
					  //RNCta:=-1
					  //ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
					  //ACTpgs_CargaDatosPagoApdo (False;$d_fechaProceso)
					
					  //vtACT_BancoNombre:=""
					  //vtACT_BancoCodigo:=""
					  //vtACT_NoSerie:=""
					  //vdACT_FechaDocumento:=!00-00-00!
					  //vtACT_BancoCuenta:=""
					
					  //  //si no hay cheque el monto del pago es el de los cargos
					  //  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
					  //vrACT_MontoPago:=0
					  //For ($l_indicePagos;1;Size of array($alACT_posMatPagos))
					  //vrACT_MontoPago:=vrACT_MontoPago+Num($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePagos}})
					  //End for 
					  //$vrACT_MontoPago:=vrACT_MontoPago
					
					  //vtACT_ObservacionesPago:=""
					  //vlACT_FormasdePago:=$r_medioPagoCol
					  //vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					  //vdACT_FechaPago:=$d_fechaProceso
					
					  //  //para que se ingrese el pago
					  //vtACT_TCDocumento:=""
					  //vtACT_TCTipo:=""
					  //vtACT_TCTitular:=""
					
					  //vtACT_RDocumento:=""
					  //vtACT_TDTipo:=""
					  //vtACT_TDTitular:=""
					  //If ($r_medioPagoCol=-6)
					  //  //vtACT_TCDocumento:=String($r_medioPagoCol)
					  //C_OBJECT($ob_tc)
					  //OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
					  //OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
					  //OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
					  //OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
					  //If (vtACT_TCDocumento="")
					  //vtACT_TCDocumento:=String($r_medioPagoCol)
					  //End if 
					  //End if 
					  //If ($r_medioPagoCol=-7)
					  //  //vtACT_RDocumento:=String($r_medioPagoCol)
					  //C_OBJECT($ob_td)
					  //OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
					  //OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
					  //OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
					  //OB_GET ($ob_td;->vtACT_TDTitular;"titular")
					  //If (vtACT_RDocumento="")
					  //vtACT_RDocumento:=String($r_medioPagoCol)
					  //End if 
					  //End if 
					
					  //vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String(Current date(*);5)
					
					  //  //ACTabc_ImportProcess
					  //ACTcfg_ItemsMatricula ("InicializaYLee")
					  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;False;vdACT_FechaPago;True;$t_usuario;"";$t_detalleVenta;String($r_ordenCompra))
					  //COPY ARRAY(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
					  //For ($r;1;Size of array($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
					  //ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False;True)
					  //End for 
					
					  //End if 
					
					  //End case 
					
				End if 
				
				  //Modificado por: Saúl Ponce (23/10/2017) Ticket 170917, Se determina por la posición en el array si es sólo una forma de pago
				  //si son diferentes FDP se ingresan por separado
				  //If (Find in array($alACT_idsFDP;$r_medioPagoMat)=Find in array($alACT_idsFDP;$r_medioPagoCol))
				If ((Find in array:C230($alACT_idsFDP;$r_medioPagoMat)=Find in array:C230($alACT_idsFDP;$r_medioPagoCol)) & (Find in array:C230($alACT_idsFDP;$r_medioPagoMat)>0))  //20171130 RCH Para asegurar que alguno de los modos sea de pago
					
					If ($r_error=0)
						
						ARRAY LONGINT:C221(alACTpgs_idsCargos;0)
						ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
						  //colegiatura
						
						USE SET:C118("cargosApdo")
						QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$arACT_CargosIDACT)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
							ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
							vbACTpgs_ArregloCargos:=True:C214
							
							KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
							RNApdo:=Record number:C243([Personas:7])
							RNTercero:=-1
							RNCta:=-1
							ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
							ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
							  //$alACT_idsItems
							vtACT_BancoNombre:=""
							vtACT_BancoCodigo:=""
							vtACT_NoSerie:=""
							vdACT_FechaDocumento:=!00-00-00!
							vtACT_BancoCuenta:=""
							
							  //si no hay cheque el monto del pago es el de los cargos
							  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
							vrACT_MontoPago:=0
							For ($l_indicePagos;1;Size of array:C274($atACT_CargosMontos))
								vrACT_MontoPago:=vrACT_MontoPago+Num:C11($atACT_CargosMontos{$l_indicePagos})
							End for 
							$vrACT_MontoPago:=vrACT_MontoPago
							
							vtACT_ObservacionesPago:=""
							vlACT_FormasdePago:=$r_medioPagoMat
							vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
							vdACT_FechaPago:=$d_fechaProceso
							  //para que se ingrese el pago
							  //para que se ingrese el pago
							vtACT_TCDocumento:=""
							vtACT_TCTipo:=""
							vtACT_TCTitular:=""
							vtACT_TCNumero:=""
							vtACT_TCBancoCodigo:=""
							vtACT_TCMesVencimiento:=""
							vtACT_TCAgnoVencimiento:=""
							
							vtACT_RDocumento:=""
							vtACT_TDTipo:=""
							vtACT_TDTitular:=""
							vtACT_TDNumero:=""
							vtACT_TDBancoCodigo:=""
							vtACT_TDMesVencimiento:=""
							vtACT_TDAgnoVencimiento:=""
							If ($r_medioPagoMat=-6)
								  //vtACT_TCDocumento:=String($r_medioPagoMat)
								  //ACTpgs_CreacionDocdePago 
								
								C_OBJECT:C1216($ob_tc)
								$ob_tc:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
								OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
								OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
								OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
								OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
								  //ABC185803
								  //OB_GET ($ob_td;->vtACT_TCMesVencimiento;"mes_vencimiento")
								  //OB_GET ($ob_td;->vtACT_TCAgnoVencimiento;"anio_vencimiento")
								  //OB_GET ($ob_td;->vtACT_TCBancoCodigo;"banco_emisor")
								  //OB_GET ($ob_td;->vtACT_TCNumero;"numero_tarjeta")
								
								  // Modificado por: Saúl Ponce (14/11/2017), al parecer en el cambio anterior quedó mal y se mezclaron los objetos TC y TD
								C_LONGINT:C283($l_mes;$l_year)
								OB_GET ($ob_tc;->$l_mes;"mes_vencimiento")
								OB_GET ($ob_tc;->$l_year;"anio_vencimiento")
								OB_GET ($ob_tc;->vtACT_TCBancoCodigo;"banco_emisor")
								OB_GET ($ob_tc;->vtACT_TCNumero;"numero_tarjeta")
								vtACT_TCMesVencimiento:=String:C10($l_mes)
								vtACT_TCAgnoVencimiento:=String:C10($l_year)
								
								If (vtACT_TCDocumento="")
									vtACT_TCDocumento:=String:C10($r_medioPagoMat)
								End if 
								
								If (vtACT_TCBancoCodigo#"")
									$l_pos:=Find in array:C230(atACT_BankID;vtACT_TCBancoCodigo)
									If ($l_pos>0)
										vtACT_TCBancoEmisor:=atACT_BankName{$l_pos}
									End if 
								End if 
								
							End if 
							
							If ($r_medioPagoMat=-7)
								  //vtACT_RDocumento:=String($r_medioPagoMat)
								  //ACTpgs_CreacionDocdePago 
								
								C_OBJECT:C1216($ob_td)
								$ob_td:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
								OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
								OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
								OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
								OB_GET ($ob_td;->vtACT_TDTitular;"titular")
								  //ABC185803 
								C_LONGINT:C283($l_mes;$l_year)
								OB_GET ($ob_td;->$l_mes;"mes_vencimiento")
								OB_GET ($ob_td;->$l_year;"anio_vencimiento")
								OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
								OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
								vtACT_TDMesVencimiento:=String:C10($l_mes)
								vtACT_TDAgnoVencimiento:=String:C10($l_year)
								
								  //agregados
								If (vtACT_RDocumento="")
									vtACT_RDocumento:=String:C10($r_medioPagoMat)
								End if 
								
								If (vtACT_TDBancoCodigo#"")
									$l_pos:=Find in array:C230(atACT_BankID;vtACT_TDBancoCodigo)
									If ($l_pos>0)
										vtACT_TDBancoEmisor:=atACT_BankName{$l_pos}
									End if 
								End if 
								
							End if 
							
							vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
							
							  //ACTabc_ImportProcess
							ACTcfg_ItemsMatricula ("InicializaYLee")
							$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
							COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
							For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
								ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
							End for 
							
						End if 
						
					End if 
					
				Else 
					
					If (Find in array:C230($alACT_idsFDP;$r_medioPagoMat)>0)
						  //matricula
						ARRAY LONGINT:C221($alACT_pos;0)
						$atACT_tipo{0}:="matricula"
						AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
						
						  //busca y carga cargos
						ARRAY LONGINT:C221($alACT_refMat;0)
						ARRAY LONGINT:C221($alACT_posMatPagos;0)
						$atACT_CargosTipo{0}:="matricula"
						AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
						For ($l_indiceMat;1;Size of array:C274($alACT_posMatPagos))
							APPEND TO ARRAY:C911($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
						End for 
						AT_DistinctsArrayValues (->$alACT_refMat)
						USE SET:C118("cargosApdo")
						QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_refMat)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
							ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
							vbACTpgs_ArregloCargos:=True:C214
							
							KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
							RNApdo:=Record number:C243([Personas:7])
							RNTercero:=-1
							RNCta:=-1
							ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
							ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
							
							vtACT_BancoNombre:=""
							vtACT_BancoCodigo:=""
							vtACT_NoSerie:=""
							vdACT_FechaDocumento:=!00-00-00!
							vtACT_BancoCuenta:=""
							
							vrACT_MontoPago:=0
							  //si no hay cheque el monto del pago es el de los cargos
							  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
							vrACT_MontoPago:=0
							For ($l_indicePagos;1;Size of array:C274($alACT_posMatPagos))
								vrACT_MontoPago:=vrACT_MontoPago+Num:C11($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePagos}})
							End for 
							$vrACT_MontoPago:=vrACT_MontoPago
							
							vtACT_ObservacionesPago:=""
							vlACT_FormasdePago:=$r_medioPagoMat
							vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
							vdACT_FechaPago:=$d_fechaProceso
							
							  //para que se ingrese el pago
							  //para que se ingrese el pago
							vtACT_TCDocumento:=""
							vtACT_TCTipo:=""
							vtACT_TCTitular:=""
							vtACT_TCNumero:=""
							vtACT_TCBancoCodigo:=""
							vtACT_TCMesVencimiento:=""
							vtACT_TCAgnoVencimiento:=""
							
							vtACT_RDocumento:=""
							vtACT_TDTipo:=""
							vtACT_TDTitular:=""
							vtACT_TDNumero:=""
							vtACT_TDBancoCodigo:=""
							vtACT_TDMesVencimiento:=""
							vtACT_TDAgnoVencimiento:=""
							If ($r_medioPagoMat=-6)
								  //vtACT_TCDocumento:=String($r_medioPagoMat)
								  //ACTpgs_CreacionDocdePago 
								
								C_OBJECT:C1216($ob_tc)
								$ob_tc:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
								OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
								OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
								OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
								OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
								  //ABC185803
								  //OB_GET ($ob_td;->vtACT_TCMesVencimiento;"mes_vencimiento")
								  //OB_GET ($ob_td;->vtACT_TCAgnoVencimiento;"anio_vencimiento")
								  //OB_GET ($ob_td;->vtACT_TCBancoCodigo;"banco_emisor")
								  //OB_GET ($ob_td;->vtACT_TCNumero;"numero_tarjeta")
								
								  // Modificado por: Saúl Ponce (14/11/2017), al parecer en el cambio anterior quedó mal y se mezclaron los objetos TC y TD
								C_LONGINT:C283($l_mes;$l_year)
								OB_GET ($ob_tc;->$l_mes;"mes_vencimiento")
								OB_GET ($ob_tc;->$l_year;"anio_vencimiento")
								OB_GET ($ob_tc;->vtACT_TCBancoCodigo;"banco_emisor")
								OB_GET ($ob_tc;->vtACT_TCNumero;"numero_tarjeta")
								vtACT_TCMesVencimiento:=String:C10($l_mes)
								vtACT_TCAgnoVencimiento:=String:C10($l_year)
								
								If (vtACT_TCDocumento="")
									vtACT_TCDocumento:=String:C10($r_medioPagoMat)
								End if 
								
								If (vtACT_TCBancoCodigo#"")
									$l_pos:=Find in array:C230(atACT_BankID;vtACT_TCBancoCodigo)
									If ($l_pos>0)
										vtACT_TCBancoEmisor:=atACT_BankName{$l_pos}
									End if 
								End if 
								
							End if 
							If ($r_medioPagoMat=-7)
								  //vtACT_RDocumento:=String($r_medioPagoMat)
								  //ACTpgs_CreacionDocdePago 
								
								C_OBJECT:C1216($ob_td)
								$ob_td:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
								OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
								OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
								OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
								OB_GET ($ob_td;->vtACT_TDTitular;"titular")
								  //ABC
								C_LONGINT:C283($l_mes;$l_year)
								OB_GET ($ob_td;->$l_mes;"mes_vencimiento")
								OB_GET ($ob_td;->$l_year;"anio_vencimiento")
								OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
								OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
								vtACT_TDMesVencimiento:=String:C10($l_mes)
								vtACT_TDAgnoVencimiento:=String:C10($l_year)
								  //agregados
								If (vtACT_RDocumento="")
									vtACT_RDocumento:=String:C10($r_medioPagoMat)
								End if 
								
								If (vtACT_TDBancoCodigo#"")
									$l_pos:=Find in array:C230(atACT_BankID;vtACT_TDBancoCodigo)
									If ($l_pos>0)
										vtACT_TDBancoEmisor:=atACT_BankName{$l_pos}
									End if 
								End if 
								
							End if 
							
							vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
							
							  //ACTabc_ImportProcess
							ACTcfg_ItemsMatricula ("InicializaYLee")
							$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
							COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
							For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
								ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
							End for 
							
						End if 
					End if 
					
					If (Find in array:C230($alACT_idsFDP;$r_medioPagoCol)>0)
						ARRAY LONGINT:C221(alACTpgs_idsCargos;0)
						ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
						  //colegiatura
						ARRAY LONGINT:C221($alACT_pos;0)
						$atACT_tipo{0}:="colegiatura"
						AT_SearchArray (->$atACT_tipo;"=";->$alACT_pos)
						
						  //busca y carga cargos
						ARRAY LONGINT:C221($alACT_refMat;0)
						ARRAY LONGINT:C221($alACT_posMatPagos;0)
						$atACT_CargosTipo{0}:="colegiatura"
						AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posMatPagos)
						For ($l_indiceMat;1;Size of array:C274($alACT_posMatPagos))
							APPEND TO ARRAY:C911($alACT_refMat;$arACT_CargosIDACT{$alACT_posMatPagos{$l_indiceMat}})
						End for 
						AT_DistinctsArrayValues (->$alACT_refMat)
						USE SET:C118("cargosApdo")
						QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_refMat)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							  // Modificado por: Saúl Ponce (22/01/2018) Ticket Nº 194553, cuando el JSON involucraba más de un alumno, los cargos se pagaban de forma aleatoria.
							ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
							vbACTpgs_ArregloCargos:=True:C214
							
							KRL_FindAndLoadRecordByIndex (->[Personas:7]Auto_UUID:36;->$atACT_uuidApdoCta{1})
							RNApdo:=Record number:C243([Personas:7])
							RNTercero:=-1
							RNCta:=-1
							ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
							ACTpgs_CargaDatosPagoApdo (False:C215;$d_fechaProceso)
							
							vtACT_BancoNombre:=""
							vtACT_BancoCodigo:=""
							vtACT_NoSerie:=""
							vdACT_FechaDocumento:=!00-00-00!
							vtACT_BancoCuenta:=""
							
							  //si no hay cheque el monto del pago es el de los cargos
							  //vrACT_MontoPago:=Num($atACT_Monto{$alACT_pos{$l_indicePagos}})
							vrACT_MontoPago:=0
							For ($l_indicePagos;1;Size of array:C274($alACT_posMatPagos))
								vrACT_MontoPago:=vrACT_MontoPago+Num:C11($atACT_CargosMontos{$alACT_posMatPagos{$l_indicePagos}})
							End for 
							$vrACT_MontoPago:=vrACT_MontoPago
							
							vtACT_ObservacionesPago:=""
							vlACT_FormasdePago:=$r_medioPagoCol
							vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
							vdACT_FechaPago:=$d_fechaProceso
							
							  //para que se ingrese el pago
							  //para que se ingrese el pago
							vtACT_TCDocumento:=""
							vtACT_TCTipo:=""
							vtACT_TCTitular:=""
							vtACT_TCNumero:=""
							vtACT_TCBancoCodigo:=""
							vtACT_TCMesVencimiento:=""
							vtACT_TCAgnoVencimiento:=""
							
							vtACT_RDocumento:=""
							vtACT_TDTipo:=""
							vtACT_TDTitular:=""
							vtACT_TDNumero:=""
							vtACT_TDBancoCodigo:=""
							vtACT_TDMesVencimiento:=""
							vtACT_TDAgnoVencimiento:=""
							If ($r_medioPagoCol=-6)
								  //vtACT_TCDocumento:=String($r_medioPagoCol)
								C_OBJECT:C1216($ob_tc)
								$ob_tc:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
								OB_GET ($ob_raiz;->$ob_tc;"tarjeta_credito")
								OB_GET ($ob_tc;->vtACT_TCDocumento;"numero_operacion")
								OB_GET ($ob_tc;->vtACT_TCTipo;"tipo_tarjeta")
								OB_GET ($ob_tc;->vtACT_TCTitular;"titular")
								  //ABC185803
								  //OB_GET ($ob_td;->vtACT_TCMesVencimiento;"mes_vencimiento")
								  //OB_GET ($ob_td;->vtACT_TCAgnoVencimiento;"anio_vencimiento")
								  //OB_GET ($ob_td;->vtACT_TCBancoCodigo;"banco_emisor")
								  //OB_GET ($ob_td;->vtACT_TCNumero;"numero_tarjeta")
								
								  // Modificado por: Saúl Ponce (14/11/2017), al parecer en el cambio anterior quedó mal y se mezclaron los objetos TC y TD
								C_LONGINT:C283($l_mes;$l_year)
								OB_GET ($ob_tc;->$l_mes;"mes_vencimiento")
								OB_GET ($ob_tc;->$l_year;"anio_vencimiento")
								OB_GET ($ob_tc;->vtACT_TCBancoCodigo;"banco_emisor")
								OB_GET ($ob_tc;->vtACT_TCNumero;"numero_tarjeta")
								vtACT_TCMesVencimiento:=String:C10($l_mes)
								vtACT_TCAgnoVencimiento:=String:C10($l_year)
								
								If (vtACT_TCDocumento="")
									vtACT_TCDocumento:=String:C10($r_medioPagoCol)
								End if 
								
								If (vtACT_TCBancoCodigo#"")
									$l_pos:=Find in array:C230(atACT_BankID;vtACT_TCBancoCodigo)
									If ($l_pos>0)
										vtACT_TCBancoEmisor:=atACT_BankName{$l_pos}
									End if 
								End if 
								
							End if 
							If ($r_medioPagoCol=-7)
								  //vtACT_RDocumento:=String($r_medioPagoCol)
								C_OBJECT:C1216($ob_td)
								$ob_td:=OB_Create   // Modificado por: Saúl Ponce (14/11/2017), inicializo en objeto para evitar errores en compilado
								OB_GET ($ob_raiz;->$ob_td;"tarjeta_debito")
								OB_GET ($ob_td;->vtACT_RDocumento;"numero_operacion")
								OB_GET ($ob_td;->vtACT_TDTipo;"tipo_tarjeta")
								OB_GET ($ob_td;->vtACT_TDTitular;"titular")
								  //ABC
								C_LONGINT:C283($l_mes;$l_year)
								OB_GET ($ob_td;->$l_mes;"mes_vencimiento")
								OB_GET ($ob_td;->$l_year;"anio_vencimiento")
								OB_GET ($ob_td;->vtACT_TDBancoCodigo;"banco_emisor")
								OB_GET ($ob_td;->vtACT_TDNumero;"numero_tarjeta")
								vtACT_TDMesVencimiento:=String:C10($l_mes)
								vtACT_TDAgnoVencimiento:=String:C10($l_year)
								
								  //agregados
								If (vtACT_RDocumento="")
									vtACT_RDocumento:=String:C10($r_medioPagoCol)
								End if 
								
								If (vtACT_TDBancoCodigo#"")
									$l_pos:=Find in array:C230(atACT_BankID;vtACT_TDBancoCodigo)
									If ($l_pos>0)
										vtACT_TDBancoEmisor:=atACT_BankName{$l_pos}
									End if 
								End if 
								
							End if 
							
							vtACT_ObservacionesPago:=__ ("Pago ingresado desde Reinscripciones, el día ")+String:C10(Current date:C33(*);5)
							
							  //ACTabc_ImportProcess
							ACTcfg_ItemsMatricula ("InicializaYLee")
							$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214;$t_usuario;"";$t_detalleVenta;String:C10($r_ordenCompra))
							COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
							For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
								ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
							End for 
							
						End if 
					End if 
					
				End if 
				
			End if 
			
			
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Término inicio ingreso de pagos..."+"\r"
		
		  //verifica montos emitidos
		If ($r_error=0)
			USE SET:C118("setACPost")
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			$r_montoCargosAC:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fechaProceso)
			
			$r_montoCargos:=0
			For ($x;1;Size of array:C274($atACT_CargosMontos))
				$r_montoCargos:=$r_montoCargos+Num:C11($atACT_CargosMontos{$x})
			End for 
			
			If ($r_montoCargosAC#$r_montoCargos)
				<>tRINSC_debug:=<>tRINSC_debug+"Monto en Avisos: "+String:C10($r_montoCargosAC)+". Monto en JSON: "+String:C10($r_montoCargos)+"."+"\r"
				$r_error:=-36
				
				CREATE SET:C116([ACT_Cargos:173];"setCargos")
				ARRAY LONGINT:C221($alACT_idsCtasLog;0)
				ARRAY LONGINT:C221($alACT_idsItems;0)
				DISTINCT VALUES:C339([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtasLog)
				For ($l_indiceCta;1;Size of array:C274($alACT_idsCtasLog))
					USE SET:C118("setCargos")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$alACT_idsCtasLog{$l_indiceCta})
					DISTINCT VALUES:C339([ACT_Cargos:173]Ref_Item:16;$alACT_idsItems)
					CREATE SET:C116([ACT_Cargos:173];"setCargos2")
					For ($l_indiceItem;1;Size of array:C274($alACT_idsItems))
						USE SET:C118("setCargos2")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$alACT_idsItems{$l_indiceItem})
						KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
						KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
						<>tRINSC_debug:=<>tRINSC_debug+"Alumno: "+[Alumnos:2]apellidos_y_nombres:40+", uuid: "+[Alumnos:2]auto_uuid:72+", ref item: "+String:C10([ACT_Cargos:173]Ref_Item:16)+", Cargo: "+[ACT_Cargos:173]Glosa:12+", monto: "+String:C10(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fechaProceso))+"..."+"\r"
						
						$l_existe:=Find in array:C230($arACT_CargosIDACT;[ACT_Cargos:173]Ref_Item:16)
						If ($l_existe>0)
							$r_montoCargoJS:=Num:C11($atACT_CargosMontos{$l_existe})
						Else 
							$r_montoCargoJS:=0
						End if 
						$r_montoEnCargos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fechaProceso)
						
						If ($r_montoEnCargos#$r_montoCargoJS)
							$t_descripcionError:=$t_descripcionError+"Alumno: "+[Alumnos:2]apellidos_y_nombres:40+", uuid: "+[Alumnos:2]auto_uuid:72+", ref item: "+String:C10([ACT_Cargos:173]Ref_Item:16)+", Cargo: "+[ACT_Cargos:173]Glosa:12+", monto: "+String:C10($r_montoEnCargos)+", Monto Json: "+String:C10($r_montoCargoJS)+"..."+"\r"
						End if 
						
					End for 
					SET_ClearSets ("setCargos2")
				End for 
				SET_ClearSets ("setCargos")
				
			End if 
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Montos verificados..."+"\r"
		
		  //verifica
		If ($r_error=0)
			
			  //20180122 RCH Se cambia validación ya que no se hacía cuando se pagaba solo la matrícula y no la colegiatura
			  //reviso saldos de avisos de cobranza creados
			  //If (((Find in array($alACT_idsFDP;$r_medioPagoMat)>0) | ($r_medioPagoMat=-4)) & ((Find in array($alACT_idsFDP;$r_medioPagoCol)>0) | ($r_medioPagoCol=-4)))  //20151014 RCH Si es efectivo, cheque o WP se considera pagado
			  //USE SET("setACPost")
			  //KRL_RelateSelection (->[ACT_Documentos_de_Cargo]No_ComprobanteInterno;->[ACT_Avisos_de_Cobranza]ID_Aviso;"")
			  //KRL_RelateSelection (->[ACT_Cargos]ID_Documento_de_Cargo;->[ACT_Documentos_de_Cargo]ID_Documento;"")
			  //If (Sum([ACT_Cargos]Saldo)#0)
			  //<>tRINSC_debug:=<>tRINSC_debug+"Quedaron cargos con saldo. Saldo: "+String(Sum([ACT_Cargos]Saldo))+"."+"\r"
			  //$r_error:=-25  //cargos con saldo
			
			  //$t_descripcionError:="Quedaron cargos con saldo. Saldo: "+String(Sum([ACT_Cargos]Saldo))+"."
			  //End if 
			  //End if 
			
			If ((Find in array:C230($alACT_idsFDP;$r_medioPagoMat)>0) | ($r_medioPagoMat=-4))
				ARRAY LONGINT:C221($alACT_ref;0)
				ARRAY LONGINT:C221($alACT_posPagos;0)
				$atACT_CargosTipo{0}:="matricula"
				AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posPagos)
				For ($l_indiceMat;1;Size of array:C274($alACT_posPagos))
					APPEND TO ARRAY:C911($alACT_ref;$arACT_CargosIDACT{$alACT_posPagos{$l_indiceMat}})
				End for 
				
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				USE SET:C118("setACPost")
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_ref)  //filtra pagos matricula
				If (Sum:C1([ACT_Cargos:173]Saldo:23)#0)
					<>tRINSC_debug:=<>tRINSC_debug+"Quedaron cargos de matrícula con saldo. Saldo: "+String:C10(Sum:C1([ACT_Cargos:173]Saldo:23))+"."+"\r"
					$r_error:=-25  //cargos con saldo
					$t_descripcionError:="Quedaron cargos de matrícula con saldo. Saldo: "+String:C10(Sum:C1([ACT_Cargos:173]Saldo:23))+"."
					
				Else 
					  //20180228 RCH Soporte para ticket 193173
					READ ONLY:C145([ACT_Transacciones:178])
					READ ONLY:C145([ACT_Pagos:172])
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
					KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
					SET FIELD RELATION:C919([ACT_Pagos:172]ID_DocumentodePago:6;Automatic:K51:4;Do not modify:K51:1)
					SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;$alACT_idsPagosMatricula;[ACT_Pagos:172]ID_WebpayOC:32;$alACT_idsOCMatricula;[ACT_Documentos_de_Pago:176]NoSerie:12;$atACT_idsSerieMatricula)
					SET FIELD RELATION:C919([ACT_Pagos:172]ID_DocumentodePago:6;Structure configuration:K51:2;Structure configuration:K51:2)
					
				End if 
				
			End if 
			
			If ($r_error=0)
				If ((Find in array:C230($alACT_idsFDP;$r_medioPagoCol)>0) | ($r_medioPagoCol=-4))  //20151014 RCH Si es efectivo, cheque o WP se considera pagado
					ARRAY LONGINT:C221($alACT_ref;0)
					ARRAY LONGINT:C221($alACT_posPagos;0)
					$atACT_CargosTipo{0}:="colegiatura"
					AT_SearchArray (->$atACT_CargosTipo;"=";->$alACT_posPagos)
					For ($l_indiceMat;1;Size of array:C274($alACT_posPagos))
						APPEND TO ARRAY:C911($alACT_ref;$arACT_CargosIDACT{$alACT_posPagos{$l_indiceMat}})
					End for 
					
					READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
					USE SET:C118("setACPost")
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_ref)  //filtra pagos colegiatura
					If (Sum:C1([ACT_Cargos:173]Saldo:23)#0)
						<>tRINSC_debug:=<>tRINSC_debug+"Quedaron cargos de colegiatura con saldo. Saldo: "+String:C10(Sum:C1([ACT_Cargos:173]Saldo:23))+"."+"\r"
						$r_error:=-25  //cargos con saldo
						$t_descripcionError:="Quedaron cargos de colegiatura con saldo. Saldo: "+String:C10(Sum:C1([ACT_Cargos:173]Saldo:23))+"."
					Else 
						  //20180228 RCH Soporte para ticket 193173
						READ ONLY:C145([ACT_Transacciones:178])
						READ ONLY:C145([ACT_Pagos:172])
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
						KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
						SET FIELD RELATION:C919([ACT_Pagos:172]ID_DocumentodePago:6;Automatic:K51:4;Do not modify:K51:1)
						SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;$alACT_idsPagosColegiatura;[ACT_Pagos:172]ID_WebpayOC:32;$alACT_idsOCColegiatura;[ACT_Documentos_de_Pago:176]NoSerie:12;$atACT_idsSerieColegiatura)
						SET FIELD RELATION:C919([ACT_Pagos:172]ID_DocumentodePago:6;Structure configuration:K51:2;Structure configuration:K51:2)
						
					End if 
				End if 
			End if 
			
			
		End if 
		<>tRINSC_debug:=<>tRINSC_debug+"Saldos verificados..."+"\r"
		
		  //devuelve- OJO QUE HASTA AQUÍ ESTÁBAMOS EN TRANSACCIÓN
		If ($r_error=0)
			<>tRINSC_debug:=<>tRINSC_debug+"Transacción validada..."+"\r"
			ok:=1
			TRACE:C157
			VALIDATE TRANSACTION:C240
			If (ok=1)
				
				  // Modificado por: Alexis Bustamante (10-06-2017)
				  //Ticket 179869
				
				C_OBJECT:C1216($ob_error)
				C_LONGINT:C283($vl_error)
				C_TEXT:C284($vt_ok)
				
				$vl_error:=0
				$vt_ok:="ok"
				
				
				$ob_error:=OB_Create 
				OB_SET ($ob_error;->$vl_error;"error")
				OB_SET ($ob_error;->$vt_ok;"mensaje")
				
				  //20180228 RCH Soporte para ticket 193173
				C_OBJECT:C1216($ob_datos;$ob_datosMat;$ob_datosCol)
				OB SET ARRAY:C1227($ob_datosMat;"idspagos";$alACT_idsPagosMatricula)
				OB SET ARRAY:C1227($ob_datosMat;"ocpagos";$alACT_idsOCMatricula)
				OB SET ARRAY:C1227($ob_datosMat;"serie";$atACT_idsSerieMatricula)
				OB SET ARRAY:C1227($ob_datosCol;"idspagos";$alACT_idsPagosColegiatura)
				OB SET ARRAY:C1227($ob_datosCol;"ocpagos";$alACT_idsOCColegiatura)
				OB SET ARRAY:C1227($ob_datosCol;"serie";$atACT_idsSerieColegiatura)
				OB SET:C1220($ob_datos;"datosmatricula";$ob_datosMat)
				OB SET:C1220($ob_datos;"datoscolegiatura";$ob_datosCol)
				OB SET:C1220($ob_error;"datosdepago";$ob_datos)
				
				$json:=OB_Object2Json ($ob_error)
				  //$t_principal:=JSON New 
				  //$node:=JSON Append real ($t_principal;"error";0)
				  //$node:=JSON Append text ($t_principal;"mensaje";"ok")
				  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
				  //JSON CLOSE ($t_principal)
			Else 
				$r_error:=-37
				
				$t_descripcionError:="No fue posible validar la transacción. Intente nuevamente."
				
				If (In transaction:C397)  //no se si la transaccion queda abierta. Me imagino que no... pero por si acaso.
					CANCEL TRANSACTION:C241
				End if 
			End if 
		Else 
			CANCEL TRANSACTION:C241
		End if 
	End if 
	<>tRINSC_debug:=<>tRINSC_debug+"Transacción finalizada..."+"\r"
	
Else 
	$r_error:=-19
End if 

  //retorno año 0 a items
For ($l_indice;1;Size of array:C274($alACT_idsItemsYear0))
	READ WRITE:C146([xxACT_Items:179])
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=$alACT_idsItemsYear0{$l_indice})
	[xxACT_Items:179]Meses_de_cargo:9:=0
	SAVE RECORD:C53([xxACT_Items:179])
	KRL_UnloadReadOnly (->[xxACT_Items:179])
End for 

If ($r_error#0)
	$json:=RINSCwa_RespuestaError ($r_error;False:C215;$t_descripcionError)
End if 

SET_ClearSets ("setACOrg";"setACPost")
SET_ClearSets ("CargosApdo")

CLEAR SEMAPHORE:C144("ACT_IngresoReinscripcionesAvisos")

<>tRINSC_debug:=<>tRINSC_debug+"JSON respuesta: "+$json+"."+"\r"

If (<>bRINSC_depurarRINSC)
	SET TEXT TO PASTEBOARD:C523(<>tRINSC_debug)
End if 

$0:=$json