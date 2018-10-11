Case of 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($object;$element;$process)
		$draggedElement:=Self:C308->{$element}
		$dropPosition:=Drop position:C608
		If ($dropPosition=-1)
			$dropPosition:=Size of array:C274(at_OrdenAsignaturas)+1
		End if 
		INSERT IN ARRAY:C227(Self:C308->;$dropPosition)
		INSERT IN ARRAY:C227(at_OrdenAsignaturas;$dropPosition)
		aSubjectName{$dropPosition}:=$draggedElement
		If ($dropPosition<$element)
			DELETE FROM ARRAY:C228(Self:C308->;$element+1)
			DELETE FROM ARRAY:C228(at_OrdenAsignaturas;$element+1)
		Else 
			DELETE FROM ARRAY:C228(Self:C308->;$element)
			DELETE FROM ARRAY:C228(at_OrdenAsignaturas;$element)
		End if 
		For ($i;1;Size of array:C274(at_OrdenAsignaturas))
			at_OrdenAsignaturas{$i}:=String:C10($i;"00")
		End for 
		vb_orderModified:=True:C214
End case 