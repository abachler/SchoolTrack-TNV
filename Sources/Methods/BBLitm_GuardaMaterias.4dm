//%attributes = {}
  // BBLitm_GuardaMaterias()
  // Por: Alberto Bachler K.: 11-02-15, 16:05:52
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i)
C_POINTER:C301($y_Materias)
C_OBJECT:C1216($ob_Materias)

ARRAY TEXT:C222($at_materias;0)

$y_Materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")

For ($i;Size of array:C274($y_Materias->);1;-1)
	If ($y_Materias->{$i}="")
		DELETE FROM ARRAY:C228($y_Materias->;$i)
	End if 
End for 

  //$t_refJson:=JSON New
  //JSON_AgregaElemento ($t_refJson;$y_Materias;"materiasCatalogacion_KW")
  //[BBL_Items]Materias_json:=JSON Export to text ($t_refJson;JSON_WITH_WHITE_SPACE)
  //JSON CLOSE ($t_refjSon)

$ob_Materias:=OB_SET ($ob_Materias;$y_Materias;"materiasCatalogacion_KW")
[BBL_Items:61]Materias_json:53:=OB_Object2Json ($ob_Materias;True:C214)
SAVE RECORD:C53([BBL_Items:61])