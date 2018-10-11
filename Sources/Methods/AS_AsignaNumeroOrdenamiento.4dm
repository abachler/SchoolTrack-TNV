//%attributes = {}
  //AS_AsignaNumeroOrdenamiento

ARRAY TEXT:C222(at_OrdenAsignaturas;0)
ARRAY TEXT:C222(aSubjectName;0)

If ([Asignaturas:18]Nivel:30#"")
	$nombreNivel:=[Asignaturas:18]Nivel:30
	$xOrdenamiento:=KRL_GetBlobFieldData (->[xxSTR_Niveles:6]Nivel:1;->$nombreNivel;->[xxSTR_Niveles:6]OrdenSubsectores:36)
	If (BLOB size:C605($xOrdenamiento)>0)
		ARRAY TEXT:C222(at_OrdenAsignaturas;0)
		ARRAY TEXT:C222(aSubjectName;0)
		BLOB_Blob2Vars (->$xOrdenamiento;0;->at_OrdenAsignaturas;->aSubjectName)
		If ([Asignaturas:18]denominacion_interna:16="")
			[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3
		End if 
		$el:=Find in array:C230(aSubjectName;[Asignaturas:18]denominacion_interna:16)
		If ($el>0)
			[Asignaturas:18]ordenGeneral:105:=at_OrdenAsignaturas{$el}
			[Asignaturas:18]posicion_en_informes_de_notas:36:=Num:C11(Substring:C12([Asignaturas:18]ordenGeneral:105;1;2))
		End if 
	End if 
End if 

If ([Asignaturas:18]Curso:5#"")
	$curso:=[Asignaturas:18]Curso:5
	$xOrdenamiento:=KRL_GetBlobFieldData (->[Cursos:3]Curso:1;->$curso;->[Cursos:3]Orden_Subsectores:17)
	If (BLOB size:C605($xOrdenamiento)>0)
		ARRAY TEXT:C222(at_OrdenAsignaturas;0)
		ARRAY TEXT:C222(aSubjectName;0)
		BLOB_Blob2Vars (->$xOrdenamiento;0;->at_OrdenAsignaturas;->aSubjectName)
		If ([Asignaturas:18]denominacion_interna:16="")
			[Asignaturas:18]denominacion_interna:16:=[Asignaturas:18]Asignatura:3
		End if 
		$el:=Find in array:C230(aSubjectName;[Asignaturas:18]denominacion_interna:16)
		If ($el>0)
			[Asignaturas:18]ordenGeneral:105:=at_OrdenAsignaturas{$el}
			[Asignaturas:18]posicion_en_informes_de_notas:36:=Num:C11(Substring:C12([Asignaturas:18]ordenGeneral:105;1;2))
		End if 
	End if 
End if 