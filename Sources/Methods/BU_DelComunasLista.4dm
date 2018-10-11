//%attributes = {}
  //BU_DelComunasLista

  //EMA--> Transporte Escolar
  //$1= Numero de la Ruta Seleccionada
  //$2= Nombre de la Comuna que se desea eliminar


C_LONGINT:C283($1)
C_TEXT:C284($2)

ARRAY LONGINT:C221($comunas;0)
If (Count parameters:C259=2)
	READ WRITE:C146([BU_Rutas_Comunas:27])
	QUERY:C277([BU_Rutas_Comunas:27];[BU_Rutas_Comunas:27]Numero_Ruta:1=$1;*)
	QUERY:C277([BU_Rutas_Comunas:27]; & ;[BU_Rutas_Comunas:27]Nombre_Comuna:2=$2)
	DELETE RECORD:C58([BU_Rutas_Comunas:27])
	READ ONLY:C145([BU_Rutas_Comunas:27])
End if 