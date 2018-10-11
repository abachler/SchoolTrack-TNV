//%attributes = {}
  // KRL_GetPrimaryKey(punteroTabla:Y {; punteroArregloLLaves:Y}) -> llavePrimaria:Y
  //
  //
  // creado por: Alberto Bachler Klein: 18-11-16, 09:37:13
  // -----------------------------------------------------------
C_POINTER:C301($0)
C_POINTER:C301($1)

C_LONGINT:C283($i;$l_numeroTabla)
C_POINTER:C301($y_llavePrimaria;$y_llavesPrimarias;$y_tabla)
C_TEXT:C284($t_nombreLlave)

ARRAY LONGINT:C221($al_IdColumnas;0)
ARRAY TEXT:C222($at_llavesPrimarias;0)
ARRAY TEXT:C222($at_nombreColumnas;0)


If (False:C215)
	C_POINTER:C301(KRL_GetPrimaryKey ;$0)
	C_POINTER:C301(KRL_GetPrimaryKey ;$1)
End if 

If (Count parameters:C259>=1)
	$y_tabla:=$1
	$l_numeroTabla:=Table:C252($y_tabla)
	Begin SQL
		Select CONSTRAINT_ID from _USER_CONSTRAINTS
		Where Table_ID=:$l_numeroTabla AND CONSTRAINT_TYPE='P'
		Into :$at_llavesPrimarias
	End SQL
	
	
	For ($i;1;Size of array:C274($at_llavesPrimarias))
		$t_nombreLlave:=$at_llavesPrimarias{$i}
		Begin SQL
			Select COLUMN_ID, COLUMN_NAME from _USER_CONS_COLUMNS
			Where Table_ID=:$l_numeroTabla AND CONSTRAINT_ID=:$t_nombreLlave
			Into :$al_IdColumnas, :$at_nombreColumnas
		End SQL
	End for 
	
	If (Size of array:C274($al_IdColumnas)>=1)
		$y_llavePrimaria:=Field:C253($l_numeroTabla;$al_IdColumnas{1})
		$0:=$y_llavePrimaria
	End if 
	
	If (Count parameters:C259>=2)
		$y_llavesPrimarias:=$2
		For ($i;1;Size of array:C274($al_IdColumnas))
			APPEND TO ARRAY:C911($y_llavesPrimarias->;Field:C253($l_numeroTabla;$al_IdColumnas{$i}))
		End for 
	End if 
End if 

