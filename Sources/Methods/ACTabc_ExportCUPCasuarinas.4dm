//%attributes = {}
  //ACTabc_ExportCUPCasuarinas

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
  //IB
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total;$vl_noCuotas)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Personas:7])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""


ARRAY TEXT:C222(aQR_Text4;0)
ARRAY TEXT:C222(aQR_Text5;0)
ARRAY TEXT:C222(aQR_Text6;0)
ARRAY TEXT:C222(aQR_Text7;0)
ARRAY TEXT:C222(aQR_Text8;0)
ARRAY TEXT:C222(aQR_Text9;0)
ARRAY TEXT:C222(aQR_Text10;0)
ARRAY TEXT:C222(aQR_Text11;0)
ARRAY TEXT:C222(aQR_Text12;0)
ARRAY TEXT:C222(aQR_Text13;0)
ARRAY TEXT:C222(aQR_Text14;0)
ARRAY TEXT:C222(aQR_Text15;0)
ARRAY TEXT:C222(aQR_Text16;0)
ARRAY TEXT:C222(aQR_Text17;0)
ARRAY TEXT:C222(aQR_Text18;0)
ARRAY TEXT:C222(aQR_Text19;0)
ARRAY TEXT:C222(aQR_Text20;0)
ARRAY TEXT:C222(aQR_Text21;0)
ARRAY TEXT:C222(aQR_Text22;0)
ARRAY TEXT:C222(aQR_Text23;0)
ARRAY TEXT:C222(aQR_Text24;0)
ARRAY TEXT:C222(aQR_Text25;0)
ARRAY TEXT:C222(aQR_Text26;0)

ARRAY TEXT:C222(aMeses;0)
COPY ARRAY:C226(<>atXS_MonthNames;aMeses)

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	
	USE SET:C118("AvisosTodos")
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	ARRAY TEXT:C222(aQR_Text1;0)
	ARRAY TEXT:C222(aQR_Text2;0)
	ARRAY TEXT:C222(aQR_Text3;0)
	
	KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	
	If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
	End if 
	
	READ ONLY:C145([xxACT_ItemsCategorias:98])
	QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Nombre:1="Pensi@")
	If (Records in selection:C76([xxACT_ItemsCategorias:98])=1)
		ARRAY LONGINT:C221(aQR_Longint5;0)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=[xxACT_ItemsCategorias:98]ID:2)
		SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;aQR_Longint5)
		
		CREATE SET:C116([ACT_Cargos:173];"setCargos1")
		  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Glosa="Pensi@")
		QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint5;True:C214)
		CREATE SET:C116([ACT_Cargos:173];"setCargos2")
		DIFFERENCE:C122("setCargos1";"setCargos2";"setCargos1")
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;aQR_Longint1;[ACT_Cargos:173]Año:14;aQR_Longint2;[ACT_Cargos:173]Ref_Item:16;aQR_Longint3)
		For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
			  //vQR_Text1:=String(aQR_Longint2{vQR_Long1})+String(aQR_Longint1{vQR_Long1};"00")+ACTabc_GetFieldWithFormat (String(aQR_Longint3{vQR_Long1});"N";4)
			vQR_Text1:=String:C10(aQR_Longint2{vQR_Long1})+String:C10(aQR_Longint1{vQR_Long1};"00")+ACTabc_GetFieldWithFormat ("2345";"N";4)
			If (Find in array:C230(aQR_Text1;vQR_Text1)=-1)
				APPEND TO ARRAY:C911(aQR_Text1;vQR_Text1)
			End if 
		End for 
		
		For (vQR_Long1;1;Size of array:C274(aQR_Text1))
			APPEND TO ARRAY:C911(aQR_Text2;Substring:C12(aQR_Text1{vQR_Long1};7)+Substring:C12(aQR_Text1{vQR_Long1};3;2)+Substring:C12(aQR_Text1{vQR_Long1};5;2))
			APPEND TO ARRAY:C911(aQR_Text3;"PENS."+ST_Uppercase (Substring:C12(aMeses{Num:C11(Substring:C12(aQR_Text1{vQR_Long1};5;2))};1;5)))
		End for 
		
		ARRAY TEXT:C222(aQR_Text1;0)
		USE SET:C118("setCargos1")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="Matricula@")
		CREATE SET:C116([ACT_Cargos:173];"setCargos2")
		DIFFERENCE:C122("setCargos1";"setCargos2";"setCargos1")
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;aQR_Longint1;[ACT_Cargos:173]Año:14;aQR_Longint2;[ACT_Cargos:173]Ref_Item:16;aQR_Longint3)
		For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
			vQR_Text1:=String:C10(aQR_Longint2{vQR_Long1})+String:C10(aQR_Longint1{vQR_Long1};"00")+ACTabc_GetFieldWithFormat (String:C10(aQR_Longint3{vQR_Long1});"N";4)
			If (Find in array:C230(aQR_Text1;vQR_Text1)=-1)
				APPEND TO ARRAY:C911(aQR_Text1;vQR_Text1)
			End if 
		End for 
		
		For (vQR_Long1;1;Size of array:C274(aQR_Text1))
			APPEND TO ARRAY:C911(aQR_Text2;Substring:C12(aQR_Text1{vQR_Long1};7)+Substring:C12(aQR_Text1{vQR_Long1};3;2)+Substring:C12(aQR_Text1{vQR_Long1};5;2))
			APPEND TO ARRAY:C911(aQR_Text3;"MATR."+ST_Uppercase (Substring:C12(aMeses{Num:C11(Substring:C12(aQR_Text1{vQR_Long1};5;2))};1;5)))
		End for 
		
		ARRAY TEXT:C222(aQR_Text1;0)
		USE SET:C118("setCargos1")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="BL@")
		CREATE SET:C116([ACT_Cargos:173];"setCargos2")
		DIFFERENCE:C122("setCargos1";"setCargos2";"setCargos1")
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;aQR_Longint1;[ACT_Cargos:173]Año:14;aQR_Longint2;[ACT_Cargos:173]Ref_Item:16;aQR_Longint3)
		For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
			vQR_Text1:=String:C10(aQR_Longint2{vQR_Long1})+String:C10(aQR_Longint1{vQR_Long1};"00")+ACTabc_GetFieldWithFormat (String:C10(aQR_Longint3{vQR_Long1});"N";4)
			If (Find in array:C230(aQR_Text1;vQR_Text1)=-1)
				APPEND TO ARRAY:C911(aQR_Text1;vQR_Text1)
			End if 
		End for 
		
		For (vQR_Long1;1;Size of array:C274(aQR_Text1))
			APPEND TO ARRAY:C911(aQR_Text2;Substring:C12(aQR_Text1{vQR_Long1};7)+Substring:C12(aQR_Text1{vQR_Long1};3;2)+Substring:C12(aQR_Text1{vQR_Long1};5;2))
			APPEND TO ARRAY:C911(aQR_Text3;"BL-A.."+ST_Uppercase (Substring:C12(aMeses{Num:C11(Substring:C12(aQR_Text1{vQR_Long1};5;2))};1;5)))
		End for 
		
		ARRAY TEXT:C222(aQR_Text1;0)
		USE SET:C118("setCargos1")
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Mes:13;aQR_Longint1;[ACT_Cargos:173]Año:14;aQR_Longint2;[ACT_Cargos:173]Ref_Item:16;aQR_Longint3)
		
		For (vQR_Long1;1;Size of array:C274(aQR_Longint1))
			If (aQR_Longint3{vQR_Long1}=-100)
				aQR_Longint3{vQR_Long1}:=3456
			End if 
			vQR_Text1:=String:C10(aQR_Longint2{vQR_Long1})+String:C10(aQR_Longint1{vQR_Long1};"00")+ACTabc_GetFieldWithFormat (String:C10(aQR_Longint3{vQR_Long1});"N";4)
			If (Find in array:C230(aQR_Text1;vQR_Text1)=-1)
				APPEND TO ARRAY:C911(aQR_Text1;vQR_Text1)
			End if 
		End for 
		
		For (vQR_Long1;1;Size of array:C274(aQR_Text1))
			APPEND TO ARRAY:C911(aQR_Text2;Substring:C12(aQR_Text1{vQR_Long1};7)+Substring:C12(aQR_Text1{vQR_Long1};3;2)+Substring:C12(aQR_Text1{vQR_Long1};5;2))
			APPEND TO ARRAY:C911(aQR_Text3;"GV-M."+ST_Uppercase (Substring:C12(aMeses{Num:C11(Substring:C12(aQR_Text1{vQR_Long1};5;2))};1;5)))
		End for 
		
		CLEAR SET:C117("setCargos1")
		CLEAR SET:C117("setCargos2")
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Recopilando información...")
		ARRAY LONGINT:C221(aQR_Longint3;0)
		USE SET:C118("AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];aQR_Longint3;"")
		For (vQR_Long2;1;Size of array:C274(aQR_Longint3))
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];aQR_Longint3{vQR_Long2})
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			ARRAY LONGINT:C221(aQR_Longint4;0)
			If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			End if 
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint4;"")
			For (vQR_Long3;1;Size of array:C274(aQR_Longint4))
				GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint4{vQR_Long3})
				  //Case of 
				  //: ([ACT_Cargos]Glosa="Pensi@")
				  //vQR_Text1:="0011"
				  //: ([ACT_Cargos]Glosa="Matricula@")
				  //vQR_Text1:="0022"
				  //: ([ACT_Cargos]Glosa="BL@")
				  //vQR_Text1:="0006"
				  //Else 
				  //vQR_Text1:="0003"
				  //End case 
				Case of 
					: ([ACT_Cargos:173]Glosa:12="Pensi@")
						vQR_Text1:="2345"
					: ([ACT_Cargos:173]Ref_Item:16=-100)
						vQR_Text1:="3456"
					Else 
						vQR_Text1:=String:C10([ACT_Cargos:173]Ref_Item:16)
				End case 
				
				vQR_Text1:=ACTabc_GetFieldWithFormat (vQR_Text1;"N";4)
				vQR_Text1:=vQR_Text1+Substring:C12(String:C10([ACT_Cargos:173]Año:14);3;2)+String:C10([ACT_Cargos:173]Mes:13;"00")
				vQR_Long5:=Find in array:C230(aQR_Text2;vQR_Text1)
				
				APPEND TO ARRAY:C911(aQR_Text4;ACTabc_GetFieldWithFormat ("13";"N";2))
				APPEND TO ARRAY:C911(aQR_Text5;ACTabc_GetFieldWithFormat ([ACT_CuentasCorrientes:175]Codigo:19;"A";20))
				APPEND TO ARRAY:C911(aQR_Text6;ACTabc_GetFieldWithFormat (aQR_Text2{vQR_Long5};"A";8))
				APPEND TO ARRAY:C911(aQR_Text7;ACTabc_GetFieldWithFormat ([Alumnos:2]apellidos_y_nombres:40;"A";30))
				APPEND TO ARRAY:C911(aQR_Text8;ACTabc_GetFieldWithFormat (aQR_Text3{vQR_Long5};"A";10))
				APPEND TO ARRAY:C911(aQR_Text9;ACTabc_GetFieldWithFormat (" ";"A";10))
				APPEND TO ARRAY:C911(aQR_Text10;ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Cargos:173]FechaEmision:22))+String:C10(Month of:C24([ACT_Cargos:173]FechaEmision:22);"00")+String:C10(Day of:C23([ACT_Cargos:173]FechaEmision:22);"00");"N";8))
				APPEND TO ARRAY:C911(aQR_Text11;ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7))+String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00");"N";8))
				APPEND TO ARRAY:C911(aQR_Text12;ACTabc_GetFieldWithFormat (" ";"A";15))
				APPEND TO ARRAY:C911(aQR_Text13;ACTabc_GetFieldWithFormat ("01";"A";2))
				
				vQR_Text2:=""
				vQR_Text3:=""
				If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14))
					ACTio_Num2Vars (Abs:C99([ACT_Cargos:173]Saldo:23);7;2;->vQR_Text2;->vQR_Text3)
				Else 
					ACTio_Num2Vars (Abs:C99([ACT_Cargos:173]Monto_Neto:5);7;2;->vQR_Text2;->vQR_Text3)
				End if 
				APPEND TO ARRAY:C911(aQR_Text14;ACTabc_GetFieldWithFormat (vQR_Text2+vQR_Text3;"N";9))
				APPEND TO ARRAY:C911(aQR_Text15;ACTabc_GetFieldWithFormat ("0";"N";9))
				APPEND TO ARRAY:C911(aQR_Text16;ACTabc_GetFieldWithFormat ("0";"N";9))
				APPEND TO ARRAY:C911(aQR_Text17;ACTabc_GetFieldWithFormat ("0";"N";9))
				APPEND TO ARRAY:C911(aQR_Text18;ACTabc_GetFieldWithFormat ("0";"N";9))
				APPEND TO ARRAY:C911(aQR_Text19;ACTabc_GetFieldWithFormat ("0";"N";9))
				APPEND TO ARRAY:C911(aQR_Text20;ACTabc_GetFieldWithFormat ("0";"N";9))
				APPEND TO ARRAY:C911(aQR_Text21;ACTabc_GetFieldWithFormat (" ";"A";2))
				APPEND TO ARRAY:C911(aQR_Text22;ACTabc_GetFieldWithFormat ("A";"A";1))
				APPEND TO ARRAY:C911(aQR_Text23;ACTabc_GetFieldWithFormat (" ";"A";13))
				APPEND TO ARRAY:C911(aQR_Text24;ACTabc_GetFieldWithFormat ("0";"N";8))
				
				APPEND TO ARRAY:C911(aQR_Text26;aQR_Text5{Size of array:C274(aQR_Text5)}+aQR_Text6{Size of array:C274(aQR_Text6)})
				
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Num:C11(Substring:C12(aQR_Text14{Size of array:C274(aQR_Text14)};1;7)+<>tXS_RS_DecimalSeparator+Substring:C12(aQR_Text14{Size of array:C274(aQR_Text14)};8;2)))
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;vQR_Long2/Size of array:C274(aQR_Longint3);"Recopilando información...")
		End for 
		
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando información...")
		C_TEXT:C284($vt_tiporegistro1;$vt_codigoGrupo2;$vt_codUnico;$vt_codRubro4;$vt_codEmpresa5;$vt_codServ6;$vt_codReq7;$vt_codSol8;$vt_descSol9;$vt_canalEnv10;$vt_tipoInf11;$vt_numReg12;$vt_importeS13;$vt_importeD14;$vt_fechaPr15;$vt_libre16;$vt_codFijo17)
		$vt_tiporegistro1:=ACTabc_GetFieldWithFormat ("11";"N";2)
		$vt_codigoGrupo2:=ACTabc_GetFieldWithFormat ("21";"N";2)
		$vt_codUnico:=ACTabc_GetFieldWithFormat ("0008370903";"N";10)
		$vt_codRubro4:=ACTabc_GetFieldWithFormat ("04";"N";2)
		$vt_codEmpresa5:=ACTabc_GetFieldWithFormat ("153";"N";3)
		$vt_codServ6:=ACTabc_GetFieldWithFormat ("01";"N";2)
		$vt_codReq7:=ACTabc_GetFieldWithFormat ("002";"N";3)
		$vt_codSol8:=ACTabc_GetFieldWithFormat ("01";"N";2)
		$vt_descSol9:=ACTabc_GetFieldWithFormat ("COBRO OBLIGACIONES 2009";"A";30)
		$vt_canalEnv10:=ACTabc_GetFieldWithFormat ("1";"N";1)
		$vt_tipoInf11:=ACTabc_GetFieldWithFormat ("M";"A";1)
		$vt_numReg12:=ACTabc_GetFieldWithFormat (vnumTransCUP;"N";8)
		vQR_Text2:=""
		vQR_Text3:=""
		ACTio_Num2Vars (Num:C11(vtotalCUP);13;2;->vQR_Text2;->vQR_Text3)
		$vt_importeS13:=ACTabc_GetFieldWithFormat (vQR_Text2+vQR_Text3;"N";15)
		$vt_importeD14:=ACTabc_GetFieldWithFormat ("0";"N";15)
		$vt_fechaPr15:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00");"A";8)
		$vt_libre16:=ACTabc_GetFieldWithFormat (" ";"A";88)
		$vt_codFijo17:=ACTabc_GetFieldWithFormat ("0";"N";8)
		
		$text:=$vt_tiporegistro1+$vt_codigoGrupo2+$vt_codUnico+$vt_codRubro4+$vt_codEmpresa5+$vt_codServ6+$vt_codReq7+$vt_codSol8+$vt_descSol9+$vt_canalEnv10+$vt_tipoInf11+$vt_numReg12+$vt_importeS13+$vt_importeD14+$vt_fechaPr15+$vt_libre16+$vt_codFijo17+"\r"
		IO_SendPacket ($ref;$text)
		
		vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT_Pagos")
		
		C_TEXT:C284($vt_tipReg1;$vt_codCuota2;$vt_numConc3;$vt_descConc4;$vt_descConc5;$vt_descConc6;$vt_descConc7;$vt_descConc8;$vt_descConc9;$vt_descConc10;$vt_descConc11;$vt_descConc12)
		
		For (vQR_Long1;1;Size of array:C274(aQR_Text2))
			$vt_tipReg1:=ACTabc_GetFieldWithFormat ("12";"N";2)
			$vt_codCuota2:=ACTabc_GetFieldWithFormat (aQR_Text2{vQR_Long1};"N";8)
			$vt_numConc3:=ACTabc_GetFieldWithFormat ("1";"N";1)
			$vt_descConc4:=ACTabc_GetFieldWithFormat (aQR_Text3{vQR_Long1};"A";10)
			$vt_descConc5:=ACTabc_GetFieldWithFormat (" ";"A";10)
			$vt_descConc6:=ACTabc_GetFieldWithFormat (" ";"A";10)
			$vt_descConc7:=ACTabc_GetFieldWithFormat (" ";"A";10)
			$vt_descConc8:=ACTabc_GetFieldWithFormat (" ";"A";10)
			$vt_descConc9:=ACTabc_GetFieldWithFormat (" ";"A";10)
			$vt_descConc10:=ACTabc_GetFieldWithFormat (" ";"A";10)
			$vt_descConc11:=ACTabc_GetFieldWithFormat (" ";"A";111)
			$vt_descConc12:=ACTabc_GetFieldWithFormat ("0";"N";8)
			$text:=$vt_tipReg1+$vt_codCuota2+$vt_numConc3+$vt_descConc4+$vt_descConc5+$vt_descConc6+$vt_descConc7+$vt_descConc8+$vt_descConc9+$vt_descConc10+$vt_descConc11+$vt_descConc12+"\r"
			IO_SendPacket ($ref;$text)
		End for 
		
		C_TEXT:C284($vt_tipoRegi1;$vt_codDeudor2;$vt_codDeudor3;$vt_nomDeudor4;$vt_ref5;$vt_ref6;$vt_fechaEmision7;$vt_fechaVenc8;$vt_numDcto9;$vt_moneda10;$vt_importe11;$vt_importe12;$vt_importe13;$vt_importe14;$vt_importe15;$vt_importe16;$vt_importe17;$vt_libre18;$vt_tipoOp19;$vt_libre20;$vt_codFijo21)
		ARRAY TEXT:C222(aQR_Text25;0)
		For (vQR_Long1;1;Size of array:C274(aQR_Text26))
			vQR_Text4:=""
			If (Find in array:C230(aQR_Text25;aQR_Text26{vQR_Long1})=-1)
				APPEND TO ARRAY:C911(aQR_Text25;aQR_Text26{vQR_Long1})
				aQR_Text26{0}:=aQR_Text26{vQR_Long1}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aQR_Text26;"=";->$DA_Return)
				For (vQR_Long2;1;Size of array:C274($DA_Return))
					vQR_Text4:=String:C10(Num:C11(vQR_Text4)+Num:C11(aQR_Text14{$DA_Return{vQR_Long2}}))
				End for 
				vQR_Text4:=ACTabc_GetFieldWithFormat (vQR_Text4;"N";9)
				
				$vt_tipoRegi1:=aQR_Text4{vQR_Long1}
				$vt_codDeudor2:=aQR_Text5{vQR_Long1}
				$vt_codDeudor3:=aQR_Text6{vQR_Long1}
				$vt_nomDeudor4:=aQR_Text7{vQR_Long1}
				$vt_ref5:=aQR_Text8{vQR_Long1}
				$vt_ref6:=aQR_Text9{vQR_Long1}
				$vt_fechaEmision7:=aQR_Text10{vQR_Long1}
				$vt_fechaVenc8:=aQR_Text11{vQR_Long1}
				$vt_numDcto9:=aQR_Text12{vQR_Long1}
				$vt_moneda10:=aQR_Text13{vQR_Long1}
				$vt_importe11:=vQR_Text4
				$vt_importe12:=aQR_Text15{vQR_Long1}
				$vt_importe13:=aQR_Text16{vQR_Long1}
				$vt_importe14:=aQR_Text17{vQR_Long1}
				$vt_importe15:=aQR_Text18{vQR_Long1}
				$vt_importe16:=aQR_Text19{vQR_Long1}
				$vt_importe17:=aQR_Text20{vQR_Long1}
				$vt_libre18:=aQR_Text21{vQR_Long1}
				$vt_tipoOp19:=aQR_Text22{vQR_Long1}
				$vt_libre20:=aQR_Text23{vQR_Long1}
				$vt_codFijo21:=aQR_Text24{vQR_Long1}
				
				$text:=$vt_tipoRegi1+$vt_codDeudor2+$vt_codDeudor3+$vt_nomDeudor4+$vt_ref5+$vt_ref6+$vt_fechaEmision7+$vt_fechaVenc8+$vt_numDcto9+$vt_moneda10+$vt_importe11+$vt_importe12+$vt_importe13+$vt_importe14+$vt_importe15+$vt_importe16+$vt_importe17+$vt_libre18+$vt_tipoOp19+$vt_libre20+$vt_codFijo21+"\r"
				IO_SendPacket ($ref;$text)
				
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;vQR_Long1/Size of array:C274(aQR_Text26);"Exportando información...")
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		vb_detenerImp:=True:C214
	End if 
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
Else 
	vb_detenerImp:=True:C214
End if 