//%attributes = {}
  //UFLD_LoadArrays

C_LONGINT:C283($i;$vl_id)

  //ALL RECORDS([xShell_Userfields])
QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]ModuleName:10=vsBWR_CurrentModule)
READ ONLY:C145([xShell_Userfields:76])
SELECTION TO ARRAY:C260([xShell_Userfields:76]UserFieldName:1;aUFname;[xShell_Userfields:76]FieldID:7;aUFid;[xShell_Userfields:76]FileNo:6;aUFFileNo)
_O_ARRAY STRING:C218(35;aUFFile;Size of array:C274(aUFId))
For ($i;1;Size of array:C274(aUfFile))
	  //aUFfile{$i}:=<>aUFFileNm{Find in array(<>aUFFileNo;aUFFileNo{$i})}
	$vl_id:=Find in array:C230(<>aUFFileNo;aUFFileNo{$i})
	If ($vl_id#-1)
		aUFfile{$i}:=<>aUFFileNm{$vl_id}
	Else 
		aUFfile{$i}:=""
	End if 
End for 