//%attributes = {}
  //DIAP_ConfigCargaCursos
  //Cargar los cuartos medios que participan del DIAP
C_POINTER:C301($y_interfazCurso;$y_interfazDisponible;$y_interfazCursoUUID;$1;$2;$3)

$y_interfazCurso:=$1
$y_interfazCursoUUID:=$2
$y_interfazDisponible:=$3

C_LONGINT:C283($i;$fia)
C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)
ARRAY TEXT:C222($at_DIAP_CursoUUID;0)
ARRAY TEXT:C222($at_DIAP_Curso;0)
ARRAY BOOLEAN:C223($ab_DIAP_CursoDisponible;0)

$xBlob:=PREF_fGetBlob (0;"DIAP_Cursos_"+String:C10(<>gyear);$xBlob)  //este blob contiene 2 array: uuid de subsector y arreglo booleano para saber si está disponible para DIAP

ARRAY TEXT:C222($at_uuid;0)
ARRAY TEXT:C222($at_curso;0)

READ ONLY:C145([Cursos:3])
QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=12;*)  //Actualmente sólo inscriben cursos de este nivel
QUERY:C277([Cursos:3]; & ;[Cursos:3]Letra_Oficial_del_Curso:18#"ADT")

ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>)
SELECTION TO ARRAY:C260([Cursos:3]Auto_UUID:47;$at_uuid;[Cursos:3]Curso:1;$at_curso)

If (BLOB size:C605($xBlob)>0)
	BLOB_Blob2Vars (->$xBlob;0;->$at_DIAP_CursoUUID;->$ab_DIAP_CursoDisponible)
	ARRAY TEXT:C222($at_DIAP_Curso;Size of array:C274($at_DIAP_CursoUUID))
	
	For ($i;1;Size of array:C274($at_uuid))
		
		$fia:=Find in array:C230($at_DIAP_CursoUUID;$at_uuid{$i})
		
		If ($fia=-1)
			APPEND TO ARRAY:C911($at_DIAP_CursoUUID;$at_uuid{$i})
			APPEND TO ARRAY:C911($at_DIAP_Curso;$at_curso{$i})
			APPEND TO ARRAY:C911($ab_DIAP_CursoDisponible;False:C215)
		Else 
			$at_DIAP_Curso{$fia}:=$at_curso{$i}
		End if 
		
	End for 
	
	SORT ARRAY:C229($at_DIAP_Curso;$at_DIAP_CursoUUID;$ab_DIAP_CursoDisponible;>)
	
Else 
	
	COPY ARRAY:C226($at_uuid;$at_DIAP_CursoUUID)
	COPY ARRAY:C226($at_curso;$at_DIAP_Curso)
	ARRAY BOOLEAN:C223($ab_DIAP_CursoDisponible;Size of array:C274($at_DIAP_CursoUUID))
	
End if 

BLOB_Variables2Blob (->$xBlob;0;->$at_DIAP_CursoUUID;->$ab_DIAP_CursoDisponible)
PREF_SetBlob (0;"DIAP_Cursos_"+String:C10(<>gyear);$xBlob)

COPY ARRAY:C226($at_DIAP_Curso;$y_interfazCurso->)
COPY ARRAY:C226($at_DIAP_CursoUUID;$y_interfazCursoUUID->)
COPY ARRAY:C226($ab_DIAP_CursoDisponible;$y_interfazDisponible->)
