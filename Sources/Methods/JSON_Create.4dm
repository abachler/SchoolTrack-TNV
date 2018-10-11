//%attributes = {}
  // JSON_Create() -> refObjeto:Y
  // crea un objeto json y devuleve la referencia en <refObjeto>
  //
  // creado por: Alberto Bachler Klein: 24-11-15, 12:01:31
  // -----------------------------------------------------------


C_TEXT:C284($t_refJson)
C_OBJECT:C1216($ob_Objeto)

If (Application version:C493>="15@")
	C_OBJECT:C1216($0)
	$ob_Objeto:=OB_Create 
	$0:=$ob_Objeto
Else 
	  //C_TEXT($0)
	  //$t_refJson:=JSON New 
	  //$0:=->$t_refJson
End if 