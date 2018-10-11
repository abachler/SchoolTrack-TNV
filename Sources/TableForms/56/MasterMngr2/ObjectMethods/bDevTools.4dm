C_TEXT:C284($vMenuRef)

RELEASE MENU:C978($vMenuRef)

$vMenuRef:=Create menu:C408

APPEND MENU ITEM:C411($vMenuRef;"Agregar grupo")
APPEND MENU ITEM:C411($vMenuRef;"-")
APPEND MENU ITEM:C411($vMenuRef;"Agregar ítem")
SET MENU ITEM PARAMETER:C1004($vMenuRef;1;"grupo")
SET MENU ITEM PARAMETER:C1004($vMenuRef;3;"item")

$choice:=Dynamic pop up menu:C1006($vMenuRef)
Case of 
	: ($choice="grupo")
		WDW_OpenFormWindow (->[xxSTR_TextosInformesNotas:56];"Input";0;4;__ ("Nuevo Grupo"))
		FORM SET INPUT:C55([xxSTR_TextosInformesNotas:56];"Input")
		ADD RECORD:C56([xxSTR_TextosInformesNotas:56];*)
		CLOSE WINDOW:C154
		If (ok=1)
			$id:=[xxSTR_TextosInformesNotas:56]ID:1
			READ ONLY:C145([xxSTR_TextosInformesNotas:56])
			ALL RECORDS:C47([xxSTR_TextosInformesNotas:56])
			SELECTION TO ARRAY:C260([xxSTR_TextosInformesNotas:56]ID:1;<>aPopRsrID;[xxSTR_TextosInformesNotas:56]Name:2;<>aPopRsr)
			For ($i;1;Size of array:C274(<>aPopRsr))
				<>aPopRsr{$i}:=String:C10(<>aPopRsrID{$i};"00000")+": "+<>aPopRsr{$i}
				SORT ARRAY:C229(<>aPopRsrID;<>aPopRsr)
				<>aLang:=1
				<>langPtr:=Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);<>aLang+2)
				<>aPopRsr:=Find in array:C230(<>aPopRsrId;$id)
			End for 
			UNLOAD RECORD:C212([xxSTR_TextosInformesNotas:56])
		End if 
	: ($choice="item")
		LISTBOX INSERT ROWS:C913(lb_Textos;Size of array:C274(<>aStrIndex)+1)
		<>aStrIndex{Size of array:C274(<>aStrIndex)}:=Size of array:C274(<>aStrIndex)
		LBX_EditItem_byColNum ("lb_Textos";2;Size of array:C274(<>aStrIndex))
End case 

RELEASE MENU:C978($vMenuRef)