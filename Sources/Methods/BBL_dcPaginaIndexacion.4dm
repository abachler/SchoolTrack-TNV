//%attributes = {}
  // BBL_dcPaginaIndexacion()
  // Por: Alberto Bachler K.: 10-12-14, 18:22:29
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i)
C_POINTER:C301($y_contenedor;$y_Materias;$y_terminos)
C_TEXT:C284($t_refjSon)
C_OBJECT:C1216($ob_Materias)

ARRAY POINTER:C280($ay_Jerarquia;0)
ARRAY TEXT:C222($at_terminos;0)
ARRAY TEXT:C222($at_terminos2;0)

$y_Materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")
AT_Initialize ($y_Materias)

  //$t_refjSon:=JSON Parse text ([BBL_Items]Materias_json)
  //JSON_ExtraeValorElemento ($t_refjSon;$y_Materias;"materiasCatalogacion_KW")
  //JSON CLOSE ($t_refjSon)
$ob_Materias:=OB_JsonToObject ([BBL_Items:61]Materias_json:53)
OB_GET ($ob_Materias;$y_Materias;"materiasCatalogacion_KW")

$y_terminos:=OBJECT Get pointer:C1124(Object named:K67:5;"terminos")
$y_contenedor:=OBJECT Get pointer:C1124(Object named:K67:5;"contenedores")
AT_Initialize ($y_terminos;$y_contenedor)

DISTINCT VALUES:C339([BBL_Items:61]Autores:7;$at_terminos)
For ($i;1;Size of array:C274($at_terminos))
	APPEND TO ARRAY:C911($y_contenedor->;__ ("Autores"))
	APPEND TO ARRAY:C911($y_terminos->;$at_terminos{$i})
End for 

DISTINCT VALUES:C339([BBL_Items:61]Titulos:5;$at_terminos)
For ($i;1;Size of array:C274($at_terminos))
	APPEND TO ARRAY:C911($y_contenedor->;__ ("Titulos"))
	APPEND TO ARRAY:C911($y_terminos->;$at_terminos{$i})
End for 

DISTINCT VALUES:C339([BBL_Items:61]Editores:9;$at_terminos)
For ($i;1;Size of array:C274($at_terminos))
	APPEND TO ARRAY:C911($y_contenedor->;__ ("Editores"))
	APPEND TO ARRAY:C911($y_terminos->;$at_terminos{$i})
End for 

DISTINCT VALUES:C339([BBL_Items:61]NotasDeContenido:50;$at_terminos)
For ($i;1;Size of array:C274($at_terminos))
	APPEND TO ARRAY:C911($y_contenedor->;__ ("Notas de contenido"))
	APPEND TO ARRAY:C911($y_terminos->;$at_terminos{$i})
End for 

DISTINCT VALUES:C339([BBL_Items:61]Notas:16;$at_terminos)
For ($i;1;Size of array:C274($at_terminos))
	APPEND TO ARRAY:C911($y_contenedor->;__ ("Notas"))
	APPEND TO ARRAY:C911($y_terminos->;$at_terminos{$i})
End for 

DISTINCT VALUES:C339([BBL_Items:61]Resumen:17;$at_terminos)
For ($i;1;Size of array:C274($at_terminos))
	APPEND TO ARRAY:C911($y_contenedor->;__ ("Resumen"))
	APPEND TO ARRAY:C911($y_terminos->;$at_terminos{$i})
End for 

DISTINCT VALUES:C339([BBL_Items:61]Serie_Nombre:26;$at_terminos)
For ($i;1;Size of array:C274($at_terminos))
	APPEND TO ARRAY:C911($y_contenedor->;__ ("Serie"))
	APPEND TO ARRAY:C911($y_terminos->;$at_terminos{$i})
End for 

For ($i;Size of array:C274($y_terminos->);1;-1)
	If ($y_terminos->{$i}="")
		AT_Delete ($i;1;$y_contenedor;$y_terminos)
	End if 
End for 

APPEND TO ARRAY:C911($ay_Jerarquia;$y_contenedor)
LISTBOX SET HIERARCHY:C1098(*;"lb_terminos";True:C214;$ay_Jerarquia)

IT_SetButtonState (USR_checkRights ("M";->[BBL_Items:61]);->bdeleteSubjects;->bThesaurus)
_O_DISABLE BUTTON:C193(bdeleteSubjects)
SELECT LIST ITEMS BY REFERENCE:C630(hlTab_BBL_items;2)

OBJECT SET TITLE:C194(*;"textoEjemplo";__ ("Digite aquí la materia a agregar")*Num:C11((OBJECT Get pointer:C1124(Object named:K67:5;"palabraClave"))->=""))

FORM GOTO PAGE:C247(2)


