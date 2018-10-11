//%attributes = {}
  //ST_Format

If (False:C215)
	  //Method: st_Format
	  //Written by  Alberto Bachler on 27/3/98
	  //Module: string tools
	  //Purpose: format a string according to virtual structure configuration
	  //Syntax:  st_Format(&Pointer{;&Pointer})
	  //Parameters: $1: object pointer (could be a variable or a field pointer)
	  //                    $2: field pointer (if you want use other field config.)
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
End if 


  //DECLARATIONS
C_TEXT:C284($0;$sep)
C_LONGINT:C283($i)
C_POINTER:C301($1;$2;$3)

  //INITIALIZATION

$text:=$1->
$0:=$text
If (Count parameters:C259=1)
	$tableNumber:=Table:C252($1)
	$fieldNumber:=Field:C253($1)
Else 
	$tableNumber:=Table:C252($2)
	$fieldNumber:=Field:C253($2)
End if 
ARRAY LONGINT:C221(da_return;0)

  //MAIN CODE

<>aL_AutoFormatFile{0}:=$tableNumber
<>aL_AutoFormatField{0}:=$fieldNumber
ARRAY LONGINT:C221($DA_Return;0)
$numEls:=AT_MultiArraySearch (False:C215;->$DA_Return;-><>aL_AutoFormatFile;-><>aL_AutoFormatField)

If (($numEls>0) & ($text#""))
	$method:=Dec:C9(<>aR_AutoFormatOpts{$DA_Return{1}})*10
	If ($method>0)
		IT_MODIFIERS 
		Case of 
			: (<>shift)
				$0:=$text
			: (<>gAutoFormat=False:C215)
				$text:=ST_GetCleanString ($text)
			Else 
				$text:=ST_GetCleanString ($text)
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
		End case 
	End if 
End if 