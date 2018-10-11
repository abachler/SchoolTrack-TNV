//%attributes = {}
  //ST_ExactlyEqual

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_ExactlyEqual
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 09:07
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Compara dos cadenas usando codigos ASCII
	  //Sintaxis: st_ExactEqual(Text;Text) --> 1:IGUAL, 0:DIFERENTE
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 22/6/99
	  //Autor: Alberto Bachler
	  //Descripción: A test is done comparing the length of the two string preventing
	  //a 4D bug when tryng an inexistant char on a string
	
End if 
C_LONGINT:C283($i;$0)
C_TEXT:C284($1)
$0:=1
If (Length:C16($1)=Length:C16($2))
	If ($1=$2)
		For ($i;1;Length:C16($1))
			If (Character code:C91($1[[$i]])#Character code:C91($2[[$i]]))
				$0:=0
				$i:=Length:C16($1)
			End if 
		End for 
	Else 
		$0:=0
	End if 
Else 
	$0:=0
End if 