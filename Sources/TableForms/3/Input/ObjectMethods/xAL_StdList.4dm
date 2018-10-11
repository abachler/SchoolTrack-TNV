$event:=Form event:C388
If (USR_checkRights ("M";->[Cursos:3]))
	Case of 
		: ((alProEvt=1) | (alProEvt=2) | (alProEvt=-2))
			
		: (Form event:C388=On Drop:K2:12)
			$l_dragSource:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_DragSrcArea)
			If ($l_dragSource=Self:C308->)
				$l_dragSrcRow:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_DragSrcRow)
				$l_dragSrcCol:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_DragSrcCol)
				$l_dragType:=AL_GetAreaLongProperty ($l_dragSource;ALP_Area_DragDataType)
				$l_dragDstRow:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_DragDstRow)
				$l_dragDstCol:=AL_GetAreaLongProperty (Self:C308->;ALP_Area_DragDstCol)
				ARRAY POINTER:C280($ay_columnas;0)
				AL_ModifyArrays (Self:C308->;AL Modify Insert action;$l_dragDstRow;1)
				AL_GetObjects (Self:C308->;ALP_Object_Columns;$ay_columnas)
				$l_fila:=Choose:C955($l_dragDstRow<$l_dragSrcRow;$l_dragSrcRow+1;$l_dragSrcRow)
				For ($i;1;Size of array:C274($ay_columnas))
					$ay_columnas{$i}->{$l_dragDstRow}:=$ay_columnas{$i}->{$l_fila}
				End for 
				$l_fila:=Choose:C955($l_dragDstRow<$l_dragSrcRow;$l_dragSrcRow+1;$l_dragSrcRow)
				AL_ModifyArrays (Self:C308->;AL Modify Delete action;$l_fila;1)
				For ($i;1;Size of array:C274(aNtaRecNum))
					aNtaOrden{$i}:=$i
				End for 
				AL_UpdateArrays (xALP_StdList;-2)
				CREATE SELECTION FROM ARRAY:C640([Alumnos_Calificaciones:208];aNtaRecNum)
				OK:=KRL_Array2Selection (->aNtaOrden;->[Alumnos_Calificaciones:208]NoDeLista:10)
			End if 
			
			
		: (alProEvt=-5)
			alProEvt:=0
			AL_GetDrgSrcRow (xALP_StdList;$oldNo)
			AL_GetDrgArea (xALP_StdList;$area;$pId)
			If ($area=xALP_StdList)
				AL_GetDrgDstTyp (xALP_StdList;$type)
				If ($type=1)
					AL_GetDrgDstRow (xALP_StdList;$NewNo)
				End if 
			End if 
			CREATE SET:C116([Alumnos:2];"a")
			READ WRITE:C146([Alumnos:2])
			If ($newNo<$oldNo)
				USE SET:C118("a")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero:1=<>aStdId{$newNo})
				[Alumnos:2]no_de_lista:53:=$newNo+1
				SAVE RECORD:C53([Alumnos:2])
				USE SET:C118("a")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero:1=<>aStdID{$oldNo})
				[Alumnos:2]no_de_lista:53:=$newNo
				SAVE RECORD:C53([Alumnos:2])
				USE SET:C118("a")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]no_de_lista:53>$newNo)
				ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
				While (Not:C34(End selection:C36([Alumnos:2])))
					$newNo:=$newNo+1
					[Alumnos:2]no_de_lista:53:=$newNo
					SAVE RECORD:C53([Alumnos:2])
					NEXT RECORD:C51([Alumnos:2])
				End while 
			Else 
				If ($newNo>Size of array:C274(<>aStdID))
					$newNo:=Size of array:C274(<>aStdID)
				End if 
				USE SET:C118("a")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero:1=<>aStdId{$newNo})
				[Alumnos:2]no_de_lista:53:=$newNo-1
				SAVE RECORD:C53([Alumnos:2])
				USE SET:C118("a")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]numero:1=<>aStdID{$oldNo})
				[Alumnos:2]no_de_lista:53:=$newNo
				SAVE RECORD:C53([Alumnos:2])
				USE SET:C118("a")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]no_de_lista:53<$newNo)
				ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
				$newNo:=0
				While (Not:C34(End selection:C36([Alumnos:2])))
					$newNo:=$newNo+1
					[Alumnos:2]no_de_lista:53:=$newNo
					SAVE RECORD:C53([Alumnos:2])
					NEXT RECORD:C51([Alumnos:2])
				End while 
			End if 
			
			CU_UpdateListNumbers 
			
			
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;<>aStdId;[Alumnos:2]apellidos_y_nombres:40;<>aStdWhNme;[Alumnos:2]no_de_lista:53;<>aStdNo)
			AL_UpdateArrays (xALP_StdList;Size of array:C274(<>aStdID))
			AL_SetSort (xALP_StdList;1)
	End case 
End if 