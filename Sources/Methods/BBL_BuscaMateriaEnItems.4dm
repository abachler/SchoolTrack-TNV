//%attributes = {}
  // BBL_BuscaMateriaEnItems()
  // Por: Alberto Bachler K.: 10-12-14, 21:36:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($i)
C_TEXT:C284($t_materia)
C_OBJECT:C1216($ob_Materias)

ARRAY LONGINT:C221($al_recNum;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_jsonMaterias;0)
ARRAY TEXT:C222($at_materias;0)



If (False:C215)
	C_TEXT:C284(BBL_BuscaMateriaEnItems ;$1)
End if 

$t_materia:=$1
SELECTION TO ARRAY:C260([BBL_Items:61];$al_recNum;[BBL_Items:61]Materias_json:53;$at_jsonMaterias)


For ($i;Size of array:C274($al_recNum);1;-1)
	$ob_Materias:=OB_JsonToObject ($at_jsonMaterias{$i})
	OB_GET ($ob_Materias;->$at_materias;"materiasCatalogacion_KW")
	If (Find in array:C230($at_Materias;$t_materia)=-1)
		AT_Delete ($i;1;->$al_recNum)
	End if 
End for 

CREATE SELECTION FROM ARRAY:C640([BBL_Items:61];$al_recNum)




