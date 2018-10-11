//%attributes = {}
  // BBLitm_OpenThesaurus()
  // Por: Alberto Bachler: 17/09/13, 13:25:44
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
ARRAY TEXT:C222(at_CrossRefType;0)
ARRAY TEXT:C222(at_CrossRefWord;0)
ARRAY TEXT:C222(aKw;0)
ARRAY LONGINT:C221(aKwNumber;0)
ARRAY INTEGER:C220(aLines;0)

$y_Materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")

SAVE RECORD:C53([BBL_Items:61])

REDUCE SELECTION:C351([BBL_Thesaurus:68];0)
$l_recNum:=Record number:C243([BBL_Items:61])
WDW_OpenFormWindow (->[BBL_Thesaurus:68];"Asignador";-1;4;__ ("Catalogación por materias"))
DIALOG:C40([BBL_Thesaurus:68];"Asignador")
CLOSE WINDOW:C154



If (OK=1)
	  // en el asignador se puede haber cambiado erl registro de item actual, si (por jemplo) se elimina una materia
	  //vuelvo a cargarlo en lectura escritura
	KRL_GotoRecord (->[BBL_Items:61];$l_recNum;True:C214)
	
	If ($l_recNum>No current record:K29:2)
		C_POINTER:C301($y_Materias)
		$y_Materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")
		AT_Initialize ($y_Materias)
		$ob_Materias:=OB_JsonToObject ([BBL_Items:61]Materias_json:53)
		OB_GET ($ob_Materias;$y_Materias;"materiasCatalogacion_KW")
	End if 
	
	If (Records in selection:C76([BBL_Thesaurus:68])>0)
		SELECTION TO ARRAY:C260([BBL_Thesaurus:68]Materia:13;$at_materias)
		READ WRITE:C146([BBL_Items:61])
		KRL_GotoRecord (->[BBL_Items:61];$l_recNum;True:C214)
		For ($i;1;Size of array:C274($at_materias))
			If (Find in array:C230($y_Materias->;$at_materias{$i})<0)
				APPEND TO ARRAY:C911($y_Materias->;$at_materias{$i})
			End if 
		End for 
		BBLitm_GuardaMaterias 
	End if 
Else 
	KRL_GotoRecord (->[BBL_Items:61];$l_recNum;True:C214)
End if 

  //