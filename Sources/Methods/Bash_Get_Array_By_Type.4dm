//%attributes = {}
  //Bash_Get_Array_By_Type

C_LONGINT:C283($type;$1)
C_POINTER:C301($0;$array;$procIDArray;$procNameArray)
C_TEXT:C284($name;$procName)
C_TEXT:C284($varName)
C_LONGINT:C283($tableNum;$fieldNum;$procState;$procTime)
C_BOOLEAN:C305($found;$sem)

$type:=$1

Case of 
	: (($type=Integer array:K8:18) | ($type=Is integer:K8:5))
		$array:=Get pointer:C304("<>abBash_TrackIntegerAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4IntegerAr")
		$name:="<>aiBash_DSS"
	: (($type=String array:K8:15) | ($type=Is string var:K8:2) | ($type=Is alpha field:K8:1))
		$array:=Get pointer:C304("<>abBash_TrackStringAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4StringAr")
		$name:="<>asBash_DSS"
	: (($type=Text array:K8:16) | ($type=Is text:K8:3))
		$array:=Get pointer:C304("<>abBash_TrackTextAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4TextAr")
		$name:="<>atBash_DSS"
	: (($type=Real array:K8:17) | ($type=Is real:K8:4))
		$array:=Get pointer:C304("<>abBash_TrackRealAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4RealAr")
		$name:="<>arBash_DSS"
	: (($type=LongInt array:K8:19) | ($type=Is longint:K8:6))
		$array:=Get pointer:C304("<>abBash_TrackLongintAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4LongintAr")
		$name:="<>alBash_DSS"
	: (($type=Date array:K8:20) | ($type=Is date:K8:7))
		$array:=Get pointer:C304("<>abBash_TrackDateAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4DateAr")
		$name:="<>adBash_DSS"
	: (($type=Boolean array:K8:21) | ($type=Is boolean:K8:9))
		$array:=Get pointer:C304("<>abBash_TrackBooleanAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4BooleanAr")
		$name:="<>abBash_DSS"
	: (($type=Picture array:K8:22) | ($type=Is picture:K8:10))
		$array:=Get pointer:C304("<>abBash_TrackPictureAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PictureAr")
		$name:="<>apBash_DSS"
	: (($type=Pointer array:K8:23) | ($type=Is pointer:K8:14))
		$array:=Get pointer:C304("<>abBash_TrackPointerAr")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerAr")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PointerAr")
		$name:="<>aptBash_DSS"
	Else 
		Bash_ERROR (-1;"Incorrect Type";Current method name:C684)
End case 
RESOLVE POINTER:C394($array;$varName;$tableNum;$fieldNum)
$found:=False:C215
If ($varName#"")
	While (Semaphore:C143("$Access2Arrays"))
		IDLE:C311
		IDLE:C311
	End while 
	For ($i;1;<>vlBash_SizeofPool)
		If ($array->{$i}=False:C215)
			$0:=Get pointer:C304($name+String:C10($i))
			$array->{$i}:=True:C214
			$procIDArray->{$i}:=Current process:C322
			PROCESS PROPERTIES:C336(Current process:C322;$procName;procState;$procTime)
			$procNameArray->{$i}:=$procName
			$i:=<>vlBash_SizeofPool+1
			$found:=True:C214
		End if 
	End for 
	If (Not:C34($found))
		Bash_ERROR (-2;"Array Type Not Available";Current method name:C684)
	End if 
	CLEAR SEMAPHORE:C144("$Access2Arrays")
End if 