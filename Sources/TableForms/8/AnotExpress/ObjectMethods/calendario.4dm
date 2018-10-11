  // [Alumnos_Conducta].AnotExpress.calendario()
  // Por: Alberto Bachler K.: 08-05-14, 10:30:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_fechaAnotacion:=OBJECT Get pointer:C1124(Object named:K67:5;"fecha")
$y_nombreAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.alumno")
$y_curso:=OBJECT Get pointer:C1124(Object named:K67:5;"curso")


$y_fechaAnotacion->:=DT_PopCalendar 
If (OK=1)
	If ($y_fechaAnotacion-><=Current date:C33(*))
		Case of 
			: (Not:C34(DateIsValid ($y_fechaAnotacion->)))
				$y_fechaAnotacion->:=!00-00-00!
				GOTO OBJECT:C206(*;"fecha")
			: (((Current date:C33(*)-$y_fechaAnotacion->)><>vi_nd_reg_anotacion) & (<>vi_nd_reg_anotacion#0))
				$t_mensaje:=__ ("El registro de anotaciones después de más ^0 días de la fecha del evento no está autorizado.\r\rPor favor consulte con el administrador si piensa que esto es un error.")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";String:C10(<>vi_nd_reg_anotacion))
				CD_Dlog (0;$t_mensaje)
				$y_fechaAnotacion->:=!00-00-00!
		End case 
	Else 
		$y_fechaAnotacion->:=!00-00-00!
		$l_ignorar:=CD_Dlog (0;__ ("La fecha ingresada es posterior a hoy.\r\rNo es posible registrar una anotación anticipadamente."))
	End if 
	OBJECT SET ENTERABLE:C238($y_nombreAlumno;($y_curso->#"") & ($y_fechaAnotacion->#!00-00-00!))
End if 

