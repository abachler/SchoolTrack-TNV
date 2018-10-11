//%attributes = {}
  //ACTitems_BuscaAñoEnCargos

ARRAY LONGINT:C221($alACT_añosCargos;0)
ARRAY TEXT:C222($atACT_años;0)
C_REAL:C285($r_idItem;$1)
C_LONGINT:C283($l_indice)
C_TEXT:C284($t_retorno;$0)


READ ONLY:C145([ACT_Cargos:173])

$r_idItem:=$1

QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$r_idItem)
DISTINCT VALUES:C339([ACT_Cargos:173]Año:14;$alACT_añosCargos)

For ($l_indice;1;Size of array:C274($alACT_añosCargos))
	If (<>gCountryCode="mx")
		APPEND TO ARRAY:C911($atACT_años;String:C10($alACT_añosCargos{$l_indice})+"-"+String:C10($alACT_añosCargos{$l_indice}))
	Else 
		APPEND TO ARRAY:C911($atACT_años;String:C10($alACT_añosCargos{$l_indice}))
	End if 
End for 

If (Find in array:C230($alACT_añosCargos;<>gYear)=-1)
	APPEND TO ARRAY:C911($alACT_añosCargos;<>gYear)
	APPEND TO ARRAY:C911($atACT_años;<>gNombreAgnoEscolar)
End if 

$t_añoAsignado:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$r_idItem;->[xxACT_Items:179]Periodo:42)

If (Find in array:C230($atACT_años;$t_añoAsignado)=-1)
	APPEND TO ARRAY:C911($alACT_añosCargos;Num:C11(Substring:C12($t_añoAsignado;1;4)))
	APPEND TO ARRAY:C911($atACT_años;$t_añoAsignado)
End if 

APPEND TO ARRAY:C911($alACT_añosCargos;(<>gYear*-1))
APPEND TO ARRAY:C911($atACT_años;__ ("Nuevo período"))
  //End if 

If (Size of array:C274($atACT_años)>0)
	$t_añoAsignado:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$r_idItem;->[xxACT_Items:179]Periodo:42)
	$l_seleccion:=IT_PopUpMenu (->$atACT_años;->$t_añoAsignado)
	If ($l_seleccion>0)
		If ($atACT_años{$l_seleccion}=__ ("Nuevo período"))
			$t_retorno:="-1"
		Else 
			$t_retorno:=$atACT_años{$l_seleccion}
		End if 
	End if 
End if 

$0:=$t_retorno