//%attributes = {}
  //DIAP_ConfigCargaSubsectores
  //Cargar materias que pueden ser seleccionadas en el diap

C_POINTER:C301($y_interfazMateria;$y_interfazUUID;$y_interfazDisponible;$y_uuidMateriaObligatoria;$1;$2;$3;$4)

$y_interfazMateria:=$1
$y_interfazUUID:=$2
$y_interfazDisponible:=$3
$y_uuidMateriaObligatoria:=$4  //uuid de subsector obligatorio

C_TEXT:C284($t_uuid_MateriaObligatoriaDiap)
C_LONGINT:C283($i;$fia)
C_BLOB:C604($xBlob)
SET BLOB SIZE:C606($xBlob;0)
ARRAY TEXT:C222($at_DIAP_MateriaUUID;0)
ARRAY TEXT:C222($at_DIAP_Materia;0)
ARRAY BOOLEAN:C223($ab_DIAP_MateriaDisponible;0)
  //podria considerarlo como una config anual ??
$xBlob:=PREF_fGetBlob (0;"DIAP_SubsectoresDisponibles_"+String:C10(<>gyear);$xBlob)  //este blob contiene 2 array: uuid de subsector y arreglo booleano para saber si está disponible para DIAP, mas el uui de la asignatura que es obligatoria

ARRAY TEXT:C222($at_uuid;0)
ARRAY TEXT:C222($at_materia;0)

READ ONLY:C145([xxSTR_Materias:20])
ALL RECORDS:C47([xxSTR_Materias:20])
ORDER BY:C49([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2;>)
SELECTION TO ARRAY:C260([xxSTR_Materias:20]Auto_UUID:21;$at_uuid;[xxSTR_Materias:20]Materia:2;$at_materia)

If (BLOB size:C605($xBlob)>0)
	BLOB_Blob2Vars (->$xBlob;0;->$at_DIAP_MateriaUUID;->$ab_DIAP_MateriaDisponible;->$t_uuid_MateriaObligatoriaDiap)
	ARRAY TEXT:C222($at_DIAP_Materia;Size of array:C274($at_DIAP_MateriaUUID))
	
	For ($i;1;Size of array:C274($at_uuid))
		
		$fia:=Find in array:C230($at_DIAP_MateriaUUID;$at_uuid{$i})
		
		If ($fia=-1)
			APPEND TO ARRAY:C911($at_DIAP_MateriaUUID;$at_uuid{$i})
			APPEND TO ARRAY:C911($at_DIAP_Materia;$at_materia{$i})
			APPEND TO ARRAY:C911($ab_DIAP_MateriaDisponible;False:C215)
		Else 
			$at_DIAP_Materia{$fia}:=$at_materia{$i}
		End if 
		
	End for 
	
	SORT ARRAY:C229($at_DIAP_Materia;$at_DIAP_MateriaUUID;$ab_DIAP_MateriaDisponible;>)
	
Else 
	
	COPY ARRAY:C226($at_uuid;$at_DIAP_MateriaUUID)
	COPY ARRAY:C226($at_materia;$at_DIAP_Materia)
	ARRAY BOOLEAN:C223($ab_DIAP_MateriaDisponible;Size of array:C274($at_DIAP_MateriaUUID))
	
End if 

BLOB_Variables2Blob (->$xBlob;0;->$at_DIAP_MateriaUUID;->$ab_DIAP_MateriaDisponible;->$t_uuid_MateriaObligatoriaDiap)
PREF_SetBlob (0;"DIAP_SubsectoresDisponibles_"+String:C10(<>gyear);$xBlob)

COPY ARRAY:C226($at_DIAP_Materia;$y_interfazMateria->)
COPY ARRAY:C226($at_DIAP_MateriaUUID;$y_interfazUUID->)
COPY ARRAY:C226($ab_DIAP_MateriaDisponible;$y_interfazDisponible->)
$y_uuidMateriaObligatoria->:=$t_uuid_MateriaObligatoriaDiap
