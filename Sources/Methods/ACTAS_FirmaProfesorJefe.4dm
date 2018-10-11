//%attributes = {}
  // ACTAS_FirmaProfesorJefe()
  // Por: Alberto Bachler K.: 31-03-14, 18:02:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($y_firmaProfesor)

  // firma del profesor
$y_firmaProfesor:=OBJECT Get pointer:C1124(Object named:K67:5;"firmaProfesor")
$y_firmaResponsable:=OBJECT Get pointer:C1124(Object named:K67:5;"firmaResponsable")


If (<>iCrtfYear=<>gYear)
	KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Cursos:3]Numero_del_profesor_jefe:2)
	If (vi_UppercaseNames=1)
		vt_NombreProfesor:=ST_CleanString ([Profesores:4]Nombres:2+" "+ST_Uppercase ([Profesores:4]Apellido_paterno:3)+" "+ST_Uppercase ([Profesores:4]Apellido_materno:4))
	Else 
		vt_NombreProfesor:=ST_CleanString ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)
	End if 
Else 
	QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]ID_Curso:52=[Cursos:3]Numero_del_curso:6;*)
	QUERY:C277([Cursos_SintesisAnual:63]; & [Cursos_SintesisAnual:63]NumeroNivel:3=[Cursos:3]Nivel_Numero:7;*)
	QUERY:C277([Cursos_SintesisAnual:63]; & [Cursos_SintesisAnual:63]Año:2=<>iCrtfYear;*)
	QUERY:C277([Cursos_SintesisAnual:63]; & [Cursos_SintesisAnual:63]ProfesorJefe_ID:8>0)
	If (Records in selection:C76([Cursos_SintesisAnual:63])>0)
		KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Cursos_SintesisAnual:63]ProfesorJefe_ID:8)
	Else 
		QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28=[Alumnos_Historico:25]ProfesorJefe:33)
	End if 
End if 
If ((Records in selection:C76([Profesores:4])=1) & (Not:C34([Profesores:4]Inactivo:62)))
	$y_firmaProfesor->:=[Profesores:4]Firma:15
	vt_NombreProfesor:=ST_CleanString ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
End if 

If (Not:C34(Is nil pointer:C315($y_firmaResponsable)))
	If (vt_NombreProfesor=vRespName)
		$y_firmaResponsable->:=$y_firmaProfesor->
	Else 
		ALL RECORDS:C47([Profesores:4])
		QUERY SELECTION BY FORMULA:C207([Profesores:4];ST_CleanString ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)=vRespName)
		If ((Records in selection:C76([Profesores:4])=1) & (Not:C34([Profesores:4]Inactivo:62)))
			$y_firmaResponsable->:=[Profesores:4]Firma:15
		Else 
			vRespName:=""
			$y_firmaResponsable->:=$y_firmaResponsable->*0
		End if 
	End if 
End if 
