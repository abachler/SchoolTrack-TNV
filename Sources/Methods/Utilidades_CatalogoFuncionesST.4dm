//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 09-10-18, 11:01:11
  // ----------------------------------------------------
  // Método: Utilidades_CatalogoFuncionesST
  // Descripción
  // Para recopilar código que sirva para ser usado desde informes para el módulo ST. La idea es poder copiar pegar el código o llamar al caso para que ejecute cierto código
  //
  // Parámetros
  //$1 Objeto con parametros. Mínimo debe tener la clave "seccion" y "funcion" con el valor correspondiente.
  //$0 Se retorna un objeto
  // ----------------------------------------------------

C_OBJECT:C1216($0;$1;$o_retorno)
C_TEXT:C284($t_funcion;$t_seccion)

If (Count parameters:C259>0)
	$t_seccion:=OB Get:C1224($1;"seccion")
	$t_funcion:=OB Get:C1224($1;"funcion")
End if 

Case of 
	: ($t_seccion="")
		  //Descripción:
		Case of 
			: ($t_funcion="")
				  //Descripción:
				
			Else 
				CD_Dlog (0;"Función para sección no implementada. Revisar!!")
		End case 
		
	: ($t_seccion="")
		  //Descripción:
		
	Else 
		CD_Dlog (0;"Sección no implementada. Revisar!!")
End case 

$0:=$o_retorno