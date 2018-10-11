//%attributes = {}
  // UD_v20130213_NombresAlumnos()
  // Por: Alberto Bachler: 13/02/13, 12:06:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_Proceso)


$l_Proceso:=IT_UThermometer (1;0;"Normalizando nombres de alumnos...")
ST_LoadModuleFormatExceptions ("SchoolTrack")
QUERY:C277([Alumnos:2];[Alumnos:2]Nombre_Común:30="";*)
QUERY:C277([Alumnos:2]; | ;[Alumnos:2]Nombre_oficial:48="")
READ WRITE:C146([Alumnos:2])
APPLY TO SELECTION:C70([Alumnos:2];AL_ProcesaNombres )
KRL_UnloadReadOnly (->[Alumnos:2])
IT_UThermometer (-2;$l_Proceso)