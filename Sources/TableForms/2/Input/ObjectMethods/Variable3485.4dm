C_LONGINT:C283($vl_Total1;$vl_Total2)
  //20131203 ASM se agrega IT_UThermometer
$l_therm:=IT_UThermometer (1;0;__ ("Recalculando totales de Conducta…"))
If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	AL_CuentaEventosConducta ([Alumnos:2]numero:1;vl_NivelSeleccionado)
End if 

AL_LeeSintesisConducta ([Alumnos:2]numero:1)
AL_LeeRegistrosConducta 

IT_UThermometer (-2;$l_therm)