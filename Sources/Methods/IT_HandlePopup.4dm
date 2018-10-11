//%attributes = {}
  //IT_HandlePopup

_O_C_STRING:C293(255;$msg;$1;$value;$3;$choice;$0)
C_POINTER:C301($array;$4;$popUp;$2)
C_BOOLEAN:C305($addingAllowed;$5)
$msg:=$1
$popUp:=$2

Case of 
	: (Count parameters:C259=5)
		$addingAllowed:=$5
		$array:=$4
		$value:=$3
	: (Count parameters:C259=4)
		$array:=$4
		$value:=$3
	: (Count parameters:C259=3)
		$value:=$3
End case 

Case of 
	: ($msg="init")
		$firstElement:=__ ("Procesos")
		If ((Not:C34(Is nil pointer:C315($array))) & (Not:C34(Is nil pointer:C315($popup))))
			COPY ARRAY:C226($array->;$popup->)
			AT_Insert (1;2;$popUp)
			$popUp->{1}:=$firstElement
			$popUp->{2}:="-"
			If ($addingAllowed)
				$lastElement:=__ ("Tareas Programadas")
				AT_Insert (Size of array:C274($popUp->)+1;2;$popUp)
				$popUp->{Size of array:C274($popUp->)-1}:="-"
				$popUp->{Size of array:C274($popUp->)}:=$lastElement
			End if 
		Else 
			ALERT:C41("Array or popup menu not defined.")
		End if 
	: ($msg="set")
		If (Not:C34(Is nil pointer:C315($popUp)))
			$el:=Find in array:C230($popUp->;$value)
			If ($el>0)
				$popUp->:=$el
			Else 
				$popUp->:=1
			End if 
		Else 
			ALERT:C41("Array or popup menu not defined")
		End if 
	: ($msg="get")
		If (Not:C34(Is nil pointer:C315($popUp)))
			Case of 
				: ($popup->{$popUp->}=__ ("Tareas Programadas"))
					$choice:=TBL_addListItem ($popUp)
				: ($popUp->>2)
					$choice:=$popUp->{$popUp->}
				Else 
					If ($value#"")
						$choice:=$value
					End if 
			End case 
		Else 
			ALERT:C41("Array or popup menu not defined.")
		End if 
	: ($msg="clear")
		If (Not:C34(Is nil pointer:C315($popUp)))
			AT_Initialize ($popUp)
			ALERT:C41("Array or popup menu not defined.")
		End if 
End case 
$0:=$choice