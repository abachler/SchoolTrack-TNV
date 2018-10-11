//%attributes = {}
  //KRL_RebuildIndexes

C_LONGINT:C283($iTable;$k;$t;$l)
C_BOOLEAN:C305($x)
C_POINTER:C301($2;$fieldPointer)
C_POINTER:C301($1;$tablePointer)


MESSAGES ON:C181

KRL_UnloadAll 
Case of 
	: (Count parameters:C259=2)
		$fieldPointer:=$2
		SET INDEX:C344($fieldPointer->;False:C215)
		SET INDEX:C344($fieldPointer->;True:C214)
	: (Count parameters:C259=1)
		$tablePointer:=$1
		$iTable:=Table:C252($tablePointer)
		For ($k;1;Get last field number:C255($iTable))
			  //20130321 RCH
			If (Is field number valid:C1000($iTable;$k))
				GET FIELD PROPERTIES:C258($iTable;$k;$t;$l;$x)
				If ($x)
					SET INDEX:C344(Field:C253($iTable;$k)->;False:C215)
					SET INDEX:C344(Field:C253($iTable;$k)->;True:C214;50)
				End if 
			End if 
		End for 
		
	: (Count parameters:C259=0)
		$m:=Milliseconds:C459
		For ($iTable;1;Get last table number:C254)
			If (Is table number valid:C999($iTable))
				For ($k;1;Get last field number:C255($iTable))
					  //20130321 RCH
					If (Is field number valid:C1000($iTable;$k))
						GET FIELD PROPERTIES:C258($iTable;$k;$t;$l;$x)
						If ($x)
							SET INDEX:C344(Field:C253($iTable;$k)->;False:C215)
							SET INDEX:C344(Field:C253($iTable;$k)->;True:C214;50)
						End if 
					End if 
				End for 
			End if 
		End for 
		$m:=Milliseconds:C459-$m
		
		
End case 

MESSAGES OFF:C175
