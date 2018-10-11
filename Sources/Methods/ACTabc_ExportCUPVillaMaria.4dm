//%attributes = {}
  //ACTabc_ExportCUPVillaMaria

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_TEXT:C284($vt_rutApoderado;$vt_noBoleta;$vt_noCuota;$vt_nombreDeudor;$vt_fechaVencimiento;$vt_moneda;$vt_montoTotal;$vt_numeroCuota)
C_TEXT:C284($vt_diaVenc)
C_TEXT:C284($vt_descripcion1;$vt_descripcion2;$vt_descripcion3;$vt_subTotal1;$vt_subTotal2;$vt_subTotal3)

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
	
	C_TEXT:C284($vt_nomEmpresa;$vt_ctaCteEmpresa;$vt_unidadMonetaria;$vt_valorCuota;$vt_monthYear;$vt_cuotaMensual;$vt_diaStandarVenc;$vt_numInicialBol;$vt_noCuotas;$vt_noInicialBoleta)
	$vt_nomEmpresa:=ACTabc_GetFieldWithFormat ("Villa Maria Academy";"A";37)
	$vt_ctaCteEmpresa:=ACTabc_GetFieldWithFormat ("00000000";"N";8)
	$vt_noCuotas:=ACTabc_GetFieldWithFormat (String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]));"N";2)
	$vt_unidadMonetaria:="2"
	$vt_valorCuota:=ACTabc_GetFieldWithFormat (String:C10($FieldPtr->);"N";12)
	$vt_monthYear:=ACTabc_GetFieldWithFormat (String:C10([ACT_Avisos_de_Cobranza:124]Mes:6)+Substring:C12(String:C10([ACT_Avisos_de_Cobranza:124]Agno:7);3);"N";4)
	$vt_cuotaMensual:=ACTabc_GetFieldWithFormat ("01";"N";2)
	$vt_diaStandarVenc:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5));"N";2)
	$vt_numInicialBol:=ACTabc_GetFieldWithFormat (String:C10([ACT_Avisos_de_Cobranza:124]Agno:7;"0000")+String:C10([ACT_Avisos_de_Cobranza:124]Mes:6;"00");"N";11)
	
	$text:="1"+$vt_nomEmpresa+$vt_ctaCteEmpresa+$vt_noCuotas+""+$vt_unidadMonetaria+$vt_valorCuota+$vt_monthYear+$vt_cuotaMensual+$vt_diaStandarVenc+$vt_numInicialBol+"\r"
	
	READ ONLY:C145([xxACT_ItemsCategorias:98])
	ALL RECORDS:C47([xxACT_ItemsCategorias:98])
	ARRAY TEXT:C222(aQR_Text2;0)
	ARRAY LONGINT:C221(aQR_Longint5;0)
	ARRAY LONGINT:C221(aQR_Longint6;0)
	
	SELECTION TO ARRAY:C260([xxACT_ItemsCategorias:98]Nombre:1;aQR_Text2;[xxACT_ItemsCategorias:98]Posicion:3;aQR_Longint5;[xxACT_ItemsCategorias:98]ID:2;aQR_Longint6)
	SORT ARRAY:C229(aQR_Longint5;aQR_Text2;aQR_Longint6;>)
	
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
			$vt_noBoleta:=ACTabc_GetFieldWithFormat (String:C10([ACT_Avisos_de_Cobranza:124]Agno:7;"0000")+String:C10([ACT_Avisos_de_Cobranza:124]Mes:6;"00");"N";8)
			$vt_nombreDeudor:=ACTabc_GetFieldWithFormat ([Personas:7]Apellidos_y_nombres:30;"A";45)
			$vt_moneda:="2"
			
			ARRAY REAL:C219(aQR_Real1;0)
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY INTEGER:C220(aQR_Integer1;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			ARRAY DATE:C224(aQR_Date1;0)
			ARRAY DATE:C224(aQR_Date2;0)
			$vl_noCuotas:=ACTabc_ObtieneMesesYAdeudado ("selectionApdo";->aQR_Longint2;->aQR_Integer1;->aQR_Text1;->aQR_Real1;$FieldPtr;->vd_FechaUF;->aQR_Date1;->aQR_Date2)
			For (vQR_Long1;1;$vl_noCuotas)
				$vt_fechaVencimiento:=String:C10(Day of:C23(aQR_Date2{vQR_Long1});"00")+"/"+String:C10(Month of:C24(aQR_Date2{vQR_Long1});"00")+"/"+String:C10(Year of:C25(aQR_Date2{vQR_Long1});"0000")
				$vt_noCuota:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(aQR_Date2{vQR_Long1}))+String:C10(vQR_Long1;"00");"N";6)
				C_TEXT:C284($vt_entero;$vt_dec)
				ACTio_Num2Vars (aQR_Real1{vQR_Long1};2;2;->$vt_entero;->$vt_dec)
				$vt_montoTotal:=$vt_entero+<>tXS_RS_DecimalSeparator+$vt_dec
				
				vtotalCUP:=String:C10(Num:C11(vtotalCUP)+Num:C11($vt_montoTotal))
				vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				
				$vt_numeroCuota:=ACTabc_GetFieldWithFormat (String:C10(vQR_Long1);"N";2)
				$vt_diaVenc:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23(aQR_Date2{vQR_Long1}));"N";2)
				$vt_noInicialBoleta:=ACTabc_GetFieldWithFormat (String:C10(Year of:C25(aQR_Date2{vQR_Long1}))+String:C10(vQR_Long1;"00");"N";6)
				USE SET:C118("selectionApdo")
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=aQR_Longint2{vQR_Long1};*)
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6=aQR_Integer1{vQR_Long1})
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Cargos:173])
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				ARRAY LONGINT:C221(aQR_Longint3;0)
				ARRAY LONGINT:C221(aQR_Longint4;0)
				ARRAY LONGINT:C221(aQR_Longint7;0)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]Ref_Item:16;aQR_Longint4;[ACT_Cargos:173];aQR_Longint7)
				
				C_LONGINT:C283($vl_refItem)
				For (vQR_Long2;1;Size of array:C274(aQR_Longint4))
					$vl_refItem:=aQR_Longint4{vQR_Long2}
					APPEND TO ARRAY:C911(aQR_Longint3;KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->$vl_refItem;->[xxACT_Items:179]ID_Categoria:8))
				End for 
				
				ARRAY LONGINT:C221(aQR_Longint8;0)
				ARRAY REAL:C219(aQR_Real3;0)
				ARRAY TEXT:C222(aQR_Text3;0)
				C_POINTER:C301(vQR_pointer)
				If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
					vQR_pointer:=->[ACT_Cargos:173]Monto_Neto:5
				Else 
					vQR_pointer:=->[ACT_Cargos:173]Saldo:23
				End if 
				
				ACTcat_RetornaMontosXCat (->aQR_Longint7;vQR_pointer;->vd_FechaUF;->aQR_Longint8;->aQR_Text3;->aQR_Real3)
				
				C_LONGINT:C283($k)
				SORT ARRAY:C229(aQR_Longint3;aQR_Longint4;>)
				For ($k;Size of array:C274(aQR_Longint3);1;-1)
					If ((aQR_Longint3{$k-1}=aQR_Longint3{$k}) & ($k>1))
						AT_Delete ($k;1;->aQR_Longint3;->aQR_Longint4)
					End if 
				End for 
				
				AT_OrderArraysByArray (1234;->aQR_Longint6;->aQR_Longint3;->aQR_Longint4)
				
				C_LONGINT:C283($pos)
				
				$vt_descripcion1:=""
				$vt_subTotal1:=""
				$vt_descripcion2:=""
				$vt_subTotal2:=""
				$vt_descripcion3:=""
				$vt_subTotal3:=""
				
				C_LONGINT:C283($el)
				For (vQR_Long2;1;Size of array:C274(aQR_Longint3))
					$pos:=Find in array:C230(aQR_Longint6;aQR_Longint3{vQR_Long2})
					If ($pos>0)
						Case of 
							: (vQR_Long2=1)
								$vt_descripcion1:=aQR_Text2{$pos}
								$el:=Find in array:C230(aQR_Text3;$vt_descripcion1)
								If ($el>0)
									$vt_subTotal1:=String:C10(aQR_Real3{$el})
								Else 
									$vt_subTotal1:="0"
								End if 
							: (vQR_Long2=2)
								$vt_descripcion2:=aQR_Text2{$pos}
								$el:=Find in array:C230(aQR_Text3;$vt_descripcion2)
								If ($el>0)
									$vt_subTotal2:=String:C10(aQR_Real3{$el})
								Else 
									$vt_subTotal2:="0"
								End if 
							Else 
								$vt_descripcion3:=$vt_descripcion3+aQR_Text2{$pos}
								$el:=Find in array:C230(aQR_Text3;$vt_descripcion3)
								If ($el>0)
									$vt_subTotal3:=String:C10(aQR_Real3{$el})
								Else 
									$vt_subTotal3:="0"
								End if 
						End case 
					End if 
				End for 
				$vt_descripcion1:=ACTabc_GetFieldWithFormat ($vt_descripcion1;"A";15)
				ACTio_Num2Vars (Num:C11($vt_subTotal1);2;2;->$vt_entero;->$vt_dec)
				$vt_subTotal1:=$vt_entero+<>tXS_RS_DecimalSeparator+$vt_dec
				
				$vt_descripcion2:=ACTabc_GetFieldWithFormat ($vt_descripcion2;"A";20)
				ACTio_Num2Vars (Num:C11($vt_subTotal2);2;2;->$vt_entero;->$vt_dec)
				$vt_subTotal2:=$vt_entero+<>tXS_RS_DecimalSeparator+$vt_dec
				
				
				$vt_descripcion3:=ACTabc_GetFieldWithFormat ($vt_descripcion3;"A";15)
				ACTio_Num2Vars (Num:C11($vt_subTotal3);2;2;->$vt_entero;->$vt_dec)
				$vt_subTotal3:=$vt_entero+<>tXS_RS_DecimalSeparator+$vt_dec
				
				$text:="2"+$vt_rutApoderado+$vt_noBoleta+$vt_nombreDeudor+$vt_fechaVencimiento+$vt_moneda+$vt_montoTotal+$vt_numeroCuota+"1"+$vt_noCuota+$vt_diaVenc+$vt_noInicialBoleta+$vt_descripcion1+$vt_descripcion2+$vt_descripcion3+$vt_subTotal1+$vt_subTotal2+$vt_subTotal3+"\r"
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
	
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	If (Records in set:C195("selectionApdo")>0)
		CLEAR SET:C117("selectionApdo")
	End if 
	
	If (vl_otrasMonedas=1)
		<>vsACT_MonedaColegio:=$vt_monedaOrg
	End if 
Else 
	vb_detenerImp:=True:C214
End if 
ARRAY INTEGER:C220(aQR_Integer1;0)
ARRAY LONGINT:C221(al_anosAvisos;0)
ARRAY TEXT:C222(aQR_Text1;0)
