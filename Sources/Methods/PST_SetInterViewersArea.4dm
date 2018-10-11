//%attributes = {}
  //PST_SetInterViewersArea

Case of 
	: ($1=1)
		QUERY:C277([Profesores:4];[Profesores:4]Es_Entrevistador_Admisiones:35=True:C214)
		CREATE SET:C116([Profesores:4];"Entrevistadores")
		viPST_RecordsinSet:=Records in set:C195("Entrevistadores")
		vsPST_RecordsInDisplay:=String:C10(Records in selection:C76([Profesores:4]))+" entrevistadores sobre un total de "+String:C10(viPST_RecordsinSet)
		QRY_BuildQueryMenu (->[Profesores:4])
End case 

AL_UpdateFields (xALP_Postulaciones;2)

FORM GOTO PAGE:C247(1)