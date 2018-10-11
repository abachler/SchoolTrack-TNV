//%attributes = {}
  // Método: ACTabc_ExportCUPStaTeresita
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 15-02-10, 09:16:32
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //ACTabc_ExportCUPStaTeresita

  //BCP
C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_TEXT:C284($vt_rutApoderado;$vt_noCuota;$vt_nombreDeudor;$vt_fechaVencimiento;$vt_moneda;$vt_montoTotal;$vt_numeroCuota;$vt_descripcion)

C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_noCuotas;vQR_Long1;$vl_total)
$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=[ACT_Avisos_de_Cobranza]ID_Apoderado)
	  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente=[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente)
	  //ORDER BY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Agno;>;[ACT_Avisos_de_Cobranza]Mes;>)
	
	C_TEXT:C284($vt_textoFijo1;$vt_textoFijo2;$vt_textoFijo3;$vt_textoFijo4;$vt_textoFijo5;$vt_textoFijo6;$vt_fechaActual7;$vt_numeroTrans8;$vt_sumaTrans9;$vt_textoFijo10;$vt_textoFijo11)
	
	
	C_TEXT:C284($vt_textoFijo1;$vt_textoFijo2;$vt_textoFijo3;$vt_textoFijo4;$vt_id2Alumno5;$vt_nombreAviso6;$vt_mesAviso7;$vt_fechaEmision8;$vt_fechaVencimiento9;$vt_montoNeto10;$vt_textoFijo11;$vt_textoFijo12;$vt_textoFijo13;$vt_identificadorApdo14)
	C_REAL:C285($vr_monto)
	
	ARRAY TEXT:C222(aQR_Text1;0)
	ARRAY TEXT:C222(aQR_Text2;0)
	ARRAY INTEGER:C220(aQR_Integer1;0)
	ARRAY DATE:C224(aQR_Date1;0)
	ARRAY DATE:C224(aQR_Date2;0)
	ARRAY REAL:C219(aQR_Real1;0)
	ARRAY TEXT:C222(aQR_Text3;0)
	ARRAY TEXT:C222(aQR_Text4;0)
	ARRAY TEXT:C222(aQR_Text5;0)
	
	LOC_LoadList2Array ("XS_Meses";->aQR_Text4)
	
	
	C_TEXT:C284($set)
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	C_POINTER:C301(vQR_Pointer1)
	If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
		vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
	Else 
		vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
	End if 
	
	
	
	
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Generando datos...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Apoderado=[ACT_Avisos_de_Cobranza]ID_Apoderado)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Transacciones:178]ID_CuentaCorriente:2;"")
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			
			While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
				USE SET:C118("selectionApdo")
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=[ACT_Avisos_de_Cobranza:124]Agno:7;*)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6=[ACT_Avisos_de_Cobranza:124]Mes:6)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"$selectionApdo2")
				DIFFERENCE:C122("selectionApdo";"$selectionApdo2";"selectionApdo")
				CLEAR SET:C117("$selectionApdo2")
				
				APPEND TO ARRAY:C911(aQR_Text1;[Alumnos:2]IDNacional_2:71)
				APPEND TO ARRAY:C911(aQR_Text5;[Alumnos:2]Nivel_Nombre:34)
				APPEND TO ARRAY:C911(aQR_Text2;ST_ReplaceAccentedChars ([ACT_Avisos_de_Cobranza:124]NombreRelacionado:27))
				APPEND TO ARRAY:C911(aQR_Integer1;[ACT_Avisos_de_Cobranza:124]Mes:6)
				APPEND TO ARRAY:C911(aQR_Date1;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
				APPEND TO ARRAY:C911(aQR_Date2;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
				KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				$set:="setCargos"
				CREATE SET:C116([ACT_Cargos:173];$set)
				$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$set;vQR_Pointer1;vd_FechaUF))
				APPEND TO ARRAY:C911(aQR_Real1;$vr_monto)
				APPEND TO ARRAY:C911(aQR_Text3;[Personas:7]RUT:6)
				
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+$vr_monto)
				USE SET:C118("selectionApdo")
			End while 
		End if 
		USE SET:C118("AvisosTodos")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Generando datos...")
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	$vt_textoFijo1:=ACTabc_GetFieldWithFormat ("CC";"A";2)
	$vt_textoFijo2:=ACTabc_GetFieldWithFormat ("194";"N";3)
	$vt_textoFijo3:=ACTabc_GetFieldWithFormat ("0";"N";1)
	$vt_textoFijo4:=ACTabc_GetFieldWithFormat ("1712154";"N";7)
	$vt_textoFijo5:=ACTabc_GetFieldWithFormat ("C";"N";1)
	$vt_textoFijo6:=ACTabc_GetFieldWithFormat ("IEP COLEGIO MIXTO SANTA TERESITA";"A";40)
	  //$vt_fechaActual7:=ACTabc_GetFieldWithFormat (String(Year of(Current date(*)))+String(Month of(Current date(*));"00")+String(Day of(Current date(*));"00");"N";8)
	$vt_fechaActual7:=ACTabc_GetFieldWithFormat ("20010101";"N";8)
	$vt_numeroTrans8:=ACTabc_GetFieldWithFormat (vnumTransCUP;"N";9)
	ACTio_Num2Vars (Num:C11(vtotalCUP);13;2;->vQR_Text1;->vQR_Text2)
	$vt_sumaTrans9:=ACTabc_GetFieldWithFormat (vQR_Text1+vQR_Text2;"N";15)
	  //$vt_textoFijo10:=ACTabc_GetFieldWithFormat ("R";"N";1)
	$vt_textoFijo10:=ACTabc_GetFieldWithFormat (" ";"A";1)
	$vt_textoFijo11:=ACTabc_GetFieldWithFormat ("00";"A";113;" ";"R")
	$text:=$vt_textoFijo1+$vt_textoFijo2+$vt_textoFijo3+$vt_textoFijo4+$vt_textoFijo5+$vt_textoFijo6+$vt_fechaActual7+$vt_numeroTrans8+$vt_sumaTrans9+$vt_textoFijo10+$vt_textoFijo11+"\r"
	IO_SendPacket ($ref;$text)
	
	AT_MultiLevelSort (">>>>>>>>";->aQR_Text2;->aQR_Date1;->aQR_Date2;->aQR_Text1;->aQR_Integer1;->aQR_Text5;->aQR_Real1;->aQR_Text3)
	
	C_LONGINT:C283($i)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	For ($i;1;Size of array:C274(aQR_Text1))
		$vt_textoFijo1:=ACTabc_GetFieldWithFormat ("DD";"A";2)
		$vt_textoFijo2:=ACTabc_GetFieldWithFormat ("194";"N";3)
		$vt_textoFijo3:=ACTabc_GetFieldWithFormat ("0";"N";1)
		$vt_textoFijo4:=ACTabc_GetFieldWithFormat ("1712154";"N";7)
		$vt_id2Alumno5:=ACTabc_GetFieldWithFormat (aQR_Text1{$i};"N";14)
		$vt_nombreAviso6:=ACTabc_GetFieldWithFormat (ST_Uppercase (aQR_Text2{$i});"A";40)
		$vt_mesAviso7:=ACTabc_GetFieldWithFormat (ST_Uppercase (aQR_Text4{aQR_Integer1{$i}}+(" "*3)+aQR_Text5{$i});"A";30)
		$vt_fechaEmision8:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(aQR_Date1{$i}))+String:C10(Month of:C24(aQR_Date1{$i});"00")+String:C10(Day of:C23(aQR_Date1{$i});"00");"N";8)
		$vt_fechaVencimiento9:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(aQR_Date2{$i}))+String:C10(Month of:C24(aQR_Date2{$i});"00")+String:C10(Day of:C23(aQR_Date2{$i});"00");"N";8)
		$vr_monto:=aQR_Real1{$i}
		ACTio_Num2Vars ($vr_monto;13;2;->vQR_Text1;->vQR_Text2)
		$vt_montoNeto10:=ACTabc_GetFieldWithFormat (vQR_Text1+vQR_Text2;"N";15)
		$vt_textoFijo11:=ACTabc_GetFieldWithFormat ("0";"N";15)
		$vt_textoFijo12:=ACTabc_GetFieldWithFormat ("0";"N";9)
		  //$vt_textoFijo13:=ACTabc_GetFieldWithFormat ("R";"A";1)
		$vt_textoFijo13:=ACTabc_GetFieldWithFormat ("0";"A";1)
		  //$vt_identificadorApdo14:=ACTabc_GetFieldWithFormat (aQR_Text3{$i};"N";47)
		$vt_identificadorApdo14:=ACTabc_GetFieldWithFormat ("0";"N";47)
		
		$text:=$vt_textoFijo1+$vt_textoFijo2+$vt_textoFijo3+$vt_textoFijo4+$vt_id2Alumno5+$vt_nombreAviso6+$vt_mesAviso7+$vt_fechaEmision8+$vt_fechaVencimiento9+$vt_montoNeto10+$vt_textoFijo11+$vt_textoFijo12+$vt_textoFijo13+$vt_identificadorApdo14+"\r"
		IO_SendPacket ($ref;$text)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Text1);"Exportando datos...")
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	If (Records in set:C195("selectionApdo")>0)
		CLEAR SET:C117("selectionApdo")
	End if 
Else 
	vb_detenerImp:=True:C214
End if 


