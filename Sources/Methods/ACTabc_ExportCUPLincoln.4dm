//%attributes = {}
  //ACTabc_ExportCUPLincoln

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

C_TEXT:C284($vt_set)
$vt_set:="selectionApdo"

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	
	C_TEXT:C284($vt_filler)
	C_TEXT:C284(vQR_Text1;vQR_Text2)
	C_TEXT:C284($vt_rutDeudor;$vt_DVRut;$vt_nombreDeudor;$vt_calle;$vt_numero;$vt_block;$vt_departamento;$vt_comuna;$vt_ciudad;$vt_banco;$vt_codDeudor;$vt_montoTotal;$vt_noCuotas;$vt_fechaPVenc;$vt_campoBanco;$vt_codMoneda;$vt_llaveOperacion;$vt_DVLlave)
	C_DATE:C307($vd_fecha1)
	$id:=IT_UThermometer (1;0;"Generando información para archivo CUP...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];$vt_set)
			DIFFERENCE:C122("AvisosTodos";$vt_set;"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>)
			FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
			$vd_fecha1:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
			
			KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)
			KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
			
			vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
			$vr_montoCuota:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetAvisosMEmision";->$vt_set;->[ACT_Cargos:173]Saldo:23;vd_FechaUF))
			$vl_noCuotas:=[Personas:7]ACT_NoCuotasCup:80
			If ($vl_noCuotas=0)
				$vl_noCuotas:=10
			End if 
			$vr_montoCuota:=Round:C94($vr_montoCuota/$vl_noCuotas;2)
			vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Abs:C99($vr_montoCuota*$vl_noCuotas);"|Despliegue_ACT")
			
			$vt_rutDeudor:=ACTabc_GetFieldWithFormat (Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1);"N";10)
			$vt_DVRut:=ACTabc_GetFieldWithFormat (Substring:C12([Alumnos:2]RUT:5;Length:C16([Alumnos:2]RUT:5));"N";1)
			$vt_nombreDeudor:=ACTabc_GetFieldWithFormat ([Alumnos:2]apellidos_y_nombres:40;"A";39)
			$vt_calle:=ACTabc_GetFieldWithFormat ([Alumnos:2]Direccion:12;"A";25)
			$vt_numero:=ACTabc_GetFieldWithFormat ("";"A";6)
			$vt_block:=ACTabc_GetFieldWithFormat ("";"A";5)
			$vt_departamento:=ACTabc_GetFieldWithFormat ("";"A";5)
			$vt_comuna:=ACTabc_GetFieldWithFormat ([Alumnos:2]Comuna:14;"A";15)
			$vt_ciudad:=ACTabc_GetFieldWithFormat ([Alumnos:2]Ciudad:15;"A";15)
			$vt_banco:=ACTabc_GetFieldWithFormat ("";"A";4)
			$vt_codDeudor:=ACTabc_GetFieldWithFormat ([ACT_CuentasCorrientes:175]Codigo:19;"A";12)
			ACTio_Num2Vars ($vr_montoCuota;8;3;->vQR_Text1;->vQR_Text2)  //20100315 incidente 76615. Segun formato eran 9 y2 no 8 y 3....
			$vt_montoTotal:=vQR_Text1+vQR_Text2
			$vt_noCuotas:=ACTabc_GetFieldWithFormat (String:C10($vl_noCuotas);"N";3)  //20100518 incidente 86262
			$vt_fechaPVenc:=String:C10(Day of:C23($vd_fecha1);"00")+String:C10(Month of:C24($vd_fecha1);"00")+String:C10(Year of:C25($vd_fecha1);"0000")
			$vt_campoBanco:=ACTabc_GetFieldWithFormat ("";"A";2)
			$vt_codMoneda:=ST_Boolean2Str (<>vsACT_MonedaColegio=ST_GetWord (ACT_DivisaPais ;1;";");"00";ST_Boolean2Str (<>vsACT_MonedaColegio="UF";"01";"00"))
			$vt_llaveOperacion:=ACTabc_GetFieldWithFormat ("";"A";11)
			$vt_DVLlave:=ACTabc_GetFieldWithFormat ("";"A";1)
			
			$text:=$vt_rutDeudor+$vt_DVRut+$vt_nombreDeudor+$vt_calle+$vt_numero+$vt_block+$vt_departamento+$vt_comuna+$vt_ciudad+$vt_banco+$vt_codDeudor
			$text:=$text+$vt_montoTotal+$vt_noCuotas+$vt_fechaPVenc+$vt_campoBanco+$vt_codMoneda+$vt_llaveOperacion+$vt_DVLlave+"\r"
			IO_SendPacket ($ref;$text)
			
		End if 
		USE SET:C118("AvisosTodos")
	End while 
	SET_ClearSets ("AvisosTodos";$vt_set)
	IT_UThermometer (-2;$id)
	CLOSE DOCUMENT:C267($ref)
Else 
	vb_detenerImp:=True:C214
End if 