//%attributes = {}
  //AS_NombresParcialesSubAsig
  //MONO 187315
If (yBWR_currentTable=->[Asignaturas:18])
	
	If (Size of array:C274(alBWR_recordNumber)>0)
		ARRAY LONGINT:C221(al_recNumSubAsig;0)
		READ ONLY:C145([Asignaturas:18])
		CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];alBWR_recordNumber)
		KRL_RelateSelection (->[xxSTR_Subasignaturas:83]ID_Mother:6;->[Asignaturas:18]Numero:1;"")
		If (Records in selection:C76([xxSTR_Subasignaturas:83])>0)
			LONGINT ARRAY FROM SELECTION:C647([xxSTR_Subasignaturas:83];al_recNumSubAsig;"")
			$l_refVentana:=Open form window:C675("AS_NombreParcialesSubAsig";Plain form window:K39:10;Horizontally centered:K39:1;At the top:K39:5)
			SET WINDOW TITLE:C213(__ ("Nombre para Evaluaciones Parciales de Sub Asignaturas");$l_refVentana)
			DIALOG:C40("AS_NombreParcialesSubAsig")
			CLOSE WINDOW:C154
		Else 
			CD_Dlog (0;__ ("Las Asignatura en el explorador, no tienen relacion con subasignaturas."))
		End if 
	Else 
		CD_Dlog (0;__ ("Debe haber al menos una Asignatura en el explorador"))
	End if 
Else 
	CD_Dlog (0;__ ("Esta Herramienta debe ejecutarse desde el panel de Asignaturas"))
End if 