//%attributes = {}
  // UD_v20130823_HorasPlanesDeClase()
  // Por: Alberto Bachler: 23/08/13, 11:06:50
  //  ---------------------------------------------
  // Corrige un error en el calculo del numero de horas enplanes de clases
  //
  //  ---------------------------------------------
$d_fechaInicioAño:=PERIODOS_InicioAñoSTrack 
$d_fechaTerminoAño:=PERIODOS_FinAñoPeriodosSTrack 

$l_idProceso:=IT_UThermometer (1;0;"Corrigiendo el numero de horas en planes de clases...")
QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$d_fechaInicioAño;*)
QUERY:C277([Asignaturas_PlanesDeClases:169]; & [Asignaturas_PlanesDeClases:169]Hasta:4<=$d_fechaTerminoAño)
READ WRITE:C146([Asignaturas_PlanesDeClases:169])
APPLY TO SELECTION:C70([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Plan:1:=[Asignaturas_PlanesDeClases:169]ID_Plan:1)
IT_UThermometer (-2;$l_idProceso)





