//%attributes = {}
  //AS_PagePlanesDeClases

ARRAY DATE:C224(adSTRas_Planes_Desde;0)
ARRAY DATE:C224(adSTRas_Planes_Hasta;0)
ARRAY INTEGER:C220(aiSTRas_Planes_Horas;0)
ARRAY LONGINT:C221(alSTRas_Planes_ID;0)
ARRAY TEXT:C222(atXDOC_AttachedDocs;0)
ARRAY LONGINT:C221(alXDOC_AttachedRecNum;0)
ARRAY TEXT:C222(atXDOC_AttachedURL;0)
ARRAY LONGINT:C221(alXDOC_AttachedURLRecNum;0)


AL_UpdateArrays (xALP_Planes;0)
READ WRITE:C146([Asignaturas_PlanesDeClases:169])
If (cb_AgnosAnteriores=1)
	QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_PlanesDeClases:169]; & ;[Asignaturas_PlanesDeClases:169]Desde:3<vdSTR_Periodos_InicioEjercicio)
	AL_SetEnterable (xALP_Planes;0;0)
Else 
	QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1)
	QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=vdSTR_Periodos_InicioEjercicio;*)
	QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; | [Asignaturas_PlanesDeClases:169]Desde:3=!00-00-00!)
End if 
AL_SetEnterable (xALP_Planes;1;1)
AL_SetEnterable (xALP_Planes;2;1)
AL_SetEnterable (xALP_Planes;3;1)

SELECTION TO ARRAY:C260([Asignaturas_PlanesDeClases:169]ID_Plan:1;alSTRas_Planes_ID;[Asignaturas_PlanesDeClases:169]Desde:3;adSTRas_Planes_Desde;[Asignaturas_PlanesDeClases:169]Hasta:4;adSTRas_Planes_Hasta;[Asignaturas_PlanesDeClases:169]NumeroHoras:5;aiSTRas_Planes_Horas)
SORT ARRAY:C229(adSTRas_Planes_Desde;adSTRas_Planes_Hasta;aiSTRas_Planes_Horas;alSTRas_Planes_ID;<)
AL_UpdateArrays (xALP_Planes;-2)
  //AL_SetSort (xALP_Planes;-2)

READ ONLY:C145([TMT_Horario:166])
QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
CREATE SET:C116([TMT_Horario:166];"horario")

FORM GOTO PAGE:C247(6)

SELECT LIST ITEMS BY POSITION:C381(vTab_Programas;1)
bGrid:=0
vt_sesionData:=""
vLastGridStatus:=0

vtSTK_TextoPlanesDeClases:=""
vtSTK_NombrePlan:=""


If (Size of array:C274(alSTRas_Planes_ID)>0)
	AL_SetLine (xALP_Planes;1)
End if 
AS_SetSesionObjectsStatus 

