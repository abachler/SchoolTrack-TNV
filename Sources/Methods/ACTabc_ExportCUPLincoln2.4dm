//%attributes = {}
  //ACTabc_ExportCUPLincoln2

  //banco bci
C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total;$vl_noCuotas)
C_REAL:C285($vr_monto)
C_TEXT:C284($vt_sede)
C_TEXT:C284($vt_monedaOrg;$vt_set;$vt_monto)
C_TEXT:C284(vQR_Text1;vQR_Text2)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([xxACT_Items:179])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

$vt_sede:="Valle Norte"

If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
End if 

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			
			If (KRL_isSameField (vQR_Pointer1;->[ACT_Cargos:173]Saldo:23))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
			End if 
			
			CREATE SET:C116([ACT_Cargos:173];"setACT_Cargos")
			ARRAY LONGINT:C221(aQR_Longint3;0)
			AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->aQR_Longint3)
			
			For (vQR_Long2;1;Size of array:C274(aQR_Longint3))
				USE SET:C118("setACT_Cargos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=aQR_Longint3{vQR_Long2})
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				
				If ((Records in selection:C76([ACT_Cargos:173])>0) & ([Cursos:3]Sede:19=$vt_sede))
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Cargos:173]ID_Apoderado:18)
					
					C_TEXT:C284($vt_id1;$vt_id2;$vt_nombre;$vt_vencimiento;$vt_moneda;$vt_montoTotal;$vt_noCuota;$vt_noTotalCuotas;$vt_mesesEntreCuotas;$vt_monthYearCuota1;$vt_diaVencimiento;$vt_numInicialBoleta;$vt_descripcion1;$vt_descripcion2;$vt_descripcion3;$vt_subTotal1;$vt_subTotal2;$vt_subTotal3;$vt_auxiliar1;$vt_auxiliar2;$vt_auxiliar3;$vt_auxiliar4;$vt_auxiliar5;$vt_auxiliar6;$vt_auxiliar7;$vt_auxiliar8;$vt_auxiliar9;$vt_auxiliar10)
					
					$vt_id1:=ACTabc_GetFieldWithFormat ([Personas:7]RUT:6;"N";11)
					$vt_id2:=ACTabc_GetFieldWithFormat ([Alumnos:2]RUT:5;"N";11)
					$vt_nombre:=ACTabc_GetFieldWithFormat ([Alumnos:2]apellidos_y_nombres:40;"A";60)
					If (vl_otrasMonedas=1)
						$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
					Else 
						$vt_moneda:=<>vsACT_MonedaColegio
					End if 
					Case of 
						: ($vt_moneda=ST_GetWord (ACT_DivisaPais ;1;";"))
							$vt_moneda:="0"
						: ($vt_moneda="Dólar@")
							$vt_moneda:="1"
						: ($vt_moneda="UF")
							$vt_moneda:="2"
						Else 
							$vt_moneda:=""
					End case 
					$vt_moneda:=ACTabc_GetFieldWithFormat ($vt_moneda;"A";20)
					
					$vt_numInicialBoleta:=ACTabc_GetFieldWithFormat (" ";"A";11)
					$vt_descripcion2:=ACTabc_GetFieldWithFormat (" ";"A";20)
					$vt_descripcion3:=ACTabc_GetFieldWithFormat (" ";"A";20)
					$vt_subTotal1:=ACTabc_GetFieldWithFormat (" ";"A";13)
					$vt_subTotal2:=ACTabc_GetFieldWithFormat (" ";"A";13)
					$vt_subTotal3:=ACTabc_GetFieldWithFormat (" ";"A";13)
					$vt_auxiliar1:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar2:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar3:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar4:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar5:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar6:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar7:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar8:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar9:=ACTabc_GetFieldWithFormat (" ";"A";40)
					$vt_auxiliar10:=ACTabc_GetFieldWithFormat (" ";"A";40)
					
					
					ARRAY REAL:C219(aQR_Real1;0)
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint4;0)
					ARRAY INTEGER:C220(aQR_Integer1;0)
					ARRAY TEXT:C222(aQR_Text1;0)
					C_LONGINT:C283($i)
					
					SELECTION TO ARRAY:C260([ACT_Cargos:173]Año:14;aQR_Longint1;[ACT_Cargos:173]Mes:13;aQR_Longint4)
					For ($i;1;Size of array:C274(aQR_Longint1))
						APPEND TO ARRAY:C911(aQR_Text1;String:C10(aQR_Longint1{$i};"0000")+String:C10(aQR_Longint4{$i};"00"))
					End for 
					AT_DistinctsArrayValues (->aQR_Text1)
					
					AT_Initialize (->aQR_Longint1;->aQR_Longint4)
					For ($i;1;Size of array:C274(aQR_Text1))
						APPEND TO ARRAY:C911(aQR_Longint1;Num:C11(Substring:C12(aQR_Text1{$i};1;4)))
						APPEND TO ARRAY:C911(aQR_Longint4;Num:C11(Substring:C12(aQR_Text1{$i};5;2)))
					End for 
					CREATE SET:C116([ACT_Cargos:173];"setACT_Cargos2")
					
					For (vQR_Long1;1;Size of array:C274(aQR_Text1))
						USE SET:C118("setACT_Cargos2")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Año:14=aQR_Longint1{vQR_Long1};*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=aQR_Longint4{vQR_Long1})
						
						If (vl_otrasMonedas=1)
							$vt_monedaOrg:=<>vsACT_MonedaColegio
							<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
						End if 
						$vt_set:="SetCargosCta"
						CREATE SET:C116([ACT_Cargos:173];$vt_set)
						$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$vt_set;vQR_Pointer1;vd_FechaUF))
						$vr_monto:=Round:C94($vr_monto;4)
						CLEAR SET:C117($vt_set)
						If (vl_otrasMonedas=1)
							<>vsACT_MonedaColegio:=$vt_monedaOrg
						End if 
						vQR_Text1:=""
						vQR_Text2:=""
						$vt_monto:=String:C10($vr_monto)
						ACTio_Num2Vars ($vr_monto;10;2;->vQR_Text1;->vQR_Text2)
						  //If (Position(".";$vt_monto)>0)
						  //$vt_monto:=Replace string($vt_monto;".";",")
						  //End if 
						$vt_monto:=vQR_Text1+","+vQR_Text2
						$vt_vencimiento:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+"/"+String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+"/"+String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7));"A";10)
						$vt_montoTotal:=ACTabc_GetFieldWithFormat ($vt_monto;"N";13)
						$vt_noCuota:=ACTabc_GetFieldWithFormat (String:C10(vQR_Long1);"N";2)
						$vt_noTotalCuotas:=ACTabc_GetFieldWithFormat (String:C10(Size of array:C274(aQR_Text1));"N";2)
						$vt_mesesEntreCuotas:=ACTabc_GetFieldWithFormat ("1";"A";2)
						$vt_monthYearCuota1:=ACTabc_GetFieldWithFormat (String:C10(aQR_Longint1{vQR_Long1})+String:C10(aQR_Longint4{vQR_Long1};"00");"A";6)
						$vt_diaVencimiento:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7));"A";2)
						ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16;<)
						QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
						If (Records in selection:C76([xxACT_Items:179])=1)
							$vt_descripcion1:=ACTabc_GetFieldWithFormat ([xxACT_Items:179]Glosa_de_Impresión:20;"A";20)
						Else 
							$vt_descripcion1:=ACTabc_GetFieldWithFormat ([ACT_Cargos:173]Glosa:12;"A";20)
						End if 
						vtotalCUP:=String:C10(Num:C11(vtotalCUP)+$vr_monto)
						vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
						$text:=$vt_id1+$vt_id2+$vt_nombre+$vt_vencimiento+$vt_moneda+$vt_montoTotal+$vt_noCuota+$vt_noTotalCuotas+$vt_mesesEntreCuotas+$vt_monthYearCuota1+$vt_diaVencimiento+$vt_numInicialBoleta+$vt_descripcion1+$vt_descripcion2+$vt_descripcion3+$vt_subTotal1+$vt_subTotal2+$vt_subTotal3+$vt_auxiliar1+$vt_auxiliar2+$vt_auxiliar3+$vt_auxiliar4+$vt_auxiliar5+$vt_auxiliar6+$vt_auxiliar7+$vt_auxiliar8+$vt_auxiliar9+$vt_auxiliar10+"\r"
						IO_SendPacket ($ref;$text)
					End for 
				End if 
			End for 
			CLEAR SET:C117("setACT_Cargos")
			CLEAR SET:C117("setACT_Cargos2")
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Exportando datos...")
		End if 
		USE SET:C118("AvisosTodos")
	End while 
	
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 