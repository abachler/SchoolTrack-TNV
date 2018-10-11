//%attributes = {}
  //ACTabc_ExportCUPKent

C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"
C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_total)

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))

vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""

If (KRL_isSameField ($FieldPtr;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
	vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
Else 
	vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
End if 
NIV_LoadArrays 
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
If ($ref#?00:00:00?)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;>)
			
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
			KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
			ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
			
			C_LONGINT:C283($i;$j;$vl_cuotas)
			C_BOOLEAN:C305($vb_continuar)
			C_REAL:C285($vr_montoAdeudado)
			
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			
			CREATE SET:C116([ACT_Cargos:173];"ACTabc_CargosTodos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@Matricula@")
			CREATE SET:C116([ACT_Cargos:173];"ACTabc_CargosMat")
			DIFFERENCE:C122("ACTabc_CargosTodos";"ACTabc_CargosMat";"ACTabc_CargosTodos")
			
			
			For ($i;1;2)
				Case of 
					: ($i=1)
						USE SET:C118("ACTabc_CargosTodos")
					Else 
						USE SET:C118("ACTabc_CargosMat")
				End case 
				If (Records in selection:C76([ACT_Cargos:173])>0)
					$vb_continuar:=True:C214
				Else 
					$vb_continuar:=False:C215
				End if 
				$vl_cuotas:=0
				
				If ($vb_continuar)
					ARRAY LONGINT:C221(aQR_Longint1;0)
					ARRAY TEXT:C222(aQR_Text1;0)
					ARRAY LONGINT:C221(aQR_Longint2;0)
					ARRAY LONGINT:C221(aQR_Longint3;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint1;"")
					$vr_montoAdeudado:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";vQR_Pointer1;vQR_Pointer1;vd_FechaUF))
					For ($j;1;Size of array:C274(aQR_Longint1))
						GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint1{$j})
						If (Find in array:C230(aQR_Text1;String:C10([ACT_Cargos:173]Año:14)+String:C10([ACT_Cargos:173]Mes:13;"00"))=-1)
							APPEND TO ARRAY:C911(aQR_Text1;String:C10([ACT_Cargos:173]Año:14)+String:C10([ACT_Cargos:173]Mes:13;"00"))
							$vl_cuotas:=$vl_cuotas+1
						End if 
					End for 
					
					C_TEXT:C284($vt_campoFijo1;$vt_codigoFamilia;$vt_vacio1;$vt_vacio2;$vt_vacio3;$vt_vacio4;$vt_vacio5;$vt_vacio6;$vt_rutHM;$vt_dvHM;$vt_nombreHM;$vt_campoFijo2;$vt_ciudad;$vt_vacio7;$vt_vacio8;$vt_vacio9;$vt_vacio10;$vt_vacio11;$vt_vacio12;$vt_cuotas;$vt_cuotaNro;$vt_totalAviso;$vt_campoFijo3;$vt_campoFijo4;$vt_fecha)
					C_REAL:C285($vr_monto)
					$vt_campoFijo1:=ACTabc_GetFieldWithFormat ("5280";"N";4)
					$vt_codigoFamilia:=ACTabc_GetFieldWithFormat ([Familia:78]Codigo_interno:14;"N";5)
					$vt_vacio1:=""
					$vt_vacio2:=""
					$vt_vacio3:=""
					$vt_vacio4:=""
					$vt_vacio5:=""
					$vt_vacio6:=""
					$vt_rutHM:=Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1)
					$vt_dvHM:=Substring:C12([Alumnos:2]RUT:5;Length:C16([Alumnos:2]RUT:5))
					$vt_nombreHM:=[Alumnos:2]apellidos_y_nombres:40
					$vt_campoFijo2:=ACTabc_GetFieldWithFormat ("A1";"A";2)
					$vt_ciudad:=[Alumnos:2]Ciudad:15
					$vt_vacio7:=""
					$vt_vacio8:=""
					$vt_vacio9:=""
					$vt_vacio10:=""
					$vt_vacio11:=""
					$vt_vacio12:=""
					$vt_cuotas:=ACTabc_GetFieldWithFormat (String:C10($vl_cuotas);"N";2)
					$vt_cuotaNro:="1"
					$vr_monto:=Round:C94($vr_montoAdeudado/$vl_cuotas;<>vlACT_Decimales)
					$vt_totalAviso:=String:C10($vr_monto)
					vtotalCUP:=String:C10(Num:C11(vtotalCUP)+($vr_monto*$vl_cuotas))
					$vt_campoFijo3:="M"
					$vt_campoFijo4:="N"
					
					CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];aQR_Longint1;"")
					ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Año:14;>;[ACT_Cargos:173]Mes:13;>)
					$vt_fecha:=String:C10(Year of:C25([ACT_Cargos:173]Fecha_de_Vencimiento:7))+String:C10(Month of:C24([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")+String:C10(Day of:C23([ACT_Cargos:173]Fecha_de_Vencimiento:7);"00")
					
					ARRAY TEXT:C222(aQR_Text1;0)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_campoFijo1)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_codigoFamilia)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio1)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio2)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio3)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio4)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio5)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio6)
					
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					
					APPEND TO ARRAY:C911(aQR_Text1;$vt_rutHM)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_dvHM)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_nombreHM)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_campoFijo2)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_ciudad)
					
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					APPEND TO ARRAY:C911(aQR_Text1;"")
					
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio7)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio8)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio9)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio10)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio11)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_vacio12)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_cuotas)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_cuotaNro)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_totalAviso)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_campoFijo3)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_campoFijo4)
					APPEND TO ARRAY:C911(aQR_Text1;$vt_fecha)
					$text:=AT_array2text (->aQR_Text1;"\t")+"\r"
					IO_SendPacket ($ref;$text)
					vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
				End if 
			End for 
			
			CLEAR SET:C117("ACTabc_CargosTodos")
			CLEAR SET:C117("ACTabc_CargosMat")
			
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