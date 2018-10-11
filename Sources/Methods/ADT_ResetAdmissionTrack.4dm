//%attributes = {}
  //ADT_ResetAdmissionTrack

KRL_UnloadReadOnly (->[ADT_Examenes:122])
KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
KRL_UnloadReadOnly (->[ADT_Candidatos:49])
KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[xxADT_PostulacionesHistoricas:112])
KRL_UnloadReadOnly (->[ADT_Contactos:95])
KRL_UnloadReadOnly (->[ADT_Prospectos:163])
KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
KRL_UnloadReadOnly (->[xxADT_MetaDataValues:80])

READ WRITE:C146([ADT_Examenes:122])
READ WRITE:C146([ADT_SesionesDeExamenes:123])
READ WRITE:C146([ADT_Entrevistas:121])
READ WRITE:C146([xxADT_PostulacionesHistoricas:112])
READ WRITE:C146([ADT_Contactos:95])
READ WRITE:C146([ADT_Prospectos:163])
READ WRITE:C146([xxADT_MetaDataDefinition:79])
READ WRITE:C146([xxADT_MetaDataValues:80])
0xDev_ClearTable (->[ADT_Examenes:122])
0xDev_ClearTable (->[ADT_SesionesDeExamenes:123])
0xDev_ClearTable (->[ADT_Entrevistas:121])
0xDev_ClearTable (->[xxADT_PostulacionesHistoricas:112])
0xDev_ClearTable (->[ADT_Contactos:95])
0xDev_ClearTable (->[ADT_Prospectos:163])
0xDev_ClearTable (->[xxADT_MetaDataDefinition:79])
0xDev_ClearTable (->[xxADT_MetaDataValues:80])

READ WRITE:C146([ADT_Candidatos:49])
READ WRITE:C146([Alumnos:2])
ALL RECORDS:C47([ADT_Candidatos:49])
KRL_RelateSelection (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1;"")
CREATE SET:C116([Alumnos:2];"2Delete")
$l_eliminado:=0  //20130730 RCH
While ($l_eliminado=0)
	$l_eliminado:=KRL_DeleteSelection (->[ADT_Candidatos:49];True:C214;__ ("Eliminando candidatos..."))
End while 
USE SET:C118("2Delete")
CLEAR SET:C117("2Delete")
AL_DeleteSelection 

ADT_CreateDefaultPrefs 

KRL_UnloadReadOnly (->[ADT_Examenes:122])
KRL_UnloadReadOnly (->[ADT_SesionesDeExamenes:123])
KRL_UnloadReadOnly (->[ADT_Entrevistas:121])
KRL_UnloadReadOnly (->[ADT_Candidatos:49])
KRL_UnloadReadOnly (->[Alumnos:2])
KRL_UnloadReadOnly (->[xxADT_PostulacionesHistoricas:112])
KRL_UnloadReadOnly (->[ADT_Contactos:95])
KRL_UnloadReadOnly (->[ADT_Prospectos:163])
KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
KRL_UnloadReadOnly (->[xxADT_MetaDataValues:80])