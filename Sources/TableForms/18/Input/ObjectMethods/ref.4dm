GET MOUSE:C468($vlMouseX;$vlMouseY;$vlButton)

If ((Macintosh control down:C544) | ($vlButton=2))
	If ((atXDOC_AttachedURL#0) & ((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169]))))
		$menuItems:="Propiedades;-;Explorar;-;"+"Borrar vínculo;-;Vincular a…"
	Else 
		$menuItems:="(Propiedades;-;(Explorar;-;"+"(Borrar vínculo;-;(Vincular a…"
	End if 
	$userChoice:=Pop up menu:C542($menuItems)
	Case of 
		: ($userChoice=1)  //Properties
			
			XDOC_EditProperties (alXDOC_AttachedURLRecNum{atXDOC_AttachedURL})
			XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_RegistroSesiones:168]);[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
			
		: ($userChoice=3)  //Open Document
			
			$selectApp:=False:C215
			XDOC_OpenAttachedDoc (alXDOC_AttachedURLRecNum{atXDOC_AttachedURL};$selectApp)
			
		: ($userChoice=5)  //remove document
			
			XDOC_RemoveAttachedDocument (alXDOC_AttachedURLRecNum{atXDOC_AttachedURL})
			XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_RegistroSesiones:168]);[Asignaturas_RegistroSesiones:168]ID_Sesion:1;"URL")
			
		: ($userChoice=7)  //attach document
			
			XDOC_AttachDocument (Table:C252(->[Asignaturas_RegistroSesiones:168]);[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
			XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_RegistroSesiones:168]);[Asignaturas_RegistroSesiones:168]ID_Sesion:1;"URL")
	End case 
End if 


$statusButtons:=((atXDOC_AttachedURL#0) & ((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169])) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))))
IT_SetButtonState ($statusButtons;->bOpenURL;->bRemoveURL)
IT_SetButtonState (((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169])) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)));->bAttachURL)