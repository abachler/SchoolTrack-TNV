//%attributes = {}
  //TBL_GetValue

If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_LONGINT:C283($i)
C_POINTER:C301($1;$2;$objectPointer;$arrayPointer;$tempArray1;$tempArray2)
C_TEXT:C284($3;$0;$listName)
ARRAY TEXT:C222(at_TempTextArray1;0)
ARRAY TEXT:C222($at_TempTextArray2;0)

  //****INICIALIZACIONES****
$arrayPointer:=$1
$objectPointer:=$2
If (Count parameters:C259=3)
	$listName:=$3
End if 

  //****CUERPO****
If ($objectPointer->#"")
	$s:=$objectPointer->+"@"
	$el:=Find in array:C230($arrayPointer->;$s)
	If ($el>0)
		INSERT IN ARRAY:C227(at_TempTextArray1;1)
		at_TempTextArray1{1}:=$arrayPointer->{$el}
		For ($i;$el+1;Size of array:C274($arrayPointer->))
			If ($arrayPointer->{$i}=$s)
				INSERT IN ARRAY:C227(at_TempTextArray1;Size of array:C274(at_TempTextArray1)+1;1)
				at_TempTextArray1{Size of array:C274(at_TempTextArray1)}:=$arrayPointer->{$i}
			Else 
				$i:=Size of array:C274($arrayPointer->)
			End if 
		End for 
	End if 
	
	
	  //$acces:=USR_GetMethodAcces ("Gestión de Listas";0)
	$acces:=USR_GetMethodAcces (Current method name:C684;0)
	Case of 
			  //: ((Size of array(at_TempTextArray1)=0) & ($listName#""))
			  //CD_Dlog (0;"Esta lista no es modificable."+Char(Carriage return )+"Por favor seleccione un valor de la lista desplegable.")
		: ((Size of array:C274(at_TempTextArray1)=1) & ($listName=""))
			$0:=at_TempTextArray1{1}
		: ((Size of array:C274(at_TempTextArray1)>1) & ($listName=""))
			ARRAY POINTER:C280(<>aChoicePtrs;1)
			<>aChoicePtrs{1}:=->at_TempTextArray1
			choiceIdx:=1
			hidecol:=0
			TBL_ShowChoiceList (0;[xShell_List:39]Listname:1;1)
			If ((ok=1) & (choiceIdx>0))
				$0:=<>aChoicePtrs{1}->{choiceIdx}
			End if 
		: ((Size of array:C274(at_TempTextArray1)=0) & ($acces=False:C215) & ($listName#""))
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$listName)
			BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_TempTextArray2)  //releemos el arreglo para asegurarnos que otro usuario no haya creado el valor
			
			COPY ARRAY:C226($at_TempTextArray2;$arrayPointer->)
			AT_Initialize ($tempArray2)
			If (Find in array:C230($arrayPointer->;$s)=-1)
				CD_Dlog (0;__ ("Valor inexistente. Consulte con el administrador del sistema."))
			Else 
				$0:=$arrayPointer->{Find in array:C230($arrayPointer->;$s)}
			End if 
		: ((Size of array:C274(at_TempTextArray1)=0) & ($acces))
			TRACE:C157
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$listName)
			If (Records in selection:C76([xShell_List:39])=1)
				KRL_LoadRecord (->[xShell_List:39])
				If (ok=1)
					BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_TempTextArray2)  //releemos el arreglo para asegurarnos que otro usuario no haya creado el valor
					
					COPY ARRAY:C226($at_TempTextArray2;$arrayPointer->)
					AT_Initialize (->$at_TempTextArray2)
					If (Find in array:C230($arrayPointer->;$s)=-1)
						If ([xShell_List:39]Enriquecible:8)
							OK:=CD_Dlog (0;__ ("Valor inexistente. \r¿ Desea Ud. agregarlo a la tabla ?");__ ("");__ ("Sí");__ ("No"))
						Else 
							OK:=0
							CD_Dlog (0;__ ("Esta tabla no ha sido configurada para poder agregar valores durante el ingreso.\rPor favor consulte al administrador de SchoolTrack."))
						End if 
						If (ok=1)
							If ([xShell_List:39]Form_Name:6#"OneValueInput")
								sValue:=ST_Format ($objectPointer;->[xShell_List:39]Listname:1)
								WDW_Open (290;84;0;4;[xShell_List:39]Listname:1)
								DIALOG:C40([xShell_List:39];[xShell_List:39]Form_Name:6)
								CLOSE WINDOW:C154
								If ((ok=1) & (sValue#""))
									INSERT IN ARRAY:C227($arrayPointer->;1;1)
									$arrayPointer->{1}:=sValue
									SORT ARRAY:C229($arrayPointer->)
									COPY ARRAY:C226($arrayPointer->;$at_TempTextArray2)
									  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->$at_TempTextArray2)
									  //SAVE RECORD([xShell_List])
									
									  //20140107 ASM Ticket  128514
									TBL_SaveListAndArrays ($arrayPointer;->$at_TempTextArray2)
									KRL_ReloadAsReadOnly (->[xShell_List:39])
									$0:=svalue
								End if 
							Else 
								$value:=$objectPointer->
								INSERT IN ARRAY:C227($arrayPointer->;1;1)
								$arrayPointer->{1}:=$value
								SORT ARRAY:C229($arrayPointer->)
								COPY ARRAY:C226($arrayPointer->;$at_TempTextArray2)
								  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->$at_TempTextArray2)
								  //SAVE RECORD([xShell_List])
								TBL_SaveListAndArrays ($arrayPointer;->$at_TempTextArray2)
								$0:=$value
							End if 
						Else 
							$0:=""
						End if 
					Else 
						$0:=$arrayPointer->{Find in array:C230($arrayPointer->;$s)}
					End if 
				End if 
				UNLOAD RECORD:C212([xShell_List:39])
				READ ONLY:C145([xShell_List:39])
			End if 
		: (Size of array:C274(at_TempTextArray1)=1)
			$0:=at_TempTextArray1{1}
		: (Size of array:C274(at_TempTextArray1)>1)
			ARRAY POINTER:C280(<>aChoicePtrs;1)
			<>aChoicePtrs{1}:=->at_TempTextArray1
			choiceIdx:=1
			hidecol:=0
			TBL_ShowChoiceList (0;[xShell_List:39]Listname:1;1;->at_TempTextArray1)
			If ((ok=1) & (choiceIdx>0))
				$0:=<>aChoicePtrs{1}->{choiceIdx}
			End if 
	End case 
	If ($0="")
		GOTO OBJECT:C206($objectPointer->)
	End if 
Else 
	$0:=""
End if 


  //****LIMPIEZA****

ARRAY TEXT:C222(at_TempTextArray1;0)
