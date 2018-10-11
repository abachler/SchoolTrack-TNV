//%attributes = {}
  // XCR_AccionesListaAlumnos()
  // Por: Alberto Bachler K.: 03-06-14, 15:37:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_filaSeleccionada;$l_idAlumno)
C_POINTER:C301($y_idAlumnos_al;$y_listaAlumnosInscritos)
C_TEXT:C284($t_texto)

ARRAY LONGINT:C221($al_filasSeleccionadas;0)

$y_listaAlumnosInscritos:=OBJECT Get pointer:C1124(Object named:K67:5;"ListaAlumnosInscritos")

$l_filaSeleccionada:=LB_GetSelectedRows ($y_listaAlumnosInscritos;->$al_filasSeleccionadas)
If ($l_filaSeleccionada>0)
	$y_idAlumnos_al:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosId")
	$l_idAlumno:=$y_idAlumnos_al->{$l_filaSeleccionada}
	
	READ ONLY:C145([Alumnos_Actividades:28])
	QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Actividad_numero:2=[Actividades:29]ID:1;*)
	QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Alumno_Numero:1=$l_idAlumno)
	Case of 
		: ([Alumnos_Actividades:28]Periodos_Inscritos:44=1)
			IT_MuestraTip (__ ("Inscrito en todos los períodos"))
			
		: ([Alumnos_Actividades:28]Periodos_Inscritos:44>1)
			$t_texto:=__ ("Inscrito en: ")
			For ($i;1;viSTR_Periodos_NumeroPeriodos)
				If ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $i)
					$t_texto:=$t_texto+"\r - "+atSTR_Periodos_Nombre{$i}
				End if 
			End for 
			IT_MuestraTip ($t_texto)
			
		Else 
			IT_MuestraTip (__ ("No está inscrito en nigún periodo"))
	End case 
End if 

$b_modXCRCondorActivo:=LICENCIA_VerificaModCondorAct ("Extracurriculares")
If (Not:C34($b_modXCRCondorActivo))
	OBJECT SET ENABLED:C1123(*;"retirar";$l_filaSeleccionada>0)
End if 