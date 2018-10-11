//%attributes = {}
  //TBL_LoadListLibraryDeveloper

C_POINTER:C301($arrPtr)
ARRAY TEXT:C222($at_sNames;0)
ARRAY TEXT:C222($Nombres;0)

If (Application type:C494=4D Remote mode:K5:5)
	$ther:=IT_UThermometer (1;0;__ ("Cargando listas del sistema..."))
	$p:=Execute on server:C373(Current method name:C684;Pila_256K;"Loading lists...")
	While (Test semaphore:C652("loading lists"))
		DELAY PROCESS:C323(Current process:C322;5)
	End while 
	IT_UThermometer (-2;$ther)
Else 
	While (Semaphore:C143("loading lists"))
		DELAY PROCESS:C323(Current process:C322;5)
	End while 
	C_TEXT:C284(sName;tText)
	C_LONGINT:C283($k)
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Tablas.txt"
	
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		ALL RECORDS:C47([xShell_List:39])
		DELETE SELECTION:C66([xShell_List:39])
		
		READ WRITE:C146([xShell_List:39])
		RECEIVE VARIABLE:C81(nbRecords)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando listas del sistema..."))
		For ($k;1;nbrecords)
			RECEIVE VARIABLE:C81(sName)
			RECEIVE RECORD:C79([xShell_List:39])
			[xShell_List:39]Enriquecible:8:=False:C215
			If (<>gCountryCode#"cl")
				If ([xShell_List:39]Listname:1="Comunas")
					SET BLOB SIZE:C606([xShell_List:39]Contents:9;0)
				End if 
			End if 
			SAVE RECORD:C53([xShell_List:39])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/nbRecords;__ ("Cargando listas del sistema..."))
		End for 
		SET CHANNEL:C77(11)
		KRL_UnloadReadOnly (->[xShell_List:39])
		TBL_LoadListsArrays 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
	CLEAR SEMAPHORE:C144("loading lists")
End if 