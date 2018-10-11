//%attributes = {}
  // UD_v20130503_SubtablasFMedica()
  // Por: Alberto Bachler: 03/05/13, 10:06:15
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica]Alergias'id_added_by_converter#0)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_FichaMedica:13];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos_FichaMedica:13];$al_RecNums{$i})
	QUERY:C277([Alumnos_FichaMedica_Alergias:223];[Alumnos_FichaMedica_Alergias:223]id_added_by_converter:3=Get subrecord key:C1137([Alumnos_FichaMedica:13]Alergias:13))
	READ WRITE:C146([Alumnos_FichaMedica_Alergias:223])
	APPLY TO SELECTION:C70([Alumnos_FichaMedica_Alergias:223];[Alumnos_FichaMedica_Alergias:223]id_alumno:4:=[Alumnos_FichaMedica:13]Alumno_Numero:1)
End for 


QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica]Enfermedades'id_added_by_converter#0)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_FichaMedica:13];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos_FichaMedica:13];$al_RecNums{$i})
	QUERY:C277([Alumnos_FichaMedica_Enfermedade:224];[Alumnos_FichaMedica_Enfermedade:224]id_added_by_converter:2=Get subrecord key:C1137([Alumnos_FichaMedica:13]Enfermedades:14))
	READ WRITE:C146([Alumnos_FichaMedica_Enfermedade:224])
	APPLY TO SELECTION:C70([Alumnos_FichaMedica_Enfermedade:224];[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3:=[Alumnos_FichaMedica:13]Alumno_Numero:1)
End for 


QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica]Aparatos_protesis'id_added_by_converter#0)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_FichaMedica:13];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos_FichaMedica:13];$al_RecNums{$i})
	QUERY:C277([Alumnos_FichaMedica_Aparatos_pr:226];[Alumnos_FichaMedica_Aparatos_pr:226]id_added_by_converter:5=Get subrecord key:C1137([Alumnos_FichaMedica:13]Aparatos_protesis:16))
	READ WRITE:C146([Alumnos_FichaMedica_Aparatos_pr:226])
	APPLY TO SELECTION:C70([Alumnos_FichaMedica_Aparatos_pr:226];[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6:=[Alumnos_FichaMedica:13]Alumno_Numero:1)
End for 



QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica]Hospitalizaciones'id_added_by_converter#0)
ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos_FichaMedica:13];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([Alumnos_FichaMedica:13];$al_RecNums{$i})
	QUERY:C277([Alumnos_FichaMedica_Hospitaliza:222];[Alumnos_FichaMedica_Hospitaliza:222]id_added_by_converter:4=Get subrecord key:C1137([Alumnos_FichaMedica:13]Hospitalizaciones:12))
	READ WRITE:C146([Alumnos_FichaMedica_Hospitaliza:222])
	APPLY TO SELECTION:C70([Alumnos_FichaMedica_Hospitaliza:222];[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5:=[Alumnos_FichaMedica:13]Alumno_Numero:1)
End for 



XSvs_ActualizaEstructuraVirtual 


