//%attributes = {}
  //ACTabc_ExportCUPWenlock

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$filePath;$fecha;$vt_fVencimiento)
C_LONGINT:C283($vl_noCuotas)
C_POINTER:C301(vQR_Pointer1)
C_TEXT:C284($vt_montoCuota)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_DATE:C307($vd_vencimientoAviso)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Cargos:173])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
NIV_LoadArrays 
If ($ref#?00:00:00?)
	
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	
	  //ordena ids de apoderados por curso de los alumnos
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
	  //KRL_RelateSelection (->[Alumnos]Apoderado_Cuentas_Nœmero;->[Personas]No;"")
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
	QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
	QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)};*)
	QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>=<>al_NumeroNivelRegular{1})
	ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	ARRAY LONGINT:C221(aQR_Longint4;0)
	SELECTION TO ARRAY:C260([Alumnos:2]Apoderado_Cuentas_Número:28;aQR_Longint3)
	For (vQR_Long1;1;Size of array:C274(aQR_Longint3))
		If (Find in array:C230(aQR_Longint4;aQR_Longint3{vQR_Long1})=-1)
			APPEND TO ARRAY:C911(aQR_Longint4;aQR_Longint3{vQR_Long1})
		End if 
	End for 
	
	C_TEXT:C284($vt_monedaEmision)
	$vt_monedaEmision:=<>vsACT_MonedaColegio
	
	If (vl_otrasMonedas=1)
		<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
	Else 
		<>vsACT_MonedaColegio:="UF"
	End if 
	
	C_LONGINT:C283($vl_noAvisos)
	$vl_noAvisos:=Records in set:C195("AvisosTodos")
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportanto cuponera...")
	C_LONGINT:C283($i)
	For ($i;1;Size of array:C274(aQR_Longint4))
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=aQR_Longint4{$i})
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionCta")
			DIFFERENCE:C122("AvisosTodos";"selectionCta";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisosApdo")
				$fecha:=String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"0000")+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")
				$vt_fVencimiento:="00"
				$vd_vencimientoAviso:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
				Case of 
					: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (5;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
						$vt_fVencimiento:="00"
					: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (10;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
						$vt_fVencimiento:="01"
					: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (15;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
						$vt_fVencimiento:="02"
					: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (20;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
						$vt_fVencimiento:="03"
					: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (25;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
						$vt_fVencimiento:="04"
					: ($vd_vencimientoAviso<DT_GetDateFromDayMonthYear (30;Month of:C24($vd_vencimientoAviso);Year of:C25($vd_vencimientoAviso)))
						$vt_fVencimiento:="05"
					Else   //30
						$vt_fVencimiento:="06"
				End case 
				
				REDUCE SELECTION:C351([Personas:7];0)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				  //KRL_FindAndLoadRecordByIndex (->[Alumnos]Apoderado_Cuentas_Nœmero;->[Personas]No)
				KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
				QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)};*)
				QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>=<>al_NumeroNivelRegular{1})
				ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
				QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
				
				C_TEXT:C284($vt_CodFamilia;$vt_nombreFamilia)
				$vt_CodFamilia:=ACTabc_GetFieldWithFormat ([Familia:78]Codigo_interno:14;"N";6)
				$vt_nombreFamilia:=ACTabc_GetFieldWithFormat ([Familia:78]Nombre_de_la_familia:3;"A";40)
				
				C_LONGINT:C283(vQR_Long2)
				vQR_Long2:=2
				
				ARRAY REAL:C219(aQR_Real1;0)
				ARRAY LONGINT:C221(aQR_Longint1;0)
				
				ARRAY LONGINT:C221(aQR_Longint2;0)
				ARRAY INTEGER:C220(aQR_Integer1;0)
				ARRAY TEXT:C222(aQR_Text1;0)
				ARRAY DATE:C224(aQR_Date1;0)
				ARRAY DATE:C224(aQR_Date2;0)
				$vl_noCuotas:=ACTabc_ObtieneMesesYAdeudado ("avisosApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2;->vQR_Long2)
				For (vQR_Long1;1;$vl_noCuotas)
					vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
					vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Abs:C99(aQR_Real1{vQR_Long1}))
					  //$vt_montoCuota:=String(aQR_Real1{vQR_Long1})
					ACTio_Num2Vars (aQR_Real1{vQR_Long1};7;2;->vQR_Text1;->vQR_Text2)
					$vt_montoCuota:=vQR_Text1+<>tXS_RS_DecimalSeparator+vQR_Text2
					$vt_montoCuota:=Replace string:C233($vt_montoCuota;<>tXS_RS_DecimalSeparator;".")
					$vt_montoCuota:=Replace string:C233($vt_montoCuota;<>tXS_RS_DecimalSeparator;".")
					$text:=$vt_CodFamilia+ST_LeftChars (ST_Uppercase ([Personas:7]Apellidos_y_nombres:30)+(" "*40);40)+" "+ST_RigthChars (("0"*9)+[Personas:7]RUT:6;9)+" "+$vt_fVencimiento+" "+ST_RigthChars ("00"+String:C10(vQR_Long1);2)+" "+"01"+" "+ST_RigthChars (("0"*10)+$vt_montoCuota;10)+" "+ST_LeftChars (ST_Uppercase ([Personas:7]ACT_DireccionEC:67)+(" "*40);40)+ST_LeftChars (ST_Uppercase ([Alumnos:2]curso:20)+(" "*6);6)+" "+$vt_nombreFamilia+"\r"
					IO_SendPacket ($ref;$text)
				End for 
				CLEAR SET:C117("avisosApdo")
			End if 
			CLEAR SET:C117("selectionCta")
			USE SET:C118("AvisosTodos")
		End if 
		USE SET:C118("AvisosTodos")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_noAvisos-Records in set:C195("AvisosTodos"))/$vl_noAvisos)
	End for 
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	<>vsACT_MonedaColegio:=$vt_monedaEmision
	
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
Else 
	vb_detenerImp:=True:C214
End if 