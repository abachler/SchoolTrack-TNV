//%attributes = {}
  //ST_UppercaseFirstLetter

C_TEXT:C284($0;$sep;$1)
C_LONGINT:C283($i)
  //se eliminan los espacios previos si existen
IT_MODIFIERS 
If ((<>Command) | (Not:C34(<>gAutoFormat)))
	$0:=$1
Else 
	If ($1#"")
		$1:=ST_Lowercase ($1)
		While (Position:C15(" ";$1)=1)
			$1:=Substring:C12($1;2)
		End while 
		  //los espacios dobles sont remplazados por espacios simples
		While (Position:C15("  ";$1)#0)
			$1:=Replace string:C233($1;"  ";" ")
		End while 
		$sep:=" ,-./%&\\"+"\r"+"\t"
		If ($1#"")
			If (Position:C15($1[[1]];$sep)=0)
				If (Character code:C91($1[[1]])=150)
					$1[[1]]:=Char:C90(132)
				Else 
					$1[[1]]:=ST_Uppercase ($1[[1]])
				End if 
			End if 
			For ($i;2;Length:C16($1)-1)
				If ((Position:C15($1[[$i]];$sep)>0) & (Position:C15($1[[$i+1]];$sep)>0))
					$i:=$i+1
				Else 
					If (Position:C15($1[[$i-1]];$sep)>0)
						$temp1:=Substring:C12($1;1;$i-1)
						If (Character code:C91($1[[$i]])=150)
							$temp2:=Char:C90(132)
						Else 
							$temp2:=ST_Uppercase ($1[[$i]])
						End if 
						$temp3:=Substring:C12($1;$i+1)
						$1:=$temp1+$temp2+$temp3
					End if 
				End if 
			End for 
			$0:=$1
		End if 
		$0:=$1
		For ($i;1;Size of array:C274(at_ExcepcionesFormato))
			If (Position:C15(at_ExcepcionesFormato{$i};$0)>0)
				$0:=Replace string:C233($0;at_ExcepcionesFormato{$i};at_ExcepcionesFormato{$i})
			End if 
		End for 
	End if 
End if 