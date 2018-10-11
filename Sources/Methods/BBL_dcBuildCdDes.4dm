//%attributes = {}
  //BBL_dcBuildCdDes

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_dcBuildCdDes
	  //Autor: Alberto Bachler
	  //Creada el 1/8/95 a 8:25 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

C_TEXT:C284($text)
$text:=""
$ind:=" "*4
$cr:="\r"
If (Position:C15($cr;[BBL_Items:61]Titulos:5)>0)
	$title:=Substring:C12([BBL_Items:61]Titulos:5;1;Position:C15($cr;[BBL_Items:61]Titulos:5)-1)
Else 
	$title:=[BBL_Items:61]Titulos:5
End if 

If ([BBL_Items:61]Autores:7#"")
	$main:=ST_ClearExtraCR ([BBL_Items:61]Autores:7)
	If (Position:C15($cr;$main)>0)
		$main:=Substring:C12([BBL_Items:61]Autores:7;1;Position:C15($cr;$main)-1)
	End if 
	If (Position:C15("/";$main)>0)
		$main:=Substring:C12($main;1;Position:C15("/";$main)-1)
	End if 
	sMainEntry:=ST_ClearSpaces ($main)
Else 
	sMainEntry:=""
End if 

If ([BBL_Items:61]Autores:7#"")
	$Text:=$ind+$title
Else 
	$text:="\r"+$ind+$title
End if 

If ([BBL_Items:61]Autor_Texto_libre:22#"")
	$Text:=$Text+" / "+[BBL_Items:61]Autor_Texto_libre:22
End if 

$text:=$text+".-- "

If ([BBL_Items:61]Lugar_de_edicion:12#"")
	$text:=$text+""+[BBL_Items:61]Lugar_de_edicion:12+": "
End if 

If ([BBL_Items:61]Edicion:11#"")
	$text:=$text+[BBL_Items:61]Edicion:11
End if 

If ([BBL_Items:61]Editores:9#"")
	$text:=$text+[BBL_Items:61]Editores:9+", "+[BBL_Items:61]Fecha_de_edicion:10
End if 

If ([BBL_Items:61]Descripción:14#"")
	$text:=$text+"\r"+$ind+[BBL_Items:61]Descripción:14
End if 

If ([BBL_Items:61]Serie_Nombre:26#"")
	$text:=$text+" -- ("+[BBL_Items:61]Serie_Nombre:26
	
	If ([BBL_Items:61]Serie_ISSN:31#"")
		$text:=$text+"\r"+", ISSN: "+[BBL_Items:61]Serie_ISSN:31
	End if 
	If ([BBL_Items:61]Serie_No:27#"")
		$text:=$text+"; "+[BBL_Items:61]Serie_No:27+"."
	End if 
	$text:=$text+")"
End if 

If ([BBL_Items:61]Notas:16#"")
	$text:=$text+$cr+$ind+[BBL_Items:61]Notas:16
End if 

If ([BBL_Items:61]ISBN:3#"")
	$text:=$text+"\r"+$ind+"ISBN: "+[BBL_Items:61]ISBN:3
End if 
If ([BBL_Items:61]LCCN:23#"")
	$text:=$text+"\r"+$ind+"LCCN: "+[BBL_Items:61]LCCN:23
End if 
  //[Items]Texto Ficha:=$text

tdcClass:=Replace string:C233([BBL_Items:61]Clasificacion:2;" ";"\r")
$refLines:=ST_countlines (tdcClass)
If (sMainEntry#"")
	tText:=sMainEntry+"\r"+$text
Else 
	tText:=$text
End if 
tText:=("\r"*($refLines-1))+tText

[BBL_Items:61]Texto_Ficha:25:=tText