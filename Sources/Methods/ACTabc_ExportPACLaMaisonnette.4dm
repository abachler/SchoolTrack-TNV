//%attributes = {}
  // Método: ACTabc_ExportPACLaMaisonnette
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 25-06-10, 11:19:43
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text;$set)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total)
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

vFechaPAC:=String:C10(Current date:C33(*);7)
vtotalPAC:=""
vnumTransPAC:=""

ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"PAC";$fileName)
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
			
			$set:="setCargos"
			CREATE SET:C116([ACT_Cargos:173];$set)
			
			If (cb_IncluirSaldosAnteriores=1)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<=vdACT_Fecha2)
				If (cb_CalcularParaTodosLosAvisos=0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*))
				End if 
				CREATE SET:C116([ACT_Cargos:173];"setCargos2")
				UNION:C120($set;"setCargos2";$set)
			End if 
			
			If (Records in selection:C76([ACT_Cargos:173])>0)
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				
				$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$set;vQR_Pointer1;vd_FechaUF))
				
				C_TEXT:C284($vt_rut1;$vt_rut2;$vt_tf3;$vt_nombre4;$vt_tf5;$vt_codBanco6;$vt_ctaCteNo7;$vt_tf8;$vt_monto9)
				$vt_rut1:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_RUTTitutal_Cta:50;"N";9)
				$vt_rut2:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_RUTTitutal_Cta:50;"N";9)
				$vt_tf3:=ACTabc_GetFieldWithFormat (" ";"A";6)
				$vt_nombre4:=ACTabc_GetFieldWithFormat (ST_ReplaceAccentedChars ([Personas:7]Apellidos_y_nombres:30);"A";45)
				$vt_tf5:=ACTabc_GetFieldWithFormat ("2";"N";1)
				$vt_codBanco6:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_ID_Banco_Cta:48;"N";3)
				$vt_ctaCteNo7:=ACTabc_GetFieldWithFormat (Replace string:C233([Personas:7]ACT_Numero_Cta:51;"-";"");"A";20)
				$vt_tf8:=ACTabc_GetFieldWithFormat ("1";"N";1)
				$vt_monto9:=ACTabc_GetFieldWithFormat (String:C10($vr_monto);"N";9)
				
				vtotalPAC:=String:C10(Num:C11(vtotalPAC)+$vr_monto)
				vnumTransPAC:=String:C10(Num:C11(vnumTransPAC)+1)
				
				$text:=$vt_rut1+$vt_rut2+$vt_tf3+$vt_nombre4+$vt_tf5+$vt_codBanco6+$vt_ctaCteNo7+$vt_tf8+$vt_monto9+"\r"
				IO_SendPacket ($ref;$text)
			End if 
			SET_ClearSets ($set;"setCargos2")
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Exportando datos...")
		End if 
		USE SET:C118("AvisosTodos")
	End while 
	
	vtotalPAC:=String:C10(Num:C11(vtotalPAC);"|Despliegue_ACT")
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CLOSE DOCUMENT:C267($ref)
	CLEAR SET:C117("AvisosTodos")
	CLEAR SET:C117("selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 