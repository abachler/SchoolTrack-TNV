//%attributes = {}
  //CU_CargaProfesoresFirmantes

C_BLOB:C604($blob)
C_LONGINT:C283($1;$classIID)

If (Count parameters:C259=1)
	$classID:=$1
Else 
	$classID:=[Cursos:3]Numero_del_curso:6
End if 

ARRAY TEXT:C222(aPrfNam;0)
ARRAY TEXT:C222(aPrfAut;0)
ARRAY TEXT:C222(aAsg2;0)
ARRAY TEXT:C222(aPrfNam2;0)
ARRAY TEXT:C222(aPrfAut2;0)
ARRAY TEXT:C222(aStringPrfID;0)
ARRAY TEXT:C222(aRUNProfesor;0)
ARRAY TEXT:C222(aAsgCode;0)


$blob:=PREF_fGetBlob (0;"Firmantes en "+String:C10($classID);$blob)
If (BLOB size:C605($blob)>0)
	$objectRef:=OT BLOBToObject ($blob)
	If ($objectRef#0)
		OT GetArray ($objectRef;"Asignatura";aAsg2)
		OT GetArray ($objectRef;"Nombres profesores";aPrfNam2)
		OT GetArray ($objectRef;"Autorizaciones";aPrfAut2)
		OT GetArray ($objectRef;"ID Profesores";aStringPrfID)
		OT GetArray ($objectRef;"Codigos asignaturas";aAsgCode)
		OT GetArray ($objectRef;"RUN profesores";aRUNProfesor)
		OT Clear ($objectRef)
	End if 
End if 
AT_ResizeArrays (->aPrfNam2;Size of array:C274(aAsg2))
AT_ResizeArrays (->aPrfAut2;Size of array:C274(aAsg2))
AT_ResizeArrays (->aStringPrfID;Size of array:C274(aAsg2))
AT_ResizeArrays (->aAsgCode;Size of array:C274(aAsg2))
AT_ResizeArrays (->aRUNProfesor;Size of array:C274(aAsg2))

