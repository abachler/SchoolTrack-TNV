//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 09-10-18, 10:57:59
  // ----------------------------------------------------
  // Método: Utilidades_CatalogoFuncionesInf
  // Descripción
  // Para almacenar código que pueda servir para reportes o búsquedas.
  //
  // Parámetros
  // ----------------------------------------------------


Case of 
	: ($t_modulo="ST")  //SchoolTrack
		Utilidades_CatalogoFuncionesST 
		
	: ($t_modulo="MT")  //MediaTrack
		
	: ($t_modulo="ACT")  //AccountTrack
		Utilidades_CatalogoFuncionesACT 
		
	: ($t_modulo="ADT")  //AdmissionTrack
		
	: ($t_modulo="XS")  //xShell
		
	: ($t_modulo="STWA")  //SchoolTrack Web Access
		
End case 
