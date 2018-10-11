Case of 
	: (Form event:C388=On Load:K2:1)
		C_LONGINT:C283($l;$t;$r;$b;$wL;$wT;$wR;$wB;$width;$heigth)
		XS_SetInterface 
		OBJECT GET COORDINATES:C663(vt_Msg;$l;$t;$r;$b)
		OBJECT GET BEST SIZE:C717(vt_Msg;$width;$height;$r-$l+1)
		  //GET FORM PROPERTIES([xShell_Dialogs];"CD_ReportProblem")
		GET WINDOW RECT:C443($wL;$wT;$wR;$wB)
		$wBoffset:=$wB-$b
		$wHeight:=$wB-$wT+1
		$new_wB:=$wT+$t+$height+$wBoffset
		If ($new_wB>520)
			$new_wB:=520
			$height:=$new_wB-$wBoffset
		End if 
		If ($new_wB>$wB)
			SET WINDOW RECT:C444($wL;$wT;$wR;$new_wB)
			  //IT_SetObjectRect (->vt_Msg;$l;$t;$r;$t+$height)
		End if 
		
		$methodID:=0
		If (vt_RepairMethod#"")
			If (API Does Method Exist (vt_RepairMethod)=1)
				$methodID:=API Get Method ID (vt_RepairMethod)
			End if 
		End if 
		If (($methodID#0) | (vt_RepairMethod="*"))
			OBJECT SET VISIBLE:C603(*;"autorepair@";True:C214)
			OBJECT SET VISIBLE:C603(*;"texto1";False:C215)
			If (USR_IsGroupMember_by_GrpID (-15001))
				_O_ENABLE BUTTON:C192(bExecute)
			Else 
				_O_DISABLE BUTTON:C193(bExecute)
			End if 
		Else 
			OBJECT SET VISIBLE:C603(*;"autorepair@";False:C215)
			OBJECT SET VISIBLE:C603(*;"texto1";True:C214)
			_O_DISABLE BUTTON:C193(bExecute)
		End if 
		If (BLOB size:C605(vx_Blob)>0)
			_O_ENABLE BUTTON:C192(bViewReport)
			_O_ENABLE BUTTON:C192(bSaveReport)
		Else 
			_O_DISABLE BUTTON:C193(bViewReport)
			_O_DISABLE BUTTON:C193(bSaveReport)
		End if 
		
		vt_Text:=BLOB to text:C555(vx_Blob;Mac text without length:K22:10)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 