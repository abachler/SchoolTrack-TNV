//%attributes = {}
  // UD_v20141210_MateriasItems()
  // Por: Alberto Bachler K.: 10-12-14, 10:57:37
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_idTermometro)
C_TEXT:C284($t_refJson)

ARRAY INTEGER:C220($al_orden;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY TEXT:C222($at_materia;0)
ARRAY TEXT:C222($at_orden;0)
ARRAY TEXT:C222($at_encabezadosJson;0)
C_OBJECT:C1216($ob_raiz)

ALL RECORDS:C47([BBL_Items:61])
LONGINT ARRAY FROM SELECTION:C647([BBL_Items:61];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Convirtiendo indexación de encabezados de materias...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Items:61])
	GOTO RECORD:C242([BBL_Items:61];$al_RecNums{$i_registros})
	QUERY:C277([BBL_Items_Keywords:245];[BBL_Items_Keywords:245]Numero_Item:4;=;[BBL_Items:61]Numero:1;*)
	QUERY:C277([BBL_Items_Keywords:245]; & ;[BBL_Items_Keywords:245]keyword:1;=;"[K]@")
	SELECTION TO ARRAY:C260([BBL_Items_Keywords:245]order:2;$al_orden;[BBL_Items_Keywords:245]keyword:1;$at_materia)
	SORT ARRAY:C229($al_orden;$at_materia;>)
	AT_Initialize (->$at_encabezadosJson)
	If (Position:C15("materiasCatalogacion_KW";[BBL_Items:61]Materias_json:53)>0)
		
		$ob_raiz:=OB_Create 
		$ob_raiz:=JSON Parse:C1218([BBL_Items:61]Materias_json:53;Is object:K8:27)
		  //$t_refJson:=JSON Parse text ([BBL_Items]Materias_json)
		  //JSON_ExtraeValorElemento ($t_refJson;->$at_encabezadosJson;"materiasCatalogacion_KW")
		OB_GET ($ob_raiz;->$at_encabezadosJson;"materiasCatalogacion_KW")
		
	Else 
		  //$t_refJson:=JSON New 
		$ob_raiz:=OB_Create 
		
	End if 
	For ($i_keyword;1;Size of array:C274($at_materia))
		$at_materia{$i_keyword}:=Substring:C12($at_materia{$i_keyword};4)
		If (Find in array:C230($at_encabezadosJson;$at_materia{$i_keyword})=-1)
			APPEND TO ARRAY:C911($at_encabezadosJson;$at_materia{$i_keyword})
		End if 
	End for 
	OB_SET ($ob_raiz;->$at_encabezadosJson;"materiasCatalogacion_KW")
	
	  //JSON_EstableceValor ($t_refJson;->$at_encabezadosJson;"materiasCatalogacion_KW")
	  //[BBL_Items]Materias_json:=JSON Export to text ($t_refJson;JSON_WITH_WHITE_SPACE)
	  //JSON CLOSE ($t_refJson)
	[BBL_Items:61]Materias_json:53:=OB_Object2Json ($ob_raiz)
	CLEAR VARIABLE:C89($ob_raiz)
	SAVE RECORD:C53([BBL_Items:61])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[BBL_Items:61])


READ WRITE:C146([BBL_Items_Keywords:245])
ALL RECORDS:C47([BBL_Items:61])
TRUNCATE TABLE:C1051([BBL_Items_Keywords:245])
