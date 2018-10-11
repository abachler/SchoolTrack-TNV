$line:=AL_GetLine (xALP_planes)
If ($line>0)
	READ WRITE:C146([Asignaturas_PlanesDeClases:169])
	  //QUERY([Asignaturas_PlanesDeClases];[Asignaturas_PlanesDeClases]ID_Plan=alSTRas_Planes_ID{$line})
	  //DELETE RECORD([Asignaturas_PlanesDeClases])
	QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1=alSTRas_Planes_ID{$line})
	STR_DeleteRecord (->[Asignaturas_PlanesDeClases:169])
	AS_PagePlanesDeClases 
End if 
