//%attributes = {}
  //ACTabc_ExportCUPSPauls

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
	
	If (vl_otrasMonedas=1)
		C_TEXT:C284($vt_monedaOrg)
		$vt_monedaOrg:=<>vsACT_MonedaColegio
		<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
	End if 
	
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	
	C_TEXT:C284($vt_nomEmpresa;$vt_ctaCteEmpresa;$vt_unidadMonetaria;$vt_valorCuota;$vt_monthYear;$vt_cuotaMensual;$vt_diaStandarVenc;$vt_numInicialBol;$vt_noCuotas)
	$vt_nomEmpresa:=ACTabc_GetFieldWithFormat ("St. Pauls School Soc.Ltda";"A";37)
	$vt_ctaCteEmpresa:=ACTabc_GetFieldWithFormat ("15097951";"N";8)
	$vt_noCuotas:=ACTabc_GetFieldWithFormat (String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]));"N";2)
	$vt_unidadMonetaria:="0"
	$vt_valorCuota:=ACTabc_GetFieldWithFormat (String:C10($FieldPtr->);"N";12)
	$vt_monthYear:=ACTabc_GetFieldWithFormat (String:C10([ACT_Avisos_de_Cobranza:124]Mes:6)+Substring:C12(String:C10([ACT_Avisos_de_Cobranza:124]Agno:7);3);"N";4)
	$vt_cuotaMensual:=ACTabc_GetFieldWithFormat ("01";"N";2)
	$vt_diaStandarVenc:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5));"N";2)
	$vt_numInicialBol:=ACTabc_GetFieldWithFormat ("1"+String:C10([ACT_Avisos_de_Cobranza:124]Agno:7;"0000")+String:C10([ACT_Avisos_de_Cobranza:124]Mes:6;"00");"N";11)
	
	$text:="1"+$vt_nomEmpresa+$vt_ctaCteEmpresa+$vt_noCuotas+""+$vt_unidadMonetaria+$vt_valorCuota+$vt_monthYear+$vt_cuotaMensual+$vt_diaStandarVenc+$vt_numInicialBol+"\r"
	  //IO_SendPacket ($ref;$text)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			
			$vt_rutApoderado:=ACTabc_GetFieldWithFormat ([Personas:7]RUT:6;"N";11)
			$vt_nombreDeudor:=ACTabc_GetFieldWithFormat ([Personas:7]Apellidos_y_nombres:30;"A";20)
			$vt_moneda:="0"
			$vt_descripcion:=ACTabc_GetFieldWithFormat ("Mensualidad";"A";11)
			
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY INTEGER:C220(aQR_Integer1;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			ARRAY DATE:C224(aQR_Date1;0)
			ARRAY DATE:C224(aQR_Date2;0)
			$vl_noCuotas:=ACTabc_ObtieneMesesYAdeudado ("selectionApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2)
			For (vQR_Long1;1;$vl_noCuotas)
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+aQR_Real1{vQR_Long1};"|Despliegue_ACT")
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				$vt_fechaVencimiento:=String:C10(Day of:C23(aQR_Date2{vQR_Long1});"00")+"/"+String:C10(Month of:C24(aQR_Date2{vQR_Long1});"00")+"/"+String:C10(Year of:C25(aQR_Date2{vQR_Long1});"0000")
				$vt_noCuota:=ACTabc_GetFieldWithFormat ("1"+String:C10(Year of:C25(aQR_Date2{vQR_Long1}))+String:C10(vQR_Long1;"00");"N";11)
				$vt_montoTotal:=ACTabc_GetFieldWithFormat (String:C10(aQR_Real1{vQR_Long1});"N";9)
				$vt_numeroCuota:=ACTabc_GetFieldWithFormat (String:C10(vQR_Long1);"N";2)
				$text:="2"+$vt_rutApoderado+$vt_nombreDeudor+$vt_montoTotal+("0"*4)+$vt_numeroCuota+$vt_noCuota+$vt_fechaVencimiento+("0"*2)+$vt_moneda+$vt_descripcion+"\r"
				IO_SendPacket ($ref;$text)
			End for 
		End if 
		USE SET:C118("AvisosTodos")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Exportando datos...")
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	C_TEXT:C284($vt_numRegistros;$vt_sumatoria)
	$vt_numRegistros:=ACTabc_GetFieldWithFormat (vnumTransCUP;"N";6)
	$vt_sumatoria:=ACTabc_GetFieldWithFormat (String:C10(Num:C11(vtotalCUP));"N";14)
	$text:="3"+$vt_numRegistros+$vt_sumatoria+(" "*59)+"\r"
	IO_SendPacket ($ref;$text)
	
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	If (Records in set:C195("selectionApdo")>0)
		CLEAR SET:C117("selectionApdo")
	End if 
	
	If (vl_otrasMonedas=1)
		<>vsACT_MonedaColegio:=$vt_monedaOrg
	End if 
End if 
ARRAY INTEGER:C220(aQR_Integer1;0)
ARRAY LONGINT:C221(al_anosAvisos;0)
ARRAY TEXT:C222(aQR_Text1;0)