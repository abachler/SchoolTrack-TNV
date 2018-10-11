  // [BBL_Items].Input.materias()
  // Por: Alberto Bachler K.: 11-02-15, 16:20:43
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_actualizarLista)
C_LONGINT:C283($l_recNum;$l_respuesta)
C_POINTER:C301($y_materias;$y_variable)
C_TEXT:C284($t_materia;$t_textoMateria)

$y_materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")

Case of 
	: (Form event:C388=On Before Data Entry:K2:39)
		$l_recNum:=Find in field:C653([BBL_Thesaurus:68]Materia:13;$y_materias->{$y_materias->})
		If ($l_recNum>No current record:K29:2)
			If ($y_materias->{$y_materias->}#"")
				GOTO OBJECT:C206(*;"lb_terminos")
				OBJECT SET ENTERABLE:C238(*;"materias";False:C215)
				GOTO OBJECT:C206(*;"lb_materias")
				LISTBOX SELECT ROW:C912(*;"lb_materias";$y_materias->)
			End if 
		Else 
			OBJECT SET ENTERABLE:C238(*;"materias";True:C214)
		End if 
		
		
	: (Form event:C388=On Data Change:K2:15)
		$t_materia:=$y_materias->{$y_materias->}
		If ($t_materia#"")
			$t_textoMateria:=$t_materia+"@"
			QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13=$t_materia)
			If (Records in selection:C76([BBL_Thesaurus:68])=1)
				$b_actualizarLista:=True:C214
				
			Else 
				$t_textoMateria:=$t_materia+"@"
				QUERY:C277([BBL_Thesaurus:68];[BBL_Thesaurus:68]Materia:13=$t_textoMateria)
				Case of 
					: (Records in selection:C76([BBL_Thesaurus:68])=1)
						$y_Materias->{$y_Materias->}:=[BBL_Thesaurus:68]Materia:13
						$b_actualizarLista:=True:C214
						
					: (Records in selection:C76([BBL_Thesaurus:68])>1)
						vs_SearchedHeader:=$t_materia
						BBLitm_OpenThesaurus 
						$b_actualizarLista:=True:C214
						vs_SearchedHeader:=""
						
					: ((Records in selection:C76([BBL_Thesaurus:68])=0) & (USR_checkRights ("A";->[BBL_Thesaurus:68])))
						$l_respuesta:=CD_Dlog (0;__ ("Encabezamiento de materia inexistente.\r¿Desea agregarlo al Thesaurus?");__ ("");__ ("Si");__ ("No"))
						If ($l_respuesta=1)
							CREATE RECORD:C68([BBL_Thesaurus:68])
							[BBL_Thesaurus:68]Materia:13:=$t_materia
							SAVE RECORD:C53([BBL_Thesaurus:68])
							$b_actualizarLista:=True:C214
						Else 
							$y_Materias->{$y_Materias->}:=""
						End if 
						
					: ((Records in selection:C76([BBL_Thesaurus:68])=0) & (Not:C34(USR_checkRights ("A";->[BBL_Thesaurus:68]))))
						CD_Dlog (0;__ ("Encabezamiento de materia inexistente."))
						
				End case 
			End if 
			
		Else 
			BEEP:C151
			$y_variable->:=""
			GOTO OBJECT:C206($y_variable->)
			HIGHLIGHT TEXT:C210($y_variable->;0;32000)
		End if 
		
		If ($b_actualizarLista)
			$y_Materias:=OBJECT Get pointer:C1124(Object named:K67:5;"materias")
			If (Find in array:C230($y_Materias->;[BBL_Thesaurus:68]Materia:13)<0)
				$y_Materias->{$y_Materias->}:=[BBL_Thesaurus:68]Materia:13
			End if 
			BBLitm_GuardaMaterias 
		Else 
			GOTO OBJECT:C206($y_variable->)
			HIGHLIGHT TEXT:C210($y_variable->;0;32000)
		End if 
		
		
	: (Form event:C388=On After Keystroke:K2:26)
		
End case 