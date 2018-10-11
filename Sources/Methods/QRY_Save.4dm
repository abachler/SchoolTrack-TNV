//%attributes = {}
  // QRY_Save()
  // Por: Alberto Bachler: 08/03/13, 18:29:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_numeroCampo;$i;$l_numeroTabla)
C_TEXT:C284($varName)


atQRY_NombreVirtualCampo:=0
atQRY_Conector_Literal:=0
atQRY_Operador_Literal:=0
ayQRY_Campos:=0
atQRY_NombreInternoCampo:=0
atQRY_ValorLiteral:=0


While ((atQRY_NombreVirtualCampo{Size of array:C274(atQRY_NombreVirtualCampo)}="") | (atQRY_Operador_Literal{Size of array:C274(atQRY_NombreVirtualCampo)}=""))
	AT_Delete (Size of array:C274(atQRY_NombreVirtualCampo);1;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->ayQRY_Campos;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo)
End while 

_O_ARRAY STRING:C218(80;aCsForms;0)
READ WRITE:C146([xShell_Queries:53])
QUERY:C277([xShell_Queries:53];[xShell_Queries:53]FileNo:5=Table:C252(vyQRY_TablePointer))
SELECTION TO ARRAY:C260([xShell_Queries:53]Name:2;aCsForms;[xShell_Queries:53];aCsFormsNo)
If (vl_currentFormula>=0)
	KRL_GotoRecord (->[xShell_Queries:53];vl_currentFormula;True:C214)
	vs_String1:=[xShell_Queries:53]Name:2
	vt_text1:=[xShell_Queries:53]Description:3
Else 
	vs_String1:=""
	vt_text1:=""
End if 


WDW_OpenDialogInDrawer (->[xShell_Queries:53];"ToSave")
CLOSE WINDOW:C154


If (ok=1)
	If (([xShell_Queries:53]Name:2#vs_String1) | (Record number:C243([xShell_Queries:53])<0))
		CREATE RECORD:C68([xShell_Queries:53])
		If (bSaveAsStandard=1)
			[xShell_Queries:53]No:1:=SQ_SeqNumber (->[xShell_Queries:53]No:1;True:C214)
		Else 
			[xShell_Queries:53]No:1:=SQ_SeqNumber (->[xShell_Queries:53]No:1)
		End if 
		
	End if 
	[xShell_Queries:53]Name:2:=vs_String1
	[xShell_Queries:53]Description:3:=vt_text1
	[xShell_Queries:53]FileNo:5:=Table:C252(vyQRY_TablePointer)
	
	If (atQR_Pais=Size of array:C274(atQR_Pais))
		[xShell_Queries:53]CodigoPais:11:=""
	Else 
		[xShell_Queries:53]CodigoPais:11:=ST_GetWord (atQR_Pais{atQR_Pais};1;":")
	End if 
	If (bSaveAsStandard=1)
		[xShell_Queries:53]InMenu:7:=String:C10([xShell_Queries:53]FileNo:5;"000")
	Else 
		If (binstall=1)
			If (r2=1)
				[xShell_Queries:53]InMenu:7:=String:C10([xShell_Queries:53]FileNo:5;"000")+"/"+<>tUSR_CurrentUser
			Else 
				[xShell_Queries:53]InMenu:7:=String:C10([xShell_Queries:53]FileNo:5;"000")
			End if 
		Else 
			[xShell_Queries:53]InMenu:7:=""
		End if 
	End if 
	ARRAY LONGINT:C221(alQRY_numeroTabla;Size of array:C274(atQRY_ValorLiteral))
	ARRAY LONGINT:C221(alQRY_numeroCampo;Size of array:C274(atQRY_ValorLiteral))
	For ($i;1;Size of array:C274(atQRY_ValorLiteral))
		If ($l_numeroCampo>0)
			RESOLVE POINTER:C394(ayQRY_Campos{$i};$t_nombreVariable;$l_numeroTabla;$l_numeroCampo)
			alQRY_numeroTabla{$i}:=$l_numeroTabla
			alQRY_numeroCampo{$i}:=$l_numeroCampo
		End if 
	End for 
	BLOB_Variables2Blob (->[xShell_Queries:53]xFormula:9;0;->alQRY_numeroTabla;->alQRY_numeroCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_NombreInternoCampo;->vb_ConsultaMultiAño;->bCurrentYearOnly;->alQRY_Operador_ID;->atQRY_Conector_Simbolo)
	COMPRESS BLOB:C534([xShell_Queries:53]xFormula:9)
	SAVE RECORD:C53([xShell_Queries:53])
End if 

UNLOAD RECORD:C212([xShell_Queries:53])
READ ONLY:C145([xShell_Queries:53])

QRY_BuildQueryMenu 