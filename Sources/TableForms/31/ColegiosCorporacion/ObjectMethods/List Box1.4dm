C_POINTER:C301($srcObj)
C_LONGINT:C283($srcLine;$srcProc)
Case of 
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($srcObj;$srcLine;$srcProc)
		If ($srcObj=(->lb_ColegiosAnteriores))
			$0:=0
		Else 
			$0:=-1
		End if 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($srcObj;$srcLine;$srcProc)
		If ($srcObj=(->lb_ColegiosAnteriores))
			$el:=Find in array:C230(aColegiosGrupo;aColegiosAnteriores{$srcLine})
			If ($el=-1)
				APPEND TO ARRAY:C911(aColegiosGrupo;aColegiosAnteriores{$srcLine})
				SORT ARRAY:C229(aColegiosGrupo)
				$el:=Find in array:C230(aColegiosGrupo;aColegiosAnteriores{$srcLine})
				LISTBOX SELECT ROW:C912(Self:C308->;$el;lk replace selection:K53:1)
				DELETE FROM ARRAY:C228(aColegiosAnteriores;$srcLine;1)
				OBJECT SET SCROLL POSITION:C906(Self:C308->;$el)
			End if 
		End if 
End case 