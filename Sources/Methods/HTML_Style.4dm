//%attributes = {}
  //HTML_Style

C_TEXT:C284($1;$3;$4;$5;$font;$style;$s1;$s2;$0;$Color)
C_LONGINT:C283($size;$2)
If (Count parameters:C259>1)
	$size:=$2
End if 
If (Count parameters:C259>2)
	$s1:=""
	$s2:=""
	For ($i;1;ST_CountWords ($3;0;","))
		$style:=ST_GetWord ($3;$i;",")
		If ($style#"")
			$s1:=$s1+"<"+$style+">"
			$s2:=$s2+"</"+$style+">"
		End if 
	End for 
End if 
If (Count parameters:C259>3)
	$color:=$4
End if 
If (Count parameters:C259=5)
	$font:=$5
End if 
If ($1="")
	$1:=<>nbSpace
End if 
$0:="<FONT"
If ($color#"")
	Case of 
		: ($color="Red")
			$color:="#DD0000"
		: ($color="Blue")
			$color:="#0000AA"
		: ($color="Green")
			$color:="#006600"
		: ($color="Yellow")
			$color:="#006600"
		: ($color="White")
			$color:="#FFFFFF"
		: ($color="Black")
			$color:="#000000"
		: ($color="Black")
			$color:="#555555"
		Else 
			$color:="#555555"
	End case 
	$0:=$0+" COLOR="+ST_Qte ($color)+" "
End if 
Case of 
	: ((Count parameters:C259=1) | ($font="Verdana"))
		$0:=$0+" FACE="+ST_Qte ("VERDANA,TAHOMA,ARIAL,TIMES NEW ROMAN")
	: ($font="Helvetica")
		$0:=$0+" FACE="+ST_Qte ("HELVETICA,ARIAL,TIMES NEW ROMAN")
	: ($font="Tahoma")
		$0:=$0+" FACE="+ST_Qte ("TAHOMA,ARIAL,TIMES NEW ROMAN")
	: ($FONT#"")
		$0:=$0+" FACE="+ST_Qte ($font)
	Else 
		$0:=$0+" FACE="+ST_Qte ("VERDANA,Tahoma,ARIAL,TIMES NEW ROMAN")
End case 
$0:=$0+" SIZE="+ST_Qte (String:C10($size))+">"
$0:=$0+_O_Mac to ISO:C519($1)+"</FONT>"
$0:=$s1+$0+$s2