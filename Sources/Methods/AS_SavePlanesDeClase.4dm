//%attributes = {}
  //AS_SavePlanesDeClase


QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3=!00-00-00!;*)
QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169]; | [Asignaturas_PlanesDeClases:169]Hasta:4=!00-00-00!)
KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169];False:C215)

CLEAR SET:C117("planes")
CLEAR SET:C117("horario")
UNLOAD RECORD:C212([Asignaturas_PlanesDeClases:169])
READ ONLY:C145([Asignaturas_PlanesDeClases:169])