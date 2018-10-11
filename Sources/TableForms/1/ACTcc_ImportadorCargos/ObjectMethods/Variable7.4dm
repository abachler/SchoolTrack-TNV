C_LONGINT:C283($i)
C_TEXT:C284($vt_msg)
C_BOOLEAN:C305(b_CargoImputacion)

ARRAY LONGINT:C221($aIDItem;0)
ARRAY LONGINT:C221($DA_Return;0)

For ($i;1;Size of array:C274(aIDItem))
	APPEND TO ARRAY:C911($aIDItem;Num:C11(aIDItem{$i}))
End for 
AT_DistinctsArrayValues (->$aIDItem)

$aIDItem{0}:=0
AT_SearchArray (->$aIDItem;"=";->$DA_Return)

For ($i;Size of array:C274($DA_Return);1;-1)
	AT_Delete ($DA_Return{$i};1;->$aIDItem)
End for 

READ ONLY:C145([xxACT_Items:179])
QUERY WITH ARRAY:C644([xxACT_Items:179]ID:1;$aIDItem)
QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]Imputacion_Unica:24=True:C214)
b_CargoImputacion:=False:C215
If (Records in selection:C76([xxACT_Items:179])>0)
	b_CargoImputacion:=True:C214
	$vt_msg:=__ ("Dentro de los registros a importar, existen ítems de cargo configurados como ")
	$vt_msg:=$vt_msg+ST_Qte (__ ("Imputación única"))
	$vt_msg:=$vt_msg+". "+__ ("Ningún cargo será importado si ya existe algún otro para el mismo período, para el mismo ítem de cargo.")
	$vt_msg:=$vt_msg+"\r\r"+__ ("¿Desea Continuar?")
	
	$vl_resp:=CD_Dlog (0;$vt_msg;"";__ ("Si");__ ("No"))
	If ($vl_resp=1)
		ACCEPT:C269
	End if 
Else 
	ACCEPT:C269
End if 