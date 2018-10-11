  //READ ONLY([ADT_Entrevistas])
  //SET QUERY DESTINATION(Into variable ;$recs)
  //QUERY([ADT_Entrevistas];[ADT_Entrevistas]ID_familia=[Alumnos]Familia_Número)
  //SET QUERY DESTINATION(Into current selection )
  //If (($recs>0) & ([ADT_Candidatos]Fecha_de_Entrevista=!00-00-00!))
  //CD_Dlog (0;"Esta familia ya tiene asignada una entrevista.")
  //Else 
C_BOOLEAN:C305(vb_opPrivada)
$date:=Current date:C33
If ($date>vdPST_EndInterviews)
	CD_Dlog (0;__ ("El intervalo de fechas para las entrevistas está fijado en el pasado."))
Else 
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"PST_SelectIViewDate";7;Palette form window:K39:9;__ ("Agenda para Entrevistas"))
	DIALOG:C40([xxSTR_Constants:1];"PST_SelectIViewDate")
	CLOSE WINDOW:C154
End if 
  //End if 
OBJECT SET ENTERABLE:C238(*;"iviewed@";Not:C34(([ADT_Candidatos:49]Fecha_de_Entrevista:4=!00-00-00!)))

ALL RECORDS:C47([Profesores:4])
QUERY SELECTION:C341([Profesores:4];[Profesores:4]Numero:1=[ADT_Candidatos:49]ID_Entrevistador:54)
If (([ADT_Candidatos:49]Si_ObsEntPrivada:55=False:C215) & (<>tUSR_CurrentUserName=[Profesores:4]Nombre_comun:21))
	vb_opPrivada:=True:C214
Else 
	vb_opPrivada:=False:C215
End if 
OBJECT SET ENTERABLE:C238(*;"Iviewed7";vb_opPrivada)
IT_SetButtonState ((Not:C34([ADT_Candidatos:49]Fecha_de_Entrevista:4=!00-00-00!));->bIViewIndicators)

  //para actualizar las vista del examen y las entrevistas del formulario
ADT_VistasIViewExam 