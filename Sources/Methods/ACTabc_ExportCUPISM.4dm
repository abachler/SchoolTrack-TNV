//%attributes = {}
  //ACTabc_ExportCUPISM

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total;$vl_noCuotas)
C_REAL:C285($vr_monto)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
End if 

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

ACTcfg_OpcionesRazonesSociales ("CargaPrincipal")
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	
	  //encabezado
	QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Codigo:2="037";*)
	QUERY:C277([xxACT_Bancos:129];[xxACT_Bancos:129]Pais:3=<>gCountryCode)
	
	C_TEXT:C284($vt_constH;$vt_numeroConvenio;$vt_rutEmpresa;$vt_dvRutEmpresa;$vt_fechaProceso;$vt_filler)
	$vt_constH:=ACTabc_GetFieldWithFormat ("1";"N";1)
	$vt_numeroConvenio:=ACTabc_GetFieldWithFormat ([xxACT_Bancos:129]mx_NumeroConvenio:5;"N";4)
	$vt_rutEmpresa:=ACTabc_GetFieldWithFormat (Substring:C12(<>vsACT_RUT;1;Length:C16(<>vsACT_RUT)-1);"N";9)
	$vt_dvRutEmpresa:=ACTabc_GetFieldWithFormat (Substring:C12(<>vsACT_RUT;Length:C16(<>vsACT_RUT));"N";1)
	$vt_fechaProceso:=String:C10(Day of:C23(Current date:C33(*));"00")+String:C10(Month of:C24(Current date:C33(*));"00")+String:C10(Year of:C25(Current date:C33(*)))
	$vt_filler:=ACTabc_GetFieldWithFormat (" ";"A";167)
	$text:=$vt_constH+$vt_numeroConvenio+$vt_rutEmpresa+$vt_dvRutEmpresa+$vt_fechaProceso+$vt_filler+"\r"
	IO_SendPacket ($ref;$text)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			  //AT_Delete (1;1;->aQR_Longint4)
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
				
				If (Records in selection:C76([ACT_Cargos:173])>0)
					QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Cargos:173]ID_Apoderado:18)
					QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Cargos:173]ID_CuentaCorriente:2)
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
					
					C_TEXT:C284($vt_tipoR1;$vt_ide2;$vt_filler3;$vt_ide4;$vt_rut5;$vt_dvRut6;$vt_nombre7;$vt_direccion8;$vt_comuna9;$vt_ciudad10;$vt_codMoneda11;$vt_montoCuota12;$vt_fechaV13;$vt_recargo14;$vt_dctoProntoPago15;$vt_filler16)
					$vt_tipoR1:=ACTabc_GetFieldWithFormat ("2";"N";1)
					$vt_ide2:=ACTabc_GetFieldWithFormat ([Alumnos:2]RUT:5;"N";9)
					$vt_filler3:=ACTabc_GetFieldWithFormat (" ";"A";9)
					$vt_rut5:=ACTabc_GetFieldWithFormat (Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1);"N";9)
					$vt_dvRut6:=ACTabc_GetFieldWithFormat (Substring:C12([Personas:7]RUT:6;Length:C16([Personas:7]RUT:6));"A";1)
					$vt_nombre7:=ACTabc_GetFieldWithFormat ([Personas:7]Apellidos_y_nombres:30;"A";40)
					$vt_direccion8:=ACTabc_GetFieldWithFormat (Replace string:C233(Replace string:C233([Personas:7]Direccion:14;"\t";" ");"\r";". ");"A";40)
					$vt_comuna9:=ACTabc_GetFieldWithFormat ([Personas:7]Comuna:16;"A";20)
					$vt_ciudad10:=ACTabc_GetFieldWithFormat ([Personas:7]Ciudad:17;"A";20)
					C_TEXT:C284($vt_moneda)
					If (vl_otrasMonedas=1)
						$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
					Else 
						$vt_moneda:=<>vsACT_MonedaColegio
					End if 
					Case of 
						: ($vt_moneda=ST_GetWord (ACT_DivisaPais ;1;";"))
							$vt_codMoneda11:="0"
						: ($vt_moneda="UF")
							$vt_codMoneda11:="1"
						: ($vt_moneda="UTM")
							$vt_codMoneda11:="4"
						: ($vt_moneda="Dólar")
							$vt_codMoneda11:="8"
					End case 
					$vt_codMoneda11:=ACTabc_GetFieldWithFormat ($vt_codMoneda11;"A";1)
					$vt_recargo14:="S"
					$vt_dctoProntoPago15:="N"
					$vt_filler16:=ACTabc_GetFieldWithFormat (" ";"A";6)
					ARRAY REAL:C219(aQR_Real1;0)
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
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
						$vt_ide4:=ACTabc_GetFieldWithFormat (String:C10(vQR_Long1);"N";9)
						$vt_fechaV13:=ACTabc_GetFieldWithFormat (String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7));"N";8)
						ARRAY LONGINT:C221(aQR_Longint2;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2;"")
						$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->aQR_Longint2;vQR_Pointer1;vd_FechaUF))
						vQR_Text1:=""
						vQR_Text2:=""
						ACTio_Num2Vars ($vr_monto;10;5;->vQR_Text1;->vQR_Text2)
						$vt_montoCuota12:=ACTabc_GetFieldWithFormat (vQR_Text1+vQR_Text2;"N";15)
						vtotalCUP:=String:C10(Num:C11(vtotalCUP)+$vr_monto)
						vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
						$text:=$vt_tipoR1+$vt_ide2+$vt_filler3+$vt_ide4+$vt_rut5+$vt_dvRut6+$vt_nombre7+$vt_direccion8+$vt_comuna9+$vt_ciudad10+$vt_codMoneda11+$vt_montoCuota12+$vt_fechaV13+$vt_recargo14+$vt_dctoProntoPago15+$vt_filler16+"\r"
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
	
	C_TEXT:C284($vt_tipoRec;$vt_totalRec;$vt_montoTotal;$vt_filler)
	$vt_tipoRec:=ACTabc_GetFieldWithFormat ("4";"N";1)
	$vt_totalRec:=ACTabc_GetFieldWithFormat (vnumTransCUP;"N";6)
	vQR_Text1:=""
	vQR_Text2:=""
	ACTio_Num2Vars (Num:C11(vtotalCUP);10;5;->vQR_Text1;->vQR_Text2)
	$vt_montoTotal:=ACTabc_GetFieldWithFormat (vQR_Text1+vQR_Text2;"N";15)
	$vt_filler:=ACTabc_GetFieldWithFormat (" ";"A";168)
	
	$text:=$vt_tipoRec+$vt_totalRec+$vt_montoTotal+$vt_filler+"\r"
	IO_SendPacket ($ref;$text)
	
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 