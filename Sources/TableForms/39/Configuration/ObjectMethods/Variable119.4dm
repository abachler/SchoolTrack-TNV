  // [xShell_List].Configuration.Variable119()
  // Por: Alberto Bachler: 05/03/13, 19:19:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($el;$i;$l_Registros;$l_totalRegistros)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_valorLiteral)

QUERY:C277([xShell_List_FieldRefs:236];[xShell_List_FieldRefs:236]ListName:4=[xShell_List:39]Listname:1)
_O_ARRAY STRING:C218(35;aInfos1;0)
ARRAY LONGINT:C221(aInfos2;0)
ARRAY LONGINT:C221(aInfos3;0)
ARRAY REAL:C219(aInfos4;0)
For ($i;1;Records in selection:C76([xShell_List_FieldRefs:236]))
	If (([xShell_List_FieldRefs:236]FileRef:1>0) & ([xShell_List_FieldRefs:236]FieldRef:2>0))
		$y_campo:=Field:C253([xShell_List_FieldRefs:236]FileRef:1;[xShell_List_FieldRefs:236]FieldRef:2)
		READ ONLY:C145(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->)
		$t_valorLiteral:=Substring:C12(sElements{aLines{1}};1;70)+"@"
		QUERY:C277(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->;$y_campo->=$t_valorLiteral)
		$l_Registros:=Records in selection:C76(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->)
		$l_totalRegistros:=Records in table:C83(Table:C252([xShell_List_FieldRefs:236]FileRef:1)->)
		$el:=Find in array:C230(aInfos1;XSvs_nombreTablaLocal_Numero ([xShell_List_FieldRefs:236]FileRef:1))
		If ($el<0)
			AT_Insert (0;1;->aInfos1;->aInfos2;->aInfos3;->aInfos4)
			aInfos1{Size of array:C274(aInfos1)}:=XSvs_nombreTablaLocal_Numero ([xShell_List_FieldRefs:236]FileRef:1)
			aInfos2{Size of array:C274(aInfos1)}:=$l_Registros
			aInfos3{Size of array:C274(aInfos1)}:=$l_totalRegistros
			aInfos4{Size of array:C274(aInfos1)}:=Round:C94((($l_Registros/$l_totalRegistros)*100);2)
		End if 
	End if 
	NEXT RECORD:C51([xShell_List_FieldRefs:236])
End for 
WDW_OpenFormWindow (->[xShell_List:39];"ElementInfo";7;Palette form window:K39:9;sElements{sElements})
DIALOG:C40([xShell_List:39];"ElementInfo")
CLOSE WINDOW:C154
AT_Initialize (->aInfos1;->aInfos2;->aInfos3;->aInfos4)

