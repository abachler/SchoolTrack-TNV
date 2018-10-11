//%attributes = {}
  //LOC_ObjNombreColumnasEval
  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
  //caso 1 "iniciar" Sirve para crear el objeto con todos los niveles ST, sólo recibe el parametro 1 del caso
  //caso 2 "actualizar" recibe el parametro 1 y el 2 con un puntero a un objeto que tiene los nodos cambiados
  //caso 3 "consultar" recibe el caso, 2 puntero de un objeto, numero nivel, con esto llenamos llenamos el objeto apuntado con la configuración del nivel que pedimos en el 3er parametro.
C_POINTER:C301($y_displayEdit;$2)
C_OBJECT:C1216($ob_display)
C_TEXT:C284($t_case;$1;$t_nodo;$t_alias;$t_uuid)
C_TEXT:C284($t_labelPA;$t_labelNF;$t_labelNO;$t_labelEX;$t_labelEXX;$t_labelEsfuerzo;$t_labelCP;$t_labelBonificacion)
C_BOOLEAN:C305($b_save)
C_LONGINT:C283($i;$l_noNivel)
ARRAY TEXT:C222($a_ColEvaName;0)
ARRAY TEXT:C222($a_ColEvaDisplay;0)

If (Count parameters:C259>=1)
	$t_case:=$1
End if 

If (Count parameters:C259>=2)
	$y_displayEdit:=$2
End if 

If (Count parameters:C259=3)
	$l_nonivel:=$3
End if 

$ob_display:=OB_Create 
$ob_display:=PREF_fGetObject (0;"PrefObj_NombreColumnasEvaluacionesGenerales";$ob_display)

Case of 
	: ($t_case="iniciar")
		$ob_display:=OB_Create 
		
		ARRAY TEXT:C222($a_ColEvaName;9)
		$a_ColEvaName{1}:=__ ("Promedio Anual")
		$a_ColEvaName{2}:=__ ("Nota Final Interna")
		$a_ColEvaName{3}:=__ ("Nota Final Oficial")
		$a_ColEvaName{4}:=__ ("Examen")
		$a_ColEvaName{5}:=__ ("Examen Extra")
		$a_ColEvaName{6}:=__ ("Esfuerzo")
		$a_ColEvaName{7}:=__ ("Control de Periodo")
		$a_ColEvaName{8}:=__ ("Promedio Transversal de Período")
		$a_ColEvaName{9}:=__ ("Bonificación")
		
		ARRAY TEXT:C222($a_ColEvaDisplay;9)
		$a_ColEvaDisplay{1}:="PA"
		$a_ColEvaDisplay{2}:="NF"
		$a_ColEvaDisplay{3}:="NO"
		$a_ColEvaDisplay{4}:="EX"
		$a_ColEvaDisplay{5}:="EXX"
		$a_ColEvaDisplay{6}:=__ ("Esfuerzo")
		$a_ColEvaDisplay{7}:="CP"
		$a_ColEvaDisplay{8}:="PTE"
		$a_ColEvaDisplay{9}:=__ ("Bonificación")
		
		If (Size of array:C274(<>aNivNo)=0)
			NIV_LoadArrays 
		End if 
		
		OB_AppendNode ($ob_display;"nombreEva")
		OB_SET ($ob_display;->$a_ColEvaName;"nombreEva")
		
		For ($i;1;Size of array:C274(<>aNivNo))
			$t_nodo:=String:C10(<>aNivNo{$i})
			If (Not:C34(OB Is defined:C1231($ob_display;$t_nodo)))
				OB_AppendNode ($ob_display;$t_nodo)
			End if 
			OB_SET ($ob_display;->$a_ColEvaDisplay;$t_nodo+".display")
		End for 
		
		$b_save:=True:C214
		
	: ($t_case="actualizar")
		
		  //Lo hago de esta manera para actualizar el objeto completo o por partes
		If (OB_GetSize ($y_displayEdit->)>0)
			ARRAY TEXT:C222($at_nombreNodos;0)
			OB_GetChildNodes ($y_displayEdit->;->$at_nombreNodos)
			
			For ($i;1;Size of array:C274($at_nombreNodos))
				
				If ($at_nombreNodos{$i}="nombreEva")
					$t_nodo:=$at_nombreNodos{$i}
				Else 
					$t_nodo:=$at_nombreNodos{$i}+".display"
				End if 
				
				OB_GET ($y_displayEdit->;->$a_ColEvaDisplay;$t_nodo)
				OB_SET ($ob_display;->$a_ColEvaDisplay;$t_nodo)
				$b_save:=True:C214
			End for 
			
		End if 
		
	: ($t_case="consultar")
		
		If (OB Is defined:C1231($ob_display;String:C10($l_nonivel)))
			C_OBJECT:C1216($o_nivLabels)
			$o_nivLabels:=OB Get:C1224($ob_display;String:C10($l_nonivel))
			OB GET ARRAY:C1229($o_nivLabels;"display";$a_ColEvaDisplay)
		End if 
		
		If (Size of array:C274($a_ColEvaDisplay)=0)  //Nivel no considerado dentro del objeto de localización de evaluaciones generales.
			$t_labelPA:=__ ("Promedio Anual")
			$t_labelNF:=__ ("Nota Final")
			$t_labelNO:=__ ("Nota Oficial")
			$t_labelEX:=__ ("Examen")
			$t_labelEXX:=__ ("Examen Extra")
			$t_labelEsfuerzo:=__ ("Esfuerzo")
			$t_labelCP:=__ ("Control Período")
			$t_labelPTC:=__ ("PTE")
			$t_labelBonificacion:=__ ("Bonificación")
		Else 
			$t_labelPA:=$a_ColEvaDisplay{1}
			$t_labelNF:=$a_ColEvaDisplay{2}
			$t_labelNO:=$a_ColEvaDisplay{3}
			$t_labelEX:=$a_ColEvaDisplay{4}
			$t_labelEXX:=$a_ColEvaDisplay{5}
			$t_labelEsfuerzo:=$a_ColEvaDisplay{6}
			$t_labelCP:=$a_ColEvaDisplay{7}
			$t_labelPTC:=$a_ColEvaDisplay{8}
			$t_labelBonificacion:=$a_ColEvaDisplay{9}
		End if 
		
		CLEAR VARIABLE:C89($y_displayEdit->)
		
		OB SET:C1220($y_displayEdit->;"PA";$t_labelPA)
		OB SET:C1220($y_displayEdit->;"NF";$t_labelNF)
		OB SET:C1220($y_displayEdit->;"NO";$t_labelNO)
		OB SET:C1220($y_displayEdit->;"EX";$t_labelEX)
		OB SET:C1220($y_displayEdit->;"EXX";$t_labelEXX)
		OB SET:C1220($y_displayEdit->;"Esfuerzo";$t_labelEsfuerzo)
		OB SET:C1220($y_displayEdit->;"CP";$t_labelCP)
		OB SET:C1220($y_displayEdit->;"PTE";$t_labelPTC)
		OB SET:C1220($y_displayEdit->;"BONO";$t_labelBonificacion)
		
End case 

If ($b_save)
	PREF_SetObject (0;"PrefObj_NombreColumnasEvaluacionesGenerales";$ob_display)
End if 