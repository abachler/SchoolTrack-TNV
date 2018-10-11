
If ((dFrom#!00-00-00!) & (dto#!00-00-00!) & (sMotivo#"") & (iProfID>0) & (sName#""))
	If ([Alumnos:2]Fecha_de_Ingreso:41#!00-00-00!)
		If (([Alumnos:2]Fecha_de_Ingreso:41<=dFrom))
			  //MONO Ticket 179808
			PREF_Set (<>lUSR_CurrentUserID;"SuspencionCreaInasistencia";String:C10(viSTR_CrearInasistencias))
			PREF_Set (<>lUSR_CurrentUserID;"SuspencionCreaInasistenciaFutura";String:C10(viSTR_CrearInasistenciasFuturas))
			ACCEPT:C269
		Else 
			CD_Dlog (0;__ ("La fecha de ingreso del alumno es: ")+String:C10([Alumnos:2]Fecha_de_Ingreso:41)+__ (". No puede ingresar suspensiones para esa fecha."))
		End if 
	Else 
		  //MONO Ticket 179808
		PREF_Set (<>lUSR_CurrentUserID;"SuspencionCreaInasistencia";String:C10(viSTR_CrearInasistencias))
		PREF_Set (<>lUSR_CurrentUserID;"SuspencionCreaInasistenciaFutura";String:C10(viSTR_CrearInasistenciasFuturas))
		ACCEPT:C269
	End if 
Else 
	CD_Dlog (0;__ ("Por favor indique el nombre del profesor o funcionario del colegio, el motivo y las fechas de inicio y término de la suspensión"))
End if 