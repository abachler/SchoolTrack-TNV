//%attributes = {}
  //SR_SetObjectFontStyleFromString

_O_C_STRING:C293(20;$1;$stringstyle)
C_LONGINT:C283($fontstyle)
$stringstyle:=$1
Case of 
	: (($stringstyle="Regular") | ($stringstyle="Normal") | ($stringstyle="Normal") | ($stringstyle="Normal") | ($stringstyle="Normal"))
		$fontstyle:=0
	: (($stringstyle="Bold") | ($stringstyle="Negrilla") | ($stringstyle="Gras") | ($stringstyle="Fett") | ($stringstyle="Realce"))
		$fontstyle:=1
	: (($stringstyle="Italic") | ($stringstyle="Cursiva@") | ($stringstyle="Italique") | ($stringstyle="Italic") | ($stringstyle="Cursiva"))
		$fontstyle:=2
	: (($stringstyle="Underline") | ($stringstyle="Subrayado") | ($stringstyle="Souligné") | ($stringstyle="unterstrichen") | ($stringstyle="sublinhado"))
		$fontstyle:=4
	Else 
		$fontstyle:=Num:C11($stringstyle)
End case 
SR_SetObjectFontStyle ($fontStyle)

  //$err:=SR Set Object Format (SRArea;SRObjectID;SR Attribute Font Style;"";0;$fontstyle;0;"";0;0;0;0;0;0;0;0;0;0;0)