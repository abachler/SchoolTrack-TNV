//%attributes = {}


C_LONGINT:C283($0)
C_LONGINT:C283($1;$groupID)
C_TEXT:C284($2;$name)
C_POINTER:C301($3;$data)


$groupID:=$1
$name:=$2
$data:=$3

$0:=0
$appSpecificDataBlob:=KRL_GetBlobFieldData (->[xShell_UserGroups:17]IDGroup:1;->$groupID;->[xShell_UserGroups:17]xApp_SpecificData:10)
If (BLOB size:C605($appSpecificDataBlob)>32)
	$ot:=OT BLOBToObject ($appSpecificDataBlob)
	If ($ot#0)
		Case of 
			: (Type:C295($data->)=Boolean array:K8:21)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=Date array:K8:20)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=LongInt array:K8:19)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=Real array:K8:17)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=String array:K8:15)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=Text array:K8:16)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=Pointer array:K8:23)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=Picture array:K8:22)
				OT GetArray ($ot;$name;$data->)
			: (Type:C295($data->)=Is BLOB:K8:12)
				OT GetBLOB ($ot;$name;$data->)
			: (Type:C295($data->)=Is boolean:K8:9)
				$data->:=OT_GetBoolean ($ot;$name)
			: (Type:C295($data->)=Is date:K8:7)
				$data->:=OT GetDate ($ot;$name)
			: (Type:C295($data->)=Is longint:K8:6)
				$data->:=OT GetLong ($ot;$name)
			: (Type:C295($data->)=Is real:K8:4)
				$data->:=OT GetReal ($ot;$name)
			: (Type:C295($data->)=Is string var:K8:2)
				$data->:=OT GetString ($ot;$name)
			: (Type:C295($data->)=Is text:K8:3)
				$data->:=OT GetText ($ot;$name)
			: (Type:C295($data->)=Is pointer:K8:14)
				OT GetPointer ($ot;$name;$data)
			: (Type:C295($data->)=Is picture:K8:10)
				$data->:=OT GetPicture ($ot;$name)
			Else 
				ALERT:C41("Incompatible type!!!")
				$0:=-1
		End case 
		OT Clear ($ot)
	End if 
End if 