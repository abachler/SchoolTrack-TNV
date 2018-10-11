//%attributes = {}
  //ACTabc_ExportCUPSanMiguelA

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($folderPath;$fileName;$text;$fecha)
C_LONGINT:C283($id;$vl_noCuotas)
C_REAL:C285($vr_montoCuota)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))


vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	
	C_TEXT:C284($vt_filler)
	C_TEXT:C284(vQR_Text1;vQR_Text2)
	C_TEXT:C284($vt_rutDeudor;$vt_DVRut;$vt_nombreDeudor;$vt_calle;$vt_numero;$vt_block;$vt_departamento;$vt_comuna;$vt_ciudad;$vt_banco;$vt_codDeudor;$vt_montoTotal;$vt_noCuotas;$vt_fechaPVenc;$vt_campoBanco;$vt_codMoneda;$vt_llaveOperacion;$vt_DVLlave)
	$id:=IT_UThermometer (1;0;"Generando información para archivo CUP...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>)
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY INTEGER:C220(aQR_Integer1;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			ARRAY DATE:C224(aQR_Date1;0)
			ARRAY DATE:C224(aQR_Date2;0)
			$vl_noCuotas:=ACTabc_ObtieneMesesYAdeudado ("selectionApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2)
			For (vQR_Long1;1;$vl_noCuotas)
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Abs:C99(aQR_Real1{vQR_Long1});"|Despliegue_ACT")
				$vr_montoCuota:=aQR_Real1{vQR_Long1}
				
				$vt_rutDeudor:=ACTabc_GetFieldWithFormat (Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);"N";10)
				$vt_DVRut:=Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6))
				$vt_nombreDeudor:=ACTabc_GetFieldWithFormat ([Personas:7]Apellidos_y_nombres:30;"A";39)
				$vt_calle:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_DireccionEC:67;"A";25)
				$vt_numero:=ACTabc_GetFieldWithFormat ("";"A";6)
				$vt_block:=ACTabc_GetFieldWithFormat ("";"A";5)
				$vt_departamento:=ACTabc_GetFieldWithFormat ("";"A";5)
				$vt_comuna:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_ComunaEC:68;"A";15)
				$vt_ciudad:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_CiudadEC:69;"A";15)
				$vt_banco:=ACTabc_GetFieldWithFormat ("";"A";4)
				$vt_codDeudor:=ACTabc_GetFieldWithFormat ([Personas:7]RUT:6;"A";12;"0";"R")
				ACTio_Num2Vars ($vr_montoCuota;9;2;->vQR_Text1;->vQR_Text2)
				$vt_montoTotal:=vQR_Text1+vQR_Text2
				$vt_noCuotas:=ACTabc_GetFieldWithFormat (String:C10(vQR_Long1);"N";3)
				$vt_fechaPVenc:=String:C10(Day of:C23(aQR_Date2{vQR_Long1});"00")+String:C10(Month of:C24(aQR_Date2{vQR_Long1});"00")+String:C10(Year of:C25(aQR_Date2{vQR_Long1});"0000")
				$vt_campoBanco:=ACTabc_GetFieldWithFormat ("";"A";2)
				$vt_codMoneda:=ST_Boolean2Str (<>vsACT_MonedaColegio=ST_GetWord (ACT_DivisaPais ;1;";");"00";ST_Boolean2Str (<>vsACT_MonedaColegio="UF";"01";"00"))
				$vt_llaveOperacion:=ACTabc_GetFieldWithFormat ("";"A";11)
				$vt_DVLlave:=ACTabc_GetFieldWithFormat ("";"A";1)
				
				$text:=$vt_rutDeudor+$vt_DVRut+$vt_nombreDeudor+$vt_calle+$vt_numero+$vt_block+$vt_departamento+$vt_comuna+$vt_ciudad+$vt_banco+$vt_codDeudor
				$text:=$text+$vt_montoTotal+$vt_noCuotas+$vt_fechaPVenc+$vt_campoBanco+$vt_codMoneda+$vt_llaveOperacion+$vt_DVLlave+"\r"
				IO_SendPacket ($ref;$text)
			End for 
		End if 
		USE SET:C118("AvisosTodos")
	End while 
	SET_ClearSets ("AvisosTodos";"selectionApdo")
	IT_UThermometer (-2;$id)
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 