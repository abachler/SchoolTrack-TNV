//%attributes = {}
  //Bash_Get_Locking_ProcessID

C_POINTER:C301($1;$procIDArray)
C_TEXT:C284($varName)
C_LONGINT:C283($tableNum;$fieldNum)
C_LONGINT:C283($type;$0)
C_BOOLEAN:C305($sem1;$sem2)

RESOLVE POINTER:C394($1;$varName;$tableNum;$fieldNum)
$0:=0
$numVar:=Num:C11($varName)
$type:=Type:C295($1->)
If (($numVar<=<>vlBash_SizeofPool) & ($numVar>0))
	Case of 
		: ($type=Integer array:K8:18)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerAr")
		: ($type=String array:K8:15)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringAr")
		: ($type=Text array:K8:16)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextAr")
		: ($type=Real array:K8:17)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealAr")
		: ($type=LongInt array:K8:19)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintAr")
		: ($type=Date array:K8:20)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateAr")
		: ($type=Boolean array:K8:21)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanAr")
		: ($type=Picture array:K8:22)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureAr")
		: ($type=Pointer array:K8:23)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerAr")
		: ($type=Is integer:K8:5)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4IntegerVar")
		: ($type=Is string var:K8:2)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4StringVar")
		: ($type=Is text:K8:3)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4TextVar")
		: ($type=Is real:K8:4)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4RealVar")
		: ($type=Is longint:K8:6)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4LongintVar")
		: ($type=Is date:K8:7)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4DateVar")
		: ($type=Is boolean:K8:9)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4BooleanVar")
		: ($type=Is picture:K8:10)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PictureVar")
		: ($type=Is pointer:K8:14)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerVar")
		: ($type=Is time:K8:8)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerVar")
		: ($type=Is BLOB:K8:12)
			$procIDArray:=Get pointer:C304("<>alBash_TrackLP4PointerVar")
		Else 
			Bash_ERROR (-1;"Incorrect Type";Current method name:C684)
	End case 
	RESOLVE POINTER:C394($array;$varName;$tableNum;$fieldNum)
	If ($varName#"")
		While ((Semaphore:C143("$Access2Arrays")) | (Semaphore:C143("$Access2Variables")))
			IDLE:C311
			IDLE:C311
		End while 
		$0:=$procIDArray->{$numVar}
		CLEAR SEMAPHORE:C144("$Access2Arrays")
		CLEAR SEMAPHORE:C144("$Access2Variables")
	End if 
Else 
	Bash_ERROR (-4;"Variable or Array Number Incorrect";Current method name:C684)
End if 