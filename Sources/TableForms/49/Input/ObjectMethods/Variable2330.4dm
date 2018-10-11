If (viPST_fatherRecNum<0)
	BEEP:C151
Else 
	SAVE RECORD:C53([Alumnos:2])
	$rec:=Record number:C243([Alumnos:2])
	$selectedRecord:=Selected record number:C246([Alumnos:2])
	$idStudent:=[Alumnos:2]numero:1
	$idFamilia:=[Alumnos:2]Familia_Número:24
	CUT NAMED SELECTION:C334([Alumnos:2];"selection")
	$loaded:=KRL_GotoRecord (->[Personas:7];viPST_fatherRecNum;True:C214)
	If ($loaded)
		  //verifiyng that the father is related to other students
		QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1;*)
		QUERY:C277([Alumnos:2]; | [Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]numero:1#$idStudent)
		$studentRelateds:=Records in selection:C76([Alumnos:2])
		
		  //verifiyng that the father is not the father of an other family
		QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Personas:7]No:1;*)
		QUERY:C277([Familia:78]; & [Familia:78]Numero:1#$idFamilia)
		$familyRelateds:=Records in selection:C76([Familia:78])
		
		  //verifiyng that the father is related to other families
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2#$idFamilia)
		$otherRelations:=Records in selection:C76([Familia:78])
		
		C_LONGINT:C283($vl_records;$vl_records2)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records2)
		QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		Case of 
			: (($familyRelateds=0) & ($studentRelateds=0) & ($otherRelations=0) & ($vl_records=0) & ($vl_records2=0))
				  //the father is related only to this student and this family, it can be deleted   
				$msg:=__ ("^0 está relacionada solo con este alumno/postulante y su familia.\r\r¿Desea eliminar definitivamente la ficha de ^0?")
				$msg:=Replace string:C233($msg;"^0";[Personas:7]Apellidos_y_nombres:30)
				OK:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
				If (OK=1)
					$loaded:=KRL_GotoRecord (->[Familia:78];vlPST_LinkedFamilyRec;True:C214)
					If ($loaded)
						START TRANSACTION:C239  //20130730 RCH
						$idPeople:=[Personas:7]No:1
						[Familia:78]Padre_Número:5:=0
						[Familia:78]Padre_Nombre:15:=""
						SAVE RECORD:C53([Familia:78])
						READ WRITE:C146([Familia_RelacionesFamiliares:77])
						  //QUERY([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Persona=[Personas]No)
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=$idPeople)
						  //DELETE SELECTION([Familia_RelacionesFamiliares])
						  //KRL_DeleteSelection (->[Familia_RelacionesFamiliares])
						$l_eliminado:=KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])
						If ($l_eliminado=1)
							viPST_fatherRecNum:=0
							QUERY:C277([Personas:7];[Personas:7]No:1=$idPeople)
							DELETE RECORD:C58([Personas:7])
							KRL_GotoRecord (->[Alumnos:2];$rec;True:C214)
							If ([Alumnos:2]Apoderado_académico_Número:27=$idPeople)
								[Alumnos:2]Apoderado_académico_Número:27:=0
							End if 
							If ([Alumnos:2]Apoderado_Cuentas_Número:28=$idPeople)
								[Alumnos:2]Apoderado_Cuentas_Número:28:=0
							End if 
							SAVE RECORD:C53([Alumnos:2])
							VALIDATE TRANSACTION:C240
						Else 
							CD_Dlog (0;"El registro no pudo ser eliminado.")
							CANCEL TRANSACTION:C241
						End if 
					End if 
				End if 
			: (($familyRelateds>0) | ($studentRelateds>0) | ($otherRelations>0))
				  //the father is related to other families and students, 
				  //we just can delete the relation to this family and student
				$msg:=__ ("^0 tiene relaciones con otros alumnos/postulantes y/o familias. Solo puede ser eliminada la relación entre la persona y la familia.\r\r¿Desea eliminar esta relación?")
				$msg:=Replace string:C233($msg;"^0";[Personas:7]Apellidos_y_nombres:30)
				OK:=CD_Dlog (0;$msg;"";__ ("Si");__ ("No"))
				If (OK=1)
					$loaded:=KRL_GotoRecord (->[Familia:78];vlPST_LinkedFamilyRec;True:C214)
					If ($loaded)
						START TRANSACTION:C239  //20130730 RCH
						$idPeople:=[Personas:7]No:1
						[Familia:78]Padre_Número:5:=0
						[Familia:78]Padre_Nombre:15:=""
						SAVE RECORD:C53([Familia:78])
						READ WRITE:C146([Familia_RelacionesFamiliares:77])
						  //QUERY([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Persona=[Personas]No;*)
						QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=$idPeople;*)
						QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=$idFamilia)
						
						  //DELETE SELECTION([Familia_RelacionesFamiliares])
						  //KRL_DeleteSelection (->[Familia_RelacionesFamiliares])
						$l_eliminado:=KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])
						If ($l_eliminado=1)
							viPST_fatherRecNum:=0
							KRL_GotoRecord (->[Alumnos:2];$rec;True:C214)
							If ([Alumnos:2]Apoderado_académico_Número:27=$idPeople)
								[Alumnos:2]Apoderado_académico_Número:27:=0
							End if 
							If ([Alumnos:2]Apoderado_Cuentas_Número:28=$idPeople)
								[Alumnos:2]Apoderado_Cuentas_Número:28:=0
							End if 
							SAVE RECORD:C53([Alumnos:2])
							VALIDATE TRANSACTION:C240
						Else 
							CD_Dlog (0;"El registro no pudo ser eliminado.")
							CANCEL TRANSACTION:C241
						End if 
					Else 
						KRL_LockedRecordInfos (->[Familia:78])
					End if 
				End if 
		End case 
	Else 
		KRL_LockedRecordInfos (->[Personas:7])
	End if 
	USE NAMED SELECTION:C332("Selection")
	KRL_GotoSelectedRecord (->[Alumnos:2];$rec;True:C214)
	PST_GetFamilyRelations 
End if 
PST_SetConnexions 