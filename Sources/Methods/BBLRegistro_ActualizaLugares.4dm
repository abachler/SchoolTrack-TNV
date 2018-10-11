//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 04-11-15, 11:52:13
  // ----------------------------------------------------
  // Método: BBLRegistro_ActualizaLugares
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------




ARRAY TEXT:C222($at_lugares;0)
QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1)
QUERY SELECTION:C341([BBL_Registros:66]; & [BBL_Registros:66]Lugar:13#"")
DISTINCT VALUES:C339([BBL_Registros:66]Lugar:13;$at_lugares)
[BBL_Items:61]Lugares:51:=AT_array2text (->$at_lugares;", ")
SAVE RECORD:C53([BBL_Items:61])
POST KEY:C465(-96)

