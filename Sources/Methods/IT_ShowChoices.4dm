//%attributes = {}
  //IT_ShowChoices

  //`xShell, Alberto Bachler
  //Metodo: IT_ShowChoices
  //Por abachler
  //Creada el 05/02/2004, 09:34:32
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($1;$textArrayPointer;$2;$objectPointer;$tempArray;$tablePointer)
C_POINTER:C301($4;$refArrayPointer)
C_LONGINT:C283($6;$comparisonMode)
C_TEXT:C284($0;$3;$listName)

  //****INICIALIZACIONES****
$textArrayPointer:=$1
$objectPointer:=$2
Case of 
	: (Count parameters:C259=6)
		$comparisonMode:=$6
		$tablePointer:=$5
		$listName:=$3
		$refArrayPointer:=$4
	: (Count parameters:C259=5)
		$tablePointer:=$5
		$listName:=$3
		$refArrayPointer:=$4
	: (Count parameters:C259=4)
		$listName:=$3
		$refArrayPointer:=$4
	: (Count parameters:C259=3)
		$listName:=$3
End case 


$value:=$objectPointer->
vyXS_CallingVariable:=$objectPointer
ARRAY TEXT:C222($at_TempArray;0)


  //****CUERPO****
If ($value#"")
	ARRAY TEXT:C222(atXS_Choices;0)
	ARRAY LONGINT:C221(alXS_ChoicesRef;0)
	If (Not:C34(Is nil pointer:C315($refArrayPointer)))
		SORT ARRAY:C229($textArrayPointer->;$refArrayPointer->;>)
	Else 
		SORT ARRAY:C229($textArrayPointer->;>)
	End if 
	
	$wordCount:=ST_CountWords ($value)
	
	Case of 
		: ($comparisonMode=0)  //comienza con
			$lookUpValue:=$value
			$textArrayPointer->{0}:=$lookUpValue+"@"
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray ($textArrayPointer;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				If (Not:C34(Is nil pointer:C315($refArrayPointer)))
					APPEND TO ARRAY:C911(atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
					APPEND TO ARRAY:C911(alXS_ChoicesRef;$refArrayPointer->{$DA_Return{$i}})
				Else 
					APPEND TO ARRAY:C911(atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
					APPEND TO ARRAY:C911(alXS_ChoicesRef;Size of array:C274(atXS_Choices))
				End if 
			End for 
			
		: ($comparisonMode=1)  //contiene la expresion
			$lookUpValue:=$value
			$textArrayPointer->{0}:="@"+$lookUpValue+"@"
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray ($textArrayPointer;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				If (Not:C34(Is nil pointer:C315($refArrayPointer)))
					APPEND TO ARRAY:C911(atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
					APPEND TO ARRAY:C911(alXS_ChoicesRef;$refArrayPointer->{$DA_Return{$i}})
				Else 
					APPEND TO ARRAY:C911(atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
					APPEND TO ARRAY:C911(alXS_ChoicesRef;Size of array:C274(atXS_Choices))
				End if 
			End for 
			
			
		: ($comparisonMode=2)  //contiene cualquier palabra de la expresión
			For ($iWordCount;1;$wordCount)
				$lookUpValue:=ST_GetWord ($value;$iWordCount)
				$textArrayPointer->{0}:="@"+$lookUpValue+"@"
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray ($textArrayPointer;"=";->$DA_Return)
				For ($i;1;Size of array:C274($DA_Return))
					If (Not:C34(Is nil pointer:C315($refArrayPointer)))
						APPEND TO ARRAY:C911(atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
						APPEND TO ARRAY:C911(alXS_ChoicesRef;$refArrayPointer->{$DA_Return{$i}})
					Else 
						APPEND TO ARRAY:C911(atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
						APPEND TO ARRAY:C911(alXS_ChoicesRef;Size of array:C274(atXS_Choices))
					End if 
				End for 
			End for 
			
			
		: ($comparisonMode=3)  //contiene todas las palabras
			ARRAY TEXT:C222($atXS_Choices;0)
			ARRAY TEXT:C222($atXS_FoundTexts;0)
			
			$lookUpValue:=ST_GetWord ($value;1)
			$textArrayPointer->{0}:="@"+$lookUpValue+"@"
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray ($textArrayPointer;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				If (Not:C34(Is nil pointer:C315($refArrayPointer)))
					APPEND TO ARRAY:C911($atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
				Else 
					APPEND TO ARRAY:C911($atXS_Choices;$textArrayPointer->{$DA_Return{$i}})
				End if 
			End for 
			
			For ($iWordCount;2;$wordCount)
				$lookUpValue:=ST_GetWord ($value;$iWordCount)
				$textArrayPointer->{0}:="@"+$lookUpValue+"@"
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray ($textArrayPointer;"=";->$DA_Return)
				
				ARRAY TEXT:C222($atXS_FoundTexts;0)
				For ($i;1;Size of array:C274($DA_Return))
					If (Not:C34(Is nil pointer:C315($refArrayPointer)))
						APPEND TO ARRAY:C911($atXS_FoundTexts;$textArrayPointer->{$DA_Return{$i}})
					Else 
						APPEND TO ARRAY:C911($atXS_FoundTexts;$textArrayPointer->{$DA_Return{$i}})
					End if 
				End for 
				AT_intersect (->$atXS_FoundTexts;->$atXS_Choices;->atXS_Choices)
				COPY ARRAY:C226(atXS_Choices;$atXS_Choices)
				COPY ARRAY:C226($atXS_Choices;atXS_Choices)
			End for 
			ARRAY LONGINT:C221(alXS_ChoicesRef;Size of array:C274(atXS_Choices))
			For ($i;1;Size of array:C274(atXS_Choices))
				alXS_ChoicesRef{$i}:=$i
			End for 
	End case 
	
	
	
	
	$acces:=USR_GetMethodAcces ("Listas";0)
	Case of 
		: ((Size of array:C274(atXS_Choices)=0) & ($acces) & ($listName#""))
			$s:=$value+"@"
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$listName)
			If (Records in selection:C76([xShell_List:39])=1)
				KRL_LoadRecord (->[xShell_List:39])
				If (ok=1)
					BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_TempArray)  //releemos el arreglo para asegurarnos que otro usuario no haya creado el valor
					COPY ARRAY:C226($at_TempArray;$textArrayPointer->)
					AT_Initialize (->$at_TempArray)
					If (Find in array:C230($textArrayPointer->;$s)=-1)
						If ([xShell_List:39]Enriquecible:8)
							OK:=CD_Dlog (0;__ ("Valor inexistente. \r¿Desea Ud. agregarlo a la tabla?");__ ("");__ ("Sí");__ ("No"))
						Else 
							OK:=0
							CD_Dlog (0;__ ("Esta tabla no ha sido configurada para poder agregar valores durante el ingreso.\rPor favor consulte al administrador de SchoolTrack."))
						End if 
						If (ok=1)
							If ([xShell_List:39]Form_Name:6#"OneValueInput")
								sValue:=ST_Format ($objectPointer;->[xShell_List:39]Listname:1)
								WDW_OpenFormWindow (->[xShell_List:39];[xShell_List:39]Form_Name:6;-1;8)
								DIALOG:C40([xShell_List:39];[xShell_List:39]Form_Name:6)
								CLOSE WINDOW:C154
								If ((ok=1) & (sValue#""))
									TRACE:C157
									INSERT IN ARRAY:C227($textArrayPointer->;1;1)
									$textArrayPointer->{1}:=sValue
									SORT ARRAY:C229($textArrayPointer->)
									COPY ARRAY:C226($textArrayPointer->;$at_TempArray)
									  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->$at_TempArray)
									  //SAVE RECORD([xShell_List])
									
									  //20140107 ASM Ticket  128514
									TBL_SaveListAndArrays ($textArrayPointer;->$at_TempArray)
									KRL_ReloadAsReadOnly (->[xShell_List:39])
									$0:=svalue
								End if 
							Else 
								$value:=$value
								INSERT IN ARRAY:C227($textArrayPointer->;1;1)
								$textArrayPointer->{1}:=$value
								SORT ARRAY:C229($textArrayPointer->)
								COPY ARRAY:C226($textArrayPointer->;$at_TempArray)
								  //BLOB_Variables2Blob (->[xShell_List]Contents;0;->$at_TempArray)
								  //SAVE RECORD([xShell_List])
								
								  //20140107 ASM Ticket  128514
								TBL_SaveListAndArrays ($textArrayPointer)
								$0:=$value
								
								  //157382
								If ([xShell_List:39]PopupArrayName:3="◊at_EventosAsignatura")  //sólo aquí por que esta lista permite el ingreso de un valor a la vez.
									CFG_ST_BlockEvtAsigNiveles ("new";$value)
								End if 
								
							End if 
						Else 
							$0:=""
						End if 
					Else 
						$0:=$textArrayPointer->{Find in array:C230($textArrayPointer->;$s)}
					End if 
				End if 
				UNLOAD RECORD:C212([xShell_List:39])
				READ ONLY:C145([xShell_List:39])
			End if 
		: ((Size of array:C274(atXS_Choices)=0) & ($listName#""))
			CD_Dlog (0;__ ("Esta lista no es modificable.\rPor favor seleccione un valor de la lista desplegable."))
		: ((Size of array:C274(atXS_Choices)=1) & ($listName=""))
			$0:=atXS_Choices{1}
		: ((Size of array:C274(atXS_Choices)>1) & ($listName=""))
			If (Not:C34(Is nil pointer:C315($tablePointer)))
				$0:=IT_OpenChoiceWindow ($tablePointer)
			Else 
				$0:=IT_OpenChoiceWindow 
			End if 
		: ((Size of array:C274(atXS_Choices)=0) & ($acces=False:C215) & ($listName#""))
			$s:=$value+"@"
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$listName)
			BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_TempArray)  //releemos el arreglo para asegurarnos que otro usuario no haya creado el valor
			COPY ARRAY:C226($at_TempArray;$textArrayPointer->)
			AT_Initialize (->$at_TempArray)
			If (Find in array:C230($textArrayPointer->;$s)=-1)
				CD_Dlog (0;__ ("Valor inexistente. Consulte con el administrador del sistema."))
			Else 
				$0:=$textArrayPointer->{Find in array:C230($textArrayPointer->;$s)}
			End if 
		: (Size of array:C274(atXS_Choices)=1)
			$0:=atXS_Choices{1}
		: (Size of array:C274(atXS_Choices)>1)
			If (Not:C34(Is nil pointer:C315($tablePointer)))
				$0:=IT_OpenChoiceWindow ($tablePointer)
			Else 
				$0:=IT_OpenChoiceWindow 
			End if 
	End case 
	If ($0="")
		GOTO OBJECT:C206($value)
	End if 
Else 
	$0:=""
End if 

  //****LIMPIEZA****
