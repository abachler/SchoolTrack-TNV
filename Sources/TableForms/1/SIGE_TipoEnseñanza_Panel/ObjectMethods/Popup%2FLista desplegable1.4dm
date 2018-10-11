C_LONGINT:C283($RECORDS)
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos:2])

$proc:=IT_UThermometer (1;0;__ ("Cargando configuración ..."))
AL_UpdateArrays (xALP_Unidades;0)

C_BLOB:C604($blob;$blob2)

  //guarda los datos en el blob y en el registro de preferencias correspondiente
$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
BLOB_Variables2Blob (->$blob;0;->at_DatosUnidadesEduc_Values)
PREF_SetBlob (0;$prefRecord;$blob)

  //lee el registro de preferencias correspondiente el tipo de enseñanza seleccionado
ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;0)
ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;29)
al_DatosUnidadesEduc_Codes:=Self:C308->
$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
SET BLOB SIZE:C606($blob;0)
BLOB_Variables2Blob (->$blob;0;->at_DatosUnidadesEduc_Values)
$blob2:=PREF_fGetBlob (0;$prefRecord;$blob)
$blob:=$blob2
BLOB_Blob2Vars (->$blob;0;->at_DatosUnidadesEduc_Values)
ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;29)
AL_UpdateArrays (xALP_Unidades;-2)


If (at_DatosUnidadesEduc_Values{1}="")
	QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
	at_DatosUnidadesEduc_Values{1}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;1;Length:C16([Cursos:3]cl_RolBaseDatos:20)-1)
	at_DatosUnidadesEduc_Values{2}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;Length:C16([Cursos:3]cl_RolBaseDatos:20))
End if 

If (at_DatosUnidadesEduc_Values{3}="")
	at_DatosUnidadesEduc_Values{3}:=String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
End if 


at_DatosUnidadesEduc_Values{20}:="0"
at_DatosUnidadesEduc_Values{21}:="0"
at_DatosUnidadesEduc_Values{22}:="0"
at_DatosUnidadesEduc_Values{23}:="0"
QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
KRL_RelateSelection (->[Alumnos:2]curso:20;->[Cursos:3]Curso:1;"")
CREATE SET:C116([Alumnos:2];"Alumnos")
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$aRecNums)
For ($iAlumnos;1;Size of array:C274($aRecNums))
	KRL_GotoRecord (->[Alumnos:2];$aRecNums{$iAlumnos})
	$origenIndigena:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"Origen Indígena")
	$diferencial:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"En Grupo Diferencial")
	$integrado:=MDATA_RetornaBooleano (->[Alumnos:2]numero:1;"Es Alumno Integrado")
	Case of 
		: (($origenIndigena) & ($diferencial) & ([Alumnos:2]Sexo:49="F"))
			at_DatosUnidadesEduc_Values{20}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{20})+1)  //"20. Als. hombres orígen indígena en Grupos Diferenciales"
		: (($origenIndigena) & ($diferencial) & ([Alumnos:2]Sexo:49="M"))
			at_DatosUnidadesEduc_Values{21}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{21})+1)  //"21. Als. mujeres orígen indígena en Grupos Diferenciales"
	End case 
	Case of 
		: (($origenIndigena) & ($integrado) & ([Alumnos:2]Sexo:49="F"))
			at_DatosUnidadesEduc_Values{22}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{22})+1)  //"22. Als. hombres orígen indígena integrados"
		: (($origenIndigena) & ($integrado) & ([Alumnos:2]Sexo:49="M"))
			at_DatosUnidadesEduc_Values{23}:=String:C10(Num:C11(at_DatosUnidadesEduc_Values{23})+1)  //"23. Als. mujeres orígen indígena integradas"
	End case 
End for 

IT_UThermometer (-2;$proc)