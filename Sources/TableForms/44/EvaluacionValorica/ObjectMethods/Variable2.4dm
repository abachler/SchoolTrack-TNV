C_TEXT:C284(<>sEvalExpl)

For ($i;1;6)
	<>aValores{$i}:=(Get pointer:C304("sValor"+String:C10($i)))->
	<>aAbrevVal{$i}:=(Get pointer:C304("sAbrevV"+String:C10($i)))->
End for 
For ($i;1;4)
	<>aVindic{$i}:=(Get pointer:C304("sEvDesc"+String:C10($i)))->
	<>aEscalaV{$i}:=(Get pointer:C304("sEvValor"+String:C10($i)))->
End for 
BLOB_Variables2Blob (->[xxSTR_Constants:1]xIndicadoresEvValorica:37;0;-><>aValores;-><>aEscalaV;-><>aVIndic;-><>aAbrevVal;-><>sEvalExpl;-><>sEvalExpl1;-><>cb_EvalLibre)
SAVE RECORD:C53([xxSTR_Constants:1])