//%attributes = {}
  //TBL_ShowChoiceList

  //MODIFICACIONES
  //03-03-2008 - RCH - Se agrega un quinto parámetro para permitir multiselección
C_POINTER:C301($object;$4)
C_BOOLEAN:C305(vb_AllowMultiLine)
vb_AllowMultiLine:=False:C215
hidecol:=$1
choiceidx:=0
Case of 
	: (Count parameters:C259=2)
		$title:=$2
		vi_sortCol:=1
	: (Count parameters:C259=3)
		If ($2#"")
			$title:=$2
		Else 
			$title:=__ ("Selección")
		End if 
		vi_sortCol:=$3
	: (Count parameters:C259=4)
		If ($2#"")
			$title:=$2
		Else 
			$title:=__ ("Selección")
		End if 
		vi_sortCol:=$3
		$object:=$4
	: (Count parameters:C259=5)
		If ($2#"")
			$title:=$2
		Else 
			$title:=__ ("Selección")
		End if 
		vi_sortCol:=$3
		$object:=$4
		vb_AllowMultiLine:=$5
	Else 
		$title:=__ ("Selección")
		vi_sortCol:=1
End case 
If (vi_sortCol=0)
	vi_sortCol:=1
End if 
WDW_OpenDialogInDrawer (->[xShell_Dialogs:114];"AreaChoices";$title;$object)