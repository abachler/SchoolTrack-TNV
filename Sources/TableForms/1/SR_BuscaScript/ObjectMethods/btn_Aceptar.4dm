  // [xxSTR_Constants].SR_BuscaScript.btn_Aceptar()
  // Por: Alberto Bachler K.: 17-08-15, 19:16:06
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_haySeleccionados)
C_LONGINT:C283($l_expresionCompleta;$l_idxLineas;$l_primerElemento;$l_ultimoElemento)
C_POINTER:C301($y_expresion;$y_metodos;$y_metodosSeleccionado)

ARRAY LONGINT:C221($l_idxMetodos;0)
ARRAY TEXT:C222($at_Expresiones;0)

$y_expresion:=OBJECT Get pointer:C1124(Object named:K67:5;"expresion")
$l_expresionCompleta:=(OBJECT Get pointer:C1124(Object named:K67:5;"expresionCompleta"))->
$y_metodosSeleccionado:=OBJECT Get pointer:C1124(Object named:K67:5;"seleccionados")
$y_metodos:=OBJECT Get pointer:C1124(Object named:K67:5;"metodos")

SORT ARRAY:C229($y_metodosSeleccionado->;$y_metodos->;>)
$b_haySeleccionados:=Find in sorted array:C1333($y_metodosSeleccionado->;True:C214;>;$l_primerElemento;$l_ultimoElemento)
If ($b_haySeleccionados)
	For ($l_idxMetodos;$l_primerElemento;$l_ultimoElemento)
		APPEND TO ARRAY:C911($at_Expresiones;$y_metodos->{$l_idxMetodos})
	End for 
End if 


If ($y_expresion->#"")
	If ($l_expresionCompleta=1)
		APPEND TO ARRAY:C911($at_Expresiones;$y_expresion->)
	Else 
		For ($l_idxLineas;1;ST_countlines ($y_expresion->))
			APPEND TO ARRAY:C911($at_Expresiones;ST_GetLine ($y_expresion->;$l_idxLineas))
		End for 
	End if 
End if 
SORT ARRAY:C229($y_metodos->;$y_metodosSeleccionado->;>)

If (Size of array:C274($at_Expresiones)>0)
	0xDev_BuscaScriptEnInformeSR ("BuscaTextoEnInforme";->$at_Expresiones)
End if 

