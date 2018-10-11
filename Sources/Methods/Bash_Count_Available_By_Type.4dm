//%attributes = {}
  //Bash_Count_Available_By_Type

C_POINTER:C301($array)
C_LONGINT:C283($1;$type;$0)
C_TEXT:C284($varName)
C_LONGINT:C283($tableNum;$fieldNum)
C_BOOLEAN:C305($sem1;$sem2)

$type:=$1
$0:=0
Case of 
	: ($type=Integer array:K8:18)
		$array:=Get pointer:C304("<>abBash_TrackIntegerAr")
	: ($type=String array:K8:15)
		$array:=Get pointer:C304("<>abBash_TrackStringAr")
	: ($type=Text array:K8:16)
		$array:=Get pointer:C304("<>abBash_TrackTextAr")
	: ($type=Real array:K8:17)
		$array:=Get pointer:C304("<>abBash_TrackRealAr")
	: ($type=LongInt array:K8:19)
		$array:=Get pointer:C304("<>abBash_TrackLongintAr")
	: ($type=Date array:K8:20)
		$array:=Get pointer:C304("<>abBash_TrackDateAr")
	: ($type=Boolean array:K8:21)
		$array:=Get pointer:C304("<>abBash_TrackBooleanAr")
	: ($type=Picture array:K8:22)
		$array:=Get pointer:C304("<>abBash_TrackPictureAr")
	: ($type=Pointer array:K8:23)
		$array:=Get pointer:C304("<>abBash_TrackPointerAr")
	: ($type=Is text:K8:3)
		$array:=Get pointer:C304("<>abBash_TrackTextVar")
	: ($type=Is real:K8:4)
		$array:=Get pointer:C304("<>abBash_TrackRealVar")
	: ($type=Is integer:K8:5)
		$array:=Get pointer:C304("<>abBash_TrackIntegerVar")
	: ($type=Is longint:K8:6)
		$array:=Get pointer:C304("<>abBash_TrackLongintVar")
	: ($type=Is date:K8:7)
		$array:=Get pointer:C304("<>abBash_TrackDateVar")
	: ($type=Is time:K8:8)
		$array:=Get pointer:C304("<>abBash_TrackTimeVar")
	: ($type=Is boolean:K8:9)
		$array:=Get pointer:C304("<>abBash_TrackBooleanVar")
	: ($type=Is picture:K8:10)
		$array:=Get pointer:C304("<>abBash_TrackPictureVar")
	: ($type=Is BLOB:K8:12)
		$array:=Get pointer:C304("<>abBash_TrackBlobVar")
	: ($type=Is pointer:K8:14)
		$array:=Get pointer:C304("<>abBash_TrackPointerVar")
	: ($type=Is string var:K8:2)
		$array:=Get pointer:C304("<>abBash_TrackStringVar")
	Else 
		Bash_ERROR (-1;"Incorrect Type";Current method name:C684)
End case 
RESOLVE POINTER:C394($array;$varName;$tableNum;$fieldNum)
If ($varName#"")
	While ((Semaphore:C143("$Access2Arrays")) | (Semaphore:C143("$Access2Variables")))
		IDLE:C311
		IDLE:C311
	End while 
	$array->{0}:=False:C215
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray ($array;"=";->$DA_Return)
	$0:=Size of array:C274($DA_Return)
	CLEAR SEMAPHORE:C144("$Access2Arrays")
	CLEAR SEMAPHORE:C144("$Access2Variables")
End if 