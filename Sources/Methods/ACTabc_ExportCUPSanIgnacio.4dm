//%attributes = {}
  //ACTabc_ExportCUPSanIgnacio

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_LONGINT:C283($i;$noCuotas)
C_LONGINT:C283($vl_TotalRegistros)
C_TEXT:C284($vt_entero;$vt_decimal)
C_TEXT:C284($vt_tipoRegistro;$vt_rutEmpresa;$vt_fechaEnvío;$vt_filler)
C_TEXT:C284($vt_numeroContrato;$vt_rutAceptante;$vt_CodigoMoneda;$vt_montoCuota;$vt_fechaVencimiento;$vt_descripcionCuota;$vt_codConvenio;$vt_nombreDeudor;$vt_calle;$vt_numero;$vt_block;$vt_departamento;$vt_comuna;$vt_ciudad;$vt_llaveOperacion;$vt_DVLLave;$vt_NumeroCuota;$vt_resultadoCarga;$vt_filler)
C_TEXT:C284($vt_numeroRegistros;$vt_montoTotal)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

$ref:=ACTabc_CreaArchivo ("CUP";$fileName)
If ($ref#?00:00:00?)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_TotalRegistros:=Records in set:C195("AvisosTodos")
	$text:=""
	
	$vt_tipoRegistro:="1"
	$vt_rutEmpresa:=ACTabc_GetFieldWithFormat (<>vsACT_RUT;"A";11;"0";"R")
	$vt_fechaEnvío:=String:C10(Year of:C25(Current date:C33(*));"0000")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Day of:C23(Current date:C33(*));"00")
	$vt_filler:=ACTabc_GetFieldWithFormat (" ";"A";190)
	$text:=$vt_tipoRegistro+$vt_rutEmpresa+$vt_fechaEnvío+$vt_filler+"\r"
	IO_SendPacket ($ref;$text)
	
	$vt_tipoRegistro:="2"
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando información...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY INTEGER:C220(aQR_Integer1;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			ARRAY DATE:C224(aQR_Date1;0)
			ARRAY DATE:C224(aQR_Date2;0)
			
			$noCuotas:=ACTabc_ObtieneMesesYAdeudado ("selectionApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2)
			
			For ($i;1;$noCuotas)
				USE SET:C118("selectionApdo")
				
				$vt_numeroContrato:=Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1)
				$vt_numeroContrato:=$vt_numeroContrato+ST_Boolean2Str (Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6))="K";"0";Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6)))
				$vt_numeroContrato:=ACTabc_GetFieldWithFormat ($vt_numeroContrato;"A";20)
				$vt_rutAceptante:=ST_Uppercase (ACTabc_GetFieldWithFormat ([Personas:7]RUT:6;"A";11;"0";"R"))
				If (vl_otrasMonedas=1)
					$vt_CodigoMoneda:=ST_GetWord (ACT_DivisaPais ;1;";")
				Else 
					$vt_CodigoMoneda:=<>vsACT_MonedaColegio
				End if 
				Case of 
					: ($vt_CodigoMoneda=ST_GetWord (ACT_DivisaPais ;1;";"))
						$vt_CodigoMoneda:="0"
					: ($vt_CodigoMoneda="UF")
						$vt_CodigoMoneda:="1"
					: ($vt_CodigoMoneda="UTM")
						$vt_CodigoMoneda:="4"
					: ($vt_CodigoMoneda="Dolar")
						$vt_CodigoMoneda:="8"
				End case 
				$vt_CodigoMoneda:=ACTabc_GetFieldWithFormat ($vt_CodigoMoneda;"N";1)
				$vt_montoCuota:=ACTabc_GetFieldWithFormat (String:C10(Round:C94(aQR_Real1{$i};0));"N";10)
				ACTio_Num2Vars (aQR_Real1{$i};10;4;->$vt_entero;->$vt_decimal)
				$vt_montoCuota:=ACTabc_GetFieldWithFormat ($vt_entero+$vt_decimal;"N";14)
				$vt_fechaVencimiento:=String:C10(Year of:C25(aQR_Date2{$i});"0000")+String:C10(Month of:C24(aQR_Date2{$i});"00")+String:C10(Day of:C23(aQR_Date2{$i});"00")
				$vt_descripcionCuota:=ACTabc_GetFieldWithFormat ("Cuota Mensual";"A";20)
				$vt_codConvenio:=ACTabc_GetFieldWithFormat ("314";"N";5)
				$vt_nombreDeudor:=ACTabc_GetFieldWithFormat ([Personas:7]Apellidos_y_nombres:30;"A";40)
				$vt_calle:=ACTabc_GetFieldWithFormat (" ";"A";25)
				$vt_numero:=ACTabc_GetFieldWithFormat (" ";"A";6)
				$vt_block:=ACTabc_GetFieldWithFormat (" ";"A";5)
				$vt_departamento:=ACTabc_GetFieldWithFormat (" ";"A";5)
				$vt_comuna:=ACTabc_GetFieldWithFormat (" ";"A";15)
				$vt_ciudad:=ACTabc_GetFieldWithFormat (" ";"A";15)
				  //$vt_llaveOperacion:=ACTabc_GetFieldWithFormat ("0";"N";11)
				  //$vt_DVLLave:=ACTabc_GetFieldWithFormat ("0";"N";1)
				$vt_llaveOperacion:=Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1)
				$vt_llaveOperacion:=$vt_llaveOperacion+ST_Boolean2Str (Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6))="K";"0";Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6)))
				$vt_llaveOperacion:=ACTabc_GetFieldWithFormat ($vt_llaveOperacion;"N";12)
				$vt_NumeroCuota:=ACTabc_GetFieldWithFormat (String:C10($i);"N";3)
				$vt_resultadoCarga:=ACTabc_GetFieldWithFormat (" ";"A";1)
				$vt_filler:=ACTabc_GetFieldWithFormat (" ";"A";3)
				
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+aQR_Real1{$i})
				
				  //$text:=$vt_tipoRegistro+$vt_numeroContrato+$vt_rutAceptante+$vt_CodigoMoneda+$vt_montoCuota+$vt_fechaVencimiento+$vt_descripcionCuota+$vt_codConvenio+$vt_nombreDeudor+$vt_calle+$vt_numero+$vt_block+$vt_departamento+$vt_comuna+$vt_ciudad+$vt_llaveOperacion+$vt_DVLLave+$vt_NumeroCuota+$vt_resultadoCarga+$vt_filler+"\r"
				$text:=$vt_tipoRegistro+$vt_numeroContrato+$vt_rutAceptante+$vt_CodigoMoneda+$vt_montoCuota+$vt_fechaVencimiento+$vt_descripcionCuota+$vt_codConvenio+$vt_nombreDeudor+$vt_calle+$vt_numero+$vt_block+$vt_departamento+$vt_comuna+$vt_ciudad+$vt_llaveOperacion+$vt_NumeroCuota+$vt_resultadoCarga+$vt_filler+"\r"
				IO_SendPacket ($ref;$text)
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
			End for 
		End if 
		USE SET:C118("AvisosTodos")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_TotalRegistros-Records in set:C195("AvisosTodos"))/$vl_TotalRegistros;"Exportando información...")
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	$vt_tipoRegistro:="3"
	$vt_numeroRegistros:=ACTabc_GetFieldWithFormat (vnumTransCUP;"N";6)
	ACTio_Num2Vars (Num:C11(vtotalCUP);14;4;->$vt_entero;->$vt_decimal)
	$vt_montoTotal:=ACTabc_GetFieldWithFormat ($vt_entero+$vt_decimal;"N";18)
	$vt_filler:=ACTabc_GetFieldWithFormat (" ";"A";185)
	$text:=$vt_tipoRegistro+$vt_numeroRegistros+$vt_montoTotal+$vt_filler
	IO_SendPacket ($ref;$text)
	
	CLOSE DOCUMENT:C267($ref)
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 