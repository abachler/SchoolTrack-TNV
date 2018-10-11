//%attributes = {}
  // MÉTODO: AL_OnUnload
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 12:17:58
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AL_OnUnload()
  // ----------------------------------------------------
  // CODIGO PRINCIPAL


AL_PostEdicionCompetencias 


vi_SoloPromedioOficial:=0
vi_SoloPromedioInterno:=0

AL_UpdateArrays (xALP_UFields;0)
AL_UpdateArrays (xALP_ConductaAlumnos;0)
AL_UpdateArrays (xALP_Notas;0)
AL_UpdateArrays (xALP_ConsultasEnfermeria;0)
AL_UpdateFields (xALP_PsyEvents;2)
AL_UpdateFields (xALP_PsyObs;2)
AL_UpdateArrays (xALP_Interview;0)
  //AL_UpdateArrays (xALP_ComentariosPJefe;0)
AL_UpdateArrays (xALP_ComentariosAlumno;0)
  //AL_UpdateArrays (xALP_ObsAsg;0)
AL_UpdateArrays (xALP_Familia;0)
AL_UpdateArrays (xALP_Hermano;0)
AL_UpdateArrays (xALP_FamUFields;0)
AL_RemoveArrays (xALP_HNotasECursos;1;10)
  //AL_RemoveArrays (xALP_ConductaAlumnos;1;10)
AL_RemoveArrays (xALP_ConductaAlumnos;1;20)
AL_initialize 
UNLOAD RECORD:C212([Familia:78])