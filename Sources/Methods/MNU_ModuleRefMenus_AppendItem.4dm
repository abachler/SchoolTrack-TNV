//%attributes = {}
  //MNU_ModuleRefMenus_AppendItem




C_TEXT:C284($1;$menuRef)
C_TEXT:C284($2;$menuName)
C_TEXT:C284($3;$shortcutKey)
C_LONGINT:C283($4;$shortcutModifiers)
C_TEXT:C284($5;$itemProperty2Set)
C_LONGINT:C283($6;$itemPropertyValue2Set)
C_TEXT:C284($7;$method)
C_LONGINT:C283($8;$l_NewProcess)


If (Application version:C493>="11@")
	vb_Modificado_4Dv11:=True:C214
	
	$menuRef:=$1
	$menuTitle:=$2
	Case of 
		: (Count parameters:C259=8)
			$l_NewProcess:=$8
			$method:=$7
			$itemPropertyValue2Set:=$6
			$itemProperty2Set:=$5
			$shortcutModifiers:=$4
			$shortcutKey:=$3
		: (Count parameters:C259=7)
			$method:=$7
			$itemPropertyValue2Set:=$6
			$itemProperty2Set:=$5
			$shortcutModifiers:=$4
			$shortcutKey:=$3
		: (Count parameters:C259=6)
			$itemPropertyValue2Set:=$6
			$itemProperty2Set:=$5
			$shortcutModifiers:=$4
			$shortcutKey:=$3
		: (Count parameters:C259=5)
			$itemProperty2Set:=""
			$shortcutModifiers:=$4
			$shortcutKey:=$3
		: (Count parameters:C259=4)
			$shortcutModifiers:=$4
			$shortcutKey:=$3
		: (Count parameters:C259=3)
			$shortcutKey:=$3
	End case 
	
	If ($shortcutModifiers=0)
		$shortcutModifiers:=Command key mask:K16:1
	End if 
	
	If ($menuRef#"")
		APPEND MENU ITEM:C411($menuRef;$menuTitle)
		SET MENU ITEM SHORTCUT:C423($menuRef;-1;$shortcutKey;$shortcutModifiers)
		SET MENU ITEM PROPERTY:C973($menuRef;-1;$itemProperty2Set;$itemPropertyValue2Set)
		SET MENU ITEM METHOD:C982($menuRef;-1;$method)
		SET MENU ITEM PROPERTY:C973($menuRef;-1;Start a new process:K56:2;$l_NewProcess)
		
	End if 
Else 
	  //nada
End if 