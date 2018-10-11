//%attributes = {}
  //RF_HijoMenor

QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1;*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=<>al_NumeroNivelRegular{1};*)
QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
ORDER BY:C49([Alumnos:2];[Alumnos:2]Fecha_de_nacimiento:7;<)
REDUCE SELECTION:C351([Alumnos:2];1)