//%attributes = {}
  // IT_archivosArrastrados()
  // Por: Alberto Bachler: 17/09/13, 13:43:06
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($y_listaArchivo)

If (Count parameters:C259=1)
	$y_listaArchivo:=$1
End if 

ARRAY TEXT:C222($at_RutaArchivos;0)
C_TEXT:C284($t_nombreArchivo)
_O_C_INTEGER:C282($i_indiceArchivo)
$i_indiceArchivo:=1
Repeat 
	$t_nombreArchivo:=Get file from pasteboard:C976($i_indiceArchivo)
	If ($t_nombreArchivo#"")
		APPEND TO ARRAY:C911($at_RutaArchivos;$t_nombreArchivo)
		$i_indiceArchivo:=$i_indiceArchivo+1
	End if 
Until ($t_nombreArchivo="")

If (Not:C34(Is nil pointer:C315($y_listaArchivo)))
	COPY ARRAY:C226($at_RutaArchivos;$y_listaArchivo->)
End if 

If (Size of array:C274($at_RutaArchivos)>0)
	$0:=$at_RutaArchivos{1}
End if 


