//%attributes = {}
  //ADTcdd_NewCddDefFieldValues

[Alumnos:2]numero:1:=SQ_SeqNumber (->[Alumnos:2]numero:1)
[Alumnos:2]Fecha_de_Creacion:21:=Current date:C33(*)
[Alumnos:2]Fecha_de_modificacion:22:=Current date:C33(*)
[Alumnos:2]Modificado_por:23:=<>tUSR_CurrentUser
[Alumnos:2]nivel_numero:29:=Nivel_AdmissionTrack
[Alumnos:2]Nivel_Nombre:34:="AdmissionTrack"
[Alumnos:2]Status:50:="Candidato"
[Alumnos:2]curso:20:="POST"
[Alumnos:2]Nacionalidad:8:=LOC_GetNacionalidad 
If (<>vtXS_CountryCode="mx")  //Cambiar por una religion por defecto elegida por el usuario!!!
	[Alumnos:2]Religion:9:="Católica"
End if 
[ADT_Candidatos:49]Candidato_numero:1:=[Alumnos:2]numero:1
[ADT_Candidatos:49]Fecha_de_Inscripción:2:=Current date:C33(*)
[ADT_Candidatos:49]Inscriptor:3:=<>tUSR_CurrentUser