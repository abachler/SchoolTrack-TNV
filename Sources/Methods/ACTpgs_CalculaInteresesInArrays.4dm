//%attributes = {}
  //ACTpgs_CalculaInteresesInArrays

C_LONGINT:C283(vl_cargosEliminados)
C_BOOLEAN:C305($vb_hayIntereses)
C_BOOLEAN:C305($b_afecto)

vl_cargosEliminados:=0
$fecha:=$1
$display:=$2
ACTcfg_LoadConfigData (1)
$0:=True:C214
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos)
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0;*)
QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<Current date:C33(*))
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	ARRAY LONGINT:C221($RNAvisos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$RNAvisos;"")
	
	  //For ($i;1;Size of array($RNAvisos))
	  //GOTO RECORD([ACT_Avisos_de_Cobranza];$RNAvisos{$i})
	CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$RNAvisos;"")
	READ ONLY:C145([xxACT_Items:179])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Cargos:173])
	  //QUERY([ACT_Documentos_de_Cargo];[ACT_Documentos_de_Cargo]No_ComprobanteInterno=[ACT_Avisos_de_Cobranza]ID_Aviso)
	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
	KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
	  //busca los cargos asociados a intereses con saldo
	CREATE SET:C116([ACT_Cargos:173];"todosCargosACT")
	  //20121231 RCH
	  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item=-100;*)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16<0;*)  //para incluir todos los cargos relacionados...
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]LastInterestsUpdate:42<$fecha)
	ARRAY LONGINT:C221($al_idsCargos;0)
	SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargos)
	QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$al_idsCargos)
	CREATE SET:C116([ACT_Cargos:173];"intCargosACT")
	  //busca cargos no intereses morosos
	USE SET:C118("todosCargosACT")
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-100;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
	QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]LastInterestsUpdate:42<$fecha)
	CREATE SET:C116([ACT_Cargos:173];"todosCargosACT")
	  //une cargos morosos y cargos asociados a intereses morosos
	UNION:C120("todosCargosACT";"intCargosACT";"todosCargosACT")
	USE SET:C118("todosCargosACT")
	SET_ClearSets ("todosCargosACT";"intCargosACT")
	ARRAY LONGINT:C221($aRNCargos;0)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNCargos;"")
	
	If ($display)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando intereses por atraso..."))
	End if 
	
	For ($g;1;Size of array:C274($aRNCargos))
		READ ONLY:C145([ACT_Cargos:173])
		GOTO RECORD:C242([ACT_Cargos:173];$aRNCargos{$g})
		  //If ($fecha>[ACT_Cargos]LastInterestsUpdate)
		If (($fecha>[ACT_Cargos:173]LastInterestsUpdate:42) & ($fecha>[ACT_Cargos:173]Fecha_de_Vencimiento:7))  //20140825 RCH Intereses
			$daysSinceLast:=$fecha-[ACT_Cargos:173]LastInterestsUpdate:42
		Else 
			$daysSinceLast:=0
		End if 
		If ([ACT_Cargos:173]ID_CuentaCorriente:2#0)  //para el caso de los cargos asociados solo al tercero
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
			$ctaAfecta:=[ACT_CuentasCorrientes:175]AfectoIntereses:28
		Else 
			$ctaAfecta:=True:C214
		End if 
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
		If (Records in selection:C76([xxACT_Items:179])=1)
			$afectoInt:=[xxACT_Items:179]AfectoInteres:26
			$tipo:=[xxACT_Items:179]TipoInteres:29
			$b_afecto:=([ACT_Cargos:173]TasaIVA:21#0)  //20170410 RCH
			
			$go:=True:C214
			If ($daysSinceLast>0)
				If (($afectoInt) & ($ctaAfecta))
					$tasaMensual:=[xxACT_Items:179]TasaInteresMensual:25/100
					$months:=$daysSinceLast/30
				Else 
					$go:=False:C215
				End if 
			Else 
				$go:=False:C215
			End if 
			
			C_DATE:C307($d_fechaCalculo)
			If (<>b_usarFechaVencimiento=1)
				$d_fechaCalculo:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
			Else 
				$d_fechaCalculo:=$fecha
			End if 
			
			If ($go)
				If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
					$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Cargos:173]Moneda:28))
					$vt_moneda:=[ACT_Cargos:173]Moneda:28
				Else 
					$vl_decimales:=<>vlACT_Decimales
					$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
				End if 
				$idCargo:=[ACT_Cargos:173]ID:1
				If ($tipo)  //verdadero corresponde a interes simple
					  //20161011 RCH Se buscan los cargos asociados no intereses.
					  //$saldo:=[ACT_Cargos]Saldo*-1
					  //$intereses:=Round($saldo*$months*$tasaMensual;$vl_decimales)
					
					PUSH RECORD:C176([ACT_Cargos:173])
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16#-100)
					$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$fecha)
					$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$fecha;$vt_moneda)
					POP RECORD:C177([ACT_Cargos:173])
					$saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
					$intereses:=Round:C94($saldo*$months*$tasaMensual;$vl_decimales)
					
				Else 
					PUSH RECORD:C176([ACT_Cargos:173])
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=$idCargo;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
					
					  //20161011 RCH Se comenta línea siguiente porque ahora se puede usar cualquier cargo para descuentos
					  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0;*)
					  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]Ref_Item<0)  //para incluir todos los cargos relacionados...
					
					  //$porInt:=Sum([ACT_Cargos]Saldo)
					  //POP RECORD([ACT_Cargos])
					  //$saldo:=([ACT_Cargos]Saldo+$porInt)*-1
					
					  //$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;$fecha)
					  //$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$fecha;$vt_moneda)
					$vr_montoPesos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;$d_fechaCalculo)
					$vr_montoMoneda:=ACTut_retornaMontoEnMoneda ($vr_montoPesos;ST_GetWord (ACT_DivisaPais ;1;";");$d_fechaCalculo;$vt_moneda)
					
					
					POP RECORD:C177([ACT_Cargos:173])
					$saldo:=([ACT_Cargos:173]Saldo:23+$vr_montoMoneda)*-1
					$intereses:=Round:C94($saldo*(((1+$tasaMensual)^$months)-1);$vl_decimales)
					
				End if 
				  //$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$fecha;ST_GetWord (ACT_DivisaPais ;1;";"))
				
				$intereses:=ACTut_retornaMontoEnMoneda ($intereses;$vt_moneda;$d_fechaCalculo;ST_GetWord (ACT_DivisaPais ;1;";"))
				
				ACTpgs_CreateCargoIntInArrays ($intereses;$idCargo;$fecha;$b_afecto)
				$vb_hayIntereses:=True:C214
			End if 
		End if 
		If ($display)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$g/Size of array:C274($aRNCargos);__ ("Calculando intereses por atraso..."))
		End if 
	End for 
	If ($display)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	
	If (RNCta#-1)
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];RNCta)
	End if 
End if 

If ($vb_hayIntereses)
	ACTpgs_CargaArreglosInterfaz ($fecha)
End if 