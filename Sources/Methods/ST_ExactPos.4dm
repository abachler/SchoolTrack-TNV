//%attributes = {}
  //ST_ExactPos

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : st_ExactPos
	  //Autor: Alberto Bachler
	  //Creada el 16/5/96 a 09:16
	  //============================== DESCRIPCION ==============================
	  //Package: StringTools
	  //Descripción: Verifica si la posición de $1 en $2 es igual a $3 comparando ASCII
	  //Sintaxis: st_ExactPos(text;text;int) --> 1:Si, 2:No
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($0;$3;$i)
C_TEXT:C284($1;$2)
Case of 
	: ($3>Length:C16($2))
		$0:=0
	: ($1="")
		$0:=0
	: ($2="")
		$0:=0
	Else 
		$0:=1
		For ($i;$3;Length:C16($1))
			If ($1[[$i-$3+1]]#$2[[$i]])
				$0:=0
				$i:=Length:C16($1)
			End if 
		End for 
End case 