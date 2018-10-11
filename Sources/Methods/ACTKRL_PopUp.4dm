//%attributes = {}
  // Método: ACTKRL_PopUp
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 24-02-10, 12:14:57
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283($0;$vl_retorno)
C_TEXT:C284($vt_variable;$vt_mensaje)
C_POINTER:C301($vy_mensaje)
$y_arraypopup:=$1
If (Count parameters:C259>=2)
	$vt_mensaje:=$2
End if 
If (Count parameters:C259>=3)
	$vy_mensaje:=$3
End if 

If ($vt_mensaje="")
	$vt_mensaje:="Seleccione..."
End if 

  // Código principal
If (Size of array:C274($y_arraypopup->)<=50)
	  //$vt_popUp:=AT_array2text ($y_arraypopup)
	  //$vl_retorno:=Pop up menu($vt_popUp)
	$vl_retorno:=IT_PopUpMenu ($y_arraypopup;$vy_mensaje)
Else 
	ARRAY POINTER:C280(<>aChoicePtrs;0)
	ARRAY POINTER:C280(<>aChoicePtrs;2)
	ARRAY LONGINT:C221(alACTkrl_Orden;0)
	ARRAY LONGINT:C221($alACT_posSeparadores;0)
	
	$y_arraypopup->{0}:="-"
	AT_SearchArray ($y_arraypopup;"=";->$alACT_posSeparadores)
	
	For ($i;1;Size of array:C274($y_arraypopup->))
		APPEND TO ARRAY:C911(alACTkrl_Orden;$i)
	End for 
	<>aChoicePtrs{1}:=$y_arraypopup
	<>aChoicePtrs{2}:=->alACTkrl_Orden
	TBL_ShowChoiceList (1;$vt_mensaje;2)
	If ((ok=1) & (Find in array:C230($alACT_posSeparadores;choiceIdx)=-1))
		$vl_retorno:=choiceIdx
	End if 
End if 

$0:=$vl_retorno