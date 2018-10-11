//%attributes = {}
  // TMT_ActualizaAreasHorario()
  // Por: Alberto Bachler: 10/05/13, 17:50:34
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
If (KRL_EsEventoEnInterfazUsuario )
	
	  // area Salas
	xALSet_TMT_Salas 
	
	
	  //Area Subsectores
	xALSet_TMT_Asignaturas 
	
	
	  // area Horario
	xALSet_TMT_Horario 
End if 
AL_SetMiscOpts (xALP_Cursos;0;0;"\\";0;1)
AL_SetMiscOpts (xALP_Salas;0;0;"\\";0;1)
AL_SetMiscOpts (xALP_Subsectores;0;0;"\\";0;1)
AL_SetMiscOpts (xALP_Horario;0;0;"\\";0;1)

AL_SetAreaLongProperty (xALP_Horario;ALP_Area_Compatibility;1)
