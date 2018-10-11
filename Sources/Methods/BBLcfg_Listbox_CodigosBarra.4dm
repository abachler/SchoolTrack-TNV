//%attributes = {}
  // BBLcfg_Listbox_CodigosBarra()
  // Por: Alberto Bachler: 17/09/13, 12:46:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_elementos)
C_LONGINT:C283($l_registros)


ARRAY LONGINT:C221(al_estiloPrefijos_registro;0)
ARRAY LONGINT:C221(al_estiloPrefijos_lector;0)
ARRAY LONGINT:C221(al_estiloPrefijos_registro;Size of array:C274(<>alBBL_IDMedia))
ARRAY LONGINT:C221(al_estiloPrefijos_lector;Size of array:C274(<>alBBL_GruposLectores))
ARRAY LONGINT:C221(al_NumeroRegistrosMediaTrack;Size of array:C274(<>alBBL_IDMedia))
ARRAY LONGINT:C221(al_NumeroLectoresMediaTrack;Size of array:C274(<>alBBL_GruposLectores))

SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Automatic:K51:4;Structure configuration:K51:2)
For ($i_elementos;1;Size of array:C274(<>alBBL_IDMedia))
	QUERY:C277([BBL_Registros:66];[BBL_Items:61]ID_Media:48=<>alBBL_IDMedia{$i_elementos})
	If (<>alBBL_IDMedia{$i_elementos}=<>vlBBL_MediaPorDefecto)
		al_estiloPrefijos_registro{$i_elementos}:=Bold:K14:2
	Else 
		al_estiloPrefijos_registro{$i_elementos}:=Plain:K14:1
	End if 
	al_NumeroRegistrosMediaTrack{$i_elementos}:=$l_registros
End for 
SET FIELD RELATION:C919([BBL_Registros:66]Número_de_item:1;Structure configuration:K51:2;Structure configuration:K51:2)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
SORT ARRAY:C229(al_NumeroRegistrosMediaTrack;<>alBBL_IDMedia;<>atBBL_Media;<>asBBL_AbrevMedia;al_estiloPrefijos_registro;<)


SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
For ($i_elementos;1;Size of array:C274(<>alBBL_GruposLectores))
	$l_registros:=0
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]ID_GrupoLectores:37=<>alBBL_GruposLectores{$i_elementos})
	al_NumeroLectoresMediaTrack{$i_elementos}:=$l_registros
	If (<>alBBL_GruposLectores{$i_elementos}=<>vlBBL_GrupoLectorPorDefecto)
		al_estiloPrefijos_lector{$i_elementos}:=Bold:K14:2
	Else 
		al_estiloPrefijos_lector{$i_elementos}:=Plain:K14:1
	End if 
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
SORT ARRAY:C229(al_NumeroLectoresMediaTrack;<>alBBL_GruposLectores;<>atBBL_GruposLectores;<>asBBL_AbrevGruposLectores;al_estiloPrefijos_lector;<)


