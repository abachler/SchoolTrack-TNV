//%attributes = {}
  //SYS_TestStorageSpace

  //`xShell, Alberto Bachler
  //Metodo: Método: SYS_testStorageSpace
  //Por Administrator
  //Creada el 01/04/2005, 06:20:40
  //Modificaciones:
If ("DESCRIPCION"="")
	  //verifica si el espacio disponible es superior al tamaño requerido
End if 

  //****DECLARACIONES****
C_TEXT:C284($1;$volume)
C_REAL:C285($2;$requiredSpace;$size;$used;$free)
C_BOOLEAN:C305($0)

  //****INICIALIZACIONES****
$volume:=$1
$requiredSpace:=$2

  //****CUERPO****
VOLUME ATTRIBUTES:C472($volume;$size;$used;$free)
If ($requiredSpace<$free)
	$0:=True:C214
End if 

  //****LIMPIEZA****





