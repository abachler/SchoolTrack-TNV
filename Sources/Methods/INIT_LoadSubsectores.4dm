//%attributes = {}
  //INIT_LoadSubsectores

ARRAY TEXT:C222(<>aAsign;0)
UNLOAD RECORD:C212([Asignaturas:18])
READ ONLY:C145([xxSTR_Materias:20])
ALL RECORDS:C47([xxSTR_Materias:20])
READ ONLY:C145([xxSTR_Materias:20])
ALL RECORDS:C47([xxSTR_Materias:20])
SELECTION TO ARRAY:C260([xxSTR_Materias:20]Materia:2;<>aAsign;[xxSTR_Materias:20]Orden interno:9;<>aAsignNo;[xxSTR_Materias:20]Area:12;<>aAsignSector;[xxSTR_Materias:20]Codigo:10;<>aAsignCode;[xxSTR_Materias:20]Abreviatura:8;<>aAsgAbrev;[xxSTR_Materias:20]NoSector:11;<>aAsgSectorPosition;[xxSTR_Materias:20]Materia_NombreLargo:20;<>aAsgLongName;[xxSTR_Materias:20]AreaMPA:4;<>aAsgAreaMPA)
SORT ARRAY:C229(<>aAsign;<>aAsignNo;<>aAsignSector;<>aAsignCode;<>aAsgAbrev;<>aAsgSectorPosition;<>aAsgLongName;<>aAsgAreaMPA;>)