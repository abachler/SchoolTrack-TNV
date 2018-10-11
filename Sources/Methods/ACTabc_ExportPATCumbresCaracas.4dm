//%attributes = {}
  // Método: ACTabc_ExportPATCumbresCaracas
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 26-04-10, 17:01:00
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //ACTabc_ExportPATCumbresCaracas

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_TEXT:C284($vQR_Text1;$vQR_Text2)
C_LONGINT:C283($vl_incrementa)

C_TEXT:C284($set)
C_LONGINT:C283($i;$vl_idCta;$j;$vl_year;$vl_mes)
C_REAL:C285($vr_monto)
C_TEXT:C284($vQR_Text1;$vQR_Text2)

C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_noCuotas;vQR_Long1;$vl_total)

ARRAY LONGINT:C221(aQR_Longint5;0)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
vFechaPAT:=String:C10(Current date:C33(*);7)
vtotalPAT:=""
vnumTransPAT:=""

ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")

READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
CREATE SET:C116([ACT_Cargos:173];"$setCargosTodos")

ARRAY TEXT:C222(aQR_Text5;0)
ARRAY LONGINT:C221(aQR_Longint2;0)
ARRAY LONGINT:C221(aQR_Longint3;0)
AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_RazonSocial:57;->aQR_Longint2)
C_LONGINT:C283($pos)
$pos:=Find in array:C230(aQR_Longint2;0)
If ($pos>0)
	aQR_Longint2{$pos}:=-1
End if 
AT_DistinctsArrayValues (->aQR_Longint2)

ACTcfg_OpcionesRazonesSociales ("LeePreferencias")
For ($i;1;Size of array:C274(aQR_Longint2))
	$pos:=Find in array:C230(alACTcfg_Razones;aQR_Longint2{$i})
	If ($pos>0)
		APPEND TO ARRAY:C911(aQR_Text5;atACTcfg_Razones{$pos})
	End if 
End for 
  //C_POINTER($ptr)
C_BOOLEAN:C305($vb_continuar)
C_LONGINT:C283($vl_idRazonSocial)
$vb_continuar:=True:C214

If (Size of array:C274(aQR_Text5)>1)
	SRtbl_ShowChoiceList (0;"Seleccione la razón social...";2;->vl_ExportXAC;False:C215;->aQR_Longint2;->aQR_Text5)
	If (Ok=1)
		USE SET:C118("$setCargosTodos")
		$vl_idRazonSocial:=aQR_Longint2{choiceIdx}
		ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_idRazonSocial)
		
		If (Records in selection:C76([ACT_Cargos:173])>0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY LONGINT:C221(aQR_Longint3;0)
			ARRAY LONGINT:C221(aQR_Longint4;0)
			
			ARRAY TEXT:C222(aQR_Text5;0)
			ARRAY TEXT:C222(aQR_Text6;0)
			
			SELECTION TO ARRAY:C260([ACT_Cargos:173];aQR_Longint2;[ACT_Cargos:173]Glosa:12;aQR_Text5;[ACT_Cargos:173]Ref_Item:16;aQR_Longint3)
			COPY ARRAY:C226(aQR_Longint3;aQR_Longint4)
			
			AT_DistinctsArrayValues (->aQR_Longint4)
			
			READ ONLY:C145([xxACT_Items:179])
			For ($i;1;Size of array:C274(aQR_Longint4))
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=aQR_Longint4{$i})
				If (Records in selection:C76([xxACT_Items:179])=1)
					APPEND TO ARRAY:C911(aQR_Text6;[xxACT_Items:179]Glosa:2)
				Else 
					$pos:=Find in array:C230(aQR_Longint3;aQR_Longint4{$i})
					APPEND TO ARRAY:C911(aQR_Text6;aQR_Text5{$pos})
				End if 
			End for 
			
			SRtbl_ShowChoiceList (0;"Seleccione ítem(s)...";2;->vl_ExportXAC;True:C214;->aQR_Longint4;->aQR_Text6)
			If (ok=1)
				ARRAY LONGINT:C221(aQR_Longint5;0)
				For ($i;1;Size of array:C274(aLinesSelected))
					aQR_Longint3{0}:=aQR_Longint4{aLinesSelected{$i}}
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->aQR_Longint3;"=";->$DA_Return)
					For ($i;1;Size of array:C274($DA_Return))
						APPEND TO ARRAY:C911(aQR_Longint5;aQR_Longint2{$DA_Return{$i}})
					End for 
					  //APPEND TO ARRAY(aQR_Longint3;aQR_Longint2{aLinesSelected{$i}})
				End for 
				If (Size of array:C274(aQR_Longint5)=0)
					$vb_continuar:=False:C215
				End if 
			Else 
				$vb_continuar:=False:C215
			End if 
		Else 
			$vb_continuar:=False:C215
		End if 
	Else 
		$vb_continuar:=False:C215
	End if 
Else 
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint5;"")
End if 

If ($vb_continuar)
	$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAT";$fileName)
	If ($ref#?00:00:00?)
		
		C_TEXT:C284($vt_texto1_1;$vt_texto1_2;$vt_texto1_3;$vt_texto1_4;$vt_texto1_5;$vt_texto1_6;$vt_texto1_7;$vt_texto1_8;$vt_texto1_9;$vt_texto1_10;$vt_texto1_11;$vt_texto1_12;$vt_texto1_13;$vt_texto1_14;$vt_texto1_15;$vt_texto1_16;$vt_texto1_17;$vt_texto1_18;$vt_texto1_19;$vt_texto1_20;$vt_texto1_21;$vt_texto1_22;$vt_texto1_23;$vt_texto1_24;$vt_texto1_25)
		C_TEXT:C284($vt_texto2_1;$vt_texto2_2;$vt_texto2_3;$vt_texto2_4;$vt_texto2_5;$vt_texto2_6;$vt_texto2_7;$vt_texto2_8;$vt_texto2_9;$vt_texto2_10;$vt_texto2_11;$vt_texto2_12;$vt_texto2_13;$vt_texto2_14;$vt_texto2_15;$vt_texto2_16;$vt_texto2_17;$vt_texto2_18;$vt_texto2_19;$vt_texto2_20;$vt_texto2_21;$vt_texto2_22;$vt_texto2_23;$vt_texto2_24;$vt_texto2_25;$vt_texto2_26;$vt_texto2_27;$vt_texto2_28)
		C_TEXT:C284($vt_texto3_1;$vt_texto3_2;$vt_texto3_3;$vt_texto3_4;$vt_texto3_5;$vt_texto3_6;$vt_texto3_7;$vt_texto3_8;$vt_texto3_9;$vt_texto3_10;$vt_texto3_11;$vt_texto3_12;$vt_texto3_13;$vt_texto3_14;$vt_texto3_15;$vt_texto3_16;$vt_texto3_17;$vt_texto3_18;$vt_texto3_19;$vt_texto3_20;$vt_texto3_21;$vt_texto3_22;$vt_texto3_23;$vt_texto3_24;$vt_texto3_25)
		
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];aQR_Longint5;"")
		CREATE SET:C116([ACT_Cargos:173];"$setCargosTodos")
		
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
		
		If (bAvisoApoderado=1)
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		Else 
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_CuentasCorrientes:175]ID:1;>;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		End if 
		CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
		$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
		
		ARRAY LONGINT:C221(aQR_Longint1;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aQR_Text4)
		
		C_POINTER:C301(vQR_Pointer1)
		If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
			vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
		Else 
			vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
		End if 
		
		ARRAY REAL:C219(aQR_Real1;0)
		ARRAY DATE:C224(aQR_Date1;0)
		ARRAY TEXT:C222(aQR_Text2;0)
		ARRAY TEXT:C222(aQR_Text3;0)
		ARRAY TEXT:C222(aQR_Text4;0)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
		While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
			USE SET:C118("AvisosTodos")
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				If (bAvisoApoderado=1)
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				Else 
					ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
				End if 
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
				DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
				
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2#0)
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				CREATE SET:C116([ACT_Cargos:173];"$setCargos")
				INTERSECTION:C121("$setCargos";"$setCargosTodos";"$setCargos")
				USE SET:C118("$setCargos")
				
				ARRAY LONGINT:C221(aQR_Longint1;0)
				If (bAvisoApoderado=1)
					APPEND TO ARRAY:C911(aQR_Longint1;0)
				Else 
					KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
					AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->aQR_Longint1)
				End if 
				
				ARRAY TEXT:C222(aQR_Text1;0)
				C_TEXT:C284($vt_valor)
				While (Not:C34(End selection:C36([ACT_Cargos:173])))
					$vt_valor:=String:C10([ACT_Cargos:173]Año:14)+String:C10([ACT_Cargos:173]Mes:13;"00")
					If (Find in array:C230(aQR_Text1;$vt_valor)=-1)
						APPEND TO ARRAY:C911(aQR_Text1;$vt_valor)
					End if 
					NEXT RECORD:C51([ACT_Cargos:173])
				End while 
				
				For ($i;1;Size of array:C274(aQR_Longint1))
					$vl_idCta:=aQR_Longint1{$i}
					For ($j;1;Size of array:C274(aQR_Text1))
						$vl_year:=Num:C11(Substring:C12(aQR_Text1{$j};1;4))
						$vl_mes:=Num:C11(Substring:C12(aQR_Text1{$j};5;2))
						
						  //USE SET("selectionApdo")
						  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Agno=$vl_year;*)
						  //QUERY SELECTION([ACT_Avisos_de_Cobranza]; & ;[ACT_Avisos_de_Cobranza]Mes=$vl_mes)
						
						USE SET:C118("$setCargos")
						If ($vl_idCta=0)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2#0;*)
						Else 
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$vl_idCta;*)
						End if 
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$vl_year;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$vl_mes)
						$set:="setCargos"
						CREATE SET:C116([ACT_Cargos:173];$set)
						$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$set;vQR_Pointer1;vd_FechaUF))
						If ($vr_monto>0)
							vnumTransPAT:=String:C10(Num:C11(vnumTransPAT)+1)
							vtotalPAT:=String:C10(Num:C11(vtotalPAT)+$vr_monto)
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							KRL_RelateSelection (->[ACT_Boletas:181]ID:1;->[ACT_Transacciones:178]No_Boleta:9;"")
							FIRST RECORD:C50([ACT_Boletas:181])
							APPEND TO ARRAY:C911(aQR_Real1;$vr_monto)
							APPEND TO ARRAY:C911(aQR_Date1;[ACT_Boletas:181]FechaEmision:3)
							APPEND TO ARRAY:C911(aQR_Text2;[Personas:7]RUT:6)
							APPEND TO ARRAY:C911(aQR_Text3;_ACTObtenerNoTC ([Personas:7]ACT_Numero_TC:54;True:C214))
							APPEND TO ARRAY:C911(aQR_Text4;[Personas:7]ACT_MesVenc_TC:57+[Personas:7]ACT_AñoVenc_TC:58)
							
						End if 
					End for 
				End for 
				
			End if 
			USE SET:C118("AvisosTodos")
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Exportando datos...")
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		If (Size of array:C274(aQR_Real1)>0)
			$vt_texto1_1:=ACTabc_GetFieldWithFormat ("80000";"N";5)
			$vt_texto1_2:=ACTabc_GetFieldWithFormat ("0";"N";5)
			$vt_texto1_3:=ACTabc_GetFieldWithFormat (Substring:C12(String:C10(Year of:C25(Current date:C33(*)));4;1)+"1"+String:C10(Num:C11(ACTtrf_Master (6;"Día Juliano";String:C10(Current date:C33(*))))+1)+"50000";"N";10)
			$vt_texto1_4:=ACTabc_GetFieldWithFormat ("7488";"N";7)
			$vt_texto1_5:=ACTabc_GetFieldWithFormat ("1";"N";3)
			$vt_texto1_6:=ACTabc_GetFieldWithFormat ("0";"N";1)
			$vt_texto1_7:=ACTabc_GetFieldWithFormat ("0";"N";1)
			$vt_texto1_8:=ACTabc_GetFieldWithFormat ("P"+Substring:C12(String:C10(Year of:C25(Current date:C33(*)));3;2)+ST_RigthChars (("0"*5)+String:C10(Num:C11(ACTtrf_Master (6;"Día Juliano";String:C10(Current date:C33(*))))+1);5);"N";8)
			$vt_texto1_9:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23(Current date:C33(*)));"N";2)
			$vt_texto1_10:=ACTabc_GetFieldWithFormat (String:C10(Month of:C24(Current date:C33(*)));"N";2)
			$vt_texto1_11:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(Current date:C33(*)));"N";4)
			$vt_texto1_12:=ACTabc_GetFieldWithFormat (vnumTransPAT;"N";5)
			ACTio_Num2Vars (Num:C11(vtotalPAT);11;2;->$vQR_Text1;->$vQR_Text2)
			$vt_texto1_13:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";13)
			ACTio_Num2Vars (Num:C11(vtotalPAT)/100;11;2;->$vQR_Text1;->$vQR_Text2)
			$vt_texto1_14:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";13)
			$vt_texto1_15:=ACTabc_GetFieldWithFormat ("0";"N";13)
			$vt_texto1_16:=ACTabc_GetFieldWithFormat ("0";"N";13)
			ACTio_Num2Vars (Num:C11(vtotalPAT)-(Num:C11(vtotalPAT)*0.01);11;2;->$vQR_Text1;->$vQR_Text2)
			$vt_texto1_17:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";13)
			$vt_texto1_18:=ACTabc_GetFieldWithFormat ("1";"N";5)
			$vt_texto1_19:=ACTabc_GetFieldWithFormat ("0";"N";5)
			$vt_texto1_20:=ACTabc_GetFieldWithFormat ("0";"N";91)
			$vt_texto1_21:=ACTabc_GetFieldWithFormat (" ";"A";30)
			$vt_texto1_22:=ACTabc_GetFieldWithFormat ("0";"N";35)
			$vt_texto1_23:=ACTabc_GetFieldWithFormat ("0";"N";5)
			$vt_texto1_24:=ACTabc_GetFieldWithFormat ("0";"N";14)
			$vt_texto1_25:=ACTabc_GetFieldWithFormat (" ";"A";2)
			
			$text:=$vt_texto1_1+$vt_texto1_2+$vt_texto1_3+$vt_texto1_4+$vt_texto1_5+$vt_texto1_6+$vt_texto1_7+$vt_texto1_8+$vt_texto1_9+$vt_texto1_10+$vt_texto1_11+$vt_texto1_12+$vt_texto1_13+$vt_texto1_14+$vt_texto1_15+$vt_texto1_16+$vt_texto1_17+$vt_texto1_18+$vt_texto1_19+$vt_texto1_20+$vt_texto1_21+$vt_texto1_22+$vt_texto1_23+$vt_texto1_24+$vt_texto1_25+"\r"
			IO_SendPacket ($ref;$text)
			
			AT_Inc (0)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
			For ($i;1;Size of array:C274(aQR_Real1))
				$vl_incrementa:=AT_Inc 
				$vt_texto2_1:=ACTabc_GetFieldWithFormat ("80000";"N";5)
				$vt_texto2_2:=ACTabc_GetFieldWithFormat (String:C10($vl_incrementa);"N";5)
				$vt_texto2_3:=ACTabc_GetFieldWithFormat ("1";"N";2)
				$vt_texto2_4:=ACTabc_GetFieldWithFormat (Substring:C12(String:C10(Year of:C25(Current date:C33(*)));4;1)+"1"+String:C10(Num:C11(ACTtrf_Master (6;"Día Juliano";String:C10(Current date:C33(*))))+1)+ST_RigthChars (String:C10(50000+$vl_incrementa);5);"N";10)
				$vt_texto2_5:=ACTabc_GetFieldWithFormat ("7488";"N";7)
				$vt_texto2_6:=ACTabc_GetFieldWithFormat ("1";"N";3)
				$vt_texto2_7:=ACTabc_GetFieldWithFormat ("0";"N";1)
				$vt_texto2_8:=ACTabc_GetFieldWithFormat ("0";"N";1)
				$vt_texto2_9:=ACTabc_GetFieldWithFormat ("P"+Substring:C12(String:C10(Year of:C25(Current date:C33(*)));3;2)+ST_RigthChars (("0"*5)+String:C10(Num:C11(ACTtrf_Master (6;"Día Juliano";String:C10(Current date:C33(*))))+1);5);"N";8)
				$vt_texto2_10:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23(aQR_Date1{$i}));"N";2)
				$vt_texto2_11:=ACTabc_GetFieldWithFormat (String:C10(Month of:C24(aQR_Date1{$i}));"N";2)
				$vt_texto2_12:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(aQR_Date1{$i}));"N";4)
				$vt_texto2_13:=ACTabc_GetFieldWithFormat (aQR_Text2{$i};"N";8)
				ACTio_Num2Vars (aQR_Real1{$i};11;2;->$vQR_Text1;->$vQR_Text2)
				$vt_texto2_14:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";13)
				$vt_texto2_15:=ACTabc_GetFieldWithFormat ("0";"N";13)
				$vt_texto2_16:=ACTabc_GetFieldWithFormat (aQR_Text3{$i};"N";16)
				$vt_texto2_17:=ACTabc_GetFieldWithFormat ("0";"N";3)
				$vt_texto2_18:=ACTabc_GetFieldWithFormat (aQR_Text4{$i};"N";6)
				$vt_texto2_19:=ACTabc_GetFieldWithFormat ("0";"N";4)
				$vt_texto2_20:=ACTabc_GetFieldWithFormat ("1";"N";5)
				$vt_texto2_21:=ACTabc_GetFieldWithFormat ("0";"N";5)
				$vt_texto2_22:=ACTabc_GetFieldWithFormat ("0";"N";26)
				$vt_texto2_23:=ACTabc_GetFieldWithFormat (" ";"A";30)
				$vt_texto2_24:=ACTabc_GetFieldWithFormat ("0";"N";30)
				$vt_texto2_25:=ACTabc_GetFieldWithFormat (" ";"A";7)
				$vt_texto2_26:=ACTabc_GetFieldWithFormat ("0";"N";3)
				$vt_texto2_27:=ACTabc_GetFieldWithFormat (" ";"A";5)
				$vt_texto2_28:=ACTabc_GetFieldWithFormat (" ";"A";80)
				
				$text:=$vt_texto2_1+$vt_texto2_2+$vt_texto2_3+$vt_texto2_4+$vt_texto2_5+$vt_texto2_6+$vt_texto2_7+$vt_texto2_8+$vt_texto2_9+$vt_texto2_10+$vt_texto2_11+$vt_texto2_12+$vt_texto2_13+$vt_texto2_14+$vt_texto2_15+$vt_texto2_16+$vt_texto2_17+$vt_texto2_18+$vt_texto2_19+$vt_texto2_20+$vt_texto2_21+$vt_texto2_22+$vt_texto2_23+$vt_texto2_24+$vt_texto2_25+$vt_texto2_26+$vt_texto2_27+$vt_texto2_28+"\r"
				IO_SendPacket ($ref;$text)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Real1);"Exportando datos...")
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			
			$vt_texto3_1:=ACTabc_GetFieldWithFormat ("99999";"N";5)
			$vt_texto3_2:=ACTabc_GetFieldWithFormat ("0";"N";5)
			$vt_texto3_3:=ACTabc_GetFieldWithFormat (Substring:C12(String:C10(Year of:C25(Current date:C33(*)));4;1)+"1"+String:C10(Num:C11(ACTtrf_Master (6;"Día Juliano";String:C10(Current date:C33(*))))+1)+"99999";"N";10)
			$vt_texto3_4:=ACTabc_GetFieldWithFormat ("999999";"N";7)
			$vt_texto3_5:=ACTabc_GetFieldWithFormat ("999";"N";3)
			$vt_texto3_6:=ACTabc_GetFieldWithFormat ("9";"N";1)
			$vt_texto3_7:=ACTabc_GetFieldWithFormat ("9";"N";1)
			$vt_texto3_8:=ACTabc_GetFieldWithFormat ("Z0000000";"N";8)
			$vt_texto3_9:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23(Current date:C33(*)));"N";2)
			$vt_texto3_10:=ACTabc_GetFieldWithFormat (String:C10(Month of:C24(Current date:C33(*)));"N";2)
			$vt_texto3_11:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(Current date:C33(*)));"N";4)
			$vt_texto3_12:=ACTabc_GetFieldWithFormat (vnumTransPAT;"N";5)
			ACTio_Num2Vars (Num:C11(vtotalPAT);11;2;->$vQR_Text1;->$vQR_Text2)
			$vt_texto3_13:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";13)
			ACTio_Num2Vars (Num:C11(vtotalPAT)/100;11;2;->$vQR_Text1;->$vQR_Text2)
			$vt_texto3_14:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";13)
			$vt_texto3_15:=ACTabc_GetFieldWithFormat ("0";"N";13)
			$vt_texto3_16:=ACTabc_GetFieldWithFormat ("0";"N";13)
			ACTio_Num2Vars (Num:C11(vtotalPAT)-(Num:C11(vtotalPAT)*0.01);11;2;->$vQR_Text1;->$vQR_Text2)
			$vt_texto3_17:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";13)
			$vt_texto3_18:=ACTabc_GetFieldWithFormat ("1";"N";5)
			$vt_texto3_19:=ACTabc_GetFieldWithFormat ("0";"N";5)
			$vt_texto3_20:=ACTabc_GetFieldWithFormat ("0";"N";91)
			$vt_texto3_21:=ACTabc_GetFieldWithFormat (" ";"A";30)
			$vt_texto3_22:=ACTabc_GetFieldWithFormat ("0";"N";35)
			$vt_texto3_23:=ACTabc_GetFieldWithFormat (" ";"A";5)
			$vt_texto3_24:=ACTabc_GetFieldWithFormat ("0";"N";14)
			$vt_texto3_25:=ACTabc_GetFieldWithFormat (" ";"A";2)
			
			$text:=$vt_texto3_1+$vt_texto3_2+$vt_texto3_3+$vt_texto3_4+$vt_texto3_5+$vt_texto3_6+$vt_texto3_7+$vt_texto3_8+$vt_texto3_9+$vt_texto3_10+$vt_texto3_11+$vt_texto3_12+$vt_texto3_13+$vt_texto3_14+$vt_texto3_15+$vt_texto3_16+$vt_texto3_17+$vt_texto3_18+$vt_texto3_19+$vt_texto3_20+$vt_texto3_21+$vt_texto3_22+$vt_texto3_23+$vt_texto3_24+$vt_texto3_25+"\r"
			IO_SendPacket ($ref;$text)
		End if 
		
		vtotalPAT:=String:C10(Num:C11(vtotalPAT);"|Despliegue_ACT")
		
		CLOSE DOCUMENT:C267($ref)
		CLEAR SET:C117("AvisosTodos")
		If (Records in set:C195("selectionApdo")>0)
			CLEAR SET:C117("selectionApdo")
		End if 
	Else 
		vb_detenerImp:=True:C214
	End if 
Else 
	vb_detenerImp:=True:C214
End if 