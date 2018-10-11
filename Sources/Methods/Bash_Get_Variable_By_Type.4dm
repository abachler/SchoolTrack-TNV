//%attributes = {}
  //Bash_Get_Variable_By_Type

C_LONGINT:C283($type;$1)
C_POINTER:C301($0;$array;$procIDArray;$procNameArray)
C_TEXT:C284($name;$procName)
C_LONGINT:C283(procState;$procTime)
C_TEXT:C284($varName)
C_LONGINT:C283($tableNum;$fieldNum)
C_BOOLEAN:C305($found;$sem)

$type:=$1

Case of 
	: (($type=Is integer:K8:5) | ($type=Integer array:K8:18))
		$array:=Get pointer:C304("<>abBash_TrackIntegerVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4IntegerVar")
		$name:="<>viBash_DSS"
	: (($type=Is string var:K8:2) | ($type=Is alpha field:K8:1) | ($type=String array:K8:15))
		$array:=Get pointer:C304("<>abBash_TrackStringVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4StringVar")
		$name:="<>vsBash_DSS"
	: (($type=Is text:K8:3) | ($type=Text array:K8:16))
		$array:=Get pointer:C304("<>abBash_TrackTextVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4TextVar")
		$name:="<>vtBash_DSS"
	: (($type=Is real:K8:4) | ($type=Real array:K8:17))
		$array:=Get pointer:C304("<>abBash_TrackRealVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4RealVar")
		$name:="<>vrBash_DSS"
	: (($type=Is longint:K8:6) | ($type=LongInt array:K8:19))
		$array:=Get pointer:C304("<>abBash_TrackLongintVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4LongintVar")
		$name:="<>vlBash_DSS"
	: (($type=Is date:K8:7) | ($type=Date array:K8:20))
		$array:=Get pointer:C304("<>abBash_TrackDateVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4DateVar")
		$name:="<>vdBash_DSS"
	: (($type=Is boolean:K8:9) | ($type=Boolean array:K8:21))
		$array:=Get pointer:C304("<>abBash_TrackBooleanVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4BooleanVar")
		$name:="<>vbBash_DSS"
	: (($type=Is picture:K8:10) | ($type=Picture array:K8:22))
		$array:=Get pointer:C304("<>abBash_TrackPictureVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PictureVar")
		$name:="<>vpBash_DSS"
	: (($type=Is pointer:K8:14) | ($type=Pointer array:K8:23))
		$array:=Get pointer:C304("<>abBash_TrackPointerVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PointerVar")
		$name:="<>vptBash_DSS"
	: ($type=Is time:K8:8)
		$array:=Get pointer:C304("<>abBash_TrackTimeVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TimeVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4TimeVar")
		$name:="<>vtmBash_DSS"
	: ($type=Is BLOB:K8:12)
		$array:=Get pointer:C304("<>abBash_TrackBlobVar")
		$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BlobVar")
		$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4BlobVar")
		$name:="<>vxBash_DSS"
	Else 
		Bash_ERROR (-1;"Incorrect Type";Current method name:C684)
End case 
RESOLVE POINTER:C394($array;$varName;$tableNum;$fieldNum)
$found:=False:C215
If ($varName#"")
	While (Semaphore:C143("$Access2Variables"))
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
		Bash_ERROR (-3;"Variable Type Not Available";Current method name:C684)
	End if 
	CLEAR SEMAPHORE:C144("$Access2Variables")
End if 