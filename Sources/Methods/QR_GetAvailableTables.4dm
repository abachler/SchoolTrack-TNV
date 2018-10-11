//%attributes = {}
  // QR_GetAvailableTables()
  // Por: Alberto Bachler: 05/03/13, 19:01:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($i;$l_listaTablasLB;$l_listaTablasQR;$l_listaTablasSRP;$l_numeroTabla)
C_TEXT:C284($t_nombreTabla;$t_nombreTablaPrincipal)

ARRAY INTEGER:C220($al_tablasRelacionadas;0)



If (False:C215)
	C_POINTER:C301(QR_GetAvailableTables ;$1)
End if 


If (Count parameters:C259=1)
	$l_numeroTabla:=Table:C252($1)
Else 
	$l_numeroTabla:=Table:C252(yBWR_currentTable)
End if 

READ ONLY:C145([xShell_Tables:51])
QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$l_numeroTabla)

hl_AvailableTables:=New list:C375
$l_listaTablasSRP:=New list:C375
$l_listaTablasQR:=New list:C375
$l_listaTablasLB:=New list:C375
$t_nombreTablaPrincipal:=XSvs_nombreTablaLocal_Numero ($l_numeroTabla)

RELATE MANY:C262([xShell_Tables:51]NumeroDeTabla:5)
AT_DistinctsFieldValues (->[xShell_Tables_RelatedFiles:243]DestinoRelacion_NumeroTabla:1;->$al_tablasRelacionadas)
SORT ARRAY:C229($al_tablasRelacionadas;>)
For ($i;1;Size of array:C274($al_tablasRelacionadas))
	$t_nombreTabla:=XSvs_nombreTablaLocal_Numero ($al_tablasRelacionadas{$i})
	If (USR_checkRights ("L";Table:C252($al_tablasRelacionadas{$i})))
		APPEND TO LIST:C376(hl_AvailableTables;$t_nombreTabla;$al_tablasRelacionadas{$i})
		APPEND TO LIST:C376($l_listaTablasSRP;$t_nombreTabla;100+$al_tablasRelacionadas{$i})
		APPEND TO LIST:C376($l_listaTablasQR;$t_nombreTabla;10100+$al_tablasRelacionadas{$i})
		APPEND TO LIST:C376($l_listaTablasLB;$t_nombreTabla;100100+$al_tablasRelacionadas{$i})
	End if 
End for 

SORT LIST:C391($l_listaTablasSRP)
SELECT LIST ITEMS BY POSITION:C381($l_listaTablasSRP;1)
SORT LIST:C391($l_listaTablasQR)
SELECT LIST ITEMS BY POSITION:C381($l_listaTablasQR;1)
SORT LIST:C391($l_listaTablasLB)
SELECT LIST ITEMS BY POSITION:C381($l_listaTablasLB;1)

If ($t_nombreTablaPrincipal#"")
	If (Count list items:C380($l_listaTablasSRP)>0)
		INSERT IN LIST:C625($l_listaTablasSRP;*;$t_nombreTablaPrincipal;100+$l_numeroTabla)
		INSERT IN LIST:C625($l_listaTablasSRP;*;"-";0;0;False:C215)
	Else 
		APPEND TO LIST:C376($l_listaTablasSRP;$t_nombreTablaPrincipal;100+$l_numeroTabla)
	End if 
	If (Count list items:C380($l_listaTablasQR)>0)
		INSERT IN LIST:C625($l_listaTablasQR;*;$t_nombreTablaPrincipal;10100+$l_numeroTabla)
		INSERT IN LIST:C625($l_listaTablasQR;*;"-";0;0;False:C215)
	Else 
		APPEND TO LIST:C376($l_listaTablasQR;$t_nombreTablaPrincipal;10100+$l_numeroTabla)
	End if 
	If (Count list items:C380($l_listaTablasLB)>0)
		INSERT IN LIST:C625($l_listaTablasLB;*;$t_nombreTablaPrincipal;100100+$l_numeroTabla)
		INSERT IN LIST:C625($l_listaTablasLB;*;"-";0;0;False:C215)
	Else 
		APPEND TO LIST:C376($l_listaTablasLB;$t_nombreTablaPrincipal;100100+$l_numeroTabla)
	End if 
End if 

APPEND TO LIST:C376(HL_NewTemplatePopup;"SuperReport desde...";-2;$l_listaTablasSRP;True:C214)
APPEND TO LIST:C376(HL_NewTemplatePopup;"-";0;0;False:C215)
APPEND TO LIST:C376(HL_NewTemplatePopup;"Informe semi-automático desde...";-3;$l_listaTablasQR;True:C214)
APPEND TO LIST:C376(HL_NewTemplatePopup;"-";0;0;False:C215)
APPEND TO LIST:C376(HL_NewTemplatePopup;"Etiquetas desde...";-5;$l_listaTablasLB;True:C214)

SORT LIST:C391(hl_AvailableTables;>)
SET LIST PROPERTIES:C387(hl_AvailableTables;1;0;18)
If (Count list items:C380(hl_AvailableTables)>0)
	SELECT LIST ITEMS BY POSITION:C381(hl_AvailableTables;1)
	INSERT IN LIST:C625(hl_AvailableTables;*;$t_nombreTablaPrincipal;$l_numeroTabla)
Else 
	APPEND TO LIST:C376(hl_AvailableTables;$t_nombreTablaPrincipal;$l_numeroTabla)
End if 
SET LIST ITEM PROPERTIES:C386(hl_AvailableTables;$l_numeroTabla;False:C215;1;0)
SELECT LIST ITEMS BY POSITION:C381(hl_AvailableTables;1)
_O_REDRAW LIST:C382(hl_AvailableTables)


