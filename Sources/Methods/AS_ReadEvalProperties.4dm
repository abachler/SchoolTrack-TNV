//%attributes = {}
  // AS_ReadEvalProperties()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 19/10/12, 11:06:24
  // ---------------------------------------------


  // CODIGO

  // DEPRECATED
  // SOLO PARA COMPATIBILIDAD CON LLAMADOS CON EL NOMBRE ANTIGUO DESDE SUPERREPORT O SCRIPTS
  // El método AS_ReadEvalProperties fue reemplazado por AS_PropEval_Lectura

Case of 
	: (Count parameters:C259=2)
		AS_PropEval_Lectura ($1;$2)
	: (Count parameters:C259=1)
		AS_PropEval_Lectura ($1)
	Else 
		AS_PropEval_Lectura 
End case 



