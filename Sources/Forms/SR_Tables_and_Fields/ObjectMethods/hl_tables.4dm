  // SR_Tables_and_Fields.hl_tables()
  // Por: Alberto Bachler: 07/03/13, 08:52:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_Indexado;$b_invisible;$b_unico)
C_LONGINT:C283($i;$l_numeroTabla;$l_largo;$l_tipo;$l_tipoCampo;$t_nombreTabla)
GET LIST ITEM:C378(hl_tables;*;$l_numeroTabla;$t_nombreTabla)

HL_ClearList (hl_Fields)
hl_Fields:=New list:C375

QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$l_numeroTabla)
For ($i;1;Records in selection:C76([xShell_Fields:52]))
	$y_campo:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
	$y_campo:=Field:C253([xShell_Fields:52]NumeroTabla:1;[xShell_Fields:52]NumeroCampo:2)
	If (XSvs_esCampoValidoEnEditores ($y_campo))
		APPEND TO LIST:C376(hl_Fields;XSvs_nombreCampoLocal_puntero ($y_campo);[xShell_Fields:52]NumeroCampo:2)
	End if 
	NEXT RECORD:C51([xShell_Fields:52])
End for 
SORT LIST:C391(hl_Fields;>)

