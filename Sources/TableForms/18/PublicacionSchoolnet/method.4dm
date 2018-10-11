  // [Asignaturas].PublicacionSchoolnet()
  // Por: Alberto Bachler: 30/07/13, 18:45:13
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If (Form event:C388=On Load:K2:1)
	cb_CalificacionesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 0)
	cb_AprendizajesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 1)
	cb_ObservacionesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 2)
	cb_PlanesDeClasesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 3)
End if 




