//%attributes = {}
  // AS_OnUnload()
  // Por: Alberto Bachler: 20/05/13, 19:27:38
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


AL_UpdateArrays (xALP_StdList;0)
AL_UpdateArrays (xALP_ASNotas;0)
AL_UpdateArrays (xALP_Planes;0)

CLEAR SET:C117("planes")
CLEAR SET:C117("horario")
KRL_ReloadAsReadOnly (->[Asignaturas:18])
KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
KRL_UnloadReadOnly (->[Asignaturas_PlanesDeClases:169])
KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])

AS_InitVariables 


AS_TareasPostEdicionNotas 


$y_listaEnunciados:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
If (Not:C34(Undefined:C82($y_listaEnunciados->)))
	If (Is a list:C621($y_listaEnunciados->))
		CLEAR LIST:C377($y_listaEnunciados->;*)
	End if 
End if 

SET FIELD RELATION:C919([Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)