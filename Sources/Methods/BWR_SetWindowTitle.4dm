//%attributes = {}
$trapped:=dhBWR_SetWindowTitle 

Case of 
	: (Not:C34($trapped))
		Case of 
			: (<>vtXS_langage="es")
				$windowTitle:="Explorador "+vsBWR_CurrentModule
			: (<>vtXS_langage="en")
				$windowTitle:=vsBWR_CurrentModule+" Explorer"
			: (<>vtXS_langage="fr")
				$windowTitle:=vsBWR_CurrentModule+" Explorer"
			: (<>vtXS_langage="pt")
				$windowTitle:=vsBWR_CurrentModule+" Explorer"
			: (<>vtXS_langage="it")
				$windowTitle:=vsBWR_CurrentModule+" Explorer"
			: (<>vtXS_langage="de")
				$windowTitle:=vsBWR_CurrentModule+" Explorer"
		End case 
		
		$version:=" (v"+SYS_LeeVersionEstructura +")"
		$windowTitle:=$windowTitle+$version
		$windowTitle:=$windowTitle+":  "+vsBWR_selectedTableName+": "+String:C10(Size of array:C274(alBWR_recordNumber))+__ (" entre ")+String:C10(Records in table:C83(yBWR_currentTable->))+" - "+<>tUSR_CurrentUserName+" - "+<>gNombreAgnoEscolar
		SET WINDOW TITLE:C213($windowTitle;vlXS_BrowserWindowID)
End case 

