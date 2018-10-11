//%attributes = {}
  //Bash_Count_Locked_By_Type

C_POINTER:C301($array;$procIDArray)
C_LONGINT:C283($1;$type;$0;$2;$procID;$locked)
C_TEXT:C284($varName)
C_LONGINT:C283($tableNum;$fieldNum)
C_BOOLEAN:C305($sem1;$sem2)

$type:=$1
If (Count parameters:C259=2)
	$procID:=$2
Else 
	$procID:=0
End if 
$0:=0
Case of 
	: ($type=Integer array:K8:18)
		$array:=Get pointer:C304("<>abBash_TrackIntegerAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerAr")
	: ($type=String array:K8:15)
		$array:=Get pointer:C304("<>abBash_TrackStringAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringAr")
	: ($type=Text array:K8:16)
		$array:=Get pointer:C304("<>abBash_TrackTextAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextAr")
	: ($type=Real array:K8:17)
		$array:=Get pointer:C304("<>abBash_TrackRealAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealAr")
	: ($type=LongInt array:K8:19)
		$array:=Get pointer:C304("<>abBash_TrackLongintAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintAr")
	: ($type=Date array:K8:20)
		$array:=Get pointer:C304("<>abBash_TrackDateAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateAr")
	: ($type=Boolean array:K8:21)
		$array:=Get pointer:C304("<>abBash_TrackBooleanAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanAr")
	: ($type=Picture array:K8:22)
		$array:=Get pointer:C304("<>abBash_TrackPictureAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureAr")
	: ($type=Pointer array:K8:23)
		$array:=Get pointer:C304("<>abBash_TrackPointerAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerAr")
	: ($type=Is text:K8:3)
		$array:=Get pointer:C304("<>abBash_TrackTextVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextVar")
	: ($type=Is real:K8:4)
		$array:=Get pointer:C304("<>abBash_TrackRealVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealVar")
	: ($type=Is integer:K8:5)
		$array:=Get pointer:C304("<>abBash_TrackIntegerVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerVar")
	: ($type=Is longint:K8:6)
		$array:=Get pointer:C304("<>abBash_TrackLongintVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintVar")
	: ($type=Is date:K8:7)
		$array:=Get pointer:C304("<>abBash_TrackDateVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateVar")
	: ($type=Is time:K8:8)
		$array:=Get pointer:C304("<>abBash_TrackTimeVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TimeVar")
	: ($type=Is boolean:K8:9)
		$array:=Get pointer:C304("<>abBash_TrackBooleanVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanVar")
	: ($type=Is picture:K8:10)
		$array:=Get pointer:C304("<>abBash_TrackPictureVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureVar")
	: ($type=Is BLOB:K8:12)
		$array:=Get pointer:C304("<>abBash_TrackBlobVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BlobVar")
	: ($type=Is pointer:K8:14)
		$array:=Get pointer:C304("<>abBash_TrackPointerVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerVar")
	: ($type=Is string var:K8:2)
		$array:=Get pointer:C304("<>abBash_TrackStringVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringVar")
	Else 
		Bash_ERROR (-1;"Incorrect Type";Current method name:C684)
End case 
RESOLVE POINTER:C394($array;$varName;$tableNum;$fieldNum)
If ($varName#"")
	While ((Semaphore:C143("$Access2Arrays")) | (Semaphore:C143("$Access2Variables")))
		IDLE:C311
		IDLE:C311
	End while 
	$array->{0}:=True:C214
	ARRAY LONGINT:C221(alBash_Results;0)
	AT_SearchArray ($array;"=";->alBash_Results)
	If ($procID=0)
		$0:=Size of array:C274(alBash_Results)
	Else 
		$locked:=0
		For ($i;1;Size of array:C274(alBash_Results))
			If ($procIDArray->{alBash_Results{$i}}=$procID)
				$locked:=$locked+1
			End if 
		End for 
		$0:=$locked
	End if 
	AT_Initialize (->alBash_Results)
	CLEAR SEMAPHORE:C144("$Access2Arrays")
	CLEAR SEMAPHORE:C144("$Access2Variables")
End if 