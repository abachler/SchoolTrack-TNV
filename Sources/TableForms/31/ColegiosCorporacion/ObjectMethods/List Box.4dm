  //If (alProEvt=-5)
  //AL_GetDrgArea (xALP_ColegiosAnteriores;$destinationArea)
  //AL_GetDrgSrcRow (xALP_ColegiosAnteriores;$selectedItemLine)
  //AL_GetDrgDstRow (xALP_ColegiosGrupo;$DestRow)
  //If ($destinationArea=xALP_ColegiosGrupo)
  //AL_UpdateArrays (xALP_ColegiosGrupo;0)
  //INSERT IN ARRAY(aColegiosGrupo;$DestRow;1)
  //aColegiosGrupo{$DestRow}:=aColegiosAnteriores{$selectedItemLine}
  //SORT ARRAY(aColegiosGrupo)
  //AL_UpdateArrays (xALP_ColegiosGrupo;-2)
  //AL_SetLine (xALP_ColegiosGrupo;0)
  //AL_UpdateArrays (xALP_ColegiosAnteriores;0)
  //DELETE FROM ARRAY(aColegiosAnteriores;$selectedItemLine;1)
  //AL_UpdateArrays (xALP_ColegiosAnteriores;-2)
  //AL_SetLine (xALP_ColegiosAnteriores;0)
  //End if 
  //End if 
  //

C_POINTER:C301($srcObj)
C_LONGINT:C283($srcLine;$srcProc)
Case of 
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($srcObj;$srcLine;$srcProc)
		If ($srcObj=(->lb_ColegiosGrupo))
			$0:=0
		Else 
			$0:=-1
		End if 
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($srcObj;$srcLine;$srcProc)
		If ($srcObj=(->lb_ColegiosGrupo))
			APPEND TO ARRAY:C911(aColegiosAnteriores;aColegiosGrupo{$srcLine})
			SORT ARRAY:C229(aColegiosAnteriores)
			$colegio:=aColegiosGrupo{$srcLine}
			DELETE FROM ARRAY:C228(aColegiosGrupo;$srcLine;1)
			LISTBOX SELECT ROW:C912(lb_ColegiosGrupo;0;lk remove from selection:K53:3)
			$el:=Find in array:C230(aColegiosAnteriores;$colegio)
			LISTBOX SELECT ROW:C912(lb_ColegiosAnteriores;$el;lk replace selection:K53:1)
			OBJECT SET SCROLL POSITION:C906(Self:C308->;$el)
		End if 
End case 