//%attributes = {}
  // MPAcfg_Dimension_AlGuardar()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 24/06/12, 17:39:40
  // ---------------------------------------------
C_LONGINT:C283($l_bitToSet;$l_Niveles)


  // CÓDIGO
If (KRL_RegistroFueModificado (->[MPA_DefinicionDimensiones:188]))
	[MPA_DefinicionDimensiones:188]DTS_Modificacion:18:=DTS_MakeFromDateTime 
	
	  // asignación del campo de ordenamiento utilizando los primeros 255 caracteres del nombre del eje
	  // (que puede almacenar hasta 2Gb, pero no es ordenable)
	[MPA_DefinicionDimensiones:188]AlphaSort:8:=Substring:C12([MPA_DefinicionDimensiones:188]Dimensión:4;1;255)
	
	  // asigno el iusuario actual solo si no estoy dentro del trigger
	  // (que en cliente servidor no conoce el valor de la variable <>tUSR_CurrentUser)
	  // así este método puede ser llamado desde el formulario de propiedades o desde el trigger
	If (Trigger level:C398=0)
		[MPA_DefinicionDimensiones:188]ModificadoPor:19:=<>tUSR_CurrentUser
	End if 
End if 

