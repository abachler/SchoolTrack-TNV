//%attributes = {}
  // TMT_Manager()
  // Por: Alberto Bachler: 10/05/13, 12:13:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
If (False:C215)
	C_TEXT:C284(TMT_Manager ;$1)
End if 

C_TEXT:C284(vs_SelectedClass)
If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	If (USR_GetMethodAcces (Current method name:C684))
		If (Count parameters:C259=1)
			vs_SelectedClass:=$1
		Else 
			If (vs_SelectedClass="")
				vs_SelectedClass:=<>aCursos{1}
			End if 
		End if 
		KRL_UnloadReadOnly (->[TMT_Horario:166];->[TMT_Salas:167];->[Asignaturas:18];->[Asignaturas_RegistroSesiones:168];->[Asignaturas_Inasistencias:125])
		TMT_InicializaVariables 
		PERIODOS_Init 
		WDW_OpenFormWindow (->[TMT_Horario:166];"Horario";2;Plain form window:K39:10)
		DIALOG:C40([TMT_Horario:166];"Horario")
		CLOSE WINDOW:C154
		KRL_UnloadReadOnly (->[TMT_Horario:166];->[TMT_Salas:167];->[Asignaturas:18];->[Asignaturas_RegistroSesiones:168];->[Asignaturas_Inasistencias:125])
	End if 
End if 