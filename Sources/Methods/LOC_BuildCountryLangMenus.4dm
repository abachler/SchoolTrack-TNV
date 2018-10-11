//%attributes = {}
C_TEXT:C284(<>vmenu_Idiomas)
C_TEXT:C284(<>vmenu_paises)

ARRAY TEXT:C222($arregloListaPaises;0)
ARRAY TEXT:C222($arregloListaIdiomas;0)

ARRAY LONGINT:C221($pictLibRefs;0)
ARRAY TEXT:C222($pictLibNames;0)
PICTURE LIBRARY LIST:C564($pictLibRefs;$pictLibNames)

HL_List2Array ("XS_CountryCodes";->$arregloListaPaises)
HL_List2Array ("XS_LangageCodes";->$arregloListaIdiomas)

ARRAY TEXT:C222(<>atXS_PaisesNombres;0)
ARRAY TEXT:C222(<>atXS_PaisesCodigos;0)
ARRAY LONGINT:C221(<>alXS_PaisesIconos;0)
For ($i;1;Size of array:C274($arregloListaPaises))
	$codigo:=ST_GetWord ($arregloListaPaises{$i};1;":")
	$nombre:=Substring:C12(ST_GetWord ($arregloListaPaises{$i};2;":");2)
	APPEND TO ARRAY:C911(<>atXS_PaisesNombres;$nombre)
	APPEND TO ARRAY:C911(<>atXS_PaisesCodigos;$codigo)
	$el:=Find in array:C230($pictLibNames;"XS_Pais_MWI_"+Uppercase:C13($codigo))
	If ($el#-1)
		APPEND TO ARRAY:C911(<>alXS_PaisesIconos;$pictLibRefs{$el})
	Else 
		APPEND TO ARRAY:C911(<>alXS_PaisesIconos;0)
	End if 
End for 
SORT ARRAY:C229(<>atXS_PaisesNombres;<>atXS_PaisesCodigos;<>alXS_PaisesIconos)
ARRAY TEXT:C222(<>atXS_IdiomasNombres;0)
ARRAY TEXT:C222(<>atXS_IdiomasCodigos;0)
ARRAY LONGINT:C221(<>alXS_IdiomasIconos;0)
For ($i;1;Size of array:C274($arregloListaIdiomas))
	$codigo:=ST_GetWord ($arregloListaIdiomas{$i};1;":")
	$nombre:=Substring:C12(ST_GetWord ($arregloListaIdiomas{$i};2;":");2)
	APPEND TO ARRAY:C911(<>atXS_IdiomasNombres;$nombre)
	APPEND TO ARRAY:C911(<>atXS_IdiomasCodigos;$codigo)
	$el:=Find in array:C230($pictLibNames;"XS_Language_Mini_"+Uppercase:C13($codigo))
	If ($el#-1)
		APPEND TO ARRAY:C911(<>alXS_IdiomasIconos;$pictLibRefs{$el})
	Else 
		APPEND TO ARRAY:C911(<>alXS_IdiomasIconos;0)
	End if 
End for 
SORT ARRAY:C229(<>atXS_IdiomasNombres;<>atXS_IdiomasCodigos;<>alXS_IdiomasIconos)

AT_Insert (1;2;-><>atXS_PaisesNombres;-><>atXS_PaisesCodigos;-><>alXS_PaisesIconos;-><>atXS_IdiomasNombres;-><>atXS_IdiomasCodigos;-><>alXS_IdiomasIconos)
<>atXS_PaisesNombres{1}:=__ ("Todos")
<>atXS_PaisesCodigos{1}:="all"
<>alXS_PaisesIconos{1}:=31943
<>atXS_PaisesNombres{2}:="-"
<>atXS_PaisesCodigos{2}:=""
<>alXS_PaisesIconos{2}:=0
<>atXS_IdiomasNombres{1}:=__ ("Todos")
<>atXS_IdiomasCodigos{1}:="all"
<>alXS_IdiomasIconos{1}:=31944
<>atXS_IdiomasNombres{2}:="-"
<>atXS_IdiomasCodigos{2}:=""
<>alXS_IdiomasIconos{2}:=0

RELEASE MENU:C978(<>vmenu_Idiomas)
<>vmenu_Idiomas:=Create menu:C408

For ($i;1;Size of array:C274(<>atXS_IdiomasNombres))
	APPEND MENU ITEM:C411(<>vmenu_Idiomas;<>atXS_IdiomasNombres{$i})
	SET MENU ITEM ICON:C984(<>vmenu_Idiomas;$i;<>alXS_IdiomasIconos{$i})
	SET MENU ITEM PARAMETER:C1004(<>vmenu_Idiomas;$i;<>atXS_IdiomasCodigos{$i})
End for 

RELEASE MENU:C978(<>vmenu_paises)
<>vmenu_paises:=Create menu:C408

For ($i;1;Size of array:C274(<>atXS_PaisesNombres))
	APPEND MENU ITEM:C411(<>vmenu_paises;<>atXS_PaisesNombres{$i})
	SET MENU ITEM ICON:C984(<>vmenu_paises;$i;<>alXS_PaisesIconos{$i})
	SET MENU ITEM PARAMETER:C1004(<>vmenu_paises;$i;<>atXS_PaisesCodigos{$i})
End for 