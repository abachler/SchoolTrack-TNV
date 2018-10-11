//%attributes = {}
  //ACTabc_ExportCUPGreenland

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total;$vl_noCuotas;$i)

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

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	
	ARRAY LONGINT:C221(aQR_Longint5;0)
	ARRAY LONGINT:C221(aQR_Longint6;0)
	DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;aQR_Longint5)
	
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;"")
	KRL_RelateSelection (->[Alumnos:2]Apoderado_Cuentas_Número:28;->[Personas:7]No:1;"")
	ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	ARRAY LONGINT:C221(aQR_Longint4;0)
	SELECTION TO ARRAY:C260([Alumnos:2]Apoderado_Cuentas_Número:28;aQR_Longint3)
	For (vQR_Long1;1;Size of array:C274(aQR_Longint3))
		If (Find in array:C230(aQR_Longint4;aQR_Longint3{vQR_Long1})=-1)
			APPEND TO ARRAY:C911(aQR_Longint4;aQR_Longint3{vQR_Long1})
		End if 
	End for 
	C_TEXT:C284($vt_constH;$vt_codCausa;$vt_razonSocial;$vt_moneda;$vt_filler)
	$vt_constH:=ACTabc_GetFieldWithFormat ("1";"N";1)
	$vt_codCausa:=ACTabc_GetFieldWithFormat ("144";"N";3)
	$vt_razonSocial:=ACTabc_GetFieldWithFormat ("THE GREENLAND SCHOOL";"A";70)
	$vt_moneda:=ACTabc_GetFieldWithFormat ("1";"N";1)
	$vt_filler:=ACTabc_GetFieldWithFormat (" ";"A";24)
	$text:=$vt_constH+$vt_codCausa+$vt_razonSocial+$vt_moneda+$vt_filler+"\r"
	IO_SendPacket ($ref;$text)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			
			If (Size of array:C274(aQR_Longint4)>0)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=aQR_Longint4{1})
				AT_Delete (Find in array:C230(aQR_Longint5;aQR_Longint4{1});1;->aQR_Longint5)
				AT_Delete (1;1;->aQR_Longint4)
			Else 
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=aQR_Longint5{1})
				APPEND TO ARRAY:C911(aQR_Longint6;aQR_Longint5{1})
				AT_Delete (1;1;->aQR_Longint5)
			End if 
			
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>)
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
			KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
			C_TEXT:C284($vt_constB;$vt_codSubConv;$vt_codCliente;$vt_rutDeudor;$vt_DVRutDeudor;$vt_nombreDeudor;$vt_separador;$vt_curso;$vt_mensaje;$vt_numeroCuota;$vt_FechaVencCuota;$vt_montoAPagar)
			$vt_constB:=ACTabc_GetFieldWithFormat ("2";"N";1)
			$vt_codSubConv:=ACTabc_GetFieldWithFormat ("01";"N";2)
			$vt_codCliente:=ACTabc_GetFieldWithFormat ([Personas:7]RUT:6;"N";16)
			$vt_rutDeudor:=ACTabc_GetFieldWithFormat ([Personas:7]RUT:6;"N";10)
			$vt_nombreDeudor:=ST_Uppercase (ACTabc_GetFieldWithFormat ([Personas:7]Apellidos_y_nombres:30;"A";35))
			$vt_separador:=ACTabc_GetFieldWithFormat (".";"A";1)
			$vt_curso:=ACTabc_GetFieldWithFormat ([Alumnos:2]curso:20;"A";3)
			$vt_mensaje:=ACTabc_GetFieldWithFormat (" ";"A";30)
			
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY INTEGER:C220(aQR_Integer1;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			ARRAY DATE:C224(aQR_Date1;0)
			ARRAY DATE:C224(aQR_Date2;0)
			
			$vl_noCuotas:=ACTabc_ObtieneMesesYAdeudado ("selectionApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2)
			For (vQR_Long1;1;$vl_noCuotas)
				$vt_numeroCuota:=ACTabc_GetFieldWithFormat (String:C10(vQR_Long1);"N";3)
				$vt_FechaVencCuota:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23(aQR_Date2{vQR_Long1});"00")+String:C10(Month of:C24(aQR_Date2{vQR_Long1});"00")+Substring:C12(String:C10(Year of:C25(aQR_Date2{vQR_Long1}));3);"N";6)
				$vt_montoAPagar:=ACTabc_GetFieldWithFormat (String:C10(aQR_Real1{vQR_Long1});"N";9)
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Num:C11($vt_montoAPagar))
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				$text:=$vt_constB+$vt_codSubConv+$vt_codCliente+$vt_rutDeudor+$vt_nombreDeudor+$vt_separador+$vt_curso+$vt_mensaje+$vt_numeroCuota+$vt_FechaVencCuota+$vt_montoAPagar+"\r"
				IO_SendPacket ($ref;$text)
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Exportando datos...")
		End if 
		USE SET:C118("AvisosTodos")
	End while 
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
	
	If (Size of array:C274(aQR_Longint6)>0)
		AT_DistinctsArrayValues (->aQR_Longint6)
		CD_Dlog (0;"Hay avisos asociados a apoderados que no son apoderados de cuenta actuales. Aviso"+"s asociados a apoderados número: "+AT_array2text (->aQR_Longint6;" - ";"#########")+"."+"\r\r"+"Se debe cambiar el actual apoderado de cuenta de las cuentas asociadas a los avis"+"os de cobranza con el número de apoderado ya mencionado.")
	End if 
	
Else 
	vb_detenerImp:=True:C214
End if 