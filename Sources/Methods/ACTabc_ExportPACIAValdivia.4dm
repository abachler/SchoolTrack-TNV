//%attributes = {}
  //ACTabc_ExportPACIAValdivia

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_POINTER:C301($FieldPtr)
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_LONGINT:C283($i)
C_LONGINT:C283($vl_TotalRegistros)
C_LONGINT:C283($vl_Year;$vl_mes)
C_TEXT:C284($vt_diaCargo;$diaFecha)
C_TEXT:C284($vt_espacio1;$vt_espacio2;$vt_apellidoPaterno;$vt_apellidomaterno;$vt_nombres;$vt_espacio7;$vt_espacio8;$vt_espacio9;$vt_codMandatoPAC;$vt_fijo11;$vt_espacio12)
C_TEXT:C284($vt_fijo13;$vt_fijo14;$vt_monto;$vt_espacio16;$vt_numeroCta;$vt_codBanco;$vt_espacio19)
C_REAL:C285($vr_monto)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaPAC:=String:C10(Current date:C33(*);7)
vtotalPAC:=""
vnumTransPAC:=""

If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
End if 

$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)
If ($ref#?00:00:00?)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_TotalRegistros:=Records in set:C195("AvisosTodos")
	$text:=""
	
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
			
			READ ONLY:C145([ACT_Transacciones:178])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			QUERY SELECTION:C341([ACT_Cargos:173];vQR_Pointer1->#0)
			
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY LONGINT:C221(aQR_Longint3;0)
			ARRAY LONGINT:C221(aQR_Longint4;0)
			
			SELECTION TO ARRAY:C260([ACT_Cargos:173];aQR_Longint1;[ACT_Cargos:173]ID_CuentaCorriente:2;aQR_Longint2)
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
			QUERY SELECTION:C341([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Matriculado:29=True:C214)
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;aQR_Longint3)
			
			For ($i;1;Size of array:C274(aQR_Longint2))
				If (Find in array:C230(aQR_Longint3;aQR_Longint2{$i})#-1)
					APPEND TO ARRAY:C911(aQR_Longint4;aQR_Longint1{$i})
				End if 
			End for 
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];aQR_Longint4;"")
			CREATE SET:C116([ACT_Cargos:173];"setACT_Cargos2")
			
			ARRAY LONGINT:C221(aQR_Longint1;0)
			ARRAY LONGINT:C221(aQR_Longint2;0)
			ARRAY TEXT:C222(aQR_Text1;0)
			
			SELECTION TO ARRAY:C260([ACT_Cargos:173]Año:14;aQR_Longint1;[ACT_Cargos:173]Mes:13;aQR_Longint2)
			For ($i;1;Size of array:C274(aQR_Longint1))
				APPEND TO ARRAY:C911(aQR_Text1;String:C10(aQR_Longint1{$i};"0000")+String:C10(aQR_Longint2{$i};"00"))
			End for 
			AT_DistinctsArrayValues (->aQR_Text1)
			
			AT_Initialize (->aQR_Longint1;->aQR_Longint2)
			For ($i;1;Size of array:C274(aQR_Text1))
				APPEND TO ARRAY:C911(aQR_Longint1;Num:C11(Substring:C12(aQR_Text1{$i};1;4)))
				APPEND TO ARRAY:C911(aQR_Longint2;Num:C11(Substring:C12(aQR_Text1{$i};5;2)))
			End for 
			
			
			For ($i;1;Size of array:C274(aQR_Text1))
				USE SET:C118("setACT_Cargos2")
				$vl_Year:=aQR_Longint1{$i}
				$vl_mes:=aQR_Longint2{$i}
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Año:14=$vl_Year;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$vl_mes)
				
				ARRAY LONGINT:C221(aQR_Longint3;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint3;"")
				$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->aQR_Longint3;vQR_Pointer1;vd_FechaUF))
				
				$diaFecha:=ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))
				$vt_diaCargo:=$diaFecha+String:C10($vl_mes;"00")+String:C10($vl_Year;"0000")
				$vt_espacio1:=ACTabc_GetFieldWithFormat (" ";"A";8)
				$vt_espacio2:=ACTabc_GetFieldWithFormat (" ";"A";1)
				$vt_apellidoPaterno:=ACTabc_GetFieldWithFormat ([Personas:7]Apellido_paterno:3;"A";15)
				$vt_apellidomaterno:=ACTabc_GetFieldWithFormat ([Personas:7]Apellido_materno:4;"A";15)
				$vt_nombres:=ACTabc_GetFieldWithFormat ([Personas:7]Nombres:2;"A";15)
				$vt_espacio7:=ACTabc_GetFieldWithFormat (" ";"A";35)
				$vt_espacio8:=ACTabc_GetFieldWithFormat ("0";"N";10)
				$vt_espacio9:=ACTabc_GetFieldWithFormat (" ";"A";3)
				$vt_codMandatoPAC:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_CodMandatoPAC:62;"N";10)
				$vt_fijo11:="5"
				$vt_espacio12:=ACTabc_GetFieldWithFormat (" ";"A";14)
				$vt_fijo13:=ACTabc_GetFieldWithFormat ("0";"N";13)
				$vt_fijo14:=ACTabc_GetFieldWithFormat ("0";"N";13)
				$vt_monto:=ACTabc_GetFieldWithFormat (String:C10($vr_monto);"N";13)
				$vt_espacio16:=ACTabc_GetFieldWithFormat (" ";"A";3)
				$vt_numeroCta:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_Numero_Cta:51;"N";15)
				$vt_codBanco:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_ID_Banco_Cta:48;"N";3)
				$vt_espacio19:=ACTabc_GetFieldWithFormat (" ";"A";3)
				
				vtotalPAC:=String:C10(Num:C11(vtotalPAC)+$vr_monto)
				
				$text:=$vt_diaCargo+$vt_espacio1+$vt_espacio2+$vt_apellidoPaterno+$vt_apellidomaterno+$vt_nombres+$vt_espacio7+$vt_espacio8+$vt_espacio9
				$text:=$text+$vt_codMandatoPAC+$vt_fijo11+$vt_espacio12+$vt_fijo13+$vt_fijo14+$vt_monto+$vt_espacio16+$vt_numeroCta+$vt_codBanco+$vt_espacio19+"\r"
				IO_SendPacket ($ref;$text)
				vnumTransPAC:=String:C10(Num:C11(vnumTransPAC)+1)
			End for 
			CLEAR SET:C117("setACT_Cargos2")
		End if 
		USE SET:C118("AvisosTodos")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_TotalRegistros-Records in set:C195("AvisosTodos"))/$vl_TotalRegistros;"Exportando información...")
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	CLOSE DOCUMENT:C267($ref)
	vtotalPAC:=String:C10(Num:C11(vtotalPAC);"|Despliegue_ACT")
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 