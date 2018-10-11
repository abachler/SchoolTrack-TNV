  // [Asignaturas].Input.lb_Alumnos()
  // Por: Alberto Bachler K.: 13-05-14, 11:26:08
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$y_alumnosId:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosId")
$y_alumnosNombre:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosNombre")
$l_idAlumno:=$y_alumnosId->{$y_alumnosId->}

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		AL_UpdateArrays (xALP_Aprendizajes;0)
		$refArea:=xALP_Aprendizajes
		vlMPA_IDAlumnoSeleccionado:=$l_idAlumno
		vtEVLG_VistaActual:="Alumnos"
		COPY ARRAY:C226($y_alumnosId->;aNtaIdAlumno)
		COPY ARRAY:C226($y_alumnosNombre->;aNtaStdNme)
		$recNum:=Find in field:C653([Alumnos:2]numero:1;$l_idAlumno)
		KRL_GotoRecord (->[Alumnos:2];$recNum;False:C215)
		WDW_OpenFormWindow (->[Asignaturas:18];"RegistroAprendizajes";-1;8;__ ("Evaluación de aprendizajes esperados en ")+[Asignaturas:18]denominacion_interna:16)
		DIALOG:C40([Asignaturas:18];"RegistroAprendizajes")
		CLOSE WINDOW:C154
		xALP_Aprendizajes:=$refArea
		AL_UpdateArrays (xALP_Aprendizajes;-2)
		
	: (Form event:C388=On Selection Change:K2:29)
		vlMPA_IDAlumnoSeleccionado:=$l_idAlumno
		EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;vlMPA_IDAlumnoSeleccionado;[Asignaturas:18]EVAPR_IdMatriz:91)
End case 



  //Case of 
  //: (Form event=On Double Clicked)
  //  //ALP_RemoveAllArrays (xALP_Aprendizajes)
  //AL_UpdateArrays (xALP_Aprendizajes;0)
  //$refArea:=xALP_Aprendizajes
  //aNtaIdAlumno:=aNtaStdNme
  //vlMPA_IDAlumnoSeleccionado:=aNtaIDAlumno{aNtaStdNme}
  //vtEVLG_VistaActual:="Alumnos"
  //$recNum:=Find in field([Alumnos]Número;aNtaIdAlumno{aNtaStdNme})
  //KRL_GotoRecord (->[Alumnos];$recNum;False)
  //WDW_OpenFormWindow (->[Asignaturas];"RegistroAprendizajes";-1;8;__ ("Evaluación de aprendizajes esperados en ")+[Asignaturas]Denominación_interna)
  //DIALOG([Asignaturas];"RegistroAprendizajes")
  //CLOSE WINDOW
  //xALP_Aprendizajes:=$refArea
  //  //vtEVLG_VistaActual:="Alumnos"
  //AL_UpdateArrays (xALP_Aprendizajes;-2)
  //  //AS_PageEVLG (vtEVLG_VistaActual)

  //  //: ((Form event=On Clicked ) | (Form event=On Selection Change ))
  //: (Form event=On Selection Change)
  //AL_ExitCell (xALP_Aprendizajes)
  //aNtaIdAlumno:=aNtaStdNme
  //vlMPA_IDAlumnoSeleccionado:=aNtaIDAlumno{aNtaStdNme}
  //EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;vlMPA_IDAlumnoSeleccionado;[Asignaturas]EVAPR_IdMatriz)
  //End case 
