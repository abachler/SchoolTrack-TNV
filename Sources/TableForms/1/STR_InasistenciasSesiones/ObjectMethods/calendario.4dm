  // [xxSTR_Constants].STR_InasistenciasSesiones.Botón invisible()
  // Por: Alberto Bachler: 05/07/13, 11:35:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_DATE:C307($d_fecha)
$d_fecha:=DT_PopCalendar 
If (OK=1)
	If (DateIsValid ($d_fecha))
		If ($d_fecha>Current date:C33(*))
			CD_Dlog (0;__ ("Usted seleccionó una fecha posterior a la fecha actual.\r\rNo es posible registrar inasistencias con anticipación"))
		Else 
			dFrom:=$d_fecha
			AL_UpdateArrays (xALP_Inasistencias;0)
			AL_UpdateArrays (xALP_Subsectores;0)
			vs_SelectedClass:=<>aCursos{<>aCursos}
			ALabs_LoadData (vs_SelectedClass)
			ALabs_UpdateForm 
		End if 
	End if 
	OBJECT SET TITLE:C194(bCalendario;String:C10(dFrom;System date long:K1:3))
End if 

GOTO OBJECT:C206(hl_cursosAsistenciaSesiones)
OBJECT SET SCROLL POSITION:C906(hl_cursosAsistenciaSesiones;Selected list items:C379(hl_cursosAsistenciaSesiones))