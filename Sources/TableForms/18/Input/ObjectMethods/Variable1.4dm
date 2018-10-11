  // Método: [Asignaturas].Input.Variable1
  // código original de: ABK
  // modificado por Alberto Bachler Klein, 23/08/18, 13:04:11
  // 
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



If (USR_checkRights ("M";->[Asignaturas:18]))
	Case of 
		: ((alProEvt=AL Single click event) | (alProEvt=AL Double click event) | (alProEvt=AL Select all event))
			AS_OnActivate 
			
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
	End case 
	
Else 
	OBJECT SET ENABLED:C1123(b_Retirar;False:C215)
	OBJECT SET ENABLED:C1123(b_eximir;False:C215)
End if 