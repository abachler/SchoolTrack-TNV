  // [TMT_Horario].InfoSesiones.SesionesHasta()
  // Por: Alberto Bachler: 03/06/13, 15:12:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_recNumAsignacion;$l_recNumAsignatura)
C_TEXT:C284($t_textoError)


$l_recNumAsignacion:=Record number:C243([TMT_Horario:166])
$l_recNumAsignatura:=Record number:C243([Asignaturas:18])

Case of 
	: ([TMT_Horario:166]SesionesHasta:13<[TMT_Horario:166]SesionesDesde:12)
		CD_Dlog (0;__ ("La fecha de término de aplicación no puede ser inferior a la fecha de inicio (")+String:C10([TMT_Horario:166]SesionesDesde:12)+").")
		[TMT_Horario:166]SesionesHasta:13:=Old:C35([TMT_Horario:166]SesionesHasta:13)
		GOTO OBJECT:C206([TMT_Horario:166]SesionesHasta:13)
		HIGHLIGHT TEXT:C210([TMT_Horario:166]SesionesHasta:13;1;80)
	: ([TMT_Horario:166]SesionesHasta:13>vdSTR_Periodos_FinEjercicio)
		CD_Dlog (0;__ ("Ingrese una fecha igual o inferior a la fecha de fin del ciclo escolar (")+String:C10(vdSTR_Periodos_FinEjercicio)+").")
		[TMT_Horario:166]SesionesHasta:13:=Old:C35([TMT_Horario:166]SesionesHasta:13)
		GOTO OBJECT:C206([TMT_Horario:166]SesionesHasta:13)
		HIGHLIGHT TEXT:C210([TMT_Horario:166]SesionesHasta:13;1;80)
	Else 
		
		  // determino la última fecha valida para el día antes de la fecha de término de aplicacion
		$d_inicioSesiones:=[TMT_Horario:166]SesionesDesde:12
		$d_terminoSesiones:=[TMT_Horario:166]SesionesHasta:13
		$b_fechaTerminoValida:=TMT_FechaDiaValidos (->$d_terminoSesiones;$d_inicioSesiones;[TMT_Horario:166]NumeroDia:1)
		If ($b_fechaTerminoValida)
			If ($d_terminoSesiones#[TMT_Horario:166]SesionesHasta:13)
				[TMT_Horario:166]SesionesHasta:13:=$d_terminoSesiones
				  //guardo el registro
				SAVE RECORD:C53([TMT_Horario:166])
			End if 
			OK:=1
		Else 
			CD_Dlog (0;__ ("La fecha ingresada está fuera del ciclo escolar.\r\rPor favor ingrese una fecha válida"))
			OK:=0
		End if 
End case 

If (OK=1)
	  // llamo la rutina que se encarga de validar las fechas, crear o eliminar sesiones y almacenar la modificación
	$t_textoError:=TMT_ValidaCambiosFechas 
	If ($t_textoError#"")
		CD_Dlog (0;$t_textoError)
	End if 
	  // cargo el registro de asignatura que puede haber cambiado durante la validación
	KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura;False:C215)
	TMT_LeeDetallesAsignacion ($l_recNumAsignacion)
End if 