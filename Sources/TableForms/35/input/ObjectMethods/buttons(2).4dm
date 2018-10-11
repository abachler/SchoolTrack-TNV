  //Eliminación de inscripción de Alumno

  //Se obtienen las posiciones de los registros de las líneas de las listas de Recorridos y de Inscripciones
$pos:=AL_GetLine (xalp_ListaRec)  //Recorrido al que pertenece la inscripcion
$line:=AL_GetLine (xalp_Inscritos)  //Registro de inscripción a eliminar

  //Se obtiene el registro de incripción que coincida con el recorrido y el alumno y se elimina.
AL_UpdateArrays (xalp_Inscritos;0)
READ WRITE:C146([BU_Rutas_Inscripciones:35])
QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=alBU_IdRecorrido{$pos};*)
QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2=alBU_ALID{$line})
DELETE RECORD:C58([BU_Rutas_Inscripciones:35])
READ ONLY:C145([BU_Rutas_Inscripciones:35])


READ WRITE:C146([BU_Rutas_Recorridos:33])
QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Recorrido:1;=;alBU_IdRecorrido{$pos})
[BU_Rutas_Recorridos:33]Total_Alumnos:10:=[BU_Rutas_Recorridos:33]Total_Alumnos:10-1
SAVE RECORD:C53([BU_Rutas_Recorridos:33])
UNLOAD RECORD:C212([BU_Rutas_Recorridos:33])
READ ONLY:C145([BU_Rutas_Recorridos:33])


  //Se eliminan los valores de los arreglos.
AT_Delete ($line;1;->atBU_ALNom;->atBU_ALCurso;->atBU_ALTipoServ;->atBU_ALDesciende;->atBU_ALAcompañado;->alBU_ALID;->at_observacion)
AL_UpdateArrays (xalp_Inscritos;-2)

  //Se actualiza el listado general de alumno para que aparezca disponible el alumno de la
  //inscripción eliminada.
AL_UpdateArrays (xALP_Trans1;0)
BU_CtrListas (<>aCursos{<>acursos};alBU_IdRecorrido{$pos})
If (Size of array:C274(alBU_ALID)>0)
	_O_ENABLE BUTTON:C192(bDelAL)
	_O_ENABLE BUTTON:C192(bPrintAL)
Else 
	_O_DISABLE BUTTON:C193(bDelAL)
	_O_DISABLE BUTTON:C193(bPrintAL)
End if 
AL_UpdateArrays (xALP_Trans1;-2)