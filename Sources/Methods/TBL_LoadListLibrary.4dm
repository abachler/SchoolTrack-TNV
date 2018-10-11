//%attributes = {}
  //TBL_LoadListLibrary

C_POINTER:C301($arrPtr)
ARRAY TEXT:C222($at_sNames;0)
ARRAY TEXT:C222($Nombres;0)

IT_MODIFIERS 
C_TEXT:C284(sName;tText)
C_LONGINT:C283($k)
$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Tablas.txt"

SET CHANNEL:C77(10;$file)
If (ok=1)
	RECEIVE VARIABLE:C81(nbRecords)
	For ($i;1;nbRecords)
		RECEIVE VARIABLE:C81(sName)
		INSERT IN ARRAY:C227($at_sNames;Size of array:C274($at_sNames)+1;1)
		$at_sNames{Size of array:C274($at_sNames)}:=sName
		RECEIVE RECORD:C79([xShell_List:39])
	End for 
	SET CHANNEL:C77(11)
	
	ALL RECORDS:C47([xShell_List:39])
	SELECTION TO ARRAY:C260([xShell_List:39]Listname:1;$Nombres)
	
	For ($t;1;Size of array:C274($Nombres))
		$exist:=Find in array:C230($at_sNames;$Nombres{$t})
		If ($exist=-1)
			READ WRITE:C146([xShell_List:39])
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=$Nombres{$t})
			DELETE RECORD:C58([xShell_List:39])
		End if 
	End for 
	
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		UNLOAD RECORD:C212([xShell_List:39])
		READ WRITE:C146([xShell_List:39])
		If (<>option)
			OK:=CD_Dlog (0;__ ("¿Desea Ud. realmente inicializar el archivo completo?");__ ("");__ ("Si");__ ("No"))
			If (ok=1)
				ALL RECORDS:C47([xShell_List:39])
				DELETE SELECTION:C66([xShell_List:39])
			End if 
		End if 
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando las tablas..."))
		
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbrecords)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/nbRecords;__ ("Cargando las tablas…"))
			RECEIVE VARIABLE:C81(sName)
			QUERY:C277([xShell_List:39];[xShell_List:39]Listname:1=sName)
			If (Records in selection:C76([xShell_List:39])=0)
				RECEIVE RECORD:C79([xShell_List:39])
				[xShell_List:39]Enriquecible:8:=False:C215
				If (<>gCountryCode#"cl")
					If ([xShell_List:39]Listname:1="Comunas")
						SET BLOB SIZE:C606([xShell_List:39]Contents:9;0)
					End if 
				End if 
				SAVE RECORD:C53([xShell_List:39])
			Else 
				$blob:=[xShell_List:39]Contents:9
				$enriquecible:=[xShell_List:39]Enriquecible:8
				$t_json:=[xShell_List:39]json:2
				DELETE RECORD:C58([xShell_List:39])
				RECEIVE RECORD:C79([xShell_List:39])
				[xShell_List:39]Contents:9:=$blob
				[xShell_List:39]json:2:=$t_json
				ARRAY TEXT:C222($tempTextArray;0)
				ARRAY TEXT:C222($aDefaults;0)
				AT_Text2Array (->$aDefaults;[xShell_List:39]DefaultValues:10;"\r")
				BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$tempTextArray)
				For ($i;1;Size of array:C274($aDefaults))
					$found:=Find in array:C230($tempTextArray;$aDefaults{$i})
					If ($found=-1)
						INSERT IN ARRAY:C227($tempTextArray;1;1)
						$tempTextArray{1}:=$aDefaults{$i}
					End if 
				End for 
				SORT ARRAY:C229($tempTextArray;>)
				BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;->$tempTextArray)
				[xShell_List:39]Enriquecible:8:=$enriquecible
				SAVE RECORD:C53([xShell_List:39])
			End if 
		End for 
		SET CHANNEL:C77(11)
		KRL_UnloadReadOnly (->[xShell_List:39])
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando las tablas 2..."))
		$fileField:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"TablasFIeld.txt"
		  // se eliminan registros existentes
		READ WRITE:C146([xShell_List_FieldRefs:236])
		ALL RECORDS:C47([xShell_List_FieldRefs:236])
		DELETE SELECTION:C66([xShell_List_FieldRefs:236])
		  // se lee archivo
		SET CHANNEL:C77(10;$fileField)
		RECEIVE VARIABLE:C81(nbRecords)
		For ($k;1;nbRecords)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/nbRecords)
			RECEIVE VARIABLE:C81(sNameField)
			If (sNameField#"")
				RECEIVE RECORD:C79([xShell_List_FieldRefs:236])
				SAVE RECORD:C53([xShell_List_FieldRefs:236])
			End if 
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		SET CHANNEL:C77(11)
		KRL_UnloadReadOnly (->[xShell_List_FieldRefs:236])
		  //***** 20110722 RCH Se cambia carga de registros de esta tabla
		
		
		CLOSE WINDOW:C154
		TBL_LoadListsArrays 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene las tablas no pudo ser cargado."))
	End if 
Else 
	$r:=CD_Dlog (1;__ ("El archivo que contiene las tablas no pudo ser cargado."))
End if 