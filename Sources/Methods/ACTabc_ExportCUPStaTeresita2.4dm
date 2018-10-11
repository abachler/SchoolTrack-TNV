//%attributes = {}
  // Método: ACTabc_ExportCUPStaTeresita2
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 18-02-10, 17:04:13
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //ACTabc_ExportCUPStaTeresita2

  //Scotiabank
C_TEXT:C284($2;$3)  //No incluir en archivo de exportacion!!!
vVerifier:="ColegiumTransferFile"
vType:="exporter"

C_TEXT:C284($fileName;$text)
C_TIME:C306($ref)
C_POINTER:C301($FieldPtr)
C_LONGINT:C283($vl_noCuotas;vQR_Long1;$vl_total;$x)
ARRAY LONGINT:C221(aQR_Longint1;0)
C_LONGINT:C283($i)

$fileName:=$1
$FieldPtr:=Field:C253(Num:C11($2);Num:C11($3))
vFechaCUP:=String:C10(Current date:C33(*);7)
vtotalCUP:=""
vnumTransCUP:=""
$ref:=ACTabc_CreaDocumento ("Archivos Bancarios"+Folder separator:K24:12+"Cuponera";$fileName)
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([Alumnos:2])
If ($ref#?00:00:00?)
	ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"AvisosTodos")
	$vl_total:=Records in selection:C76([ACT_Avisos_de_Cobranza:124])
	C_REAL:C285($vr_monto)
	C_TEXT:C284($vt_docInstitucion1;$vt_codCoordinado2;$vt_codigoBancario3;$vt_fecha4;$vt_importe5;$vt_importe6;$vt_fecha7;$vt_nombre8)
	READ ONLY:C145([ACT_Transacciones:178])
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	C_POINTER:C301(vQR_Pointer1)
	If (KRL_isSameField (->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;$FieldPtr))
		vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
	Else 
		vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
	End if 
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Exportando datos...")
	While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
		USE SET:C118("AvisosTodos")
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"selectionApdo")
			DIFFERENCE:C122("AvisosTodos";"selectionApdo";"AvisosTodos")
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7;>;[ACT_Avisos_de_Cobranza:124]Mes:6;>)
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2#0)
			AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->aQR_Longint1)
			CREATE SET:C116([ACT_Cargos:173];"setCargosExport")
			
			For ($i;1;Size of array:C274(aQR_Longint1))
				USE SET:C118("setCargosExport")
				USE SET:C118("selectionApdo")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=aQR_Longint1{$i})
				ARRAY LONGINT:C221(aQR_Longint2;0)
				LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint2;"")
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=aQR_Longint1{$i})
				QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
				For ($x;1;Size of array:C274(aQR_Longint2))
					GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint2{$x})
					$vt_docInstitucion1:="20137973589"
					$vt_codCoordinado2:="01"
					$vt_codigoBancario3:=ACTabc_GetFieldWithFormat ([Alumnos:2]IDNacional_2:71;"N";10)
					$vt_fecha4:=Substring:C12(DTS_MakeFromDateTime ([ACT_Cargos:173]Fecha_de_Vencimiento:7);1;8)
					$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";vQR_Pointer1;vQR_Pointer1;vd_FechaUF))
					ACTio_Num2Vars ($vr_monto;7;2;->vQR_Text1;->vQR_Text2)
					$vt_importe5:=vQR_Text1+"."+vQR_Text2
					$vt_importe6:=$vt_importe5
					$vt_fecha7:=Substring:C12(DTS_MakeFromDateTime (Current date:C33(*));1;8)
					$vt_nombre8:=ACTabc_GetFieldWithFormat ([Alumnos:2]apellidos_y_nombres:40;"A";30)
					vnumTransCUP:=String:C10(Num:C11(vnumTransCUP)+1)
					vtotalCUP:=String:C10(Num:C11(vtotalCUP)+$vr_monto)
					$text:=$vt_docInstitucion1+$vt_codCoordinado2+$vt_codigoBancario3+$vt_fecha4+$vt_importe5+$vt_importe6+$vt_fecha7+$vt_nombre8+"\r"
					IO_SendPacket ($ref;$text)
				End for 
			End for 
			CLEAR SET:C117("setCargosExport")
		End if 
		USE SET:C118("AvisosTodos")
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;($vl_total-Records in set:C195("AvisosTodos"))/$vl_total;"Exportando datos...")
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	vtotalCUP:=String:C10(Num:C11(vtotalCUP);"|Despliegue_ACT")
	CLOSE DOCUMENT:C267($ref)
	SET_ClearSets ("AvisosTodos";"selectionApdo")
Else 
	vb_detenerImp:=True:C214
End if 