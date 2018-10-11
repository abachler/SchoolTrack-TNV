//%attributes = {}
  // VS_RelationsALPsettings()
  // Por: Alberto Bachler: 06/03/13, 07:23:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_numeroTablaPrincipal)

If (False:C215)
	C_LONGINT:C283(VS_RelationsALPsettings ;$1)
End if 




$l_numeroTablaPrincipal:=$1
AL_UpdateArrays (xALP_RelatedFields;0)

READ ONLY:C145([xShell_Tables_RelatedFiles:243])
QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=$l_numeroTablaPrincipal)
LONGINT ARRAY FROM SELECTION:C647([xShell_Tables_RelatedFiles:243];$al_recNumTablas)

$l_tamañoArreglos:=Size of array:C274($al_recNumTablas)
ARRAY TEXT:C222(at_CampoPrincipal;$l_tamañoArreglos)
ARRAY TEXT:C222(at_CampoRelacionado;$l_tamañoArreglos)
ARRAY TEXT:C222(at_TipoRelacion;$l_tamañoArreglos)
ARRAY TEXT:C222(at_metodoBusqueda;$l_tamañoArreglos)
ARRAY INTEGER:C220(al_NumeroCampoPrincipal;$l_tamañoArreglos)
ARRAY INTEGER:C220(al_numeroTablaRelacionada;$l_tamañoArreglos)
ARRAY INTEGER:C220(al_numeroCampoRelacionado;$l_tamañoArreglos)

For ($i;1;Size of array:C274($al_recNumTablas))
	GOTO RECORD:C242([xShell_Tables_RelatedFiles:243];$al_recNumTablas{$i})
	at_CampoPrincipal{$i}:=[xShell_Tables_RelatedFiles:243]OrigenRelacion_NombreCampo:16
	at_CampoRelacionado{$i}:=[xShell_Tables_RelatedFiles:243]DestinoRelacion_NombreCampo:8
	at_TipoRelacion{$i}:=[xShell_Tables_RelatedFiles:243]TipoRelacion:9
	at_metodoBusqueda{$i}:=[xShell_Tables_RelatedFiles:243]MetodoBusqueda:7
	al_NumeroCampoPrincipal{$i}:=[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroCampo:3
	al_numeroTablaRelacionada{$i}:=[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1
	  //al_numeroCampoRelacionado{$i}:=[xShell_Tables_RelatedFiles]DestinoRelacion_NumeroTabla
	al_numeroCampoRelacionado{$i}:=[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroCampo:4  //MONO: Estaba tratando de eliminar una relación en mi local y me di cuenta de esto
	NEXT RECORD:C51([xShell_Tables_RelatedFiles:243])
End for 
AL_UpdateArrays (xALP_RelatedFields;Size of array:C274(at_CampoPrincipal))
AL_SetSort (xALP_RelatedFields;2)


IT_SetButtonState (Size of array:C274(al_NumeroCampoPrincipal)>0;->bDelRelation)
IT_SetButtonState (True:C214;->bRebuildRelations;->vi_RelatedReport;->hl_source;->hl_destination)
OBJECT SET ENTERABLE:C238(vs_searchmethod;Size of array:C274(al_NumeroCampoPrincipal)>0)

