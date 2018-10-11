//%attributes = {}
  //ADTsq_HijosdeExAlumnos


READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ADT_Candidatos:49])
If (IT_AltKeyIsDown )
	USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(->[ADT_Candidatos:49])))
Else 
	ALL RECORDS:C47([ADT_Candidatos:49])
End if 
ARRAY LONGINT:C221($RNHijoEx;0)
ARRAY LONGINT:C221($aNumeros;0)


  //MONO CONEXIONES

$l_proc:=IT_UThermometer (1;0;"Buscando postulantes hijos de ex alumnos...")
SELECTION TO ARRAY:C260([ADT_Candidatos:49]Candidato_numero:1;$aNumeros)
QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$aNumeros)
KRL_RelateSelection (->[Alumnos_Conexiones:212]Alumno_AutoUUID:7;->[Alumnos:2]auto_uuid:72;"")
QUERY SELECTION:C341([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Conexion:1="Hijo de ex alumno")
KRL_RelateSelection (->[Alumnos:2]auto_uuid:72;->[Alumnos_Conexiones:212]Alumno_AutoUUID:7;"")

  //CD_THERMOMETRE (1;0;__ ("Buscando postulantes hijos de ex alumnos..."))
  //For ($i;1;Size of array($aNumeros))
  //$alumno:=KRL_FindAndLoadRecordByIndex (->[Alumnos]Número;->$aNumeros{$i})
  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hijo de ex alumno")
  //If (Records in subselection([Alumnos]Conexiones)>0)
  //APPEND TO ARRAY($RNHijoEx;$alumno)
  //End if 
  //CD_THERMOMETRE (0;$i/Size of array($aNumeros)*100)
  //End for 
  //CD_THERMOMETRE (-1)
  //CREATE SELECTION FROM ARRAY([Alumnos];$RNHijoEx;"")

KRL_RelateSelection (->[ADT_Candidatos:49]Candidato_numero:1;->[Alumnos:2]numero:1;"")
UNLOAD RECORD:C212([ADT_Candidatos:49])
UNLOAD RECORD:C212([Alumnos:2])
IT_UThermometer (-2;$l_proc)
ok:=1