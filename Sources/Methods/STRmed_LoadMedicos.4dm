//%attributes = {}
  //STRmed_LoadMedicos


  //ABK_20140701 Este código debe ser modificado para cargar los nuevos campos de la tabla médicos

  //ASM 20140718 No es necesario comentar este código, ya que sun función es cargar los mediscos creados en ST para realizar el "autocomplete" en STWA y así evitar que se dupliquen médicos.

ARRAY TEXT:C222(aMedNombre;0)
ARRAY TEXT:C222(aMedEspecialidad;0)
ARRAY TEXT:C222(aMedTelefonos;0)
ARRAY TEXT:C222(aMedEMail;0)
ARRAY LONGINT:C221(aMedID;0)
READ ONLY:C145([STR_Medicos:89])
ALL RECORDS:C47([STR_Medicos:89])
SELECTION TO ARRAY:C260([STR_Medicos:89]eMail:5;aMedEMail;[STR_Medicos:89]Especialidad:2;aMedEspecialidad;[STR_Medicos:89]ID:3;aMedID;[STR_Medicos:89]Nombres:1;aMedNombre;[STR_Medicos:89]Telefono_movil:4;aMedTelefonos)