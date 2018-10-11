  // [xShell_Reports].Repositorio.hlRIN_Modulos()
  // Por: Alberto Bachler K.: 21-08-14, 11:21:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_listaPaneles)
C_LONGINT:C283($l_IdModulo)
C_TEXT:C284($t_NombreModulo;$t_refPanelesModulo)


C_LONGINT:C283(hlRIN_Paneles)

GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$l_IdModulo;$t_NombreModulo)

If (Is a list:C621(hlRIN_Paneles))
	HL_ClearList (hlRIN_Paneles)
End if 
If ($l_IdModulo>0)
	$t_refPanelesModulo:=XS_GetBlobName ("browser";$l_IdModulo;<>vtXS_CountryCode;<>vtXS_langage)
	$x_listaPaneles:=PREF_fGetBlob (0;$t_refPanelesModulo;$x_listaPaneles)
	If (BLOB size:C605($x_listaPaneles)>0)
		hlRIN_Paneles:=BLOB to list:C557($x_listaPaneles)
	End if 
	SELECT LIST ITEMS BY POSITION:C381(hlRIN_Paneles;1)
	INSERT IN LIST:C625(hlRIN_Paneles;*;"Todos";-1)
	GET LIST ITEM:C378(hlRIN_Paneles;1;$l_IdModulo;$t_NombreModulo)
Else 
	hlRIN_Paneles:=New list:C375
	APPEND TO LIST:C376(hlRIN_Paneles;"Todos";-1)
End if 
_O_REDRAW LIST:C382(hlRIN_Paneles)


POST KEY:C465(Character code:C91("+");Command key mask:K16:1+Option key mask:K16:7)