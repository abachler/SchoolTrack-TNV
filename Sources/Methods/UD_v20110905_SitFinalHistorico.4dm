//%attributes = {}
  //UD_v20110905_SitFinalHistorico
  //20110906 RCH Se agrega termometro

C_LONGINT:C283($vl_proc)

READ WRITE:C146([Alumnos_SintesisAnual:210])

$vl_proc:=IT_UThermometer (1;0;"Actualizando datos en síntesis anual")
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]SituacionFinal:8="P";*)
QUERY:C277([Alumnos_SintesisAnual:210]; | [Alumnos_SintesisAnual:210]SituacionFinal:8="A";*)
QUERY:C277([Alumnos_SintesisAnual:210]; | [Alumnos_SintesisAnual:210]SituacionFinal:8="RR")
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Promovido:91=False:C215)
APPLY TO SELECTION:C70([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Promovido:91:=True:C214)


QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]SituacionFinal:8="R";*)
QUERY:C277([Alumnos_SintesisAnual:210]; | [Alumnos_SintesisAnual:210]SituacionFinal:8="D";*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Promovido:91=True:C214)
APPLY TO SELECTION:C70([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Promovido:91:=False:C215)
IT_UThermometer (-2;$vl_proc)

KRL_UnloadAll 
