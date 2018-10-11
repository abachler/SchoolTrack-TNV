//%attributes = {}
  //ST_Format2

If (False:C215)
	  //Method: st_Format
	  //Written by  Alberto Bachler on 27/3/98
	  //Module: string tools
	  //Purpose: format a string according to the method parameter
	  //Syntax:  st_Format(&Pointer;&L)
	  //Parameters: $1: object pointer (could be a variable or a field pointer)
	  //                    $2: method
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
End if 


  //DECLARATIONS
C_TEXT:C284($0;$sep)
C_LONGINT:C283($i;$2)
C_POINTER:C301($1)
C_LONGINT:C283($tableNumber;$fieldNumber)

  //INITIALIZATION
$text:=$1->
$0:=$text
  //MONO 2018-08-18: ya no se utilizan dentro del método
  //$tableNumber:=Table($1)
  //$fieldNumber:=Field($1)
$method:=$2

  //MAIN CODE

If ($text#"")
	If ($method>0)
		IT_MODIFIERS 
		If ((<>Command) | (Not:C34(<>gAutoFormat)))
			$0:=$text
		Else 
			Case of 
				: ($method=1)
					$0:=$text
				: ($method=2)
					$0:=ST_Lowercase ($text)
				: ($method=3)
					$0:=ST_Uppercase ($text[[1]])+ST_Lowercase (Substring:C12($text;2))
				: ($method=5)
					$0:=ST_Uppercase ($text)
				: ($method=4)
					If ($text#"")  //se eliminan los espacios previos si existen
						$text:=ST_Lowercase ($text)
						While (Position:C15(" ";$text)=1)
							$text:=Substring:C12($text;2)
						End while 
						  //los espacios dobles sont remplazados por espacios simples
						While (Position:C15("  ";$text)#0)
							$text:=Replace string:C233($text;"  ";" ")
						End while 
						$sep:=" ,-./%&\\"+"\r"+"\t"
						If ($text#"")
							If (Position:C15($text[[1]];$sep)=0)
								If (Character code:C91($text[[1]])=150)
									$text[[1]]:=Char:C90(132)
								Else 
									$text[[1]]:=ST_Uppercase ($text[[1]])
								End if 
							End if 
							For ($i;2;Length:C16($text)-1)
								If ((Position:C15($text[[$i]];$sep)>0) & (Position:C15($text[[$i+1]];$sep)>0))
									$i:=$i+1
								Else 
									If (Position:C15($text[[$i-1]];$sep)>0)
										$temp1:=Substring:C12($text;1;$i-1)
										If (Character code:C91($text[[$i]])=150)
											$temp2:=Char:C90(132)
										Else 
											$temp2:=ST_Uppercase ($text[[$i]])
										End if 
										$temp3:=Substring:C12($text;$i+1)
										$text:=$temp1+$temp2+$temp3
									End if 
								End if 
							End for 
							$0:=$text
						End if 
						$0:=$text
						For ($i;1;Size of array:C274(at_ExcepcionesFormato))
							If (Position:C15(at_ExcepcionesFormato{$i};$0)>0)
								$0:=Replace string:C233($0;at_ExcepcionesFormato{$i};at_ExcepcionesFormato{$i})
							End if 
						End for 
					End if 
			End case 
		End if 
	End if 
End if 