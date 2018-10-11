//%attributes = {}
  // QR_DocReport2Blob()
  // Por: Alberto Bachler: 08/03/13, 17:37:27
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_guardarConsulta)
C_LONGINT:C283($l_IdxFila;$l_anchoColumna;$l_columna;$l_columnaOculta;$l_columnas_objetos;$l_error;$l_filasConsulta;$l_numeroCampo;$l_numeroTabla;$l_valoresRepetidos)
C_LONGINT:C283($i_secciones;$l_indexObjeto)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_nombreDocumento;$t_encabezado;$t_formatoColumna;$t_html1;$t_html2;$t_nombreVariable;$t_objeto;$t_script)

ARRAY LONGINT:C221($al_idObjetos;0)

C_POINTER:C301(vy_Campo)
C_LONGINT:C283(vlSRP_AreaRef;vlSRP_objectID;vlSRP_rectTop;vlSRP_rectLeft;vlSRP_rectBottom;vlSRP_rectRight;vlSRP_objType;vlSRP_options;vlSRP_order;vlSRP_selected;vlSRP_tableNo;vlSRP_fieldNo;vlSRP_varType;vlSRP_arrayElem;vlSRP_calcType;vlSRP_rows;vlSRP_cols;vlSRP_repeatHOffset;vlSRP_repeatVOffset)
C_TEXT:C284(vtSRP_objName;vtSRP_calcName)
C_TEXT:C284(vtSR_StartScript;vtSR_BodyScript;vtSR_EndScript)
C_LONGINT:C283(vlQR_AreaRef)

EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"Log")
EM_ErrorManager ("SetCurrentMethod";Current method name:C684)

vl_ErrorCode:=0
ARRAY TEXT:C222(atQRY_Operador_Literal;0)
ARRAY TEXT:C222(atQRY_ValorLiteral;0)
ARRAY TEXT:C222(atQRY_Conector_Literal;0)
ARRAY POINTER:C280(ayQRY_Campos;0)
ARRAY TEXT:C222(atQRY_NombreVirtualCampo;0)
ARRAY TEXT:C222(atQRY_NombreInternoCampo;0)
If (BLOB size:C605([xShell_Reports:54]AssociatedQuery:21)>0)
	BLOB_Blob2Vars (->[xShell_Reports:54]AssociatedQuery:21;0;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral)
	$l_filasConsulta:=Size of array:C274(atQRY_Conector_Literal)
	ARRAY POINTER:C280(ayQRY_Campos;$l_filasConsulta)
	ARRAY LONGINT:C221(alQRY_numeroTabla;$l_filasConsulta)
	ARRAY LONGINT:C221(alQRY_numeroCampo;$l_filasConsulta)
	$b_guardarConsulta:=True:C214
	For ($l_IdxFila;1;$l_filasConsulta)
		EM_ErrorManager ("InstallFailedInstruction";"EXECUTE(\"vy_Campo:=->\""+atQRY_NombreInternoCampo{$l_IdxFila}+")")
		atQRY_NombreInternoCampo{$l_IdxFila}:=Replace string:C233(atQRY_NombreInternoCampo{$l_IdxFila};"[Alumnos_Notas]";"[Alumnos_Evaluaciones]")
		EXECUTE FORMULA:C63("vy_Campo:=->"+atQRY_NombreInternoCampo{$l_IdxFila})
		EM_ErrorManager ("ClearFailedInstruction")
		If (vl_ErrorCode=0)
			RESOLVE POINTER:C394(vy_Campo;$t_nombreVariable;$l_numeroTabla;$l_numeroCampo)
			If (($l_numeroTabla>0) & ($l_numeroCampo>0))
				alQRY_numeroTabla{$l_IdxFila}:=$l_numeroTabla
				alQRY_numeroCampo{$l_IdxFila}:=$l_numeroCampo
			End if 
			$b_guardarConsulta:=False:C215
		End if 
	End for 
	If ($b_guardarConsulta)
		BLOB_Variables2Blob (->[xShell_Reports:54]AssociatedQuery:21;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo)
		COMPRESS BLOB:C534([xShell_Reports:54]AssociatedQuery:21)
		SAVE RECORD:C53([xShell_Reports:54])
	Else 
		SET BLOB SIZE:C606([xShell_Reports:54]AssociatedQuery:21;0)
		SAVE RECORD:C53([xShell_Reports:54])
	End if 
End if 

Case of 
	: ([xShell_Reports:54]ReportType:2="gSR2")
		
		
	: ([xShell_Reports:54]ReportType:2="4DSE")
		$t_nombreDocumento:=Temporary folder:C486+[xShell_Reports:54]ReportName:26+".4QR"
		$h_refDocumento:=Create document:C266($t_nombreDocumento)
		SEND PACKET:C103($h_refDocumento;[xShell_Reports:54]Texto:5)
		CLOSE DOCUMENT:C267($h_refDocumento)
		DOCUMENT TO BLOB:C525(document;$x_blob)
		DELETE DOCUMENT:C159(document)
		[xShell_Reports:54]xReportData_:29:=$x_blob
		[xShell_Reports:54]Converted_v2003:19:=True:C214
		vlQR_AreaRef:=QR New offscreen area:C735
		QR SET REPORT TABLE:C757(vlQR_AreaRef;[xShell_Reports:54]MainTable:3)
		QR SET REPORT KIND:C738(vlQR_AreaRef;1)
		QR BLOB TO REPORT:C771(vlQR_AreaRef;[xShell_Reports:54]xReportData_:29)
		QR REPORT TO BLOB:C770(vlQR_AreaRef;[xShell_Reports:54]xReportData_:29)
		$l_columnas_objetos:=QR Count columns:C764(vlQR_AreaRef)
		For ($l_columna;1;$l_columnas_objetos)
			QR GET INFO COLUMN:C766(vlQR_AreaRef;$l_columna;$t_encabezado;$t_objeto;$l_columnaOculta;$l_anchoColumna;$l_valoresRepetidos;$t_formatoColumna)
			QR SET INFO COLUMN:C765(vlQR_AreaRef;$l_columna;$t_encabezado;QR_ValidaExpresionEnScript ($t_objeto);$l_columnaOculta;$l_anchoColumna;$l_valoresRepetidos;$t_formatoColumna)
		End for 
		QR REPORT TO BLOB:C770(vlQR_AreaRef;$x_blob)
		QR DELETE OFFSCREEN AREA:C754(vlQR_AreaRef)
End case 

If (BLOB size:C605($x_blob)>0)
	[xShell_Reports:54]xReportData_:29:=$x_blob
	[xShell_Reports:54]Converted_v2003:19:=True:C214
	[xShell_Reports:54]ExecuteBeforePrinting:4:=QR_ValidaExpresionEnScript ("QR_ChoosePeriod")
	SAVE RECORD:C53([xShell_Reports:54])
End if 


EM_ErrorManager ("Clear")

