//%attributes = {}
  //IT_OpenChoiceWindow

  //`xShell, Alberto Bachler
  //Metodo: IT_OpenChoiceWindow
  //Por abachler
  //Creada el 07/02/2004, 08:22:46
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($tablePointer)
C_BOOLEAN:C305($sort;$enterable)
C_LONGINT:C283(hl_ChoiceList;$style;$left;$top;$right;$bottom;$wLeft;$wTop;$wRight;$wBottom;$nLeft;$nTop;$nRight;$nBottom;$screenHeight;$screenHeight;$lines;$ref)
C_TEXT:C284($text)

  //****INICIALIZACIONES****
$sort:=True:C214
$enterable:=False:C215
$style:=0
If (Count parameters:C259=1)
	$tablePointer:=$1
End if 

  //****CUERPO****
hl_ChoiceList:=AT_Array2ReferencedList (->atXS_Choices;->alXS_ChoicesRef;hl_ChoiceList;$sort;$enterable;$style)
SET LIST PROPERTIES:C387(hl_ChoiceList;1;0;15)
SELECT LIST ITEMS BY POSITION:C381(hl_ChoiceList;0)
OBJECT GET COORDINATES:C663(vyXS_CallingVariable->;$left;$top;$right;$bottom)
GET WINDOW RECT:C443($wLeft;$wTop;$wRight;$wBottom)
If (($left=0) & ($right=0) & ($top=0) & ($bottom=0))
	$left:=(($wRight-$wLeft)/2)-75
	$top:=(($wBottom-$wTop)/2)-6
	$right:=$left+150
	$bottom:=$top+12
End if 

$nLeft:=$left+$wLeft
$nTop:=$bottom+6+$wTop
$nRight:=$nLeft+($right-$left)
$nBottom:=$nTop+(12*15)
$screenHeight:=Screen height:C188(*)
If ($nBottom>$screenHeight)
	$nBottom:=$screenHeight
	$lines:=Int:C8(($nBottom-$nTop)/15)
	$nBottom:=$nTop+($lines*15)
End if 
$nHeigth:=$nBottom-$nTop
$lines:=MATH_Min (16;Int:C8($nHeigth/15))
If (Count list items:C380(hl_ChoiceList)<$lines)
	$lines:=Count list items:C380(hl_ChoiceList)+1
	$nBottom:=$nTop+($lines*15)
End if 

$ref:=Open window:C153($nLeft;$nTop;$nRight;$nBottom;32)
WDW_SetWindowIcon ($ref)
DIALOG:C40([xShell_Dialogs:114];"ChoiceWindow")
CLOSE WINDOW:C154

If (OK=1)
	  //GET LIST ITEM(hl_ChoiceList;Selected list items(hl_ChoiceList);$ref;$text)
	If (Not:C34(Is nil pointer:C315($tablePointer)))
		READ ONLY:C145($tablePointer->)
		GOTO RECORD:C242($tablePointer->;vl_SelectedListItemRef)
	End if 
	$0:=vt_SelectedListItemText
Else 
	$0:=""
End if 

  //****LIMPIEZA****



