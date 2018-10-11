//%attributes = {}
  //CU_Reorganizacion

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	If (USR_GetMethodAcces (Current method name:C684))
		vb_ReasignaNoFolio_co:=False:C215
		EVS_LoadStyles 
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_TransfertStud";-1;4;__ ("Reorganización de cursos"))
		DIALOG:C40([xxSTR_Constants:1];"STR_TransfertStud")
		CLOSE WINDOW:C154
		CU_LoadArrays 
		NIV_LoadArrays 
		KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
		If (vb_ReasignaNoFolio_co)
			
			
			  //`verificar si pais es Colombia
			If (<>vtXS_CountryCode="co")
				  //para saber si hay registros tomados
				QUERY:C277([Alumnos:2];[Alumnos:2]NumeroDeFolio:103#"")
				ARRAY TEXT:C222($aText;Records in selection:C76([Alumnos:2]))
				
				READ WRITE:C146([Alumnos:2])
				CREATE EMPTY SET:C140([Alumnos:2];"lockedSet")
				ARRAY TO SELECTION:C261($aText;[Alumnos:2]NumeroDeFolio:103)
				
				If (Records in set:C195("lockedSet")>0)  //`si hay registros tomados
					$r:=CD_Dlog (0;__ ("La actualización de números de folio involucra a muchos registros de alumnos, por lo que es posible \rque no pueda realizarse mientras otros usuarios estén en Schooltrack. \rQue desea hacer?");__ ("");__ ("Seguir intentando");__ ("Dejar como tarea de fin de día"))
					
					Case of 
						: ($r=2)
							  //`tarea de fin de dia, no sigo intentando, seteo la preferencia en 0
							PREF_Set (0;"AsignacionNumeroFolio";"1")  //para ejecutarse en las tareas de fin de dia
						Else 
							  //`asigno la tarea a las tareas programadas
							BM_CreateRequest ("co-AsignaNumerosDeFolio")
							  //AL_AsignaNoDeFolio
					End case 
				Else 
					BM_CreateRequest ("co-AsignaNumerosDeFolio")
				End if 
			End if 
		End if 
	End if 
End if 

