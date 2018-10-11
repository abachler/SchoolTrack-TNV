//%attributes = {}
  // UD_v20151130_ObservacionesMater()
  //
  //
  // creado por: Alberto Bachler Klein: 30-11-15, 12:07:55
  // -----------------------------------------------------------

  // NO se convierte nada
  // Los colegios no usan observaciones predefinidas
  // pero pueden usarlas con el nuevo sistema


  //20170623 RCH SE comentan las siguientes 3 líneas y se restaura método de 12.0. Se agrega it_progress
  //READ WRITE([xxSTR_Materias_Observaciones])
  //ALL RECORDS([xxSTR_Materias_Observaciones])
  //TRUNCATE TABLE([xxSTR_Materias_Observaciones])
C_BOOLEAN:C305($b_expanded;$b_isFolder)
C_LONGINT:C283($hl_lista;$i;$i_elementos;$i_filas;$i_materias;$i_niveles;$i_pares;$i_subLista;$l_idCategoria;$l_idObservacion)
C_LONGINT:C283($l_index;$l_numeroNivel;$l_ref;$l_refSubItem;$l_sublist)
C_TEXT:C284($t_categoria;$t_observacion;$t_observacionSub;$t_parent;$t_texto;$t_ultimaCategoria)
C_OBJECT:C1216($ob_nivel;$ob_nodo;$ob_nodoCategoria;$ob_nodoNivel;$ob_nodoUndefinedCategoria;$ob_observacion;$ob_Observaciones;$ob_raiz;$ob_vacio)

ARRAY LONGINT:C221($al_filas;0)
ARRAY LONGINT:C221($al_recNums;0)
ARRAY TEXT:C222($at_Categorias;0)
ARRAY TEXT:C222($at_Observaciones;0)
ARRAY TEXT:C222($at_pares;0)
ARRAY OBJECT:C1221($ao_categorias;0)
ARRAY OBJECT:C1221($ao_Observaciones;0)
C_LONGINT:C283($l_proc)

NIV_LoadArrays 

$ob_raiz:=OB_Create 

READ WRITE:C146([xxSTR_Materias:20])
ALL RECORDS:C47([xxSTR_Materias:20])
APPLY TO SELECTION:C70([xxSTR_Materias:20];[xxSTR_Materias:20]ob_Observaciones:7:=$ob_raiz)

  //QUERY([xxSTR_Materias];[xxSTR_Materias]Materia="Matemática")
ALL RECORDS:C47([xxSTR_Materias:20])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Materias:20];$al_recNums)

$l_proc:=IT_Progress (1;0;0;"Almacenando observaciones...";0;"")
For ($i_materias;1;Size of array:C274($al_recNums))
	CLEAR VARIABLE:C89($ob_raiz)
	$ob_raiz:=OB_Create 
	KRL_GotoRecord (->[xxSTR_Materias:20];$al_recNums{$i_materias};True:C214)
	
	For ($i_niveles;1;Size of array:C274(<>aNivNo))
		CLEAR VARIABLE:C89($ob_nodoNivel)
		$ob_nodoNivel:=OB_Create 
		$l_numeroNivel:=<>aNivNo{$i_niveles}
		QUERY:C277([xxSTR_Materias_Observaciones:233];[xxSTR_Materias_Observaciones:233]id_added_by_converter:3;=;Get subrecord key:C1137([xxSTR_Materias:20]Observaciones:6);*)
		QUERY:C277([xxSTR_Materias_Observaciones:233]; & [xxSTR_Materias_Observaciones:233]NumeroNivel:1;=;$l_numeroNivel)
		If (BLOB size:C605([xxSTR_Materias_Observaciones:233]xListaObservaciones:2)>0)
			$hl_lista:=BLOB to list:C557([xxSTR_Materias_Observaciones:233]xListaObservaciones:2)
			HL_CollapseAll ($hl_lista)
		Else 
			HL_ClearList ($hl_lista)
		End if 
		
		If (Is a list:C621($hl_lista))
			  // preparo para eliminar eventuales duplicados categoria/Observacion
			AT_Initialize (->$at_Categorias;->$at_Observaciones;->$at_pares)
			For ($i_elementos;1;Count list items:C380($hl_lista))
				GET LIST ITEM:C378($hl_lista;$i_elementos;$l_ref;$t_parent;$l_sublist)
				If ($l_sublist>0)
					For ($i_subLista;1;Count list items:C380($l_sublist))
						GET LIST ITEM:C378($l_sublist;$i_subLista;$l_refSubItem;$t_observacionSub)
						APPEND TO ARRAY:C911($at_pares;$t_parent+"‰"+$t_observacionSub)
					End for 
				Else 
					If ($l_ref<0)
						APPEND TO ARRAY:C911($at_pares;$t_parent+"‰"+"")
					Else 
						APPEND TO ARRAY:C911($at_pares;"none"+"‰"+$t_observacionSub)
					End if 
				End if 
			End for 
			AT_DistinctsArrayValues (->$at_pares)  // elimino los duplicados
			SORT ARRAY:C229($at_pares)
			
			  // creo los objetos
			$l_idCategoria:=0
			$l_idObservacion:=0
			$b_isFolder:=True:C214
			$b_expanded:=True:C214
			$t_ultimaCategoria:=""
			AT_Initialize (->$ao_Categorias)
			If (Find in array:C230($at_pares;"none‰")<0)
				APPEND TO ARRAY:C911($at_pares;"none‰")
			End if 
			
			
			For ($i_pares;1;Size of array:C274($at_pares))
				$t_categoria:=ST_GetWord ($at_pares{$i_pares};1;"‰")
				If ($t_categoria#$t_ultimaCategoria)
					$t_ultimaCategoria:=$t_categoria
					AT_Initialize (->$ao_Observaciones)
					$l_idCategoria:=$l_idCategoria-1
					CLEAR VARIABLE:C89($ob_nodoCategoria)
					$ob_nodoCategoria:=OB_Create 
					OB_SET ($ob_nodoCategoria;->$t_categoria;"title")
					OB_SET ($ob_nodoCategoria;->$l_idCategoria;"id")
					  //OB_SET ($ob_nodoCategoria;->$b_isFolder;"is folder")
					OB_SET ($ob_nodoCategoria;->$b_isFolder;"isFolder")  //20180718 ASM Ticket 211873
					OB_SET ($ob_nodoCategoria;->$b_expanded;"expand")
					
					$l_index:=$i_Pares
					While ($t_categoria=$t_ultimaCategoria)
						$t_observacion:=ST_GetWord ($at_pares{$l_index};2;"‰")
						If ($t_observacion#"")
							$l_idObservacion:=$l_idObservacion+1
							CLEAR VARIABLE:C89($ob_observacion)
							$ob_observacion:=OB_Create 
							OB_SET ($ob_observacion;->$t_observacion;"title")
							OB_SET ($ob_observacion;->$l_idObservacion;"id")
							APPEND TO ARRAY:C911($ao_observaciones;$ob_observacion)
						End if 
						If ($l_index<Size of array:C274($at_pares))
							$l_index:=$l_index+1
							$t_categoria:=ST_GetWord ($at_pares{$l_index};1;"‰")
						Else 
							$t_categoria:=""
						End if 
					End while 
					
					OB_SET ($ob_nodoCategoria;->$ao_observaciones;"children")
					APPEND TO ARRAY:C911($ao_categorias;$ob_nodoCategoria)
				End if 
			End for 
		End if 
		OB_SET ($ob_nodoNivel;->$ao_categorias;"categorias")
		OB_SET ($ob_raiz;->$ob_nodoNivel;String:C10($l_numeroNivel))
		
		IT_Progress (0;$l_proc;$i_materias/Size of array:C274($al_recNums);"Almacenando observaciones, materia: "+[xxSTR_Materias:20]Materia:2+"...";$i_niveles/Size of array:C274(<>aNivNo);"Nivel: "+<>aNivel{$i_niveles}+"...")
	End for 
	
	
	[xxSTR_Materias:20]ob_Observaciones:7:=$ob_raiz
	SAVE RECORD:C53([xxSTR_Materias:20])
	
	IT_Progress (0;$l_proc;$i_materias/Size of array:C274($al_recNums);"Almacenando observaciones, materia: "+[xxSTR_Materias:20]Materia:2+"...";0;"")
End for 
IT_Progress (-1;$l_proc)

ALL RECORDS:C47([xxSTR_Materias_Observaciones:233])
TRUNCATE TABLE:C1051([xxSTR_Materias_Observaciones:233])

