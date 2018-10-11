//%attributes = {}
  //ST_ClrWildChars

If (False:C215)
	  // ===== IDENTIFICACION =====
	  // FUNCTION: Procédure : st_ClrWildChars
	  // BY: Alberto Bachler
	  // DATE: 21/03/96 a 17:30
	  // ===== DESCRIPCION =====
	  //Limpia la cadena eliminando los caracteres anteriores al código 32 (space)
	
	  // ===== RELACIONES =====
	  // PACKAGE: String Tools
	  // CALLED BY:
	  // USES: 
	
	  // ===== SYNTAX =====
	  //st_ClrWildChars(text)-->Text
	
	  // ===== CONTROL =====
	  // FECHA MODIF:
	  // AUTOR: 
	  // DESCRIPCION: 
End if 
C_BOOLEAN:C305(ABK210396)
C_TEXT:C284($1;$0)

$0:=$1

  //20180516 RCH En la Maisinnette habian textos con caracteres char(0). Ejemplo, direccion de apdo "11f3eb1a-e9ca-544a-b659-d3c0a186feec". "8e9bacf9-df4b-0348-94d9-ff4a80c20b16","a3e3691b-7aea-7e44-ac54-d72a384a4d7e" 
  //For ($i;1;12)
  //If (Position(Char($i);$0)>0)
  //$0:=Replace string($0;Char($i);"")
  //End if 
  //End for 
For ($i;0;12)
	If (Position:C15(Char:C90($i);$0)>0)
		$0:=Replace string:C233($0;Char:C90($i);"";*)
	End if 
End for 

For ($i;14;31)
	If (Position:C15(Char:C90($i);$0)>0)
		$0:=Replace string:C233($0;Char:C90($i);"")
	End if 
End for 