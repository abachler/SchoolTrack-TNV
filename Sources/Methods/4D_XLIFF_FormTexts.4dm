//%attributes = {"executedOnServer":true}
  // Método: 4D_XLIFF_FormTexts
  //
  //
  // creado por Alberto Bachler Klein
  // el 20/02/18, 12:46:10
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_TEXT:C284($0)
C_POINTER:C301($1)
C_TEXT:C284($2)

C_LONGINT:C283($i;$i_elementos;$l_tipoObjeto)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_formName;$t_groupXML;$t_tableName;$t_titulo)

ARRAY LONGINT:C221($al_paginas;0)
ARRAY TEXT:C222($at_nombreObjetos;0)
ARRAY POINTER:C280($ay_nombreValiables;0)
ARRAY TEXT:C222($at_Titles;0)
ARRAY TEXT:C222($at_TransUnitID;0)



If (False:C215)
	C_TEXT:C284(4D_XLIFF_FormTexts ;$0)
	C_POINTER:C301(4D_XLIFF_FormTexts ;$1)
	C_TEXT:C284(4D_XLIFF_FormTexts ;$2)
End if 

$y_tabla:=$1
$t_formName:=$2

  //20180612 ASM 
ARRAY LONGINT:C221($al_tiposExcluidos;0)
APPEND TO ARRAY:C911($al_tiposExcluidos;2)  //picture
APPEND TO ARRAY:C911($al_tiposExcluidos;32)  //linea
APPEND TO ARRAY:C911($al_tiposExcluidos;18)  //botón invisible
APPEND TO ARRAY:C911($al_tiposExcluidos;31)  //Rectángulo
APPEND TO ARRAY:C911($al_tiposExcluidos;38)  //Plugin area
APPEND TO ARRAY:C911($al_tiposExcluidos;35)  //Matriz
APPEND TO ARRAY:C911($al_tiposExcluidos;21)  //línea
APPEND TO ARRAY:C911($al_tiposExcluidos;39)  //Sub form
APPEND TO ARRAY:C911($al_tiposExcluidos;33)  //rectangulo redondeado
APPEND TO ARRAY:C911($al_tiposExcluidos;19)  //picture button
APPEND TO ARRAY:C911($al_tiposExcluidos;40)  //web area
APPEND TO ARRAY:C911($al_tiposExcluidos;34)  //Object type oval
APPEND TO ARRAY:C911($al_tiposExcluidos;4)  //Object type picture input
APPEND TO ARRAY:C911($al_tiposExcluidos;17)  //Object type highlight button
APPEND TO ARRAY:C911($al_tiposExcluidos;12)  //Object type popup dropdown list //20180514 RCH No se puede activar porque no todos los objetos tienen fuente
APPEND TO ARRAY:C911($al_tiposExcluidos;36)  //Object type splitter
APPEND TO ARRAY:C911($al_tiposExcluidos;27)  //Object type progress indicator //20180625 RCH Se agrega progreso
APPEND TO ARRAY:C911($al_tiposExcluidos;29)  //Object type ruler //20180626 RCH

If (Is nil pointer:C315($y_tabla))
	$t_tableName:="[ProjectForm]"
	FORM LOAD:C1103($t_formName)
Else 
	$t_tableName:="["+Table name:C256($y_tabla)+"]"
	FORM LOAD:C1103($y_tabla->;$t_formName)
End if 

FORM GET OBJECTS:C898($at_nombreObjetos;$ay_nombreValiables;$al_paginas)
For ($i;1;Size of array:C274($at_nombreObjetos))
	$l_tipoObjeto:=OBJECT Get type:C1300(*;$at_nombreObjetos{$i})
	If (Find in array:C230($al_tiposExcluidos;$l_tipoObjeto)=-1)
		$t_titulo:=OBJECT Get title:C1068(*;$at_nombreObjetos{$i})
		If ($t_titulo#"")
			$t_titulo:=Replace string:C233($t_titulo;":xliff:";"")
			$t_nombreObjeto:=$at_nombreObjetos{$i}
			$t_nombreObjeto:=Replace string:C233($t_nombreObjeto;"&";"&amp;")
			$t_nombreObjeto:=Replace string:C233($t_nombreObjeto;"<";"&lt;")
			$t_nombreObjeto:=Replace string:C233($t_nombreObjeto;">";"&gt;")
			APPEND TO ARRAY:C911($at_TransUnitID;$t_nombreObjeto)
			
			$t_titulo:=Replace string:C233($t_titulo;"&";"&amp;")
			$t_titulo:=Replace string:C233($t_titulo;"<";"&lt;")
			$t_titulo:=Replace string:C233($t_titulo;">";"&gt;")
			APPEND TO ARRAY:C911($at_Titles;$t_titulo)
		End if 
	End if 
End for 
FORM UNLOAD:C1299

If (Size of array:C274($at_Titles)>0)
	$t_groupXML:=""
	
	$t_groupXML:=$t_groupXML+"<group resname=\""+$t_tableName+"\">\r"+"  <group resname=\""+$t_formName+"\">\r"
	For ($i_elementos;1;Size of array:C274($at_Titles))
		$t_groupXML:=$t_groupXML+"   <trans-unit id=\""+$at_TransUnitID{$i_elementos}+"\" resname=\""+$at_TransUnitID{$i_elementos}+"\">\r"
		$t_groupXML:=$t_groupXML+"      <source>"+$at_Titles{$i_elementos}+"</source>\r"
		$t_groupXML:=$t_groupXML+"      <target>"+$at_Titles{$i_elementos}+"</target>\r"
		$t_groupXML:=$t_groupXML+"   </trans-unit>\r"
	End for 
	$t_groupXML:=$t_groupXML+"  </group>\r</group>\r\r"
End if 



$0:=$t_groupXML




