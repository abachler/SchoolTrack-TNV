//%attributes = {}
C_POINTER:C301($y_tabla;$1)
C_TEXT:C284($t_columnas;$2)
C_TEXT:C284($t_ordenamiento;$3)
C_TEXT:C284($label;$4)
C_TEXT:C284($json;$temp;$0)

$y_tabla:=$1
$t_columnas:=$2
If (Count parameters:C259=3)
	$t_ordenamiento:=$3
End if 


ARRAY TEXT:C222($at_nombresColumnas;0)
AT_Text2Array (->$at_nombresColumnas;$t_columnas;",")
ARRAY POINTER:C280($ay_Campos;0)

If (Size of array:C274($at_nombresColumnas)>0)
	For ($i;1;Size of array:C274($at_nombresColumnas))
		$t_nombreCampo:=$at_nombresColumnas{$i}
		$y_campo:=KRL_GetFieldPointerByName ("["+Table name:C256($y_tabla)+"]"+$t_nombreCampo)
		If (Not:C34(Is nil pointer:C315($y_campo)))
			APPEND TO ARRAY:C911($ay_Campos;$y_campo)
		End if 
	End for 
Else 
	$lastFieldNum:=Get last field number:C255($y_tabla)
	For ($i;1;$lastFieldNum)
		If (Is field number valid:C1000($y_tabla;$i))
			APPEND TO ARRAY:C911($ay_Campos;$i)
		End if 
	End for 
End if 

  //ordenar seleccion aqui
ARRAY TEXT:C222($aOrdenamiento;0)
ARRAY TEXT:C222($aOrdenamientoFld;0)
ARRAY TEXT:C222($aOrdenamientoDir;0)
If ($t_ordenamiento#"")
	AT_Text2Array (->$aOrdenamiento;$t_ordenamiento;",")
	For ($i;1;Size of array:C274($aOrdenamiento))
		$aOrdenamiento{$i}:=ST_TrimLeadingChars ($aOrdenamiento{$i};" ")
		While ($aOrdenamiento{$i}[[Length:C16($aOrdenamiento{$i})]]=" ")
			$aOrdenamiento{$i}:=Substring:C12($aOrdenamiento{$i};1;Length:C16($aOrdenamiento{$i})-1)
		End while 
		If (($aOrdenamiento{$i}#"<") & ($aOrdenamiento{$i}#">"))
			APPEND TO ARRAY:C911($aOrdenamientoFld;$aOrdenamiento{$i})
			APPEND TO ARRAY:C911($aOrdenamientoDir;">")
		Else 
			$aOrdenamientoDir{Size of array:C274($aOrdenamientoFld)}:=$aOrdenamiento{$i}
		End if 
	End for 
	For ($i;1;Size of array:C274($aOrdenamientoFld))
		$t_nombreCampo:=$aOrdenamientoFld{$i}
		$y_campo:=KRL_GetFieldPointerByName ("["+Table name:C256($y_tabla)+"]"+$t_nombreCampo)
		If (Not:C34(Is nil pointer:C315($y_campo)))
			If ($aOrdenamientoDir{$i}=">")
				ORDER BY:C49($y_tabla->;$y_campo->;>;*)
			Else 
				ORDER BY:C49($y_tabla->;$y_campo->;<;*)
			End if 
		End if 
	End for 
	ORDER BY:C49($y_tabla->)
End if 

$0:=Json_Seleccion_a_jSon ($y_tabla;->$ay_Campos)
