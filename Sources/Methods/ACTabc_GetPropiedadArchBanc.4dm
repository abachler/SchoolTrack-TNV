//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 03-02-18, 16:14:42
  // ----------------------------------------------------
  // Método: LoadPropArchivosBancarios
  // Descripción
  //  Devuelve el valor de la propiedad solicitada en el parametro $1, del registro del archivo bancario
  // Parámetros
  // $1 Propiedades a buscar, tipo de dato Texto
  // ----------------------------------------------------


C_TEXT:C284($t_buscar)
ARRAY TEXT:C222($at_propiedades;0)
ARRAY TEXT:C222($at_valores;0)
C_LONGINT:C283($l_pos)

$t_buscar:=$1

If (Not:C34(Undefined:C82([xxACT_ArchivosBancarios:118]Configuracion:15)))
	OB GET ARRAY:C1229([xxACT_ArchivosBancarios:118]Configuracion:15;"Propiedades";$at_propiedades)
	$l_pos:=Find in array:C230($at_propiedades;$t_buscar)
	If ($l_pos>0)
		OB GET ARRAY:C1229([xxACT_ArchivosBancarios:118]Configuracion:15;"Valores";$at_valores)
		$0:=$at_valores{$l_pos}
	End if 
End if 
