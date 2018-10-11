  // [BBL_Items].Input.palabraClave()
  // Por: Alberto Bachler: 16/09/13, 20:17:22
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_actualizarLista)
C_LONGINT:C283($l_filaSeleccionada;$l_respuesta)
C_POINTER:C301($y_variable)
C_TEXT:C284($t_materia;$t_textoMateria)

$y_variable:=OBJECT Get pointer:C1124(Object current:K67:2)
$y_materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")
$t_materia:=Get edited text:C655

Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		
	: (Form event:C388=On After Keystroke:K2:26)
		If ($t_materia#"")
			$t_texto:=$t_materia+"@"
			If (Find in field:C653([BBL_Thesaurus:68]Materia:13;$t_texto)>No current record:K29:2)
				$y_variable->:=IT_SeleccionCampo (->[BBL_Thesaurus:68]Materia:13;$t_materia)
				HIGHLIGHT TEXT:C210($y_variable->;MAXLONG:K35:2;MAXLONG:K35:2)
				
				If ($y_variable->#"")
					If (Find in field:C653([BBL_Thesaurus:68]Materia:13;$y_variable->)>No current record:K29:2)
						$y_Materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")
						If (Find in array:C230($y_Materias->;$y_variable->)<0)
							APPEND TO ARRAY:C911($y_Materias->;$y_variable->)
							BBLitm_GuardaMaterias 
							$y_variable->:=""
						End if 
					End if 
				End if 
			End if 
			OBJECT SET VISIBLE:C603(*;"textoEjemplo";$t_materia="")
		Else 
			OBJECT SET VISIBLE:C603(*;"textoEjemplo";True:C214)
		End if 
	: (Form event:C388=On Losing Focus:K2:8)
		If ($y_variable->#"")
			If (Find in field:C653([BBL_Thesaurus:68]Materia:13;$y_variable->)=No current record:K29:2)
				$l_respuesta:=CD_Dlog (0;__ ("Encabezamiento de materia inexistente.\r¿Desea agregarlo al Thesaurus?");__ ("");__ ("Si");__ ("No"))
				If ($l_respuesta=1)
					CREATE RECORD:C68([BBL_Thesaurus:68])
					[BBL_Thesaurus:68]Materia:13:=$y_variable->
					SAVE RECORD:C53([BBL_Thesaurus:68])
					If (Find in array:C230($y_Materias->;$y_variable->)<0)
						APPEND TO ARRAY:C911($y_Materias->;$y_variable->)
						BBLitm_GuardaMaterias 
						$y_variable->:=""
					End if 
				Else 
					$y_variable->:=""
				End if 
			End if 
		End if 
		OBJECT SET VISIBLE:C603(*;"textoEjemplo";$y_variable->="")
		
	Else 
		
End case 


GOTO OBJECT:C206($y_variable->)

