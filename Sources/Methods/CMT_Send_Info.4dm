//%attributes = {}
  // CMT_Send_Info()
  // 
  //
  // modificado por: Alberto Bachler Klein: 03-11-16, 15:47:50
  // -----------------------------------------------------------

If ((<>vl_CMT_OnOff=1) & (LICENCIA_esModuloAutorizado (1;CommTrack)))
	
	If (Not:C34(<>vbCMT_SendSoloModificados))
		  //sólo cuando se generan datos completos eliminamos todo lo anterior que no pudo ser enviado.
		DELETE FOLDER:C693(SYS_CarpetaAplicacion (CLG_Intercambios_CMT);Delete with contents:K24:24)
	End if 
	
	If (Not:C34(((Shift down:C543) & ((Macintosh command down:C546) | (Windows Ctrl down:C562)))))
		CMT_RegistrosMarcados ("CMT_Send_Datos")
	Else 
		CMT_Send_Alumnos 
		CMT_Send_Relaciones 
		CMT_Send_Profesores 
		CMT_Send_Asignaturas 
		CMT_Send_Cursos 
		CMT_Send_Niveles 
		CMT_Send_Actividades 
		CMT_Send_AlumnosEvaluaciones 
		CMT_Send_AlumnosActividades 
		CMT_Send_Familias 
	End if 
	CMT_SendFiles2FTP 
End if 