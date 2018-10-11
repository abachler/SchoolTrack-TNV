If (Contextual click:C713)\

	If ((atXDOC_AttachedDocs#0) & ((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169]))))
		$menuItems:="Propiedades;-;Abrir documento;Abrir documento con…;-;"+"Guardar como…;-;Borrar documento;-;Adjuntar documento…"
	Else 
		$menuItems:="(Propiedades;-;(Abrir documento;(Abrir documento con…;-;"+"(Guardar como…;-;(Borrar documento;-;(Adjuntar documento…"
	End if 
	$userChoice:=Pop up menu:C542($menuItems)
	Case of 
		: ($userChoice=1)  //Properties
			XDOC_EditProperties (alXDOC_AttachedRecNum{atxDOC_AttachedDocs})
			XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1)
			
			
		: ($userChoice=3)  //Open Document
			$selectApp:=False:C215
			XDOC_OpenAttachedDoc (alXDOC_AttachedRecNum{atxDOC_AttachedDocs};$selectApp)
			
		: ($userChoice=4)
			  //open document with
			$selectApp:=True:C214
			XDOC_OpenAttachedDoc (alXDOC_AttachedRecNum{atxDOC_AttachedDocs};$selectApp)
			
		: ($userChoice=6)  //save document
			XDOC_SaveAttachedDocument (alXDOC_AttachedRecNum{atXDOC_AttachedDocs})
			
		: ($userChoice=8)  //remove document
			XDOC_RemoveAttachedDocument (alXDOC_AttachedRecNum{atXDOC_AttachedDocs})
			XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1)
			
		: ($userChoice=10)  //attach document
			XDOC_AttachDocument (Table:C252(->[Asignaturas_RegistroSesiones:168]);[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
			XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1)
	End case 
End if 

$statusButtons:=((atXDOC_AttachedDocs#0) & ((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169])) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))))

IT_SetButtonState ($statusButtons;->bOpenDoc;->bSaveDoc;->bRemoveDoc)
IT_SetButtonState (((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169])) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)));->bAttachDoc)