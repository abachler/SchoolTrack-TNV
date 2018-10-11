//%attributes = {}
  //AS_SetSesionObjectsStatus


$page:=Selected list items:C379(vTab_Programas)
$ReadWrite:=((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169])))

$line:=AL_GetLine (xALP_planes)
If ($line>0)
	OBJECT SET ENABLED:C1123(*;"ref2";True:C214)
	OBJECT SET ENABLED:C1123(*;"ref7";True:C214)  //ABC//TICKET 200272 // 2018032018
	OBJECT SET ENABLED:C1123(*;"ref8";True:C214)
	OBJECT SET ENABLED:C1123(*;"ref9";True:C214)
	OBJECT SET ENABLED:C1123(*;"ref(3)";True:C214)
	OBJECT SET ENABLED:C1123(*;"ref6";True:C214)
	OBJECT SET ENABLED:C1123(*;"ref10";True:C214)
	$page:=Selected list items:C379(vTab_Programas)
	If ((adSTRas_Planes_Desde{$line}>=vdSTR_Periodos_InicioEjercicio) | (adSTRas_Planes_Desde{$line}=!00-00-00!))  //MONO TICKET 203783
		READ WRITE:C146([Asignaturas_PlanesDeClases:169])
		QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1=alSTRas_Planes_ID{$line})
		vtSTK_NombrePlan:=[Asignaturas_PlanesDeClases:169]Nombre:14
		Case of 
			: (($page=5) & ($line#0))
				IT_SetButtonState ((atXDOC_AttachedDocs#0) & ($ReadWrite);->bOpenDoc;->bSaveDoc;->bRemoveDoc)
				IT_SetButtonState ($ReadWrite;->bAttachDoc)
				IT_SetButtonState ((atXDOC_AttachedURL#0) & ($ReadWrite);->bOpenURL;->bRemoveURL)
				IT_SetButtonState (((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169])));->bAttachURL)
		End case 
		
		
		$page:=Selected list items:C379(vTab_Programas)
		Case of 
			: ($page=1)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Nota_al_Alumno:6
			: ($page=2)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Objetivos:7
			: ($page=3)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Contenidos:8
			: ($page=4)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Actividades:9
			: ($page=5)
				vtSTK_RefPlanDeClases:=[Asignaturas_PlanesDeClases:169]Referencias:10
				XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1)
				XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1;"URL")
			: ($page=6)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Tareas:12
			: ($page=7)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Intrumentos_evaluacion:11
		End case 
		GOTO OBJECT:C206(vtSTK_TextoPlanesDeClases)
		HIGHLIGHT TEXT:C210(vtSTK_TextoPlanesDeClases;Length:C16(vtSTK_TextoPlanesDeClases)+1;Length:C16(vtSTK_TextoPlanesDeClases)+1)
		REDRAW WINDOW:C456
		
		OBJECT SET ENTERABLE:C238(vtSTK_TextoPlanesDeClases;$readWrite)
		OBJECT SET ENTERABLE:C238(vtSTK_RefPlanDeClases;$readWrite)
		IT_SetButtonState ($readWrite;->bDelLine;->bAddLine)
		
		AL_SetEnterable (xALP_Planes;1;Num:C11($ReadWrite))
		AL_SetEnterable (xALP_Planes;2;Num:C11($ReadWrite))
		$horario:=Records in set:C195("horario")
		If ($horario>0)
			AL_SetEnterable (xALP_Planes;3;0)
		Else 
			AL_SetEnterable (xALP_Planes;3;1)
		End if 
	Else 
		READ ONLY:C145([Asignaturas_PlanesDeClases:169])
		QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1=alSTRas_Planes_ID{$line})
		vtSTK_NombrePlan:=[Asignaturas_PlanesDeClases:169]Nombre:14
		Case of 
			: (($page=5) & ($line#0))
				OBJECT SET ENABLED:C1123(bRemoveDoc;False:C215)
				OBJECT SET ENABLED:C1123(bSaveDoc;False:C215)
				OBJECT SET ENABLED:C1123(bAttachDoc;False:C215)
				OBJECT SET ENABLED:C1123(bAttachURL;False:C215)
				OBJECT SET ENABLED:C1123(bRemoveURL;False:C215)
				IT_SetButtonState ((atXDOC_AttachedDocs#0) & ($ReadWrite);->bOpenDoc)
				IT_SetButtonState ((atXDOC_AttachedURL#0) & ($ReadWrite);->bOpenURL)
			Else 
				OBJECT SET VISIBLE:C603(vtSTK_TextoPlanesDeClases;False:C215)
				OBJECT SET VISIBLE:C603(*;"ref@";False:C215)
		End case 
		
		
		$page:=Selected list items:C379(vTab_Programas)
		Case of 
			: ($page=1)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Nota_al_Alumno:6
			: ($page=2)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Objetivos:7
			: ($page=3)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Contenidos:8
			: ($page=4)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Actividades:9
			: ($page=5)
				vtSTK_RefPlanDeClases:=[Asignaturas_PlanesDeClases:169]Referencias:10
				XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1)
				XDOC_LoadAttachedDocsIntoArray (Table:C252(->[Asignaturas_PlanesDeClases:169]);[Asignaturas_PlanesDeClases:169]ID_Plan:1;"URL")
			: ($page=6)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Tareas:12
			: ($page=7)
				vtSTK_TextoPlanesDeClases:=[Asignaturas_PlanesDeClases:169]Intrumentos_evaluacion:11
		End case 
		GOTO OBJECT:C206(vtSTK_TextoPlanesDeClases)
		HIGHLIGHT TEXT:C210(vtSTK_TextoPlanesDeClases;Length:C16(vtSTK_TextoPlanesDeClases)+1;Length:C16(vtSTK_TextoPlanesDeClases)+1)
		REDRAW WINDOW:C456
		
		IT_SetButtonState ($ReadWrite;->bAddLine)
		AL_SetEnterable (xALP_Planes;0;0)
	End if 
Else 
	OBJECT SET ENABLED:C1123(*;"ref2";False:C215)  //ABC//TICKET 200272 // 2018032018
	OBJECT SET ENABLED:C1123(*;"ref7";False:C215)
	OBJECT SET ENABLED:C1123(*;"ref8";False:C215)
	OBJECT SET ENABLED:C1123(*;"ref9";False:C215)
	OBJECT SET ENABLED:C1123(*;"ref(3)";False:C215)
	OBJECT SET ENABLED:C1123(*;"ref6";False:C215)
	OBJECT SET ENABLED:C1123(*;"ref10";False:C215)
	IT_SetButtonState (False:C215;->bDelLine)
	IT_SetButtonState ($ReadWrite;->bAddLine)
End if 


OBJECT SET ENTERABLE:C238(vtSTK_TextoPlanesDeClases;($page#5) & ($ReadWrite))
OBJECT SET VISIBLE:C603(vtSTK_TextoPlanesDeClases;$page#5)
OBJECT SET VISIBLE:C603(*;"ref@";$page=5)
OBJECT SET ENTERABLE:C238(vtSTK_RefPlanDeClases;$page=5)
