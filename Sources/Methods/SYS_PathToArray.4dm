//%attributes = {}
  // Método: SYS_PathToArray
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/08/10, 21:04:03
  // ---------------------------------------------
  // Descripción: 
  // Pone en un arreglo todos los objetos de la ruta, desde el más cercano al mas lejano


  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_POINTER:C301($arrayPointer;$2)
C_TEXT:C284($path;$1)
$path:=$1
$arrayPointer:=$2
If (Position:C15(":\\";$path)>0)  //es un path windows
	  //$path:=Replace string($path;":\\";"//")
	$path:=Replace string:C233($path;"\\";"/")
Else 
	$path:=Replace string:C233($path;":";"/")
End if 

If ($path="@/")
	$path:=Substring:C12($path;1;Length:C16($path)-1)
End if 

$containers:=ST_CountWords ($path;0;"/")
AT_RedimArrays ($containers;$arrayPointer)

$index:=1
For ($i;$containers;1;-1)
	$arrayPointer->{$index}:=ST_GetWord ($path;$i;"/")
	$index:=$index+1
End for 

