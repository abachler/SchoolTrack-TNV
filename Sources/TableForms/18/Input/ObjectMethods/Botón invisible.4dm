  // [Asignaturas].Input.Botón invisible()
  // Por: Alberto Bachler: 30/07/13, 18:49:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
cb_CalificacionesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 0)
cb_AprendizajesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 1)
cb_ObservacionesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 2)
cb_PlanesDeClasesEnSNT:=Num:C11([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 3)

WDW_OpenPopupWindow (Self:C308;->[Asignaturas:18];"PublicacionSchoolNet";32)
DIALOG:C40([Asignaturas:18];"PublicacionSchoolNet")
CLOSE WINDOW:C154
Case of 
	: ([Asignaturas:18]Publicar_en_SchoolNet:60=0)
		cb_publicarEnSchoolNet:=0
	: ([Asignaturas:18]Publicar_en_SchoolNet:60=15)
		cb_publicarEnSchoolNet:=1
	Else 
		cb_publicarEnSchoolNet:=2
End case 





