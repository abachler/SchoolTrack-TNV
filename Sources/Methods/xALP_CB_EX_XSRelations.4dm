//%attributes = {}
  // xALP_CB_EX_XSRelations()
  // Por: Alberto Bachler: 06/03/13, 07:51:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_columna;$l_fila;$l_numeroCampoPrincipal;$l_numeroCampoRelacionado;$l_numeroTablaRelacionada)
C_TEXT:C284($t_llaveTablaPrincipal;$t_llaveTablaRelacionada)

If (False:C215)
	C_BOOLEAN:C305(xALP_CB_EX_XSRelations ;$0)
	C_LONGINT:C283(xALP_CB_EX_XSRelations ;$1)
	C_LONGINT:C283(xALP_CB_EX_XSRelations ;$2)
End if 

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	If (AL_GetCellMod (xALP_RelatedFields)=1)
		AL_GetCurrCell (xALP_RelatedFields;$l_columna;$l_fila)
		If ($l_fila>0)
			$l_numeroCampoPrincipal:=al_NumeroCampoPrincipal{$l_fila}
			$l_numeroCampoRelacionado:=al_numeroCampoRelacionado{$l_fila}
			$l_numeroTablaRelacionada:=al_numeroTablaRelacionada{$l_fila}
			AL_UpdateArrays (xALP_RelatedFields;0)
			
			$t_llaveTablaPrincipal:=KRL_MakeStringAccesKey (->[xShell_Tables:51]NumeroDeTabla:5;->$l_numeroCampoPrincipal)
			$t_llaveTablaRelacionada:=KRL_MakeStringAccesKey (->$l_numeroTablaRelacionada;->$l_numeroCampoRelacionado)
			READ WRITE:C146([xShell_Tables_RelatedFiles:243])
			QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_RefTablaCampo:12=$t_llaveTablaPrincipal;*)
			QUERY:C277([xShell_Tables_RelatedFiles:243]; & ;[xShell_Tables_RelatedFiles:243]DestinoRelacion_RefTablaCampo:13=$t_llaveTablaRelacionada)
			[xShell_Tables_RelatedFiles:243]TipoRelacion:9:=at_TipoRelacion{$l_fila}
			[xShell_Tables_RelatedFiles:243]MetodoBusqueda:7:=at_metodoBusqueda{$l_fila}
			SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
			AL_UpdateArrays (xALP_RelatedFields;-2)
		End if 
	End if 
End if 