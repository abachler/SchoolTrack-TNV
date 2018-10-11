//%attributes = {}
  //PST_SetCandidatesArea

sSearch:=""
Case of 
	: ($1=1)
		READ WRITE:C146([ADT_Candidatos:49])
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Terminado:44=False:C215)
		CREATE SET:C116([ADT_Candidatos:49];"Postulantes")
		QRY_BuildQueryMenu (->[ADT_Candidatos:49])
		viPST_RecordsinSet:=Records in set:C195("Postulantes")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1;"")
		vsPST_RecordsInDisplay:=String:C10(Records in selection:C76([Alumnos:2]))+" postulantes sobre un total de "+String:C10(viPST_RecordsinSet)
End case 
AL_UpdateFields (xALP_Postulaciones;2)


FORM GOTO PAGE:C247(1)

SELECT LIST ITEMS BY POSITION:C381(hlTab_ADT_Postulantes;1)

