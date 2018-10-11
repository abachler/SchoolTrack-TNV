  // [Actividades].Input.inscribir()
  // Por: Alberto Bachler K.: 05-06-14, 13:53:51
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------

C_LONGINT:C283($l_abajo;$l_abajoVentana;$l_arriba;$l_arribaVentana;$l_derecha;$l_derechaVentana;$l_estadoProceso;$l_idProcesoSelecccion;$l_izquierda;$l_izquierdaVentana)
C_POINTER:C301($y_idProcesoSeleccion)
Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		If (OBJECT Get enabled:C1079(*;OBJECT Get name:C1087(Object current:K67:2)))
			IT_MuestraTip (__ ("Inscribir Alumnos"))
		Else 
			IT_MuestraTip (__ ("Inscribir Alumnos")+"\r"+__ ("Usted no está autorizado para esta operación"))
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		READ ONLY:C145([Alumnos:2])
		viBWR_RecordWasSaved:=XCR_fSave 
		If (viBWR_RecordWasSaved>=0)
			XCR_periodoInscripcion_l:=(OBJECT Get pointer:C1124(Object named:K67:5;"periodo"))->
			If (XCR_periodoInscripcion_l<0)
				XCR_periodoInscripcion_l:=0
			End if 
			
			WDW_OpenFormWindow (->[Actividades:29];"StudSelection";-1;Movable form dialog box:K39:8)
			DIALOG:C40([Actividades:29];"StudSelection")
			CLOSE WINDOW:C154
			
			XCR_ContabilizaInscritos ([Actividades:29]ID:1)
			XCR_ListaAlumnosInscritos 
			
			[Actividades:29]ID:1:=[Actividades:29]ID:1
			viBWR_RecordWasSaved:=XCR_fSave 
			
			LOAD RECORD:C52([Actividades:29])
		End if 
		
End case 
