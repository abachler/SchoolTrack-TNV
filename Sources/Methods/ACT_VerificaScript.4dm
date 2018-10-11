//%attributes = {}
  //ACT_VerificaScript

C_TEXT:C284($1;$0)
C_LONGINT:C283($i;$pos)
C_TEXT:C284($t_NuevaVariable;$t_script;$t_VariableAntigua)

ARRAY TEXT:C222($at_script;0)

$t_script:=$1
AT_Text2Array (->$at_script;$t_script;"\r")

For ($i;1;Size of array:C274($at_script))
	Case of 
		: ($at_script{$i}="@SET QUERY DESTINATION@")
			$pos:=Position:C15("Into variable";$at_script{$i})
			If ($pos#0)
				$at_script{$i}:=Replace string:C233($at_script{$i};"\r";"")
				$at_script{$i}:=Replace string:C233($at_script{$i};Char:C90(10);"")
				$t_VariableAntigua:=ST_GetWord ($at_script{$i};2;";")
				$t_VariableAntigua:=Replace string:C233($t_VariableAntigua;")";"")
				$t_NuevaVariable:=Replace string:C233($t_VariableAntigua;"$";"vl_")
				$t_script:=Replace string:C233($t_script;$t_VariableAntigua;$t_NuevaVariable)
			End if 
	End case 
End for 

$0:=$t_script

