  //[Asignaturas].Input.Propiedades4


C_BLOB:C604($x_RecNumsArray)
C_LONGINT:C283($l_recordWasSaved)
ARRAY LONGINT:C221($al_RecNumsAsignaturas;0)


$l_recordWasSaved:=AS_fSave 

If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ (".\r\rNo se guardará ningún cambio en las opciones de exámenes y controles."))
End if 
If (Is compiled mode:C492)
	WDW_OpenFormWindow (->[Asignaturas:18];"Configuracion_Examenes";-1;Movable form dialog box:K39:8)
Else 
	WDW_OpenFormWindow (->[Asignaturas:18];"Configuracion_Examenes";-1;Plain form window:K39:10)
End if 
DIALOG:C40([Asignaturas:18];"Configuracion_Examenes")
CLOSE WINDOW:C154
If (OK=1)
	POST KEY:C465(Character code:C91("*");256)
End if 
