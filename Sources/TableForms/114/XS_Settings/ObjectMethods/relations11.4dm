  // [xShell_Dialogs].XS_Settings.relations11()
  // Por: Alberto Bachler: 06/03/13, 08:21:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_fila;$l_numeroCampoPrincipal;$l_numeroCampoRelacionado;$l_numeroTablaRelacionada)
C_TEXT:C284($t_llaveTablaPrincipal;$t_llaveTablaRelacionada)


C_POINTER:C301(vy_RelationSource;vy_RelationDestination)

$l_fila:=AL_GetLine (xALP_RelatedFields)
If ($l_fila>0)
	$l_numeroCampoPrincipal:=al_NumeroCampoPrincipal{$l_fila}
	$l_numeroCampoRelacionado:=al_numeroCampoRelacionado{$l_fila}
	$l_numeroTablaRelacionada:=al_numeroTablaRelacionada{$l_fila}
	AL_UpdateArrays (xALP_RelatedFields;0)
	$t_llaveTablaPrincipal:=KRL_MakeStringAccesKey (->[xShell_Tables:51]NumeroDeTabla:5;->$l_numeroCampoPrincipal)
	$t_llaveTablaRelacionada:=KRL_MakeStringAccesKey (->$l_numeroTablaRelacionada;->$l_numeroCampoRelacionado)
	QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_RefTablaCampo:12=$t_llaveTablaPrincipal;*)
	QUERY:C277([xShell_Tables_RelatedFiles:243]; & ;[xShell_Tables_RelatedFiles:243]DestinoRelacion_RefTablaCampo:13=$t_llaveTablaRelacionada)
	OK:=KRL_DeleteRecord (->[xShell_Tables_RelatedFiles:243])
	If (OK=1)
		AT_Delete ($l_fila;1;->at_CampoPrincipal;->at_CampoRelacionado;->at_TipoRelacion;->at_metodoBusqueda;->ab_Informes;->al_NumeroCampoPrincipal;->al_numeroCampoRelacionado;->al_numeroCampoRelacionado)
	End if 
	AL_UpdateArrays (xALP_RelatedFields;-2)
End if 

