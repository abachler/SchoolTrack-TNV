//%attributes = {}
  //ACTcae_QuitaDctos2Del

$idAviso:=$1

READ ONLY:C145([ACT_Transacciones:178])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$idAviso)
DISTINCT VALUES:C339([ACT_Transacciones:178]No_Boleta:9;$alACT_IDsBoletasAsoc)
DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;$alACT_idsAvisosDesdePagos)
DISTINCT VALUES:C339([ACT_Transacciones:178]ID_Pago:4;$alACT_idsPagosDesdeAvisos)

  //20120103 RCH Para quitar tb los dctos relacionados
ARRAY LONGINT:C221($alACT_DTRelacionados;0)
QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_DctoRelacionado:15#0)
SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_DctoRelacionado:15;$alACT_DTRelacionados)
QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;$alACT_DTRelacionados)
While (Not:C34(End selection:C36([ACT_Boletas:181])))
	If ([ACT_Boletas:181]ID_DctoAsociado:19#0)
		If (Find in array:C230($alACT_IDsBoletasAsoc;[ACT_Boletas:181]ID_DctoAsociado:19)=-1)
			APPEND TO ARRAY:C911($alACT_IDsBoletasAsoc;[ACT_Boletas:181]ID_DctoAsociado:19)
		End if 
	End if 
	NEXT RECORD:C51([ACT_Boletas:181])
End while 

$el:=Find in array:C230($alACT_idsAvisosDesdePagos;0)
If ($el#-1)
	AT_Delete ($el;1;->$alACT_idsAvisosDesdePagos)
End if 
$el:=Find in array:C230($alACT_IDsBoletasAsoc;0)
If ($el#-1)
	AT_Delete ($el;1;->$alACT_IDsBoletasAsoc)
End if 
$el:=Find in array:C230($alACT_idsPagosDesdeAvisos;0)
If ($el#-1)
	AT_Delete ($el;1;->$alACT_idsPagosDesdeAvisos)
End if 
  //20120103 RCH
$el:=Find in array:C230($alACT_IDsBoletasAsoc;-1)
If ($el#-1)
	AT_Delete ($el;1;->$alACT_IDsBoletasAsoc)
End if 

For ($y;1;Size of array:C274($alACT_IDsBoletasAsoc))
	If (Find in array:C230(alACT_BoletasNoEliminarT;$alACT_IDsBoletasAsoc{$y})=-1)
		$index:=Find in field:C653([ACT_Boletas:181]ID:1;$alACT_IDsBoletasAsoc{$y})
		If ($index#-1)
			APPEND TO ARRAY:C911(alACT_BoletasNoEliminarT;$alACT_IDsBoletasAsoc{$y})
		End if 
	End if 
End for 

For ($y;1;Size of array:C274($alACT_idsAvisosDesdePagos))
	If (Find in array:C230(alACT_AvisosNoEliminarT;$alACT_idsAvisosDesdePagos{$y})=-1)
		APPEND TO ARRAY:C911(alACT_AvisosNoEliminarT;$alACT_idsAvisosDesdePagos{$y})
	End if 
End for 

For ($y;1;Size of array:C274($alACT_idsPagosDesdeAvisos))
	If ($alACT_idsPagosDesdeAvisos{$y}>0)
		If (Find in array:C230(alACT_PagosNoEliminarT;$alACT_idsPagosDesdeAvisos{$y})=-1)
			APPEND TO ARRAY:C911(alACT_PagosNoEliminarT;$alACT_idsPagosDesdeAvisos{$y})
		End if 
	End if 
End for 

For ($y;1;Size of array:C274($alACT_idsPagosDesdeAvisos))
	If ($alACT_idsPagosDesdeAvisos{$y}>0)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$alACT_idsPagosDesdeAvisos{$y})
		DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;$alACT_IDsAvisosAsoc)
		$el:=Find in array:C230($alACT_IDsAvisosAsoc;0)
		If ($el#-1)
			AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
		End if 
		$el:=Find in array:C230($alACT_IDsAvisosAsoc;$idAviso)
		If ($el#-1)
			AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
		End if 
		For ($x;1;Size of array:C274($alACT_IDsAvisosAsoc))
			If (Find in array:C230(alACT_AvisosNoEliminarT;$alACT_IDsAvisosAsoc{$x})=-1)
				ACTcae_QuitaDctos2Del ($alACT_IDsAvisosAsoc{$x})
			End if 
		End for 
	End if 
End for 

For ($y;1;Size of array:C274($alACT_IDsBoletasAsoc))
	$index:=Find in field:C653([ACT_Boletas:181]ID:1;$alACT_IDsBoletasAsoc{$y})
	If ($index#-1)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=$alACT_IDsBoletasAsoc{$y})
		DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;$alACT_IDsAvisosAsoc)
		$el:=Find in array:C230($alACT_IDsAvisosAsoc;0)
		If ($el#-1)
			AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
		End if 
		$el:=Find in array:C230($alACT_IDsAvisosAsoc;$idAviso)
		If ($el#-1)
			AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
		End if 
		For ($x;1;Size of array:C274($alACT_IDsAvisosAsoc))
			If (Find in array:C230(alACT_AvisosNoEliminarT;$alACT_IDsAvisosAsoc{$x})=-1)
				ACTcae_QuitaDctos2Del ($alACT_IDsAvisosAsoc{$x})
			End if 
		End for 
		
		  //20120606 RCH se quitan las posibles NC asociadas a dctos que no se pueden cerrar.
		GOTO RECORD:C242([ACT_Boletas:181];$index)
		If ([ACT_Boletas:181]ID:1>0)
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=[ACT_Boletas:181]ID:1)
			If (Records in selection:C76([ACT_Boletas:181])>0)
				KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
				DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;$alACT_IDsAvisosAsoc)
				$el:=Find in array:C230($alACT_IDsAvisosAsoc;0)
				If ($el#-1)
					AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
				End if 
				$el:=Find in array:C230($alACT_IDsAvisosAsoc;$idAviso)
				If ($el#-1)
					AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
				End if 
				For ($x;1;Size of array:C274($alACT_IDsAvisosAsoc))
					If (Find in array:C230(alACT_AvisosNoEliminarT;$alACT_IDsAvisosAsoc{$x})=-1)
						ACTcae_QuitaDctos2Del ($alACT_IDsAvisosAsoc{$x})
					End if 
				End for 
			End if 
			
			GOTO RECORD:C242([ACT_Boletas:181];$index)
			If ([ACT_Boletas:181]ID_DctoAsociado:19>0)
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=[ACT_Boletas:181]ID_DctoAsociado:19)
				KRL_RelateSelection (->[ACT_Transacciones:178]No_Boleta:9;->[ACT_Boletas:181]ID:1;"")
				DISTINCT VALUES:C339([ACT_Transacciones:178]No_Comprobante:10;$alACT_IDsAvisosAsoc)
				$el:=Find in array:C230($alACT_IDsAvisosAsoc;0)
				If ($el#-1)
					AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
				End if 
				$el:=Find in array:C230($alACT_IDsAvisosAsoc;$idAviso)
				If ($el#-1)
					AT_Delete ($el;1;->$alACT_IDsAvisosAsoc)
				End if 
				For ($x;1;Size of array:C274($alACT_IDsAvisosAsoc))
					If (Find in array:C230(alACT_AvisosNoEliminarT;$alACT_IDsAvisosAsoc{$x})=-1)
						ACTcae_QuitaDctos2Del ($alACT_IDsAvisosAsoc{$x})
					End if 
				End for 
			End if 
		End if 
		
	End if 
End for 