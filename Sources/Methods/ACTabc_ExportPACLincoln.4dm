//%attributes = {}
  //ACTabc_ExportPACLincoln
C_TEXT:C284($1;$2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total)
C_REAL:C285($vr_monto)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

ALERT:C41("Prueba caracteres - áéíóú")

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

ACTcfg_OpcionesRazonesSociales ("CargaPrincipal")
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
					
					ARRAY LONGINT:C221(aQR_Longint2;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2;"")
					$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->aQR_Longint2;vQR_Pointer1;vd_FechaUF))
					
					C_TEXT:C284($vt_fechaCargo;$vt_rut;$vt_dvRut;$vt_apellidoPaterno;$vt_apellidoMaterno;$vt_nombre;$vt_direccion;$vt_fax;$vt_codComuna;$vt_identificador;$vt_numDcto;$vt_valorDcto;$vt_dctoDcto;$vt_montoCobrar;$vt_formaDePago;$vt_noCtaCte;$vt_codBanco;$vt_ofDestino)
					$vt_fechaCargo:=ACTabc_GetFieldWithFormat (ST_Boolean2Str ((cb_DiaApdo=1);String:C10([Personas:7]ACT_DiaCargo:61;"00");String:C10(vl_DiaApdo;"00"))+String:C10(vl_MesApdo;"00")+String:C10(vl_AñoApdo;"0000");"N";8)
					$vt_rut:=ACTabc_GetFieldWithFormat (Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1);"N";8)
					$vt_dvRut:=ACTabc_GetFieldWithFormat (Substring:C12([Alumnos:2]RUT:5;Length:C16([Alumnos:2]RUT:5)-1);"N";1)
					$vt_apellidoPaterno:=ACTabc_GetFieldWithFormat ([Alumnos:2]Apellido_paterno:3;"A";15)
					$vt_apellidoMaterno:=ACTabc_GetFieldWithFormat ([Alumnos:2]Apellido_materno:4;"A";15)
					$vt_nombre:=ACTabc_GetFieldWithFormat ([Alumnos:2]Nombres:2;"A";15)
					$vt_direccion:=ACTabc_GetFieldWithFormat ([Personas:7]Direccion:14;"A";35)
					$vt_fax:=ACTabc_GetFieldWithFormat ("0";"N";10)
					$vt_codComuna:=ACTabc_GetFieldWithFormat ("";"A";3)
					$vt_identificador:=ACTabc_GetFieldWithFormat (ST_RigthChars (("0"*9)+[Personas:7]RUT:6;9);"A";25)
					$vt_numDcto:=ACTabc_GetFieldWithFormat ("";"A";25)
					$vt_valorDcto:=ACTabc_GetFieldWithFormat ("0";"N";13)
					$vt_dctoDcto:=ACTabc_GetFieldWithFormat ("0";"N";13)
					$vt_montoCobrar:=ACTabc_GetFieldWithFormat (String:C10($vr_monto);"N";13)
					$vt_formaDePago:=ACTabc_GetFieldWithFormat ("";"N";3)
					$vt_noCtaCte:=ACTabc_GetFieldWithFormat (Replace string:C233(Replace string:C233(Replace string:C233([Personas:7]ACT_Numero_Cta:51;"-";"");".";"");" ";"");"N";15)
					$vt_codBanco:=ACTabc_GetFieldWithFormat ([Personas:7]ACT_ID_Banco_Cta:48;"N";3)
					$vt_ofDestino:=ACTabc_GetFieldWithFormat ("";"N";3)
					
					vtotalPAC:=String:C10(Num:C11(vtotalPAC)+$vr_monto)
					vnumTransPAC:=String:C10(Num:C11(vnumTransPAC)+1)
					
					$text:=$vt_fechaCargo+$vt_rut+$vt_dvRut+$vt_apellidoPaterno+$vt_apellidoMaterno+$vt_nombre+$vt_direccion+$vt_fax+$vt_codComuna+$vt_identificador+$vt_numDcto+$vt_valorDcto+$vt_dctoDcto+$vt_montoCobrar+$vt_formaDePago+$vt_noCtaCte+$vt_codBanco+$vt_ofDestino+"\r"
					IO_SendPacket ($ref;$text)
				End if 
			End for 
			CLEAR SET:C117("setACT_Cargos")
			CLEAR SET:C117("setACT_Cargos2")
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