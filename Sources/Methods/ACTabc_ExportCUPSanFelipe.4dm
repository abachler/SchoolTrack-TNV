//%attributes = {}
  //ACTabc_ExportCUPSanFelipe

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
	
	  //Encabezado
	C_TEXT:C284($vt_rutCliente;$vt_DVRut;$vt_fechaEnvio;$vt_filler)
	$vt_rutCliente:="00000000"
	$vt_DVRut:="0"
	$vt_fechaEnvio:=String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
	$vt_filler:=ACTabc_GetFieldWithFormat ("";"A";190)
	$text:="1"+ST_RigthChars (("0"*11)+$vt_rutCliente+$vt_DVRut;11)+$vt_fechaEnvio+$vt_filler+"\r"
	IO_SendPacket ($ref;$text)
	
	C_TEXT:C284(vQR_Text1;vQR_Text2)
	C_TEXT:C284($vt_tipoRegistro;$vt_numeroCotrato;$vt_rutAceptante;$vt_dvRUT;$vt_unidadMonetaria;$vt_montoCuota;$vt_fechaVenc;$vt_descripcion;$vt_codConvenio;$vt_nombreAceptante;$vt_calle;$vt_numero;$vt_block;$vt_departamento;$vt_comuna;$vt_ciudad;$vt_llave_Operacion;$vt_DVLlaveOperacion;$vt_numeroCuota;$vt_CodResult;$vt_filler)
	
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
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
			QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
			
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY INTEGER:C220(aQR_Integer1;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			ARRAY DATE:C224(aQR_Date1;0)
			ARRAY DATE:C224(aQR_Date2;0)
			  //$vl_noCuotas:=ACTabc_ObtieneMesesYAdeudado ("selectionApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2)
			For (vQR_Long1;1;$vl_noCuotas)
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Abs:C99(aQR_Real1{vQR_Long1});"|Despliegue_ACT")
				$vr_montoCuota:=aQR_Real1{vQR_Long1}
				
				$vt_tipoRegistro:="2"
				$vt_numeroCotrato:=ACTabc_GetFieldWithFormat ("4529";"A";20)
				$vt_rutAceptante:=ACTabc_GetFieldWithFormat (Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);"N";10)
				$vt_dvRUT:=Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6))
				$vt_unidadMonetaria:="0"
				ACTio_Num2Vars ($vr_montoCuota;10;4;->vQR_Text1;->vQR_Text2)
				$vt_montoCuota:=vQR_Text1+vQR_Text2
				$vt_fechaVenc:=String:C10(Year of:C25(aQR_Date2{vQR_Long1});"0000")+String:C10(Month of:C24(aQR_Date2{vQR_Long1});"00")+String:C10(Day of:C23(aQR_Date2{vQR_Long1});"00")
				$vt_descripcion:=ACTabc_GetFieldWithFormat ("";"A";20)
				$vt_codConvenio:=ACTabc_GetFieldWithFormat ("289";"N";5)
				$vt_nombreAceptante:=ACTabc_GetFieldWithFormat ([Personas:7]Apellidos_y_nombres:30;"A";40)
				$vt_calle:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_DireccionEC:67;"A";25)
				$vt_numero:=ACTabc_GetFieldWithFormat ("";"A";6)
				$vt_block:=ACTabc_GetFieldWithFormat ("";"A";5)
				$vt_departamento:=ACTabc_GetFieldWithFormat ("";"A";5)
				$vt_comuna:=ACTabc_GetFieldWithFormat ("";"A";15)
				$vt_ciudad:=ACTabc_GetFieldWithFormat ("";"A";15)
				$vt_llave_Operacion:=ACTabc_GetFieldWithFormat ("";"N";11)
				$vt_DVLlaveOperacion:=ACTabc_GetFieldWithFormat ("";"N";1)
				$vt_numeroCuota:=ACTabc_GetFieldWithFormat (String:C10(vQR_Long1);"N";3)
				$vt_CodResult:=ACTabc_GetFieldWithFormat ("";"N";1)
				$vt_filler:=ACTabc_GetFieldWithFormat ("";"A";3)
				
				$text:=$vt_tipoRegistro+$vt_numeroCotrato+$vt_rutAceptante+$vt_dvRUT+$vt_unidadMonetaria+$vt_montoCuota+$vt_fechaVenc+$vt_descripcion
				$text:=$text+$vt_codConvenio+$vt_nombreAceptante+$vt_calle+$vt_numero+$vt_block+$vt_departamento+$vt_comuna+$vt_ciudad
				$text:=$text+$vt_llave_Operacion+$vt_DVLlaveOperacion+$vt_numeroCuota+$vt_CodResult+$vt_filler+"\r"
				IO_SendPacket ($ref;$text)
			End for 
		End if 
		USE SET:C118("AvisosTodos")
	End while 
	SET_ClearSets ("AvisosTodos";"selectionApdo")
	
	  //Registro Control
	C_TEXT:C284($vt_noRegistros;$vt_montoTotal)
	$vt_noRegistros:=ACTabc_GetFieldWithFormat (vnumTransCUP;"N";6)
	ACTio_Num2Vars (Num:C11(vtotalCUP);14;4;->vQR_Text1;->vQR_Text2)
	$vt_montoTotal:=vQR_Text1+vQR_Text2
	$vt_filler:=ACTabc_GetFieldWithFormat ("";"A";185)
	$text:="3"+$vt_noRegistros+$vt_montoTotal+$vt_filler
	IO_SendPacket ($ref;$text)
	
	IT_UThermometer (-2;$id)
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 