//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 03-02-18, 16:14:42
  // ----------------------------------------------------
  // Método: actabc_NombreArchivoBancario
  // Descripción
  // Metodo verifica la configuracion del registro del archivo bancario el cual debe estar cargardo, con lo cual agrega el prefijo, sufijo y extension dependiendo de la configuracion del registro
  // Si el registro no posee configuracion o no esta activa se retorna el mismo valor que ingreso en el primer parametro
  // Parámetros
  // $1 String nombre de archivo al cual aplicar la configuracion realizada en registro de archivo bancario
  // ----------------------------------------------------

ARRAY TEXT:C222($at_propiedades;0)
C_TEXT:C284($t_nombre;$t_prefijo;$t_sufijo;$t_ext)
C_OBJECT:C1216($o_archivo)

$t_nombre:=$1

OB GET PROPERTY NAMES:C1232([xxACT_ArchivosBancarios:118]Configuracion:15;$at_propiedades)
If (Size of array:C274($at_propiedades)>0)
	$o_archivo:=OB Get:C1224([xxACT_ArchivosBancarios:118]Configuracion:15;"Archivo")
	$t_prefijo:=OB Get:C1224($o_archivo;"prefijo")
	$t_sufijo:=ACTabc_SufijoArchivoBancario (OB Get:C1224($o_archivo;"sufijo"))
	$t_ext:=OB Get:C1224($o_archivo;"extension")
	If (OB Get:C1224($o_archivo;"activo")=1)
		$t_nombre:=$t_prefijo+$t_sufijo
	End if 
	$t_nombre:=$t_nombre+"."+$t_ext
Else 
	$t_nombre:=$t_nombre+".txt"
End if 

$0:=$t_nombre