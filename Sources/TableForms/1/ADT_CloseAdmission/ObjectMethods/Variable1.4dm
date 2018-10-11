
Case of 
	: (Form event:C388=On Load:K2:1)
		IT_MODIFIERS 
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		hl_cursosPostulantes:=New list:C375
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Situación_final:16=("Aceptado@");*)
		QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Curso:37="";*)
		If (<>shift)
			QUERY:C277([ADT_Candidatos:49])
		Else 
			QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Terminado:44=False:C215)
		End if 
		$subListRef:=0
		If (Records in selection:C76([ADT_Candidatos:49])>0)
			SELECTION TO ARRAY:C260([ADT_Candidatos:49]Candidato_numero:1;$aIds;[Alumnos:2]apellidos_y_nombres:40;$aNames)
			SORT ARRAY:C229($aNames;$aIds;>)
			$subListRef:=New list:C375
			For ($i;1;Size of array:C274($aIds))
				$name:=$aNames{$i}
				If (Length:C16($name)>30)
					$name:=Substring:C12($name;1;30)+Char:C90(201)
				End if 
				APPEND TO LIST:C376($subListRef;$name;$aids{$i})
			End for 
		End if 
		APPEND TO LIST:C376(hl_cursosPostulantes;"Sin curso asignado";-1;$subListRef;True:C214)
		
		  //CU_LOAD ARRAYS 
		ARRAY TEXT:C222(aCursosPK;0)
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=-2)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aCursosPK)
		
		For ($k;1;Size of array:C274(aCursosPK))
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Situación_final:16=("Aceptado@");*)
			QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Curso:37=aCursosPK{$k};*)
			If (<>shift)
				QUERY:C277([ADT_Candidatos:49])
			Else 
				QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Terminado:44=False:C215)
			End if 
			If (Records in selection:C76([ADT_Candidatos:49])>0)
				SELECTION TO ARRAY:C260([ADT_Candidatos:49]Candidato_numero:1;$aIds;[Alumnos:2]apellidos_y_nombres:40;$aNames)
				SORT ARRAY:C229($aNames;$aIds;>)
				$subListRef:=New list:C375
				For ($i;1;Size of array:C274($aIds))
					$name:=$aNames{$i}
					If (Length:C16($name)>30)
						$name:=Substring:C12($name;1;30)+Char:C90(201)
					End if 
					APPEND TO LIST:C376($subListRef;$name;$aids{$i})
				End for 
				APPEND TO LIST:C376(hl_cursosPostulantes;aCursosPK{$k};0;$subListRef;True:C214)
			Else 
				APPEND TO LIST:C376(hl_cursosPostulantes;aCursosPK{$k};-2;0;False:C215)
			End if 
		End for 
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	: (Form event:C388=On Drop:K2:12)
		
		$element:=Drop position:C608
		GET LIST ITEM:C378(Self:C308->;$element;$ref;$class)
		DRAG AND DROP PROPERTIES:C607($object;$dragged;$process)
		GET LIST ITEM:C378($object->;$dragged;$idCandidate;$student)
		
		Case of 
			: ($ref=-1)
				READ WRITE:C146([ADT_Candidatos:49])
				QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=$idCandidate)
				[ADT_Candidatos:49]Curso:37:=""
				SAVE RECORD:C53([ADT_Candidatos:49])
				UNLOAD RECORD:C212([ADT_Candidatos:49])
				
			: ($ref=-2)
				READ WRITE:C146([ADT_Candidatos:49])
				QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Candidato_numero:1=$idCandidate)
				[ADT_Candidatos:49]Curso:37:=$class
				SAVE RECORD:C53([ADT_Candidatos:49])
				UNLOAD RECORD:C212([ADT_Candidatos:49])
			Else 
				BEEP:C151
		End case 
		
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		hl_cursosPostulantes:=New list:C375
		QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Situación_final:16=("Aceptado@");*)
		QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Curso:37="";*)
		If (<>shift)
			QUERY:C277([ADT_Candidatos:49])
		Else 
			QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Terminado:44=False:C215)
		End if 
		$subListRef:=0
		If (Records in selection:C76([ADT_Candidatos:49])>0)
			SELECTION TO ARRAY:C260([ADT_Candidatos:49]Candidato_numero:1;$aIds;[Alumnos:2]apellidos_y_nombres:40;$aNames)
			SORT ARRAY:C229($aNames;$aIds;>)
			$subListRef:=New list:C375
			For ($i;1;Size of array:C274($aIds))
				$name:=$aNames{$i}
				If (Length:C16($name)>30)
					$name:=Substring:C12($name;1;30)+Char:C90(201)
				End if 
				APPEND TO LIST:C376($subListRef;$name;$aids{$i})
			End for 
		End if 
		APPEND TO LIST:C376(hl_cursosPostulantes;"Sin curso asignado";-1;$subListRef;True:C214)
		
		  //CU_LOAD ARRAYS 
		ARRAY TEXT:C222(aCursosPK;0)
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=-2)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aCursosPK)
		
		For ($k;1;Size of array:C274(aCursosPK))
			QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]Situación_final:16=("Aceptado@");*)
			QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Curso:37=aCursosPK{$k};*)
			If (<>shift)
				QUERY:C277([ADT_Candidatos:49])
			Else 
				QUERY:C277([ADT_Candidatos:49]; & [ADT_Candidatos:49]Terminado:44=False:C215)
			End if 
			If (Records in selection:C76([ADT_Candidatos:49])>0)
				SELECTION TO ARRAY:C260([ADT_Candidatos:49]Candidato_numero:1;$aIds;[Alumnos:2]apellidos_y_nombres:40;$aNames)
				SORT ARRAY:C229($aNames;$aIds;>)
				$subListRef:=New list:C375
				For ($i;1;Size of array:C274($aIds))
					$name:=$aNames{$i}
					If (Length:C16($name)>30)
						$name:=Substring:C12($name;1;30)+Char:C90(201)
					End if 
					APPEND TO LIST:C376($subListRef;$name;$aids{$i})
				End for 
				APPEND TO LIST:C376(hl_cursosPostulantes;aCursosPK{$k};-2;$subListRef;True:C214)
			Else 
				APPEND TO LIST:C376(hl_cursosPostulantes;aCursosPK{$k};-2;0;False:C215)
			End if 
		End for 
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		_O_REDRAW LIST:C382(Self:C308->)
End case 