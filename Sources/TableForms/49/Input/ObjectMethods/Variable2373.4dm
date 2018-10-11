If (vlPST_LinkedFamilyRec<0)
	BEEP:C151
Else 
	SAVE RECORD:C53([Alumnos:2])
	$rec:=Record number:C243([Alumnos:2])
	$idStudent:=[Alumnos:2]numero:1
	$idFamilia:=[Alumnos:2]Familia_Número:24
	CUT NAMED SELECTION:C334([Alumnos:2];"selection")
	SAVE RECORD:C53([Familia:78])
	$loaded:=KRL_GotoRecord (->[Familia:78];vlPST_LinkedFamilyRec;True:C214)
	If ($loaded)
		  //verifiyng that the mother is related to other students
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]numero:1#$idStudent)
		$studentRelateds:=Records in selection:C76([Alumnos:2])
		
		  //verifiyng that the mother is related to other families
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2#$idFamilia)
		$otherRelations:=Records in selection:C76([Familia:78])
		
		Case of 
			: ($studentRelateds=0)
				  //the family is related only to this student, it can be deleted   
				  //$msg:=Replace string(RP_GetIdxString (21403;39);"^0";[Familia]Nombre_de_la_familia)
				OK:=CD_Dlog (0;Replace string:C233(__ ("La familia ^0 solo está relacionada con este alumno/aspirante.\r¿Desea eliminar definitivamente la familia ^0?");__ ("^0");[Familia:78]Nombre_de_la_familia:3);__ ("");__ ("Sí");__ ("No"))
				If (OK=1)
					$idPeople:=[Personas:7]No:1
					[Familia:78]Madre_Número:6:=0
					[Familia:78]Madre_Nombre:16:=""
					SAVE RECORD:C53([Familia:78])
					READ WRITE:C146([Familia_RelacionesFamiliares:77])
					QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
					DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
					DELETE RECORD:C58([Familia:78])
					KRL_GotoRecord (->[Alumnos:2];$rec;True:C214)
					[Alumnos:2]Familia_Número:24:=0
					vlPST_LinkedFamilyRec:=-1
					SAVE RECORD:C53([Alumnos:2])
				End if 
			: ($studentRelateds>0)
				  //the family is related to other students, 
				  //we just can delete links between family and student
				  //$msg:=Replace string(RP_GetIdxString (21403;40);"^0";[Familia]Nombre_de_la_familia)
				OK:=CD_Dlog (0;Replace string:C233(__ ("La familia ^0 tiene registradas relaciones con otros alumnos/postulantes. Solo puede ser eliminada la relación entre el alumno/aspirante y la familia.\r¿Desea eliminar esta relación?");__ ("^0");[Familia:78]Nombre_de_la_familia:3);__ ("");__ ("Sí");__ ("No"))
				If (OK=1)
					KRL_GotoRecord (->[Alumnos:2];$rec;True:C214)
					[Alumnos:2]Familia_Número:24:=0
					vlPST_LinkedFamilyRec:=-1
					SAVE RECORD:C53([Alumnos:2])
				End if 
		End case 
	Else 
		KRL_LockedRecordInfos (->[Familia:78])
	End if 
	USE NAMED SELECTION:C332("Selection")
	KRL_GotoSelectedRecord (->[Alumnos:2];$rec;True:C214)
	PST_GetFamilyRelations 
	PST_SetConnexions 
End if 

