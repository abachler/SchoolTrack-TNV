Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_PICTURE:C286($pict)
		C_LONGINT:C283($f)
		ARRAY TEXT:C222(aModDisp;0)
		ARRAY TEXT:C222(aModTables;0)
		ARRAY LONGINT:C221(aModRefs;0)
		If ([xShell_Userfields:76]FieldID:7=0)
			[xShell_Userfields:76]FieldID:7:=SQ_SeqNumber (->[xShell_Userfields:76]FieldID:7)
			[xShell_Userfields:76]ModuleName:10:=vsBWR_CurrentModule
			OBJECT SET VISIBLE:C603(*;"nuevo@";True:C214)
			OBJECT SET VISIBLE:C603(*;"antiguo@";False:C215)
			AT_Initialize (-><>aUFvalues)
			BLOB_Variables2Blob (->[xShell_Userfields:76]xListOfValues:9;0;-><>aUFValues)
			<>aUFvalues:=0
			[xShell_Userfields:76]FileNo:6:=0
			sFileName:=""
			vtCP_FileName:=""
			<>aUFFileNm:=0
		Else 
			sFileName:=<>aUFFileNm{Find in array:C230(<>aUFFileNo;[xShell_Userfields:76]FileNo:6)}
			<>aUFFileNm:=Find in array:C230(<>aUFFileNo;[xShell_Userfields:76]FileNo:6)
			vField:="["+Table name:C256([xShell_Userfields:76]FileNo:6)+"]Userfields'Value"
			vtCP_FileName:=<>aUFFileNm{<>aUFFileNm}
			EXECUTE FORMULA:C63("vPointer:=»"+vField)
			$id:=String:C10([xShell_Userfields:76]FieldID:7;"00000/"+"@")
			SET QUERY DESTINATION:C396(Into variable:K19:4;$f)
			QUERY:C277(Table:C252([xShell_Userfields:76]FileNo:6)->;vPointer->=$id)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			  //$f:=Records in selection(Table([xShell_Userfields]FileNo)->)
			OBJECT SET VISIBLE:C603(*;"nuevo@";False:C215)
			OBJECT SET VISIBLE:C603(*;"antiguo@";True:C214)
			SYS_ModulesTableBelongTo (Table:C252([xShell_Userfields:76]FileNo:6))
			IT_SetButtonState ($f=0;->r1;->r2;->r3;->r4)
		End if 
		Case of 
			: ([xShell_Userfields:76]FieldType:2=0)
				r1:=1
			: ([xShell_Userfields:76]FieldType:2=9)
				r2:=1
			: ([xShell_Userfields:76]FieldType:2=1)
				r3:=1
			: ([xShell_Userfields:76]FieldType:2=4)
				r4:=1
		End case 
		sUFvalue:=""
		C_PICTURE:C286($pict)
		AT_Initialize (-><>aUFvalues)
		BLOB_Blob2Vars (->[xShell_Userfields:76]xListOfValues:9;0;-><>aUFValues)
		<>aUFvalues:=0
		ARRAY REAL:C219(<>aUFOcc;Size of array:C274(<>aUFValues))
		For ($i;1;Size of array:C274(<>aUFValues))
			$ItemV:=String:C10([xShell_Userfields:76]FieldID:7;"00000/")+<>aUFvalues{$i}
			SET QUERY DESTINATION:C396(Into variable:K19:4;$f)
			QUERY:C277(Table:C252([xShell_Userfields:76]FileNo:6)->;vPointer->=$itemV)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			  //$f:=Records in selection(Table([xShell_Userfields]FileNo)->)
			$t:=Records in table:C83(Table:C252([xShell_Userfields:76]FileNo:6)->)
			<>aUFOcc{$i}:=Round:C94($f/$t*100;2)
		End for 
		IT_SetButtonState (Size of array:C274(<>aUFvalues)>0;->bSortV;->bDelV)
		IT_SetButtonState (Old:C35([xShell_Userfields:76]FieldID:7)#0;->bDel)
		aModDisp:=Find in array:C230(aModDisp;[xShell_Userfields:76]ModuleName:10)
		aModRefs:=aModDisp
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		IT_SetButtonState (Size of array:C274(<>aUFvalues)>0;->bSortV)
End case 
