//%attributes = {}
  //SR_SetObjectFontSizeFromString

_O_C_STRING:C293(20;$1;$stringSize)
C_LONGINT:C283($fontSize)
$stringSize:=$1
Case of 
	: (($stringSize="Smallest") | ($stringSize="Muy pequeño") | ($stringSize="Tres petit") | ($stringSize="kleinsten") | ($stringSize="mais menor"))
		$fontsize:=6
	: (($stringSize="Small") | ($stringSize="Pequeño") | ($stringSize="Petit") | ($stringSize="klein") | ($stringSize="menor"))
		$fontsize:=8
	: (($stringSize="Medium") | ($stringSize="Medio") | ($stringSize="Moyen") | ($stringSize="Mittel") | ($stringSize="Media"))
		$fontsize:=9
	: (($stringSize="Large") | ($stringSize="Grande") | ($stringSize="Grand") | ($stringSize="Groß") | ($stringSize="Grande"))
		$fontsize:=14
	: (($stringSize="Largest") | ($stringSize="Muy Grande") | ($stringSize="Trés Grand") | ($stringSize="größten") | ($stringSize="Maior"))
		$fontsize:=18
	Else 
		$fontsize:=Num:C11($stringSize)
End case 
SR_SetObjectFontSize ($fontsize)

  //$err:=SR Set Object Format (SRArea;SRObjectID;SR Attribute Font Size;"";$fontsize;0;0;"";0;0;0;0;0;0;0;0;0;0;0)