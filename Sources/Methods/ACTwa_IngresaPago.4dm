//%attributes = {}
  //ACTwa_IngresaPago 

C_TEXT:C284($t_idsAC;$t_llave)
C_DATE:C307($d_fecha)
C_TEXT:C284($t_string2hash;$t_string2hash2;$res)
C_LONGINT:C283($l_idApdo)
C_LONGINT:C283($l_idTercero)
C_BOOLEAN:C305($b_ejecucionOk;$b_mesAbierto)
ARRAY LONGINT:C221($al_idsAC;0)
ARRAY LONGINT:C221($al_idsApdo;0)
ARRAY LONGINT:C221($al_idsTerceros;0)
C_REAL:C285($r_montoPago)
C_BOOLEAN:C305($b_verificarLLave)
C_TEXT:C284($t_separadorAvisos)
C_TEXT:C284($t_jsonConDatos;$t_referencia;$t_ordenCompra;$t_monto)
C_REAL:C285($r_formaDePago)
C_TEXT:C284($t_obs)

  //recibo parametros
$b_verificarLLave:=True:C214

$r_montoPago:=$1
$t_idsAC:=$2
$d_fecha:=$3
$t_llave:=$4
If (Count parameters:C259>=5)
	$b_verificarLLave:=$5
End if 
If (Count parameters:C259>=6)
	$t_referencia:=$6
End if 
If (Count parameters:C259>=7)
	$t_jsonConDatos:=$7
End if 
If (Count parameters:C259>=8)
	$r_formaDePago:=$8
End if 
If (Count parameters:C259>=9)
	$t_ordenCompra:=$9
End if 
If (Count parameters:C259>=10)
	$t_monto:=$10
End if 
If (Count parameters:C259>=11)
	$t_obs:=$11
End if 

  //20161107 RCH Para evitar procesos paralelos. Ticket 170501
If (Semaphore:C143("ACT_ProcesoIPWPEnCurso";600))
	$b_cont:=False:C215
Else 
	$b_cont:=True:C214
End if 

If ($b_cont)
	$l_numeroOrden:=Num:C11($t_ordenCompra)
	If ($l_numeroOrden>0)
		$l_RecNumPagoExistente:=Find in field:C653([ACT_Pagos:172]ID_WebpayOC:32;$l_numeroOrden)
		$b_cont:=($l_RecNumPagoExistente=-1)
	Else 
		$b_cont:=True:C214
	End if 
	
	If ($b_cont)
		  //$l_idApdo:=0
		  //
		  //$l_idApdo:=1112
		
		  //ids a arreglo
		$t_separadorAvisos:=","
		AT_Text2Array (->$al_idsAC;$t_idsAC;$t_separadorAvisos)
		
		  //TRACE
		If ($r_formaDePago=0)
			$r_formaDePago:=-18  //nueva forma de pago WebPay
		End if 
		
		  //declaraciones
		ACTinit_LoadPrefs 
		
		  //busco avisos
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAC)
		DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;$al_idsApdo)
		
		DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]ID_Tercero:26;$al_idsTerceros)
		
		$l_pos:=Find in array:C230($al_idsApdo;0)
		If ($l_pos>0)
			AT_Delete ($l_pos;1;->$al_idsApdo)
		End if 
		
		$l_pos:=Find in array:C230($al_idsTerceros;0)
		If ($l_pos>0)
			AT_Delete ($l_pos;1;->$al_idsTerceros)
		End if 
		
		  //If (Size of array($al_idsApdo)=1)
		If ((Size of array:C274($al_idsApdo)=1) | (Size of array:C274($al_idsTerceros)=1))
			If (Size of array:C274($al_idsApdo)>0)
				$l_idApdo:=$al_idsApdo{1}
			End if 
			If (Size of array:C274($al_idsTerceros)>0)
				$l_idTercero:=$al_idsTerceros{1}
			End if 
			
			  //verificar llaves
			  //$t_string2hash:=Replace string($t_idsAC;".";String($l_idApdo))+String($l_idApdo)
			  //$b_ejecucionOk:=PHP Execute("";"hash";$res;"sha1";$t_string2hash)
			  //If ($b_ejecucionOk)
			  //$t_string2hash2:=$res+Replace string($t_idsAC;".";"")+String(Day of($d_fecha);"00")+"/"+String(Month of($d_fecha);"00")+"/"+String(Year of($d_fecha))
			  //$b_ejecucionOk:=PHP Execute("";"hash";$res;"sha1";$t_string2hash2)
			  //End if 
			
			$b_continuar:=True:C214
			  //TRACE
			If ($b_verificarLLave)
				
				C_BLOB:C604($blob)
				C_TEXT:C284($t_md5;$t_cadena;$t_hash;$t_hash_2)
				
				Case of 
					: ($r_formaDePago=-18)  //webpay
						  //md5 del monto
						$t_string2hash:=String:C10($r_montoPago)
						CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
						$t_md5:=MD5 ($blob;Crypto HEX)
						
						$t_string2hash:=Replace string:C233($t_idsAC;$t_separadorAvisos;String:C10($l_idApdo))+String:C10($l_idApdo)+$t_md5+String:C10($l_idApdo)
						CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
						$t_hash:=SHA1 ($blob;Crypto HEX)
						
						$t_cadena:=Replace string:C233($t_idsAC;$t_separadorAvisos;"")+String:C10(Day of:C23($d_fecha);"00")+"/"+String:C10(Month of:C24($d_fecha);"00")+"/"+String:C10(Year of:C25($d_fecha))
						$t_string2hash2:=$t_hash+$t_cadena
						CONVERT FROM TEXT:C1011($t_string2hash2;"utf-8";$blob)
						$t_hash_2:=SHA1 ($blob;Crypto HEX)
						
					: (($r_formaDePago=-19) | ($r_formaDePago=-20) | ($r_formaDePago=-21))  //pago web bancomer//pago web banorte//Servipag
						C_TEXT:C284($t_ccRbd)
						If ((<>gCountryCode="") | (<>gRolBD=""))
							STR_ReadGlobals 
						End if 
						$t_ccRbd:=<>gCountryCode+<>gRolBD
						$t_string2hash:=$t_monto
						CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
						$t_md5:=MD5 ($blob;Crypto HEX)
						
						$t_string2hash:=Replace string:C233($t_idsAC;$t_separadorAvisos;String:C10($t_ccRbd))+String:C10($t_ccRbd)+$t_md5+String:C10($t_ccRbd)
						CONVERT FROM TEXT:C1011($t_string2hash;"utf-8";$blob)
						$t_hash:=SHA1 ($blob;Crypto HEX)
						
						$t_cadena:=Replace string:C233($t_idsAC;$t_separadorAvisos;"")+String:C10(Day of:C23($d_fecha);"00")+"/"+String:C10(Month of:C24($d_fecha);"00")+"/"+String:C10(Year of:C25($d_fecha))
						$t_string2hash2:=$t_hash+$t_cadena
						CONVERT FROM TEXT:C1011($t_string2hash2;"utf-8";$blob)
						$t_hash_2:=SHA1 ($blob;Crypto HEX)
						
					Else 
						$t_hash_2:="1"
						$t_llave:="2"
				End case 
				
				If ($t_hash_2#$t_llave)
					$b_continuar:=False:C215
				End if 
			Else 
				$b_continuar:=True:C214
			End if 
			
			If ($b_continuar)
				
				$b_mesAbierto:=ACTcm_IsMonthOpenFromDate ($d_fecha)
				If ($b_mesAbierto)
					  //carga deuda
					C_REAL:C285(RNApdo;RNCta)
					C_LONGINT:C283(RNTercero;$i_indiceArreglos)
					C_REAL:C285($r_deudaOriginal)
					ARRAY LONGINT:C221($alACT_posAC;0)
					
					READ ONLY:C145([Personas:7])
					
					ACTcfg_ItemsMatricula ("InicializaYLee")
					
					RNApdo:=-1
					RNCta:=-1
					RNTercero:=-1
					vrACT_MontoPago:=$r_montoPago
					vdACT_FechaPago:=$d_fecha
					$l_page:=1
					$b_marca:=False:C215
					
					RNApdo:=KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo;False:C215)
					RNTercero:=KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero;False:C215)
					  //If (RNApdo#-1)
					If ((RNApdo#-1) | (RNTercero#-1))
						If (Size of array:C274($al_idsAC)=1)  //20150815 RCH para mejorar el tiempo de respuesta
							  //20150826 RCH Para evitar problemas con los saldos disponibles que puedan tener los apoderados.
							  //ACTpgs_CargaDatosPagoApdo (False;$d_fecha;$al_idsAC{1})
							If ($l_idTercero=0)
								ACTpgs_CargaDatosPagoApdo (False:C215;$d_fecha;$al_idsAC{1};0;$d_fecha;True:C214)
							Else 
								ACTpgs_CargaDatosPagoTercero (False:C215;$d_fecha;$al_idsAC{1};0;$d_fecha;True:C214)
							End if 
						Else 
							ACTpgs_CargaDatosPagoApdo (False:C215;$d_fecha)
						End if 
						  //20150819 RCH
						vtACT_ObservacionesPago:=$t_obs
						ACTpgs_MarkNotMark ("InitArrays";->$l_page;->$b_marca)
						ACTpgs_EliminaCargosNoSel ("LlenaArreglos")
						For ($i_indiceArreglos;1;Size of array:C274($al_idsAC))
							$l_pos:=Find in array:C230(alACT_AIDAviso;$al_idsAC{$i_indiceArreglos})
							If ($l_pos#-1)
								APPEND TO ARRAY:C911($alACT_posAC;$l_pos)
								abACT_ASelectedAvisos{$l_pos}:=True:C214
							End if 
						End for 
						ACTpgs_MarkNotMark ("DesdeAvisos";->$alACT_posAC)
						
						ACTpgs_EliminaCargosNoSel ("EliminaCargos")
						
						vrACT_MontoPago:=$r_montoPago
						vdACT_FechaPago:=$d_fecha
						vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->$r_formaDePago)
						
						  //ingresar pago
						ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
						  //$r_deudaOriginal:=ACTpgs_IngresarPagos ($r_formaDePago;False;False;$d_fecha;True;"Internet")
						$r_deudaOriginal:=ACTpgs_IngresarPagos ($r_formaDePago;False:C215;False:C215;$d_fecha;True:C214;"Internet";$t_referencia;$t_jsonConDatos;$t_ordenCompra)
						COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
						vrACT_MontoPago:=0
						
						For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
							ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};$d_fecha;False:C215;True:C214)
						End for 
						  //20131210 RCH Cambio arreglo alACT_RecNumsAvisos por $alACTpgs_Avisos2Recalc
						For ($tt;1;Size of array:C274($alACTpgs_Avisos2Recalc))
							ACTac_Prepagar ($alACTpgs_Avisos2Recalc{$tt};True:C214)
						End for 
						
						ACTmnu_RecalcularSaldosAvisos (->$alACTpgs_Avisos2Recalc;Current date:C33(*);False:C215;True:C214)
						
						  //registra obs
						If ($l_idApdo#0)
							READ ONLY:C145([Personas:7])
							KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
							If (Records in selection:C76([Personas:7])=1)
								ACTpp_CreateObs ([Personas:7]No:1;"El apoderado realizó un pago en Webpay exitosamente. Pago ingresado para avisos: "+$t_idsAC+", por un monto de: "+String:C10($r_montoPago;"|Despliegue_ACT")+", con fecha de pago: "+String:C10($d_fecha)+".";Current date:C33(*))
							End if 
						End if 
						
						  //Genera JSON de respuesta, avisos y pagos
						  //$json:=ACTwa_EnviaRespAvisosPagos ($l_idApdo)
						$json:=ACTwa_EnviaRespAvisosPagos ($l_idApdo;$l_idTercero)
						
						
					Else 
						  //error. Apdo no encontrado
						$json:=ACTwa_RespuestaError (-6)
					End if 
				Else 
					  //error. mes cerrado
					$json:=ACTwa_RespuestaError (-5)
				End if 
			Else 
				  //error. la llave no corresponde
				$json:=ACTwa_RespuestaError (-4)
			End if 
		Else 
			  //error. Hay mas de 1 apdo asociado a los avisos.
			$json:=ACTwa_RespuestaError (-2)
		End if 
	Else 
		  //Pago ya ingresado (duplicado)
		$json:=ACTwa_RespuestaError (-16)
	End if 
Else 
	$json:=ACTwa_RespuestaError (-17)
End if 
CLEAR SEMAPHORE:C144("ACT_ProcesoIPWPEnCurso")

$0:=$json