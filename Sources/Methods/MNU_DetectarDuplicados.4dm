//%attributes = {}
  // MNU_DetectarDuplicados()
  // 
  //
If (False:C215)
	  // ---------------------------------------------
	  // Alberto Bachler: 08/01/13, 17:10:01
	  // Normalización, declaración de variables, documentación
	  // ---------------------------------------------
End if 


C_LONGINT:C283($l_numDuplicados)
ARRAY LONGINT:C221($al_recNumsDuplicados;0)



  // CÓDIGO
READ ONLY:C145(yBWR_currentTable->)
ALL RECORDS:C47(yBWR_currentTable->)
Case of 
	: (vsBWR_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
				  // buscamos alumnos con los mismos apellidos y nombres
				$l_numDuplicados:=KRL_ValoresDuplicados (->[Alumnos:2]apellidos_y_nombres:40;->$al_recNumsDuplicados)
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Familia:78]))
				  // buscamos familias con los mismos nombres
				$l_numDuplicados:=KRL_ValoresDuplicados (->[Familia:78]Nombre_de_la_familia:3;->$al_recNumsDuplicados)
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				  // buscamos personas con los mismos apellidos y nombres
				$l_numDuplicados:=KRL_ValoresDuplicados (->[Personas:7]Apellidos_y_nombres:30;->$al_recNumsDuplicados)
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Profesores:4]))
				  // buscamos profesores con los mismos apellidos y nombres
				$l_numDuplicados:=KRL_ValoresDuplicados (->[Profesores:4]Apellidos_y_nombres:28;->$al_recNumsDuplicados)
				
		End case 
		
		
		
	: (vsBWR_CurrentModule="MediaTrack")
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Lectores:72]))
				  // buscamos lectores con los mismos apellidos y nombres
				$l_numDuplicados:=KRL_ValoresDuplicados (->[BBL_Lectores:72]NombreCompleto:3;->$al_recNumsDuplicados)
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[BBL_Items:61]))
				  // buscamos items con los mismos títulos
				$l_numDuplicados:=KRL_ValoresDuplicados (->[BBL_Items:61]Primer_título:4;->$al_recNumsDuplicados)
				
		End case 
		
		
		
	: (vsBWR_CurrentModule="AccountTrack")  // 20130917 RCH Ticket 125338
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				READ ONLY:C145([Alumnos:2])
				ALL RECORDS:C47([Alumnos:2])
				$l_numDuplicados:=KRL_ValoresDuplicados (->[Alumnos:2]apellidos_y_nombres:40;->$al_recNumsDuplicados)
				If ($l_numDuplicados>0)
					CREATE SELECTION FROM ARRAY:C640([Alumnos:2];$al_recNumsDuplicados;"")
					KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
					dhBWR_SpecialSearch 
					LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$al_recNumsDuplicados;"")
					$l_numDuplicados:=Size of array:C274($al_recNumsDuplicados)
				End if 
				
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
				$l_numDuplicados:=KRL_ValoresDuplicados (->[Personas:7]Apellidos_y_nombres:30;->$al_recNumsDuplicados)
				If ($l_numDuplicados>0)
					CREATE SELECTION FROM ARRAY:C640([Personas:7];$al_recNumsDuplicados;"")
					dhBWR_SpecialSearch 
					LONGINT ARRAY FROM SELECTION:C647([Personas:7];$al_recNumsDuplicados;"")
					$l_numDuplicados:=Size of array:C274($al_recNumsDuplicados)
				End if 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
				$l_numDuplicados:=KRL_ValoresDuplicados (->[ACT_Terceros:138]Nombre_Completo:9;->$al_recNumsDuplicados)
				
		End case 
		
		
		
	: (vsBWR_CurrentModule="AdmissionTrack")  // 20130917 RCH Ticket 125338
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ADT_Candidatos:49]))
				READ ONLY:C145([Alumnos:2])
				ALL RECORDS:C47([Alumnos:2])
				$l_numDuplicados:=KRL_ValoresDuplicados (->[Alumnos:2]apellidos_y_nombres:40;->$al_recNumsDuplicados)
				If ($l_numDuplicados>0)
					CREATE SELECTION FROM ARRAY:C640([Alumnos:2];$al_recNumsDuplicados;"")
					KRL_RelateSelection (->[ADT_Candidatos:49]Candidato_numero:1;->[Alumnos:2]numero:1;"")
					LONGINT ARRAY FROM SELECTION:C647([ADT_Candidatos:49];$al_recNumsDuplicados;"")
					$l_numDuplicados:=Size of array:C274($al_recNumsDuplicados)
				End if 
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ADT_Contactos:95]))
				$l_numDuplicados:=KRL_ValoresDuplicados (->[ADT_Contactos:95]Apellidos_y_Nombres:5;->$al_recNumsDuplicados)
				
		End case 
		
End case 

If ($l_numDuplicados>0)
	  // se detectaron duplicados, se muestran en el explorador
	CREATE SELECTION FROM ARRAY:C640(yBWR_currentTable->;$al_recNumsDuplicados)
	CREATE SET:C116(yBWR_currentTable->;"$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
	If (brLastDim>0)
		AL_RemoveArrays (xALP_Browser;1;brLastDim)
	End if 
	BWR_SelectTableData 
Else 
	CD_Dlog (0;__ ("No se detectó ningún registro duplicado u homónimo."))
End if 

