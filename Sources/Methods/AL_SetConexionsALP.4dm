//%attributes = {}
  //AL_SetConexionsALP

  //vb_ConnectionsModified:=False
  //AL_UpdateArrays (xALP_Connexions;0)
  //ARRAY TEXT(at_Connexions;0)
  //ALL SUBRECORDS([Alumnos]Conexiones)
  //SF_Subtable2Array (->[Alumnos]Conexiones;->[Alumnos]Conexiones'Conexion;->at_Connexions)
  //AL_UpdateArrays (xALP_Connexions;-2)
  //AL_SetLine (xALP_Connexions;0)

  //MONO CONEXIONES
ARRAY TEXT:C222(at_auto_uuid_a_eliminar;0)
ARRAY BOOLEAN:C223(ab_conexionnueva;0)
ARRAY TEXT:C222(at_auto_uuid;0)

vb_ConnectionsModified:=False:C215
AL_UpdateArrays (xALP_Connexions;0)
ARRAY TEXT:C222(at_Connexions;0)
QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72)
SELECTION TO ARRAY:C260([Alumnos_Conexiones:212]Conexion:1;at_Connexions;[Alumnos_Conexiones:212]Auto_UUID:6;at_auto_uuid)
AL_UpdateArrays (xALP_Connexions;-2)
AL_SetLine (xALP_Connexions;0)

ARRAY BOOLEAN:C223(ab_conexionnueva;Size of array:C274(at_Connexions))