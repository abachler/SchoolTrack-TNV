  // [Asignaturas_Inasistencias].Infos.vt_justificacion()
  // Por: Alberto Bachler K.: 19-03-14, 11:58:32
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
IT_Clairvoyance (Self:C308;-><>aJustAbs;"Justificaciones de ausencia")
If (Self:C308->#"")
	_O_ENABLE BUTTON:C192(bOK)
Else 
	_O_DISABLE BUTTON:C193(bOK)
	GOTO OBJECT:C206(Self:C308->)
End if 





