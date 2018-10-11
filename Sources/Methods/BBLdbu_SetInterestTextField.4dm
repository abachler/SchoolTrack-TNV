//%attributes = {}
  //BBLdbu_SetInterestTextField

CREATE SET:C116([BBL_Items:61];"Temp")
READ WRITE:C146([BBL_Items:61])
QUERY:C277([BBL_Items:61];[BBL_Items:61]Publico_bitArray:46>0)

If (Count parameters:C259=1)
	$bit:=$1
	If ($bit>0)
		$pcsID:=IT_UThermometer (1;0;__ ("Buscando items..."))
		QUERY SELECTION BY FORMULA:C207([BBL_Items:61];[BBL_Items:61]Publico_bitArray:46 ?? $bit)
		IT_UThermometer (-2;$pcsID)
	End if 
End if 

SELECTION TO ARRAY:C260([BBL_Items:61];$aRecNums)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando campo Interés..."))
For ($k;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([BBL_Items:61];$aRecNums{$k})
	[BBL_Items:61]Interes:21:=""
	For ($i;1;Count list items:C380(<>hl_interestList))
		GET LIST ITEM:C378(<>hl_interestList;$i;$itemRef;$itemText)
		If ([BBL_Items:61]Publico_bitArray:46 ?? $itemRef)
			[BBL_Items:61]Interes:21:=[BBL_Items:61]Interes:21+"\r"+$itemText
		End if 
	End for 
	[BBL_Items:61]Interes:21:=ST_ClearExtraCR ([BBL_Items:61]Interes:21)
	SAVE RECORD:C53([BBL_Items:61])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/Size of array:C274($aRecNums);__ ("Actualizando campo Interés..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
UNLOAD RECORD:C212([BBL_Items:61])
READ ONLY:C145([BBL_Items:61])
USE SET:C118("Temp")
CLEAR SET:C117("Temp")