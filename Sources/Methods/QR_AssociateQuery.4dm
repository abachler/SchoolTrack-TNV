//%attributes = {}
  // QR_AssociateQuery()
  // Por: Alberto Bachler: 05/03/13, 10:24:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i_fila;$l_filas)
C_TEXT:C284($t_nombreTabla)
C_POINTER:C301($y_nil)

C_TEXT:C284(vtQRY_ValorLiteral)
C_LONGINT:C283(bSrchSel)
ARRAY TEXT:C222(atQRY_Operador_Literal;0)
ARRAY TEXT:C222(atQRY_ValorLiteral;0)
ARRAY TEXT:C222(atQRY_Conector_Literal;0)
ARRAY POINTER:C280(ayQRY_Campos;0)
ARRAY TEXT:C222(atQRY_NombreVirtualCampo;0)
ARRAY TEXT:C222(atQRY_NombreInternoCampo;0)

ARRAY LONGINT:C221(alQRY_numeroTabla;0)
ARRAY LONGINT:C221(alQRY_numeroCampo;0)
ARRAY TEXT:C222(atQRY_Conector_Simbolo;0)
ARRAY LONGINT:C221(alQRY_Operador_ID;0)

If (IT_AltKeyIsDown )
	READ WRITE:C146([xShell_Reports:54])
	LOAD RECORD:C52([xShell_Reports:54])
	SET BLOB SIZE:C606([xShell_Reports:54]AssociatedQuery:21;0)
	SAVE RECORD:C53([xShell_Reports:54])
	KRL_ReloadAsReadOnly (->[xShell_Reports:54])
Else 
	If ([xShell_Reports:54]RelatedTable:14#0)
		vyQRY_TablePointer:=Table:C252([xShell_Reports:54]RelatedTable:14)
	Else 
		vyQRY_TablePointer:=vyQR_TablePointer
	End if 
	
	vtQRY_ValorLiteral:=""
	CREATE EMPTY SET:C140(vyQRY_TablePointer->;"SearchResult")
	READ ONLY:C145(vyQRY_TablePointer->)
	
	$t_nombreTabla:=XSvs_nombreTablaLocal_puntero (vyQRY_TablePointer)
	If ($t_nombreTabla#"")
		
		wSrchInSel:=False:C215
		vb_DontExecSearch:=True:C214
		
		QRY_QueryEditor (vyQRY_TablePointer;[xShell_Reports:54]AssociatedQuery:21)
		
		vb_DontExecSearch:=False:C215
		
		If (ok=1)
			READ WRITE:C146([xShell_Reports:54])
			LOAD RECORD:C52([xShell_Reports:54])
			BLOB_Variables2Blob (->[xShell_Reports:54]AssociatedQuery:21;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->vb_ConsultaMultiAño;->bCurrentYearOnly;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)
			COMPRESS BLOB:C534([xShell_Reports:54]AssociatedQuery:21)
			SAVE RECORD:C53([xShell_Reports:54])
			KRL_ReloadAsReadOnly (->[xShell_Reports:54])
		End if 
	Else 
		CD_Dlog (0;__ ("La estructura virtual no contiene ninguna definición de archivo utilizable en las consultas"))
	End if 
End if 

QR_LoadSelectedReport 