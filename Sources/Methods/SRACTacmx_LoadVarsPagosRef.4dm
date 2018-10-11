//%attributes = {}
  //SRACTacmx_LoadVarsPagosRef

If (<>gCountryCode="mx")
	
	ARRAY TEXT:C222($at_BancosMX;6;9)
	
	$at_BancosMX{1}{1}:="002"
	$at_BancosMX{2}{1}:="BANAMEX"
	$at_BancosMX{3}{1}:="vtACT_SRac_RefBANAMEX"
	$at_BancosMX{4}{1}:="Línea referencia "+$at_BancosMX{2}{1}
	$at_BancosMX{5}{1}:="SI"
	$at_BancosMX{6}{1}:="1"
	
	$at_BancosMX{1}{2}:="888"
	$at_BancosMX{2}{2}:="SANTANDER"
	$at_BancosMX{3}{2}:="vtACT_SRac_RefSANTANDER"
	$at_BancosMX{4}{2}:="Línea referencia "+$at_BancosMX{2}{2}
	$at_BancosMX{5}{2}:="NO"
	$at_BancosMX{6}{2}:="2"
	
	$at_BancosMX{1}{3}:="777"
	$at_BancosMX{2}{3}:="HSBN"
	$at_BancosMX{3}{3}:="vtACT_SRac_RefHSBN"
	$at_BancosMX{4}{3}:="Línea referencia "+$at_BancosMX{2}{3}
	$at_BancosMX{5}{3}:="NO"
	$at_BancosMX{6}{3}:="3"
	
	$at_BancosMX{1}{4}:="072"
	$at_BancosMX{2}{4}:="BANORTE"
	$at_BancosMX{3}{4}:="vtACT_SRac_RefBANORTE"
	$at_BancosMX{4}{4}:="Línea referencia "+$at_BancosMX{2}{4}
	$at_BancosMX{5}{4}:="SI"
	$at_BancosMX{6}{4}:="4"
	
	$at_BancosMX{1}{5}:="003"
	$at_BancosMX{2}{5}:="SERFIN"
	$at_BancosMX{3}{5}:="vtACT_SRac_RefSERFIN"
	$at_BancosMX{4}{5}:="Línea referencia "+$at_BancosMX{2}{5}
	$at_BancosMX{5}{5}:="SI"
	$at_BancosMX{6}{5}:="5"
	
	$at_BancosMX{1}{6}:="666"
	$at_BancosMX{2}{6}:="SCOTIABANK"
	$at_BancosMX{3}{6}:="vtACT_SRac_RefSCOTIABANK"
	$at_BancosMX{4}{6}:="Línea referencia "+$at_BancosMX{2}{6}
	$at_BancosMX{5}{6}:="NO"
	$at_BancosMX{6}{6}:="6"
	
	$at_BancosMX{1}{7}:="012"
	$at_BancosMX{2}{7}:="BBVA_BANCOMER"
	$at_BancosMX{3}{7}:="vtACT_SRac_RefBBVA_BANCOMER"
	$at_BancosMX{4}{7}:="Línea referencia "+$at_BancosMX{2}{7}
	$at_BancosMX{5}{7}:="SI"
	$at_BancosMX{6}{7}:="7"
	
	$at_BancosMX{1}{8}:="555"
	$at_BancosMX{2}{8}:="BANCRECER"
	$at_BancosMX{3}{8}:="vtACT_SRac_RefBANCRECER"
	$at_BancosMX{4}{8}:="Línea referencia "+$at_BancosMX{2}{8}
	$at_BancosMX{5}{8}:="NO"
	$at_BancosMX{6}{8}:="8"
	
	$at_BancosMX{1}{9}:="444"
	$at_BancosMX{2}{9}:="UNIVERSAL"
	$at_BancosMX{3}{9}:="vtACT_SRac_RefTRADICIONAL"
	$at_BancosMX{4}{9}:="Línea referencia "+$at_BancosMX{2}{9}
	$at_BancosMX{5}{9}:="NO"
	$at_BancosMX{6}{9}:="9"
	
	C_POINTER:C301($ptr)
	C_TEXT:C284($vt_accion;$1)
	
	$vt_accion:=$1
	If (Count parameters:C259>=2)
		$ptr1:=$2
	End if 
	If (Count parameters:C259>=3)
		$ptr2:=$3
	End if 
	
	Case of 
		: ($vt_accion="DeclaraVars")
			C_TEXT:C284(vtACT_SRac_RefBANAMEX1;vtACT_SRac_RefSANTANDER1;vtACT_SRac_RefHSBN1;vtACT_SRac_RefBANORTE1;vtACT_SRac_RefSERFIN1)
			C_TEXT:C284(vtACT_SRac_RefSCOTIABANK1;vtACT_SRac_RefBBVA_BANCOMER1;vtACT_SRac_RefBANCRECER1;vtACT_SRac_RefTRADICIONAL1)
			
			C_TEXT:C284(vtACT_SRac_RefBANAMEX2;vtACT_SRac_RefSANTANDER2;vtACT_SRac_RefHSBN2;vtACT_SRac_RefBANORTE2;vtACT_SRac_RefSERFIN2)
			C_TEXT:C284(vtACT_SRac_RefSCOTIABANK2;vtACT_SRac_RefBBVA_BANCOMER2;vtACT_SRac_RefBANCRECER2;vtACT_SRac_RefTRADICIONAL2)
			
			C_TEXT:C284(vtACT_SRac_RefBANAMEX3;vtACT_SRac_RefSANTANDER3;vtACT_SRac_RefHSBN3;vtACT_SRac_RefBANORTE3;vtACT_SRac_RefSERFIN3)
			C_TEXT:C284(vtACT_SRac_RefSCOTIABANK3;vtACT_SRac_RefBBVA_BANCOMER3;vtACT_SRac_RefBANCRECER3;vtACT_SRac_RefTRADICIONAL3)
			
			C_TEXT:C284(vtACT_SRac_RefBANAMEX4;vtACT_SRac_RefSANTANDER4;vtACT_SRac_RefHSBN4;vtACT_SRac_RefBANORTE4;vtACT_SRac_RefSERFIN4)
			C_TEXT:C284(vtACT_SRac_RefSCOTIABANK4;vtACT_SRac_RefBBVA_BANCOMER4;vtACT_SRac_RefBANCRECER4;vtACT_SRac_RefTRADICIONAL4)
			
		: ($vt_accion="InitVars")
			SRACTacmx_LoadVarsPagosRef ("DeclaraVars")
			For ($i;1;Size of array:C274($at_BancosMX{1}))
				$ptr:=Get pointer:C304($at_BancosMX{3}{$i}+String:C10($ptr1->))
				$ptr->:=""
			End for 
			
		: ($vt_accion="CargaVars")
			C_TEXT:C284($vt_CodBanco)
			For ($i;1;Size of array:C274($at_BancosMX{1}))
				$ptr:=Get pointer:C304($at_BancosMX{3}{$i}+String:C10($ptr1->))
				$vt_CodBanco:=$at_BancosMX{6}{$i}
				$ptr->:=ACTpgsmx_OpcionesPagosRef ("GetLineaCapturaFinal";->$vt_CodBanco;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Avisos_de_Cobranza:124]Mes:6;->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
			End for 
			
		: ($vt_accion="CargaVariablesModeloInforme")
			For ($i;1;Size of array:C274($at_BancosMX{1}))
				asSRVariables{AT_Inc }:=String:C10($ptr1->)+";"+$at_BancosMX{4}{$i}+";"+$at_BancosMX{3}{$i}+String:C10($ptr2->)+";1"
			End for 
			
		: ($vt_accion="BancoEstandarEnConfiguracion")
			If (Find in array:C230($at_BancosMX{6};$ptr1->)#-1)
				$ptr2->:=$at_BancosMX{5}{Find in array:C230($at_BancosMX{6};$ptr1->)}
			End if 
			
		: ($vt_accion="RetornaNombreBancoXCod")
			If (Find in array:C230($at_BancosMX{6};$ptr1->)#-1)
				$ptr2->:=$at_BancosMX{2}{Find in array:C230($at_BancosMX{6};$ptr1->)}
			End if 
			
		: ($vt_accion="RetornaCodigo")
			If (Find in array:C230($at_BancosMX{6};$ptr1->)#-1)
				$ptr2->:=$at_BancosMX{1}{Find in array:C230($at_BancosMX{6};$ptr1->)}
			End if 
			
		: ($vt_accion="RetornaLineaCapturaBanamexEton")
			C_TEXT:C284($vt_codBanco;$vt_lineaCaptura;$vt_numCtaCompleto;$vt_numRef;$vt_fechaLimitePago;$vt_numValImporte;$vt_numCta;$vt_numCtaVal;$vt_retorno;$vt_constanteLineaCaptura)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			C_LONGINT:C283($vl_divisor)
			C_REAL:C285($vr_suma)
			C_LONGINT:C283($vl_ponderador;$vl_cont;$mod;$vl_numPonderado)
			
			APPEND TO ARRAY:C911(aQR_Longint1;11)
			APPEND TO ARRAY:C911(aQR_Longint1;23)
			APPEND TO ARRAY:C911(aQR_Longint1;19)
			APPEND TO ARRAY:C911(aQR_Longint1;17)
			APPEND TO ARRAY:C911(aQR_Longint1;13)
			
			$vl_cont:=0
			$vt_codBanco:="1"
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			$vt_numCtaCompleto:=ACTpgsmx_OpcionesPagosRef ("GetNumCtaEmpresa";->$vt_codBanco)
			$vt_numRef:=ST_RigthChars ((("0")*6)+Replace string:C233([ACT_CuentasCorrientes:175]Codigo:19;"-";"");6)+("0"*8)
			$vt_fechaLimitePago:=ACTpgsmx_OpcionesPagosRef ("GetFechaLimitePago";->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
			$vt_numValImporte:=ACTpgsmx_OpcionesPagosRef ("GetValidacionImporte";->$vt_codBanco;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
			$vt_lineaCaptura:=$vt_numCtaCompleto+$vt_numRef+$vt_fechaLimitePago
			ACTpgsmx_OpcionesPagosRef ("GetDivisorDigitoGlobalPorColegio";->$vt_codBanco;->$vl_divisor)
			AT_Initialize (->aQR_Longint2)
			While ($vt_lineaCaptura#"")
				$vl_cont:=$vl_cont+1
				$mod:=Mod:C98($vl_cont;Size of array:C274(aQR_Longint1))
				If ($mod=0)
					$vl_ponderador:=aQR_Longint1{Size of array:C274(aQR_Longint1)}
				Else 
					$vl_ponderador:=aQR_Longint1{$mod}
				End if 
				$vl_numPonderado:=Num:C11(ST_LeftChars ($vt_lineaCaptura;1))*$vl_ponderador
				APPEND TO ARRAY:C911(aQR_Longint2;$vl_numPonderado)
				$vt_lineaCaptura:=Substring:C12($vt_lineaCaptura;2)
			End while 
			$vr_suma:=AT_GetSumArray (->aQR_Longint2)
			$vr_suma:=$vr_suma+(Num:C11($vt_numValImporte)*13)+22
			$vt_retorno:=String:C10(Int:C8(Round:C94(Mod:C98($vr_suma;$vl_divisor)+1;0)))
			$vt_retorno:=String:C10(Num:C11($vt_retorno);"00")
			$vt_constanteLineaCaptura:="2"
			$vt_numCta:=Substring:C12($vt_numCtaCompleto;1;Length:C16($vt_numCtaCompleto)-2)
			$vt_numCtaVal:=Substring:C12($vt_numCtaCompleto;(Length:C16($vt_numCtaCompleto)-2)+1;Length:C16($vt_numCtaCompleto))
			$vt_lineaCaptura:=$vt_numCta+" "+$vt_numCtaVal+" "+Substring:C12($vt_numRef;1;6)+" "+Substring:C12($vt_numRef;7;2)+" "+Substring:C12($vt_numRef;9;4)+" "+Substring:C12($vt_numRef;13;2)+Substring:C12($vt_fechaLimitePago;1;2)+" "+Substring:C12($vt_fechaLimitePago;3;2)+$vt_numValImporte+$vt_constanteLineaCaptura+" "+$vt_retorno
			$0:=$vt_lineaCaptura
			
		: ($vt_accion="RetornaLineaCapturaBancomerEton")
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			ARRAY TEXT:C222(aQR_Text2D;2;36)
			aQR_Text2D{1}{1}:="0"
			aQR_Text2D{2}{1}:="0"
			aQR_Text2D{1}{2}:="1"
			aQR_Text2D{2}{2}:="1"
			aQR_Text2D{1}{3}:="2"
			aQR_Text2D{2}{3}:="2"
			aQR_Text2D{1}{4}:="3"
			aQR_Text2D{2}{4}:="3"
			aQR_Text2D{1}{5}:="4"
			aQR_Text2D{2}{5}:="4"
			aQR_Text2D{1}{6}:="5"
			aQR_Text2D{2}{6}:="5"
			aQR_Text2D{1}{7}:="6"
			aQR_Text2D{2}{7}:="6"
			aQR_Text2D{1}{8}:="7"
			aQR_Text2D{2}{8}:="7"
			aQR_Text2D{1}{9}:="8"
			aQR_Text2D{2}{9}:="8"
			aQR_Text2D{1}{10}:="9"
			aQR_Text2D{2}{10}:="9"
			aQR_Text2D{1}{11}:="10"
			aQR_Text2D{2}{11}:="A"
			aQR_Text2D{1}{12}:="11"
			aQR_Text2D{2}{12}:="B"
			aQR_Text2D{1}{13}:="12"
			aQR_Text2D{2}{13}:="C"
			aQR_Text2D{1}{14}:="13"
			aQR_Text2D{2}{14}:="D"
			aQR_Text2D{1}{15}:="14"
			aQR_Text2D{2}{15}:="E"
			aQR_Text2D{1}{16}:="15"
			aQR_Text2D{2}{16}:="F"
			aQR_Text2D{1}{17}:="16"
			aQR_Text2D{2}{17}:="G"
			aQR_Text2D{1}{18}:="17"
			aQR_Text2D{2}{18}:="H"
			aQR_Text2D{1}{19}:="18"
			aQR_Text2D{2}{19}:="I"
			aQR_Text2D{1}{20}:="19"
			aQR_Text2D{2}{20}:="J"
			aQR_Text2D{1}{21}:="20"
			aQR_Text2D{2}{21}:="K"
			aQR_Text2D{1}{22}:="21"
			aQR_Text2D{2}{22}:="L"
			aQR_Text2D{1}{23}:="22"
			aQR_Text2D{2}{23}:="M"
			aQR_Text2D{1}{24}:="23"
			aQR_Text2D{2}{24}:="N"
			aQR_Text2D{1}{25}:="24"
			aQR_Text2D{2}{25}:="O"
			aQR_Text2D{1}{26}:="25"
			aQR_Text2D{2}{26}:="P"
			aQR_Text2D{1}{27}:="26"
			aQR_Text2D{2}{27}:="Q"
			aQR_Text2D{1}{28}:="27"
			aQR_Text2D{2}{28}:="R"
			aQR_Text2D{1}{29}:="28"
			aQR_Text2D{2}{29}:="S"
			aQR_Text2D{1}{30}:="29"
			aQR_Text2D{2}{30}:="T"
			aQR_Text2D{1}{31}:="30"
			aQR_Text2D{2}{31}:="U"
			aQR_Text2D{1}{32}:="31"
			aQR_Text2D{2}{32}:="V"
			aQR_Text2D{1}{33}:="32"
			aQR_Text2D{2}{33}:="W"
			aQR_Text2D{1}{34}:="33"
			aQR_Text2D{2}{34}:="X"
			aQR_Text2D{1}{35}:="34"
			aQR_Text2D{2}{35}:="Y"
			aQR_Text2D{1}{36}:="35"
			aQR_Text2D{2}{36}:="Z"
			
			vQR_Text1:=""
			vQR_Text2:=""
			vQR_Text3:=""
			vQR_Text4:=""
			vQR_Text5:=""
			vQR_Text6:=""
			vQR_Text7:=""
			
			vQR_Long2:=0
			vQR_Text2:=Replace string:C233([ACT_CuentasCorrientes:175]Codigo:19;"-";"")
			vQR_Text2Interno:=ACTabc_GetFieldWithFormat (vQR_Text2;"N";10)
			vQR_Text3:=String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
			vQR_Text4:=String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
			vQR_Text5:=Substring:C12(String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5));3)
			
			vQR_Long2:=Num:C11(vQR_Text3+vQR_Text4+vQR_Text5)
			ARRAY REAL:C219(aQR_Real2;0)
			APPEND TO ARRAY:C911(aQR_Real2;Mod:C98(vQR_Long2;36))
			vQR_Long2:=Int:C8(vQR_Long2/36)
			While (vQR_Long2>0)
				APPEND TO ARRAY:C911(aQR_Real2;Mod:C98(vQR_Long2;36))
				vQR_Long2:=Int:C8(vQR_Long2/36)
			End while 
			If (Size of array:C274(aQR_Real2)<4)
				vQR_Long3:=4-Size of array:C274(aQR_Real2)
				AT_Insert (0;vQR_Long3;->aQR_Real2)
			End if 
			ARRAY TEXT:C222(aQR_Text2;0)
			For (vQR_Long1;Size of array:C274(aQR_Real2);1;-1)
				vQR_Long4:=Find in array:C230(aQR_Text2D{1};String:C10(aQR_Real2{vQR_Long1}))
				AT_Insert (1;1;->aQR_Text2)
				aQR_Text2{1}:=aQR_Text2D{2}{vQR_Long4}
			End for 
			vQR_Text6:="##########"
			If (<>vlACT_Decimales>0)
				vQR_Text6:=vQR_Text6+<>tXS_RS_DecimalSeparator+(("0")*<>vlACT_Decimales)
			End if 
			vQR_Text7:=Replace string:C233(String:C10([ACT_Avisos_de_Cobranza:124]Monto_Neto:11;vQR_Text6);<>tXS_RS_DecimalSeparator;"")
			vQR_Long2:=Num:C11(vQR_Text7)
			ARRAY REAL:C219(aQR_Real2;0)
			APPEND TO ARRAY:C911(aQR_Real2;Mod:C98(vQR_Long2;36))
			vQR_Long2:=Int:C8(vQR_Long2/36)
			While (vQR_Long2>0)
				APPEND TO ARRAY:C911(aQR_Real2;Mod:C98(vQR_Long2;36))
				vQR_Long2:=Int:C8(vQR_Long2/36)
			End while 
			If (Size of array:C274(aQR_Real2)<5)
				vQR_Long3:=5-Size of array:C274(aQR_Real2)
				AT_Insert (0;vQR_Long3;->aQR_Real2)
			End if 
			AT_Insert (1;5;->aQR_Text2)
			vQR_Long5:=6
			For (vQR_Long1;Size of array:C274(aQR_Real2);1;-1)
				vQR_Long4:=Find in array:C230(aQR_Text2D{1};String:C10(aQR_Real2{vQR_Long1}))
				aQR_Text2{vQR_Long1}:=aQR_Text2D{2}{vQR_Long4}
			End for 
			vQR_Text1:=vQR_Text2Interno
			For (vQR_Long1;Size of array:C274(aQR_Text2);1;-1)
				vQR_Text1:=vQR_Text1+aQR_Text2{vQR_Long1}
			End for 
			
			ARRAY TEXT:C222(aQR_Text2D;2;36)
			aQR_Text2D{1}{1}:="0"
			aQR_Text2D{2}{1}:="0"
			aQR_Text2D{1}{2}:="1"
			aQR_Text2D{2}{2}:="1"
			aQR_Text2D{1}{3}:="2"
			aQR_Text2D{2}{3}:="2"
			aQR_Text2D{1}{4}:="3"
			aQR_Text2D{2}{4}:="3"
			aQR_Text2D{1}{5}:="4"
			aQR_Text2D{2}{5}:="4"
			aQR_Text2D{1}{6}:="5"
			aQR_Text2D{2}{6}:="5"
			aQR_Text2D{1}{7}:="6"
			aQR_Text2D{2}{7}:="6"
			aQR_Text2D{1}{8}:="7"
			aQR_Text2D{2}{8}:="7"
			aQR_Text2D{1}{9}:="8"
			aQR_Text2D{2}{9}:="8"
			aQR_Text2D{1}{10}:="9"
			aQR_Text2D{2}{10}:="9"
			aQR_Text2D{1}{11}:="A"
			aQR_Text2D{2}{11}:="1"
			aQR_Text2D{1}{12}:="B"
			aQR_Text2D{2}{12}:="2"
			aQR_Text2D{1}{13}:="C"
			aQR_Text2D{2}{13}:="3"
			aQR_Text2D{1}{14}:="D"
			aQR_Text2D{2}{14}:="4"
			aQR_Text2D{1}{15}:="E"
			aQR_Text2D{2}{15}:="5"
			aQR_Text2D{1}{16}:="F"
			aQR_Text2D{2}{16}:="6"
			aQR_Text2D{1}{17}:="G"
			aQR_Text2D{2}{17}:="7"
			aQR_Text2D{1}{18}:="H"
			aQR_Text2D{2}{18}:="8"
			aQR_Text2D{1}{19}:="I"
			aQR_Text2D{2}{19}:="9"
			aQR_Text2D{1}{20}:="J"
			aQR_Text2D{2}{20}:="1"
			aQR_Text2D{1}{21}:="K"
			aQR_Text2D{2}{21}:="2"
			aQR_Text2D{1}{22}:="L"
			aQR_Text2D{2}{22}:="3"
			aQR_Text2D{1}{23}:="M"
			aQR_Text2D{2}{23}:="4"
			aQR_Text2D{1}{24}:="N"
			aQR_Text2D{2}{24}:="5"
			aQR_Text2D{1}{25}:="O"
			aQR_Text2D{2}{25}:="6"
			aQR_Text2D{1}{26}:="P"
			aQR_Text2D{2}{26}:="7"
			aQR_Text2D{1}{27}:="Q"
			aQR_Text2D{2}{27}:="8"
			aQR_Text2D{1}{28}:="R"
			aQR_Text2D{2}{28}:="9"
			aQR_Text2D{1}{29}:="S"
			aQR_Text2D{2}{29}:="1"
			aQR_Text2D{1}{30}:="T"
			aQR_Text2D{2}{30}:="2"
			aQR_Text2D{1}{31}:="U"
			aQR_Text2D{2}{31}:="3"
			aQR_Text2D{1}{32}:="V"
			aQR_Text2D{2}{32}:="4"
			aQR_Text2D{1}{33}:="W"
			aQR_Text2D{2}{33}:="5"
			aQR_Text2D{1}{34}:="X"
			aQR_Text2D{2}{34}:="6"
			aQR_Text2D{1}{35}:="Y"
			aQR_Text2D{2}{35}:="7"
			aQR_Text2D{1}{36}:="Z"
			aQR_Text2D{2}{36}:="8"
			ARRAY REAL:C219(aQR_Real1;0)
			For (vQR_Long1;1;Length:C16(vQR_Text1))
				vQR_Long4:=Find in array:C230(aQR_Text2D{1};vQR_Text1[[vQR_Long1]])
				APPEND TO ARRAY:C911(aQR_Real1;Num:C11(aQR_Text2D{2}{vQR_Long4}))
			End for 
			ARRAY LONGINT:C221(aQR_Longint1;0)
			For (vQR_Long1;1;Size of array:C274(aQR_Real1))
				vQR_Long10:=Mod:C98((vQR_Long1+1);2)
				APPEND TO ARRAY:C911(aQR_Longint1;2-vQR_Long10)
			End for 
			ARRAY LONGINT:C221(aQR_Longint2;0)
			For (vQR_Long1;1;Size of array:C274(aQR_Real1))
				vQR_Long10:=aQR_Real1{vQR_Long1}*aQR_Longint1{vQR_Long1}
				If (vQR_Long10>9)
					vQR_Long10:=Num:C11(String:C10(vQR_Long10)[[1]])+Num:C11(String:C10(vQR_Long10)[[2]])
				End if 
				APPEND TO ARRAY:C911(aQR_Longint2;vQR_Long10)
			End for 
			vQR_Long6:=AT_GetSumArray (->aQR_Longint2)
			vQR_Long7:=Num:C11(String:C10(vQR_Long6)[[Length:C16(String:C10(vQR_Long6))]])
			vQR_Long7:=10-vQR_Long7
			If (vQR_Long7=0)
				vQR_Long7:=10
			End if 
			
			$0:=vQR_Text1+" "+String:C10(vQR_Long7)
	End case 
End if 