//%attributes = {}
  //xALCB_EN_PlanesdeClases

C_LONGINT:C283($1;$2;$col;$row)
AL_GetCurrCell (xALP_Planes;$col;$row)
adSTRas_Planes_Desde{0}:=adSTRas_Planes_Desde{$row}
adSTRas_Planes_Hasta{0}:=adSTRas_Planes_Hasta{$row}

  // Modificado por: Saúl Ponce (06-12-2016) - Ticket 172054
  // Para que al hacer doble click en la fecha del plan, la parte derecha de la pestaña se actualice correctamente (basado en AS_SetSesionObjectsStatus)
READ ONLY:C145([Asignaturas_PlanesDeClases:169])
QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1=alSTRas_Planes_ID{$row})
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


