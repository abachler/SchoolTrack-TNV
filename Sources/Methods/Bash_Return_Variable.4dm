//%attributes = {}
  //Bash_Return_Variable

C_POINTER:C301($1;$array;$procIDArray;$procNameArray)
C_TEXT:C284($varName)
C_LONGINT:C283($tableNum;$fieldNum)
C_LONGINT:C283($type)
C_BOOLEAN:C305($sem1;$sem2)

RESOLVE POINTER:C394($1;$varName;$tableNum;$fieldNum)

$numVar:=Num:C11($varName)
$type:=Type:C295($1->)
If (($numVar<=<>vlBash_SizeofPool) & ($numVar>0))
	Case of 
		: ($varName="<>viBash_DSS@")  //para resolver el problema de que type($integer)=is longint
			$array:=Get pointer:C304("<>abBash_TrackIntegerVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4IntegerVar")
			$1->:=0
		: ($type=Integer array:K8:18)
			$array:=Get pointer:C304("<>abBash_TrackIntegerAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4IntegerAr")
			AT_Initialize ($1)
		: ($type=String array:K8:15)
			$array:=Get pointer:C304("<>abBash_TrackStringAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4StringAr")
			AT_Initialize ($1)
		: ($type=Text array:K8:16)
			$array:=Get pointer:C304("<>abBash_TrackTextAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4TextAr")
			AT_Initialize ($1)
		: ($type=Real array:K8:17)
			$array:=Get pointer:C304("<>abBash_TrackRealAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4RealAr")
			AT_Initialize ($1)
		: ($type=LongInt array:K8:19)
			$array:=Get pointer:C304("<>abBash_TrackLongintAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4LongintAr")
			AT_Initialize ($1)
		: ($type=Date array:K8:20)
			$array:=Get pointer:C304("<>abBash_TrackDateAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateAr")
			$procNameArray:=Get pointer:C304("<>alBash_TrackLPN4DateAr")
			AT_Initialize ($1)
		: ($type=Boolean array:K8:21)
			$array:=Get pointer:C304("<>abBash_TrackBooleanAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4BooleanAr")
			AT_Initialize ($1)
		: ($type=Picture array:K8:22)
			$array:=Get pointer:C304("<>abBash_TrackPictureAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PictureAr")
			AT_Initialize ($1)
		: ($type=Pointer array:K8:23)
			$array:=Get pointer:C304("<>abBash_TrackPointerAr")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerAr")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PointerAr")
			AT_Initialize ($1)
			  //: ($type=Is Integer )
			  //$array:=Get pointer("<>abBash_TrackIntegerVar")
			  //$procIDArray:=Get pointer("<>alBash_TrackLP4IntegerVar")
			  //$procNameArray:=Get pointer("<>atBash_TrackLPN4IntegerVar")
			  //$1->:=0
		: ($type=Is string var:K8:2)
			$array:=Get pointer:C304("<>abBash_TrackStringVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4StringVar")
			$1->:=""
		: ($type=Is text:K8:3)
			$array:=Get pointer:C304("<>abBash_TrackTextVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4TextVar")
			$1->:=""
		: ($type=Is real:K8:4)
			$array:=Get pointer:C304("<>abBash_TrackRealVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4RealVar")
			$1->:=0
		: ($type=Is longint:K8:6)
			$array:=Get pointer:C304("<>abBash_TrackLongintVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4LongintVar")
			$1->:=0
		: ($type=Is date:K8:7)
			$array:=Get pointer:C304("<>abBash_TrackDateVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4DateVar")
			$1->:=!00-00-00!
		: ($type=Is boolean:K8:9)
			$array:=Get pointer:C304("<>abBash_TrackBooleanVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4BooleanVar")
			$1->:=False:C215
		: ($type=Is picture:K8:10)
			$array:=Get pointer:C304("<>abBash_TrackPictureVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PictureVar")
			$1->:=$1->*0
		: ($type=Is pointer:K8:14)
			$array:=Get pointer:C304("<>abBash_TrackPointerVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4PointerVar")
		: ($type=Is time:K8:8)
			$array:=Get pointer:C304("<>abBash_TrackTimeVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TimeVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4TimeVar")
			$1->:=?00:00:00?
		: ($type=Is BLOB:K8:12)
			$array:=Get pointer:C304("<>abBash_TrackBlobVar")
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BlobVar")
			$procNameArray:=Get pointer:C304("<>atBash_TrackLPN4BlobVar")
			SET BLOB SIZE:C606($1->;0)
		Else 
			Bash_ERROR (-1;"Incorrect Type";Current method name:C684)
	End case 
	RESOLVE POINTER:C394($array;$varName;$tableNum;$fieldNum)
	If ($varName#"")
		While ((Semaphore:C143("$Access2Arrays")) | (Semaphore:C143("$Access2Variables")))
			IDLE:C311
			IDLE:C311
		End while 
		$array->{$numVar}:=False:C215
		$procIDArray->{$numVar}:=0
		$procNameArray->{$numVar}:=""
		CLEAR SEMAPHORE:C144("$Access2Arrays")
		CLEAR SEMAPHORE:C144("$Access2Variables")
	End if 
Else 
	Bash_ERROR (-4;"Variable or Array Number Incorrect";Current method name:C684)
End if 