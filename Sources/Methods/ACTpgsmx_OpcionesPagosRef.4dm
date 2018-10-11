//%attributes = {}
  //ACTpgsmx_OpcionesPagosRef

C_TEXT:C284($accion;$1;$0;$vt_retorno)

$accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
If (Count parameters:C259>=5)
	$ptr4:=$5
End if 
If (Count parameters:C259>=6)
	$ptr5:=$6
End if 
If (Count parameters:C259>=7)
	$ptr6:=$7
End if 

Case of 
	: ($accion="GetNumCtaEmpresa")
		C_TEXT:C284($vt_bancoEstandar;$vt_nombreBanco)
		READ ONLY:C145([xxACT_Bancos:129])
		SRACTacmx_LoadVarsPagosRef ("BancoEstandarEnConfiguracion";$ptr1;->$vt_bancoEstandar)
		If ($vt_bancoEstandar="NO")
			SRACTacmx_LoadVarsPagosRef ("RetornaNombreBancoXCod";$ptr1;->$vt_nombreBanco)
			QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Nombre:1="@"+$vt_nombreBanco+"@";*)
			QUERY:C277([xxACT_Bancos:129]; & ;[xxACT_Bancos:129]Pais:3="mx")
		Else 
			SRACTacmx_LoadVarsPagosRef ("RetornaCodigo";$ptr1;->$vt_nombreBanco)
			QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Codigo:2=$vt_nombreBanco;*)
			QUERY:C277([xxACT_Bancos:129]; & ;[xxACT_Bancos:129]Pais:3="mx")
		End if 
		If (Records in selection:C76([xxACT_Bancos:129])=1)
			$vt_retorno:=[xxACT_Bancos:129]mx_NumeroConvenio:5
		End if 
		
	: ($accion="GetFechaLimitePago")
		C_LONGINT:C283($vl_Agno;$vl_Mes;$vl_Dia)
		$vl_Agno:=(Year of:C25($ptr1->)-1988)*372
		$vl_Mes:=(Month of:C24($ptr1->)-1)*31
		$vl_Dia:=(Day of:C23($ptr1->)-1)
		$vt_retorno:=String:C10($vl_Agno+$vl_Mes+$vl_Dia)
		
	: ($accion="GetFechaLimitePago2013")  //20140929 RCH
		C_LONGINT:C283($vl_Agno;$vl_Mes;$vl_Dia)
		$vl_Agno:=(Year of:C25($ptr1->)-2013)*372
		$vl_Mes:=(Month of:C24($ptr1->)-1)*31
		$vl_Dia:=(Day of:C23($ptr1->)-1)
		$vt_retorno:=String:C10($vl_Agno+$vl_Mes+$vl_Dia)
		
	: ($accion="GetValidacionImporte")
		C_LONGINT:C283($vl_divisor)
		ARRAY LONGINT:C221($al_ponderadores;0)
		ARRAY LONGINT:C221($al_resultados;0)
		ACTpgsmx_OpcionesPagosRef ("GetPonderadoresImportePorColegio";$ptr1;->$al_ponderadores)
		ACTpgsmx_OpcionesPagosRef ("GetNumDivisorImportePorColegio";$ptr1;->$vl_divisor)
		ACTpgsmx_OpcionesPagosRef ("GetValidacionXPonderacion";$ptr2;->$al_ponderadores;->$al_resultados)
		$vt_retorno:=ACTpgsmx_OpcionesPagosRef ("GetResultOperacion";->$al_resultados;->$vl_divisor)
		
	: ($accion="GetNumDivisorImportePorColegio")
		Case of 
			: ($ptr1->="1") | ($ptr1->="2") | ($ptr1->="3") | ($ptr1->="4") | ($ptr1->="5") | ($ptr1->="6") | ($ptr1->="7")  //Banamex - Santander - HSBN - BANORTE - SERFIN - SCOTIABANK - BBVA BANCOMER
				$ptr2->:=10
		End case 
		
	: ($accion="GetPonderadoresImportePorColegio")
		AT_Initialize ($ptr2)
		Case of 
			: ($ptr1->="1") | ($ptr1->="2") | ($ptr1->="3") | ($ptr1->="4") | ($ptr1->="5") | ($ptr1->="6") | ($ptr1->="7")  //Banamex - Santander - HSBN - BANORTE - SERFIN - SCOTIABANK - BBVA BANCOMER
				APPEND TO ARRAY:C911($ptr2->;7)
				APPEND TO ARRAY:C911($ptr2->;3)
				APPEND TO ARRAY:C911($ptr2->;1)
			Else   //20120731 RCH Entregaba error al imprimir...
				APPEND TO ARRAY:C911($ptr2->;7)
				APPEND TO ARRAY:C911($ptr2->;3)
				APPEND TO ARRAY:C911($ptr2->;1)
		End case 
		
	: ($accion="GetValidacionXPonderacion")
		C_TEXT:C284($vt_monto;$vt_formato)
		ARRAY LONGINT:C221($al_ponderadores;0)
		COPY ARRAY:C226($ptr2->;$al_ponderadores)
		$type:=Type:C295($ptr1->)
		If (($type=1) | ($type=8) | ($type=9))
			$vt_formato:="##########"
			If (<>vlACT_Decimales>0)
				$vt_formato:=$vt_formato+<>tXS_RS_DecimalSeparator+(("0")*<>vlACT_Decimales)
			End if 
			$vt_monto:=Replace string:C233(String:C10($ptr1->;$vt_formato);<>tXS_RS_DecimalSeparator;"")
		Else 
			$vt_monto:=$ptr1->
		End if 
		ACTpgsmx_OpcionesPagosRef ("GetArrayResultPonderacion";->$vt_monto;->$al_ponderadores;$ptr3)
		
	: ($accion="GetArrayResultPonderacion")
		C_LONGINT:C283($vl_ponderador;$vl_cont;$mod;$vl_numPonderado)
		$vl_cont:=0
		AT_Initialize ($ptr3)
		While ($ptr1->#"")
			$vl_cont:=$vl_cont+1
			$mod:=Mod:C98($vl_cont;Size of array:C274($ptr2->))
			If ($mod=0)
				$vl_ponderador:=$ptr2->{Size of array:C274($ptr2->)}
			Else 
				$vl_ponderador:=$ptr2->{$mod}
			End if 
			$vl_numPonderado:=Num:C11(ST_RigthChars ($ptr1->;1))*$vl_ponderador
			APPEND TO ARRAY:C911($ptr3->;$vl_numPonderado)
			$ptr1->:=Substring:C12($ptr1->;1;Length:C16($ptr1->)-1)
		End while 
		
	: ($accion="GetArrayResultPonderacionIzq")
		C_LONGINT:C283($vl_ponderador;$vl_cont;$mod;$vl_numPonderado)
		$vl_cont:=0
		AT_Initialize ($ptr3)
		While ($ptr1->#"")
			$vl_cont:=$vl_cont+1
			$mod:=Mod:C98($vl_cont;Size of array:C274($ptr2->))
			If ($mod=0)
				$vl_ponderador:=$ptr2->{Size of array:C274($ptr2->)}
			Else 
				$vl_ponderador:=$ptr2->{$mod}
			End if 
			$vl_numPonderado:=Num:C11(ST_LeftChars ($ptr1->;1))*$vl_ponderador
			APPEND TO ARRAY:C911($ptr3->;$vl_numPonderado)
			$ptr1->:=Substring:C12($ptr1->;2)
		End while 
		
	: ($accion="GetDigitoGlobalValidacion")
		C_LONGINT:C283($vl_divisor)
		C_LONGINT:C283($vl_NumMaxResultPond)
		ARRAY LONGINT:C221($al_ponderadores;0)
		ARRAY LONGINT:C221($al_resultados;0)
		ACTpgsmx_OpcionesPagosRef ("GetPonderadoresDigitoGlobalXBanco";$ptr1;->$al_ponderadores)
		ACTpgsmx_OpcionesPagosRef ("GetDivisorDigitoGlobalPorColegio";$ptr1;->$vl_divisor)
		Case of 
			: ($ptr1->="1") | ($ptr1->="2") | ($ptr1->="3") | ($ptr1->="4") | ($ptr1->="5") | ($ptr1->="6") | ($ptr1->="7")  //Banamex - Santander - HSBN - BANORTE - SERFIN - SCOTIABANK - BBVA BANCOMER
				ACTpgsmx_OpcionesPagosRef ("GetValidacionXPonderacion";$ptr2;->$al_ponderadores;->$al_resultados)
				$vt_retorno:=ACTpgsmx_OpcionesPagosRef ("GetResultOperacion";->$al_resultados;->$vl_divisor)
				$vt_retorno:=String:C10(Num:C11($vt_retorno)+1;"00")
				
			: ($ptr1->="8") | ($ptr1->="9")  //BANCRECER - TRADICIONAL
				ACTpgsmx_OpcionesPagosRef ("GetArrayResultPonderacion";$ptr2;->$al_ponderadores;->$al_resultados)
				ACTpgsmx_OpcionesPagosRef ("GetNumMaxResultPonderacion";$ptr1;->$vl_NumMaxResultPond)
				ACTpgsmx_OpcionesPagosRef ("GetArrayMaxResultPonderacion";->$al_resultados;->$vl_NumMaxResultPond)
				Case of 
					: ($ptr1->="9")  //TRADICIONAL
						ARRAY LONGINT:C221($al_resultados2;0)
						ARRAY LONGINT:C221($al_resultados1;0)
						COPY ARRAY:C226($al_resultados;$al_resultados2)
						$vt_numCtaCompleto:=ACTpgsmx_OpcionesPagosRef ("GetNumCtaEmpresa";$ptr1)
						AT_Initialize (->$al_resultados)
						ACTpgsmx_OpcionesPagosRef ("GetArrayResultPonderacion";->$vt_numCtaCompleto;->$al_ponderadores;->$al_resultados)
						ACTpgsmx_OpcionesPagosRef ("GetArrayMaxResultPonderacion";->$al_resultados;->$vl_NumMaxResultPond)
						COPY ARRAY:C226($al_resultados;$al_resultados1)
						AT_Initialize (->$al_resultados)
						For ($i;1;Size of array:C274($al_resultados1))
							APPEND TO ARRAY:C911($al_resultados;$al_resultados1{$i})
						End for 
						For ($i;1;Size of array:C274($al_resultados2))
							APPEND TO ARRAY:C911($al_resultados;$al_resultados2{$i})
						End for 
				End case 
				$vt_retorno:=ACTpgsmx_OpcionesPagosRef ("GetResultOperacion";->$al_resultados;->$vl_divisor)
				$vt_retorno:=String:C10(10-Num:C11($vt_retorno))
		End case 
		
	: ($accion="GetArrayMaxResultPonderacion")
		For ($i;1;Size of array:C274($ptr1->))
			If ($ptr1->{$i}>$ptr2->)
				$ptr1->{$i}:=$ptr1->{$i}-$ptr2->
			End if 
		End for 
		
	: ($accion="GetNumMaxResultPonderacion")
		Case of 
			: ($ptr1->="8") | ($ptr1->="9")  //BANCRECER - `TRADICIONAL
				$ptr2->:=9
		End case 
		
	: ($accion="GetResultOperacion")
		$vt_retorno:=String:C10(Mod:C98(AT_GetSumArray ($ptr1);$ptr2->))
		
	: ($accion="GetDivisorDigitoGlobalPorColegio")
		Case of 
			: ($ptr1->="1") | ($ptr1->="2") | ($ptr1->="3") | ($ptr1->="4") | ($ptr1->="5") | ($ptr1->="6") | ($ptr1->="7")  //Banamex - Santander - HSBN - BANORTE - SERFIN - SCOTIABANK - BBVA BANCOMER
				$ptr2->:=97
				
			: ($ptr1->="8") | ($ptr1->="9")  //BANCRECER - TRADICIONAL
				$ptr2->:=10
				
		End case 
		
	: ($accion="GetPonderadoresDigitoGlobalXBanco")
		AT_Initialize ($ptr2)
		Case of 
			: ($ptr1->="1") | ($ptr1->="2") | ($ptr1->="3") | ($ptr1->="4") | ($ptr1->="5") | ($ptr1->="6") | ($ptr1->="7")  //Banamex - Santander - HSBN - BANORTE - SERFIN - SCOTIABANK - BBVA BANCOMER
				APPEND TO ARRAY:C911($ptr2->;11)
				APPEND TO ARRAY:C911($ptr2->;13)
				APPEND TO ARRAY:C911($ptr2->;17)
				APPEND TO ARRAY:C911($ptr2->;19)
				APPEND TO ARRAY:C911($ptr2->;23)
				
			: ($ptr1->="8")  //BANCRECER
				APPEND TO ARRAY:C911($ptr2->;2)
				APPEND TO ARRAY:C911($ptr2->;1)
				
			: ($ptr1->="9")  //TRADICIONAL
				APPEND TO ARRAY:C911($ptr2->;1)
				APPEND TO ARRAY:C911($ptr2->;2)
				
		End case 
		
	: ($accion="GetNumReferenciaXBanco")
		$vl_decimales:=0
		Case of 
			: ($ptr1->="8") | ($ptr1->="9")  //BANCRECER - TRADICIONAL
				C_LONGINT:C283($tableNum;$fieldNum)
				C_TEXT:C284($varName)
				READ ONLY:C145([ACT_Boletas:181])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				READ ONLY:C145([ACT_Transacciones:178])
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				READ ONLY:C145([Personas:7])
				RESOLVE POINTER:C394($ptr2;$varName;$tableNum;$fieldNum)
				If ($tableNum#0)
					Case of 
						: ($tableNum=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
							KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
						: ($tableNum=Table:C252(->[ACT_Boletas:181]))
							KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
					End case 
					FIRST RECORD:C50([ACT_Transacciones:178])
					
					Case of 
						: ($ptr1->="8")  //BANCRECER
							REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
							KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2)
							If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
								$vt_retorno:=[ACT_CuentasCorrientes:175]Codigo:19
							End if 
							
						: ($ptr1->="9")  //-TRADICIONAL
							REDUCE SELECTION:C351([Personas:7];0)
							KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Transacciones:178]ID_Apoderado:11)
							If (Records in selection:C76([Personas:7])=1)
								$vt_retorno:=[Personas:7]ACT_RUTTitutal_Cta:50
							End if 
							
					End case 
				End if 
			Else 
				Case of 
					: ($ptr1->="1") | ($ptr1->="4") | ($ptr1->="6")  //Banamex - BANORTE - SCOTIABANK
						$vl_decimales:=5
					: ($ptr1->="2") | ($ptr1->="3") | ($ptr1->="5") | ($ptr1->="7")  //Santander - HSBN - SERFIN - BBVA BANCOMER
						$vl_decimales:=6
				End case 
				$vt_retorno:=ST_RigthChars ((("0")*$vl_decimales)+String:C10($ptr2->);$vl_decimales)
		End case 
		
	: ($accion="GetLineaCapturaXBanco")
		C_TEXT:C284($vt_numCta;$vt_numCtaVal;$vt_numCtaCompleto;$vt_numRef;$vt_mesPago;$vt_fechaLimitePago;$vt_numValImporte;$vt_constanteLineaCaptura;$vt_lineaCaptura)
		  //$ptr1->Nombre banco
		  //$ptr2->id para  num ref
		  //$ptr3->Fecha a la que corresponde el pago
		  //$ptr4->Fecha vencimiento o limite de pago
		  //$ptr5->Monto Importe
		  //$ptr6->Con formato Impresion??
		$vt_numCtaCompleto:=ACTpgsmx_OpcionesPagosRef ("GetNumCtaEmpresa";$ptr1)
		$vt_numRef:=ACTpgsmx_OpcionesPagosRef ("GetNumReferenciaXBanco";$ptr1;$ptr2)
		$vt_numValImporte:=ACTpgsmx_OpcionesPagosRef ("GetValidacionImporte";$ptr1;$ptr5)
		$vt_fechaLimitePago:=ACTpgsmx_OpcionesPagosRef ("GetFechaLimitePago";$ptr4)
		$vt_mesPago:=String:C10($ptr3->;"00")
		$vt_constanteLineaCaptura:="2"
		Case of 
			: ($ptr1->="1") | ($ptr1->="6")  //Banamex - SCOTIABANK
				$vt_numCta:=Substring:C12($vt_numCtaCompleto;1;Length:C16($vt_numCtaCompleto)-2)
				$vt_numCtaVal:=Substring:C12($vt_numCtaCompleto;(Length:C16($vt_numCtaCompleto)-2)+1;Length:C16($vt_numCtaCompleto))
				If ($ptr6->)
					$vt_lineaCaptura:=$vt_numCta+" "+$vt_numCtaVal+" "+$vt_numRef+" "+$vt_mesPago+" "+$vt_fechaLimitePago+" "+$vt_numValImporte+" "+$vt_constanteLineaCaptura
				Else 
					$vt_lineaCaptura:=$vt_numCtaCompleto+$vt_numRef+$vt_mesPago+$vt_fechaLimitePago+$vt_numValImporte+$vt_constanteLineaCaptura
				End if 
				
			: ($ptr1->="2") | ($ptr1->="5")  //Santander - SERFIN
				Case of 
						  //: ($ptr1->="888")
					: ($ptr1->="2")
						$vt_numCtaVal:=Substring:C12($vt_numCtaCompleto;(Length:C16($vt_numCtaCompleto)-4)+1;Length:C16($vt_numCtaCompleto))
						
					: ($ptr1->="5")
						$vt_numCtaVal:=$vt_numCtaCompleto
				End case 
				
				If ($ptr6->)
					$vt_lineaCaptura:=$vt_numCtaVal+" "+$vt_numRef+" "+$vt_fechaLimitePago+" "+$vt_numValImporte+" "+$vt_constanteLineaCaptura
				Else 
					$vt_lineaCaptura:=$vt_numCtaVal+$vt_numRef+$vt_fechaLimitePago+$vt_numValImporte+$vt_constanteLineaCaptura
				End if 
				
			: ($ptr1->="3")  //HSBN
				If ($ptr6->)
					$vt_lineaCaptura:=$vt_numCtaCompleto+" "+$vt_numRef+" "+$vt_mesPago+" "+$vt_fechaLimitePago+" "+$vt_numValImporte+" "+$vt_constanteLineaCaptura
				Else 
					$vt_lineaCaptura:=$vt_numCtaCompleto+$vt_numRef+$vt_mesPago+$vt_fechaLimitePago+$vt_numValImporte+$vt_constanteLineaCaptura
				End if 
				
			: ($ptr1->="4")  //BANORTE
				$vt_numCtaVal:=Substring:C12($vt_numCtaCompleto;(Length:C16($vt_numCtaCompleto)-2)+1;Length:C16($vt_numCtaCompleto))
				If ($ptr6->)
					$vt_lineaCaptura:=$vt_numCtaVal+" "+$vt_numRef+" "+$vt_mesPago+" "+$vt_fechaLimitePago+" "+$vt_numValImporte+" "+$vt_constanteLineaCaptura
				Else 
					$vt_lineaCaptura:=$vt_numCtaCompleto+$vt_numRef+$vt_mesPago+$vt_fechaLimitePago+$vt_numValImporte+$vt_constanteLineaCaptura
				End if 
				
			: ($ptr1->="7")  //BBVA BANCOMER
				$vt_numCta:=Substring:C12($vt_numCtaCompleto;1;Length:C16($vt_numCtaCompleto)-2)
				$vt_numCtaVal:=Substring:C12($vt_numCtaCompleto;(Length:C16($vt_numCtaCompleto)-2)+1;Length:C16($vt_numCtaCompleto))
				If ($ptr6->)
					$vt_lineaCaptura:=$vt_numCta+" "+$vt_numCtaVal+" "+$vt_numRef+" "+$vt_fechaLimitePago+" "+$vt_numValImporte+" "+$vt_constanteLineaCaptura
				Else 
					$vt_lineaCaptura:=$vt_numCtaCompleto+$vt_numRef+$vt_fechaLimitePago+$vt_numValImporte+$vt_constanteLineaCaptura
				End if 
				
			: ($ptr1->="8")  //BANCRECER
				$vt_lineaCaptura:=$vt_numRef
				
			: ($ptr1->="9")  //TRADICIONAL
				$vt_lineaCaptura:=$vt_numRef
				
		End case 
		
		$vt_retorno:=$vt_lineaCaptura
		
	: ($accion="GetLineaCapturaFinal")
		  //$ptr1->Nombre banco
		  //$ptr2->id para  num ref
		  //$ptr3->Fecha a la que corresponde el pago
		  //$ptr4->Fecha vencimiento o limite de pago
		  //$ptr5->Monto Importe
		$vb_formatoImpresion:=False:C215
		$vt_lineaCaptura:=ACTpgsmx_OpcionesPagosRef ("GetLineaCapturaXBanco";$ptr1;$ptr2;$ptr3;$ptr4;$ptr5;->$vb_formatoImpresion)
		$vt_digitoGlobalVal:=ACTpgsmx_OpcionesPagosRef ("GetDigitoGlobalValidacion";$ptr1;->$vt_lineaCaptura)
		$vb_formatoImpresion:=True:C214
		$vt_lineaCaptura:=ACTpgsmx_OpcionesPagosRef ("GetLineaCapturaXBanco";$ptr1;$ptr2;$ptr3;$ptr4;$ptr5;->$vb_formatoImpresion)
		$vt_retorno:=$vt_lineaCaptura+" "+$vt_digitoGlobalVal
		
End case 

$0:=$vt_retorno