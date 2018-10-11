  // [Asignaturas].Input.cb_publicarenSchoolNet1()
  // Por: Alberto Bachler: 25/07/13, 13:11:26
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

If ([Asignaturas:18]Publicar_en_SchoolNet:60 ?? 1)
	[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?- 1
Else 
	[Asignaturas:18]Publicar_en_SchoolNet:60:=[Asignaturas:18]Publicar_en_SchoolNet:60 ?+ 1
End if 
