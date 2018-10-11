C_BOOLEAN:C305($enterable)
C_LONGINT:C283($styles)
ARRAY TEXT:C222(atBWR_HeadersList;0)
ARRAY LONGINT:C221(alBWR_HeadersRefs;0)
$err:=AL_GetHeaders (xALP_HSubjects;atBWR_HeadersList;1)
ARRAY LONGINT:C221(alBWR_HeadersRefs;Size of array:C274(atBWR_HeadersList))
For ($i;1;Size of array:C274(atBWR_HeadersList))
	atBWR_HeadersList{$i}:=Replace string:C233(atBWR_HeadersList{$i};"\r"\
		;" "\
		)
	alBWR_HeadersRefs{$i}:=$i
End for 
AL_GetSort (xALP_HSubjects;c1;c2;c3;c4;c5;c6;c7;c8;c9;c10;c11;c12)
hl_OrderDefinition:=New list:C375
For ($i;1;12)
	$var:=Get pointer:C304("c"\
		+String:C10($i))
	If ($var->#0)
		APPEND TO LIST:C376(hl_OrderDefinition;atBWR_HeadersList{Abs:C99($var->)};alBWR_HeadersRefs{Abs:C99($var->)})
		If ($var->>0)
			$icon:=23087+Use PicRef:K28:4
		Else 
			$icon:=23086+Use PicRef:K28:4
		End if 
		SET LIST ITEM PROPERTIES:C386(hl_OrderDefinition;alBWR_HeadersRefs{Abs:C99($var->)};False:C215;Plain:K14:1;$icon)
	Else 
		$i:=13
	End if 
End for 
_O_REDRAW LIST:C382(hl_OrderDefinition)
hl_Columns:=New list:C375
hl_Columns:=AT_Array2ReferencedList (->atBWR_HeadersList;->alBWR_HeadersRefs;hl_Columns)
WDW_OpenFormWindow (->[xShell_Dialogs:114];"OrderBy";-1;8;__ ("Ordenamientos"))
DIALOG:C40([xShell_Dialogs:114];"OrderBy"\
)
CLOSE WINDOW:C154
If (OK=1)
	If (Count list items:C380(hl_OrderDefinition)>0)
		ARRAY LONGINT:C221($aOrderCols;0)
		ARRAY LONGINT:C221($aOrderDirs;0)
		ARRAY LONGINT:C221($aOrderParameter;0)
		$SortStr:="AL_SetSort(xALP_HSubjects;"
		For ($i;1;Count list items:C380(hl_OrderDefinition))
			GET LIST ITEM:C378(hl_OrderDefinition;$i;$itemRef;$itemText)
			GET LIST ITEM PROPERTIES:C631(hl_OrderDefinition;$itemRef;$enterable;$styles;$icon)
			INSERT IN ARRAY:C227($aOrderCols;Size of array:C274($aOrderCols)+1;1)
			INSERT IN ARRAY:C227($aOrderDirs;Size of array:C274($aOrderDirs)+1;1)
			INSERT IN ARRAY:C227($aOrderParameter;Size of array:C274($aOrderParameter)+1;1)
			$aOrderCols{$i}:=$itemRef
			If ($icon=(23086+Use PicRef:K28:4))
				$aOrderDirs{$i}:=-1
			Else 
				$aOrderDirs{$i}:=1
			End if 
			$aOrderParameter{$i}:=$aOrderCols{$i}*$aOrderDirs{$i}
			$SortStr:=$SortStr+String:C10($aOrderParameter{$i})+";"\
				
		End for 
	End if 
	$SortStr:=Substring:C12($SortStr;1;Length:C16($SortStr)-1)+")"\
		
	EXECUTE FORMULA:C63($SortStr)
	  //PREF_Set (USR_GetUserID ;"OrdenamientoPanel#"+String(vlBWR_SelectedTableRef);$SortStr)
	AT_Initialize (->atBWR_HeadersList;->alBWR_HeadersRefs)
	HL_ClearList (hl_Columns;hl_OrderDefinition)
End if 
