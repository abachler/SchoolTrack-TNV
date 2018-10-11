//%attributes = {}


C_LONGINT:C283($0)
C_LONGINT:C283($1;$groupID)
C_TEXT:C284($2;$name)
C_POINTER:C301($3;$data)
C_BOOLEAN:C305($popGroup)
C_BOOLEAN:C305($4;$save)
C_BLOB:C604($blob)

$groupID:=$1
$name:=$2
$data:=$3
If (Count parameters:C259=4)
	$save:=$4
End if 

$readWriteMode:=Read only state:C362([xShell_UserGroups:17])
If (Record number:C243([xShell_UserGroups:17])>-1)
	If ([xShell_UserGroups:17]IDGroup:1#$groupID)
		PUSH RECORD:C176([xShell_UserGroups:17])
		$popGroup:=True:C214
	End if 
End if 
  //$rn:=KRL_FindAndLoadRecordByIndex (->[xShell_UserGroups]IDGroup;->$groupID;True)
$rn:=Record number:C243([xShell_UserGroups:17])
If ($rn#-1)
	$ot:=OT BLOBToObject ([xShell_UserGroups:17]xApp_SpecificData:10)
	If ($ot=0)
		$ot:=OT New 
	End if 
	Case of 
		: (Type:C295($data->)=Boolean array:K8:21)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=Date array:K8:20)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=LongInt array:K8:19)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=Real array:K8:17)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=String array:K8:15)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=Text array:K8:16)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=Pointer array:K8:23)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=Picture array:K8:22)
			OT PutArray ($ot;$name;$data->)
		: (Type:C295($data->)=Is BLOB:K8:12)
			OT PutBLOB ($ot;$name;$data->)
		: (Type:C295($data->)=Is boolean:K8:9)
			OT_PutBoolean ($ot;$name;$data->)
		: (Type:C295($data->)=Is date:K8:7)
			OT PutDate ($ot;$name;$data->)
		: (Type:C295($data->)=Is longint:K8:6)
			OT PutLong ($ot;$name;$data->)
		: (Type:C295($data->)=Is real:K8:4)
			OT PutReal ($ot;$name;$data->)
		: (Type:C295($data->)=Is string var:K8:2)
			OT PutString ($ot;$name;$data->)
		: (Type:C295($data->)=Is text:K8:3)
			OT PutText ($ot;$name;$data->)
		: (Type:C295($data->)=Is pointer:K8:14)
			OT PutPointer ($ot;$name;$data->)
		: (Type:C295($data->)=Is picture:K8:10)
			OT PutPicture ($ot;$name;$data->)
		Else 
			ALERT:C41("Incompatible type!!!")
			$0:=-2
	End case 
	OT ObjectToBLOB ($ot;$blob)
	[xShell_UserGroups:17]xApp_SpecificData:10:=$blob
	OT Clear ($ot)
	If ($save)
		SAVE RECORD:C53([xShell_UserGroups:17])
	End if 
Else 
	$0:=-1
End if 
If ($popGroup)
	POP RECORD:C177([xShell_UserGroups:17])
	ONE RECORD SELECT:C189([xShell_UserGroups:17])
End if 