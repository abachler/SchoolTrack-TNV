//%attributes = {}
  // Método: BWR_ExecuteMethod
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 18-12-10, 09:42:10
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal



  //BWR_ExecuteMethod

C_TEXT:C284($1;$vt_method)

$vt_method:=$1

$methodID:=API Get Method ID ($vt_method)
If ($methodID#0)
	  //guardamos selección y ordenamiento
	AL_GetSort (xALP_Browser;$c1;$c2;$c3;$c4;$c5;$c6;$c7;$c8;$c9;$c10)
	ARRAY LONGINT:C221($aSelectedLines;0)
	$err:=AL_GetSelect (xALP_Browser;$aSelectedLines)
	ARRAY LONGINT:C221($aRecNums;Size of array:C274($aSelectedLines))
	For ($i;1;Size of array:C274($aSelectedLines))
		$aRecNums{$i}:=alBWR_recordNumber{$aSelectedLines{$i}}
	End for 
	
	KRL_ExecuteMethod ($vt_method)
	
	  //restauramos selección y ordenamientos
	BWR_SelectTableData 
	AL_SetSort (xALP_Browser;$c1;$c2;$c3;$c4;$c5;$c6;$c7;$c8;$c9;$c10)
	ARRAY LONGINT:C221($aSelectedLines;0)
	For ($i;1;Size of array:C274($aRecNums))
		$element:=Find in array:C230(alBWR_recordNumber;$aRecNums{$i})
		If ($element>0)
			INSERT IN ARRAY:C227($aSelectedLines;Size of array:C274($aSelectedLines)+1;1)
			$aSelectedLines{Size of array:C274($aSelectedLines)}:=$element
		End if 
	End for 
	AL_SetSelect (xALP_Browser;$aSelectedLines)
	COPY ARRAY:C226($aSelectedLines;abrselect)
Else 
	CD_Dlog (0;__ ("Método inexistente. \r\rEl comando no puede ser ejecutado."))
End if 
