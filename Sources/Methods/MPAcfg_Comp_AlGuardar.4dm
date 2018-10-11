//%attributes = {}
  // MPAcfg_Comp_AlGuardar()
  // Ajustes en el registro de competencias previo al almacenamiento
  // Puede ser llamado desde el formulario o desde el trigger
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 25/06/12, 07:00:04
  // ---------------------------------------------
C_LONGINT:C283($l_bitToSet;$i_Niveles)




  // CÓDIGO
If (KRL_RegistroFueModificado (->[MPA_DefinicionCompetencias:187]))
	[MPA_DefinicionCompetencias:187]DTS_Modificacion:15:=DTS_MakeFromDateTime 
	
	  // asignación del campo de ordenamiento utilizando los primeros 255 caracteres del nombre del eje
	  // (que puede almacenar hasta 2Gb, pero no es ordenable)
	[MPA_DefinicionCompetencias:187]AlphaSort:24:=Substring:C12([MPA_DefinicionCompetencias:187]Competencia:6;1;255)
End if 

  // asigno el iusuario actual solo si no estoy dentro del trigger
  // (que en cliente servidor no conoce el valor de la variable <>tUSR_CurrentUser)
  // así este método puede ser llamado desde el formulario de propiedades o desde el trigger
If (Trigger level:C398=0)
	[MPA_DefinicionCompetencias:187]ModificadoPor:16:=<>tUSR_CurrentUser
End if 


