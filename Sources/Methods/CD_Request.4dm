//%attributes = {}
  //CD_Request



C_TEXT:C284($0;$1;$2;$3;$4;cdT_Msg;cdT_HelpTxt;cdS_btn1;cdS_btn2;cdS_btn3;vt_UserEntry)
C_BOOLEAN:C305(vb_password)
cdT_Msg:=""
cdS_btn1:=""
cdS_btn2:=""
cdS_btn3:=""
vt_UserEntry:=""
vb_password:=False:C215
OK:=1
If ((<>vb_MsgON) & (Application type:C494#4D Server:K5:6))
	cdT_Msg:=$1
	cdS_btn1:=$2
	cdS_btn2:=$3
	If (Count parameters:C259>=4)
		cdS_btn3:=$4
	End if 
	  //If (Count parameters=5)
	If (Count parameters:C259>=5)
		vt_UserEntry:=$5
	Else 
		vt_UserEntry:=""
	End if 
	If (Count parameters:C259>=6)
		vb_password:=$6
	End if 
	$layout:="cd_Request"
	
	WDW_OpenDialogInDrawer (->[xShell_Dialogs:114];"cd_Request")
	If (OK=1)
		If (vt_UserEntry#"")
			$0:=vt_UserEntry
		Else 
			OK:=0
		End if 
	Else 
		vt_UserEntry:=""
	End if 
	
	$0:=vt_UserEntry
End if 