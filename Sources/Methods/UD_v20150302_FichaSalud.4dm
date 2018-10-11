//%attributes = {}
  //UD_v20150302_FichaSalud
  //Crea ficha de salud para alumnos que no la tienen. Ticket 140315.

C_LONGINT:C283($l_indice;$l_proc)
READ ONLY:C145([Alumnos:2])

$l_proc:=IT_UThermometer (1;0;"Verificando registro de salud...")
QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=Nivel_AdmisionDirecta;*)
QUERY:C277([Alumnos:2]; | ;[Alumnos:2]nivel_numero:29=Nivel_AdmissionTrack)  // 20181008 ASM Ticket 214887 creo el registro de Salud
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aQR_Longint1)
For ($l_indice;1;Size of array:C274(aQR_Longint1))
	AL_CreaRegistroSalud (aQR_Longint1{$l_indice})
End for 
IT_UThermometer (-2;$l_proc)
AT_Initialize (->aQR_Longint1)