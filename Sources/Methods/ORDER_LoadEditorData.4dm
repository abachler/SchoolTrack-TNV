//%attributes = {}
If (Count parameters:C259=1)
	$both:=$1
Else 
	$both:=True:C214
End if 
ARRAY PICTURE:C279(apSE_OrdersIcons;0)
ARRAY TEXT:C222(atSE_Orders;0)
ARRAY LONGINT:C221(alSE_OrdersColumns;0)
ARRAY LONGINT:C221(alSE_OrderOriginal;0)
ARRAY TEXT:C222(atSE_HeadersList;0)
ARRAY LONGINT:C221(alSE_ColNumbers;0)
$err:=AL_GetHeaders (xALP_Browser;atSE_HeadersList;0)
ARRAY LONGINT:C221(alSE_ColNumbers;Size of array:C274(atSE_HeadersList))
For ($i;1;Size of array:C274(atSE_HeadersList))
	atSE_HeadersList{$i}:=Replace string:C233(atSE_HeadersList{$i};"\r";" ")
	alSE_ColNumbers{$i}:=$i
End for 
If ($both)
	AL_GetSort (xALP_Browser;c1;c2;c3;c4;c5;c6;c7;c8;c9;c10;c11;c12)
	For ($i;1;12)
		$var:=Get pointer:C304("c"+String:C10($i))
		If ($var->#0)
			APPEND TO ARRAY:C911(atSE_Orders;atSE_HeadersList{Abs:C99($var->)})
			APPEND TO ARRAY:C911(alSE_OrderOriginal;Abs:C99($var->))
			  //AT_Delete (Abs($var->);1;->atSE_HeadersList;->alSE_ColNumbers)
			If ($var->>0)
				GET PICTURE FROM LIBRARY:C565(23087;$icon)
			Else 
				GET PICTURE FROM LIBRARY:C565(23086;$icon)
			End if 
			APPEND TO ARRAY:C911(apSE_OrdersIcons;$icon)
			APPEND TO ARRAY:C911(alSE_OrdersColumns;$var->)
		Else 
			$i:=13
		End if 
	End for 
	For ($i;1;Size of array:C274(alSE_OrderOriginal))
		$el:=Find in array:C230(alSE_ColNumbers;alSE_OrderOriginal{$i})
		If ($el#-1)
			AT_Delete ($el;1;->atSE_HeadersList;->alSE_ColNumbers)
		End if 
	End for 
End if 