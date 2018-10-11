//%attributes = {}
  //ACTabc_ExportCUPCasuarinasBIF

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text;$fileNameOrg)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total;$vl_noCuotas)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Personas:7])
READ ONLY:C145([Cursos:3])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)

$fileNameOrg:=Replace string:C233($fileName;".txt";"")
$fileName:=$fileNameOrg+"_Integrante.txt"

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	
	USE SET:C118("AvisosTodos")
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY TEXT:C222(aQR_Text1;0)
	ARRAY TEXT:C222(aQR_Text3;0)
	
	KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	
	If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
	End if 
	
	AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->aQR_Longint1)
	C_TEXT:C284($vt_codInterno1;$vt_apellidoPat2;$vt_apellidoMat3;$vt_nombres4;$vt_codgrupo5;$vt_codgrado6;$vt_seccion7;$vt_espacios8;$vt_ceros9)
	
	
	
	For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aQR_Longint1{vQR_Long1})
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
		$vt_codInterno1:=ACTabc_GetFieldWithFormat ([ACT_CuentasCorrientes:175]Codigo:19;"A";20)
		$vt_apellidoPat2:=ACTabc_GetFieldWithFormat (ST_Uppercase ([Alumnos:2]Apellido_paterno:3);"A";20)
		$vt_apellidoMat3:=ACTabc_GetFieldWithFormat (ST_Uppercase ([Alumnos:2]Apellido_materno:4);"A";20)
		$vt_nombres4:=ACTabc_GetFieldWithFormat (ST_Uppercase ([Alumnos:2]Nombres:2);"A";20)
		$vt_codgrupo5:=ACTabc_GetFieldWithFormat (" 001";"N";4)
		$vt_codgrado6:=ACTabc_GetFieldWithFormat ("00";"N";2)
		$vt_seccion7:=ACTabc_GetFieldWithFormat ("0 ";"A";2)
		$vt_espacios8:=ACTabc_GetFieldWithFormat (" ";"A";2)
		$vt_ceros9:=ACTabc_GetFieldWithFormat ("0";"N";2)
		$text:=$vt_codInterno1+$vt_apellidoPat2+$vt_apellidoMat3+$vt_nombres4+$vt_codgrupo5+$vt_codgrado6+$vt_seccion7+$vt_espacios8+$vt_ceros9+"\r"
		IO_SendPacket ($ref;$text)
	End for 
	CLOSE DOCUMENT:C267($ref)
	
	C_TEXT:C284($vt_numrecibo1;$vt_codInteg2;$vt_fEmision3;$vt_fVencimiento4;$vt_moneda5;$vt_codRef6;$vt_dec7;$vt_Obs8;$vt_indicador9)
	$fileName:=$fileNameOrg+"_Pensiones.txt"
	
	$ref:=ACTabc_CreaArchivo ("Cuponera";$fileName)
	If ($ref#?00:00:00?)
		
		ARRAY TEXT:C222(aQR_Text2;0)
		ARRAY TEXT:C222(aQR_Text3;0)
		ARRAY TEXT:C222(aQR_Text4;0)
		ARRAY TEXT:C222(aQR_Text5;0)
		ARRAY TEXT:C222(aQR_Text6;0)
		ARRAY TEXT:C222(aQR_Text7;0)
		ARRAY TEXT:C222(aQR_Text8;0)
		ARRAY TEXT:C222(aQR_Text9;0)
		ARRAY TEXT:C222(aQR_Text10;0)
		ARRAY TEXT:C222(aQR_Text11;0)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando datos...")
		ARRAY LONGINT:C221(aQR_Longint3;0)
		USE SET:C118("AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint3;"")
		For (vQR_Long2;1;Size of array:C274(aQR_Longint3))
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint3{vQR_Long2})
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			ARRAY LONGINT:C221(aQR_Longint4;0)
			If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			End if 
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint4;"")
			For (vQR_Long4;1;Size of array:C274(aQR_Longint4))
				GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint4{vQR_Long4})
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				Case of 
					: ([ACT_Cargos:173]Glosa:12="Pensi@")
						vQR_Text1:="PENSION."+aMeses{[ACT_Cargos:173]Mes:13}
						vQR_Text2:="01"
					: ([ACT_Cargos:173]Glosa:12="Matricula@")
						vQR_Text1:="MATRICULA."+aMeses{[ACT_Cargos:173]Mes:13}
						vQR_Text2:="01"
					Else 
						vQR_Text1:="SERVICIOS VARIOS."+aMeses{[ACT_Cargos:173]Mes:13}
						vQR_Text2:="02"
				End case 
				vQR_real2:=[ACT_Cargos:173]Ref_Item:16
				If (vQR_real2=-100)
					vQR_real2:=3456
				End if 
				vQR_Text4:=ACTabc_GetFieldWithFormat (String:C10(vQR_real2);"N";4)
				vQR_Text1:=ST_Uppercase (vQR_Text1)
				vQR_Text3:=Substring:C12(String:C10([ACT_Cargos:173]Año:14);3;2)+String:C10([ACT_Cargos:173]Mes:13;"00")
				$vt_numrecibo1:=ACTabc_GetFieldWithFormat (ACTabc_GetFieldWithFormat ([ACT_CuentasCorrientes:175]Codigo:19;"N";6)+vQR_Text4+Substring:C12(vQR_Text3;3;2);"N";12)
				$vt_codInteg2:=ACTabc_GetFieldWithFormat ([ACT_CuentasCorrientes:175]Codigo:19;"A";20)
				$vt_fEmision3:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Cargos:173]FechaEmision:22))+String:C10(Month of:C24([ACT_Cargos:173]FechaEmision:22);"00")+String:C10(Day of:C23([ACT_Cargos:173]FechaEmision:22);"00");"N";8)
				$vt_fVencimiento4:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7))+String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00");"N";8)
				$vt_moneda5:=ACTabc_GetFieldWithFormat ("SOL";"A";3)
				$vt_codRef6:=ACTabc_GetFieldWithFormat (vQR_Text4+vQR_Text3;"A";12)
				$vt_dec7:=ACTabc_GetFieldWithFormat (vQR_Text1;"A";40)
				$vt_Obs8:=ACTabc_GetFieldWithFormat (" ";"A";60)
				$vt_indicador9:=ACTabc_GetFieldWithFormat ("0";"N";1)
				
				APPEND TO ARRAY:C911(aQR_Text2;$vt_numrecibo1)
				APPEND TO ARRAY:C911(aQR_Text3;$vt_codInteg2)
				APPEND TO ARRAY:C911(aQR_Text4;$vt_fEmision3)
				APPEND TO ARRAY:C911(aQR_Text5;$vt_fVencimiento4)
				APPEND TO ARRAY:C911(aQR_Text6;$vt_moneda5)
				APPEND TO ARRAY:C911(aQR_Text7;$vt_codRef6)
				APPEND TO ARRAY:C911(aQR_Text8;$vt_dec7)
				APPEND TO ARRAY:C911(aQR_Text9;$vt_Obs8)
				APPEND TO ARRAY:C911(aQR_Text10;$vt_indicador9)
				APPEND TO ARRAY:C911(aQR_Text11;"")
				
				For (vQR_Long3;1;6)
					If (vQR_Long3=1)
						Case of 
							: ([ACT_Cargos:173]Glosa:12="Pensi@")
								vQR_Text2:="01"
							: ([ACT_Cargos:173]Glosa:12="Matricula@")
								vQR_Text2:="01"
							Else 
								vQR_Text2:="02"
						End case 
						vQR_Text5:=""
						vQR_Text6:=""
						If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
							vQR_Real1:=Abs:C99([ACT_Cargos:173]Saldo:23)
						Else 
							vQR_Real1:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
						End if 
						ACTio_Num2Vars (vQR_Real1;8;2;->vQR_Text5;->vQR_Text6)
						aQR_Text11{Size of array:C274(aQR_Text11)}:=aQR_Text11{Size of array:C274(aQR_Text11)}+vQR_Text2+ACTabc_GetFieldWithFormat (String:C10(Num:C11(vQR_Text5));"N";8;" ";"R")+vQR_Text6
					Else 
						vQR_Real1:=0
						vQR_Text2:="00"
						ACTio_Num2Vars (vQR_Real1;8;2;->vQR_Text5;->vQR_Text6)
						aQR_Text11{Size of array:C274(aQR_Text11)}:=aQR_Text11{Size of array:C274(aQR_Text11)}+vQR_Text2+ACTabc_GetFieldWithFormat (String:C10(Num:C11(vQR_Text5));"N";8)+vQR_Text6
					End if 
					vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Num:C11(vQR_Text5+<>tXS_RS_DecimalSeparator+vQR_Text6))
				End for 
				
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;vQR_Long2/Size of array:C274(aQR_Longint3);"Recopilando datos...")
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		ARRAY TEXT:C222(aQR_Text12;0)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando archivo...")
		For (vQR_Long2;1;Size of array:C274(aQR_Text2))
			If (Find in array:C230(aQR_Text12;aQR_Text2{vQR_Long2})=-1)
				APPEND TO ARRAY:C911(aQR_Text12;aQR_Text2{vQR_Long2})
				vQR_Real3:=0
				vQR_Text7:=Substring:C12(aQR_Text11{vQR_Long2};1;2)
				vQR_Text10:=Substring:C12(aQR_Text11{vQR_Long2};13)
				aQR_Text2{0}:=aQR_Text2{vQR_Long2}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aQR_Text2;"";->$DA_Return)
				For (vQR_Long3;1;Size of array:C274($DA_Return))
					vQR_Text8:=Substring:C12(aQR_Text11{$DA_Return{vQR_Long3}};3;10)
					vQR_Real3:=vQR_Real3+Num:C11(vQR_Text8)
				End for 
				vQR_Text9:=vQR_Text7+ACTabc_GetFieldWithFormat (String:C10(vQR_Real3);"N";10;" ";"R")+vQR_Text10
				
				$text:=aQR_Text2{vQR_Long2}+aQR_Text3{vQR_Long2}+aQR_Text4{vQR_Long2}+aQR_Text5{vQR_Long2}+aQR_Text6{vQR_Long2}+aQR_Text7{vQR_Long2}+aQR_Text8{vQR_Long2}+aQR_Text9{vQR_Long2}+aQR_Text10{vQR_Long2}+vQR_Text9+"\r"
				IO_SendPacket ($ref;$text)
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;vQR_Long2/Size of array:C274(aQR_Text2);"Generando archivo...")
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT_Pagos")
		
		CLOSE DOCUMENT:C267($ref)
		CLEAR SET:C117("AvisosTodos")
		CLEAR SET:C117("selectionApdo")
	End if 
Else 
	vb_detenerImp:=True:C214
End if 

