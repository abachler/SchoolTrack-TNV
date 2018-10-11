//%attributes = {}
  // Método: ACTabc_ExportCUPStaTeresita3
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 16-04-10, 19:12:22
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
  //ACTabc_ExportCUPStaTeresita3

  //BBVA
C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!

vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_TEXT:C284($vt_rutApoderado;$vt_noCuota;$vt_nombreDeudor;$vt_fechaVencimiento;$vt_moneda;$vt_montoTotal;$vt_numeroCuota;$vt_descripcion)

C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_noCuotas;vQR_Long1;$vl_total)
$fileName:=$1
$fileName:="RC329"+Substring:C12(DTS_MakeFromDateTime ;1;8)
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	C_TEXT:C284($vt_tipoReg_1;$vt_rucEmpresa2;$vt_codClase3;$vt_tipoMoneda4;$vt_fechaGenArchivos5;$vt_numRefDeInfo6;$vt_vacio7)
	
	$vt_tipoReg_1:=ACTabc_GetFieldWithFormat ("01";"N";2)
	$vt_rucEmpresa2:=ACTabc_GetFieldWithFormat ("20137973589";"N";11)
	$vt_codClase3:=ACTabc_GetFieldWithFormat ("329";"N";3)
	$vt_tipoMoneda4:=ACTabc_GetFieldWithFormat ("PEN";"N";3)
	$vt_fechaGenArchivos5:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(Current date:C33(*)))+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00");"N";8)
	$vt_numRefDeInfo6:=ACTabc_GetFieldWithFormat ("0";"N";3)
	$vt_vacio7:=ACTabc_GetFieldWithFormat (" ";"A";330)
	
	$text:=$vt_tipoReg_1+$vt_rucEmpresa2+$vt_codClase3+$vt_tipoMoneda4+$vt_fechaGenArchivos5+$vt_numRefDeInfo6+$vt_vacio7+"\r"
	IO_SendPacket ($ref;$text)
	
	
	C_TEXT:C284($vt_tipoRegistro1;$vt_nombreCliente2;$vt_referencia3;$vt_fechaV4;$vt_fechaBloqueo5;$vt_periodosFacturados6;$vt_importeMax7;$vt_importeMin8;$vt_infoAdic9;$vt_codSubConcepto10;$vt_valorSubConcepto11;$vt_codSubConcepto12;$vt_valorSubConcepto13;$vt_codSubConcepto14;$vt_valorSubConcepto15;$vt_codSubConcepto16;$vt_valorSubConcepto17;$vt_codSubConcepto18;$vt_valorSubConcepto19;$vt_codSubConcepto20;$vt_valorSubConcepto21;$vt_codSubConcepto22;$vt_valorSubConcepto23;$vt_codSubConcepto24;$vt_valorSubConcepto25;$vt_numCta26;$vt_tipoIde27;$vt_numIde28;$vt_vacio29)
	
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	
	ARRAY LONGINT:C221(aQR_Longint1;0)
	LOC_LoadList2Array ("XS_Meses";->aQR_Text4)
	
	C_TEXT:C284($set)
	C_LONGINT:C283($i;$vl_idCta;$j;$vl_year;$vl_mes)
	C_REAL:C285($vr_monto)
	C_TEXT:C284($vQR_Text1;$vQR_Text2)
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	C_POINTER:C301(vQR_Pointer1)
	If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
		vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
	Else 
		vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
	End if 
	
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	ARRAY LONGINT:C221(aQR_Longint4;0)
	ARRAY LONGINT:C221(aQR_Longint5;0)
	ARRAY LONGINT:C221(aQR_Longint6;0)
	
	KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
	SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Apoderado:11;aQR_Longint2;[ACT_Transacciones:178]ID_CuentaCorriente:2;aQR_Longint3)
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aQR_Longint4;[ACT_CuentasCorrientes:175]ID_Alumno:3;aQR_Longint5)
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
	ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
	SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aQR_Longint6)
	AT_OrderArraysByArray (MAXLONG:K35:2;->aQR_Longint6;->aQR_Longint5;->aQR_Longint4)
	AT_OrderArraysByArray (MAXLONG:K35:2;->aQR_Longint4;->aQR_Longint3;->aQR_Longint2)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	C_LONGINT:C283($x)
	For ($x;1;Size of array:C274(aQR_Longint2))
		USE SET:C118("AvisosTodos")
		
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=aQR_Longint2{$x})
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_CuentaCorriente:2#0)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"$setCargos")
			AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_CuentaCorriente:2;->aQR_Longint1)
			
			QUERY WITH ARRAY:C644([ACT_CuentasCorrientes:175]ID:1;aQR_Longint1)
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aQR_Longint4;[ACT_CuentasCorrientes:175]ID_Alumno:3;aQR_Longint5)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aQR_Longint6)
			AT_OrderArraysByArray (MAXLONG:K35:2;->aQR_Longint6;->aQR_Longint5;->aQR_Longint1)
			
			ARRAY TEXT:C222(aQR_Text1;0)
			While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
				APPEND TO ARRAY:C911(aQR_Text1;String:C10([ACT_Avisos_de_Cobranza:124]Agno:7)+String:C10([ACT_Avisos_de_Cobranza:124]Mes:6;"00"))
				NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
			End while 
			AT_DistinctsArrayValues (->aQR_Text1)
			
			For ($i;1;Size of array:C274(aQR_Longint1))
				$vl_idCta:=aQR_Longint1{$i}
				KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta)
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				
				For ($j;1;Size of array:C274(aQR_Text1))
					$vl_year:=Num:C11(Substring:C12(aQR_Text1{$j};1;4))
					$vl_mes:=Num:C11(Substring:C12(aQR_Text1{$j};5;2))
					
					USE SET:C118("selectionApdo")
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=$vl_year;*)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6=$vl_mes)
					
					USE SET:C118("$setCargos")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=$vl_year;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$vl_mes)
					$set:="setCargos"
					CREATE SET:C116([ACT_Cargos:173];$set)
					$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$set;vQR_Pointer1;vd_FechaUF))
					If ($vr_monto>0)
						vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
						vtotalCUP:=String:C10(Num:C11(vtotalCUP)+$vr_monto)
						
						$vt_tipoRegistro1:=ACTabc_GetFieldWithFormat ("02";"N";2)
						$vt_nombreCliente2:=ACTabc_GetFieldWithFormat (ST_Uppercase ([Alumnos:2]apellidos_y_nombres:40);"A";30)
						$vt_referencia3:=ST_Uppercase (ACTabc_GetFieldWithFormat (ACTabc_GetFieldWithFormat ([Alumnos:2]IDNacional_2:71;"N";10)+aQR_Text4{$vl_mes}+ACTabc_GetFieldWithFormat (" ";"A";3)+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Nivel:1);"A";48))
						$vt_fechaV4:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5))+String:C10(Month of:C24([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00")+String:C10(Day of:C23([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5);"00");"N";8)
						$vt_fechaBloqueo5:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5))+"12"+"31";"N";8)
						$vt_periodosFacturados6:=ACTabc_GetFieldWithFormat ("0";"N";2)
						
						ACTio_Num2Vars ($vr_monto;13;2;->$vQR_Text1;->$vQR_Text2)
						$vt_importeMax7:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";15)
						$vt_importeMin8:=$vt_importeMax7
						$vt_infoAdic9:=ACTabc_GetFieldWithFormat ("0";"N";32)
						$vt_codSubConcepto10:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto11:=ACTabc_GetFieldWithFormat ("0";"N";14)
						$vt_codSubConcepto12:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto13:=ACTabc_GetFieldWithFormat ("0";"N";14)
						$vt_codSubConcepto14:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto15:=ACTabc_GetFieldWithFormat ("0";"N";14)
						$vt_codSubConcepto16:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto17:=ACTabc_GetFieldWithFormat ("0";"N";14)
						$vt_codSubConcepto18:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto19:=ACTabc_GetFieldWithFormat ("0";"N";14)
						$vt_codSubConcepto20:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto21:=ACTabc_GetFieldWithFormat ("0";"N";14)
						$vt_codSubConcepto22:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto23:=ACTabc_GetFieldWithFormat ("0";"N";14)
						$vt_codSubConcepto24:=ACTabc_GetFieldWithFormat ("0";"N";2)
						$vt_valorSubConcepto25:=ACTabc_GetFieldWithFormat ("0";"N";14)
						
						$text:=$vt_tipoRegistro1+$vt_nombreCliente2+$vt_referencia3+$vt_fechaV4+$vt_fechaBloqueo5+$vt_periodosFacturados6+$vt_importeMax7+$vt_importeMin8+$vt_infoAdic9+$vt_codSubConcepto10+$vt_valorSubConcepto11+$vt_codSubConcepto12+$vt_valorSubConcepto13+$vt_codSubConcepto14+$vt_valorSubConcepto15+$vt_codSubConcepto16+$vt_valorSubConcepto17+$vt_codSubConcepto18+$vt_valorSubConcepto19+$vt_codSubConcepto20+$vt_valorSubConcepto21+$vt_codSubConcepto22+$vt_valorSubConcepto23+$vt_codSubConcepto24+$vt_valorSubConcepto25+$vt_numCta26+$vt_tipoIde27+$vt_numIde28+$vt_vacio29+"\r"
						IO_SendPacket ($ref;$text)
					End if 
				End for 
			End for 
			
		End if 
		USE SET:C118("AvisosTodos")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Exportando datos...")
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	C_TEXT:C284($vt_tipoRegistro1;$vt_total2;$vt_sumatoriaMax3;$vt_sumatoriaMin4;$vt_datosAdicionales5;$vt_vacio6)
	
	$vt_tipoRegistro1:=ACTabc_GetFieldWithFormat ("3";"N";2)
	$vt_total2:=ACTabc_GetFieldWithFormat (vnumTransCUP;"N";9)
	ACTio_Num2Vars (Num:C11(vtotalCUP);16;2;->$vQR_Text1;->$vQR_Text2)
	$vt_sumatoriaMax3:=ACTabc_GetFieldWithFormat ($vQR_Text1+$vQR_Text2;"N";18)
	$vt_sumatoriaMin4:=$vt_sumatoriaMax3
	$vt_datosAdicionales5:=ACTabc_GetFieldWithFormat ("0";"N";18)
	$vt_vacio6:=ACTabc_GetFieldWithFormat ("";"A";295)
	
	$text:=$vt_tipoRegistro1+$vt_total2+$vt_sumatoriaMax3+$vt_sumatoriaMin4+$vt_datosAdicionales5+$vt_vacio6+"\r"
	IO_SendPacket ($ref;$text)
	
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	If (Records in set:C195("selectionApdo")>0)
		CLEAR SET:C117("selectionApdo")
	End if 
Else 
	vb_detenerImp:=True:C214
End if 