//%attributes = {}
  //BU_AddComunasLista

  //EMA--> Transporte Escolar
  //$1= Numero de la Ruta Seleccionada
  //$2= Nombre de la Comuna que se desea añadir


C_LONGINT:C283($1)
C_TEXT:C284($2)

ARRAY TEXT:C222($comunas;0)
If (Count parameters:C259=2)
	READ WRITE:C146([BU_Rutas_Comunas:27])
	QUERY:C277([BU_Rutas_Comunas:27];[BU_Rutas_Comunas:27]Numero_Ruta:1=$1)
	SELECTION TO ARRAY:C260([BU_Rutas_Comunas:27]Nombre_Comuna:2;$comunas)
	$exist:=Find in array:C230($Comunas;$2)
	If ($exist<0)
		CREATE RECORD:C68([BU_Rutas_Comunas:27])
		[BU_Rutas_Comunas:27]Numero_Ruta:1:=$1
		[BU_Rutas_Comunas:27]Nombre_Comuna:2:=$2
		SAVE RECORD:C53([BU_Rutas_Comunas:27])
		UNLOAD RECORD:C212([BU_Rutas_Comunas:27])
		READ ONLY:C145([BU_Rutas_Comunas:27])
	End if 
End if 