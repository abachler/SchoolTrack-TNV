$text:=AT_array2text (vPtrBash_Tipos)
RESOLVE POINTER:C394(vPtrBash_Tipos;$name;$table;$field)
If ($name="atBash_TiposVariables")
	$suffix:="Var"
Else 
	$suffix:="Ar"
End if 
$choice:=Pop up menu:C542($text)
If ($choice>0)
	vtBash_Tipo:=vPtrBash_Tipos->{$choice}
	Case of 
		: (vPtrBash_Tipos->{$choice}="Text")
			$arrayName:="<>abBash_TrackText"
			$procName:="<>atBash_TrackLPN4Text"
			$procID:="<>alBash_TrackLP4Text"
			$name:="t"
		: (vPtrBash_Tipos->{$choice}="String")
			$arrayName:="<>abBash_TrackString"
			$procName:="<>atBash_TrackLPN4String"
			$procID:="<>alBash_TrackLP4String"
			$name:="s"
		: (vPtrBash_Tipos->{$choice}="Real")
			$arrayName:="<>abBash_TrackReal"
			$procName:="<>atBash_TrackLPN4Real"
			$procID:="<>alBash_TrackLP4Real"
			$name:="r"
		: (vPtrBash_Tipos->{$choice}="Longint")
			$arrayName:="<>abBash_TrackLongint"
			$procName:="<>atBash_TrackLPN4Longint"
			$procID:="<>alBash_TrackLP4Longint"
			$name:="l"
		: (vPtrBash_Tipos->{$choice}="Integer")
			$arrayName:="<>abBash_TrackInteger"
			$procName:="<>atBash_TrackLPN4Integer"
			$procID:="<>alBash_TrackLP4Integer"
			$name:="i"
		: (vPtrBash_Tipos->{$choice}="Date")
			$arrayName:="<>abBash_TrackDate"
			$procName:="<>atBash_TrackLPN4Date"
			$procID:="<>alBash_TrackLP4Date"
			$name:="d"
		: (vPtrBash_Tipos->{$choice}="Time")
			$arrayName:="<>abBash_TrackTime"
			$procName:="<>atBash_TrackLPN4Time"
			$procID:="<>alBash_TrackLP4Time"
			$name:="tm"
		: (vPtrBash_Tipos->{$choice}="Boolean")
			$arrayName:="<>abBash_TrackBoolean"
			$procName:="<>atBash_TrackLPN4Boolean"
			$procID:="<>alBash_TrackLP4Boolean"
			$name:="b"
		: (vPtrBash_Tipos->{$choice}="Picture")
			$arrayName:="<>abBash_TrackPicture"
			$procName:="<>atBash_TrackLPN4Picture"
			$procID:="<>alBash_TrackLP4Picture"
			$name:="p"
		: (vPtrBash_Tipos->{$choice}="Blob")
			$arrayName:="<>abBash_TrackBlob"
			$procName:="<>atBash_TrackLPN4Blob"
			$procID:="<>alBash_TrackLP4Blob"
			$name:="x"
		: (vPtrBash_Tipos->{$choice}="Pointer")
			$arrayName:="<>abBash_TrackPointer"
			$procName:="<>atBash_TrackLPN4Pointer"
			$procID:="<>alBash_TrackLP4Pointer"
			$name:="pt"
	End case 
	$arrayNamePtr:=Get pointer:C304($arrayName+$suffix)
	$procNamePtr:=Get pointer:C304($procName+$suffix)
	$procIDPtr:=Get pointer:C304($procID+$suffix)
	AL_UpdateArrays (xALP_BashVariables;0)
	$arrayNamePtr->{0}:=False:C215
	vlBash_Disponibles:=AT_SearchArray ($arrayNamePtr;"=")
	vlBash_Utilizadas:=Size of array:C274($arrayNamePtr->)-vlBash_Disponibles
	ARRAY TEXT:C222(aNames;0)
	ARRAY TEXT:C222(aNames;<>vlBash_SizeofPool)
	For ($i;1;<>vlBash_SizeofPool)
		If ($suffix="Ar")
			aNames{$i}:="<>a"+$name+"Bash_DSS"+String:C10($i)
		Else 
			aNames{$i}:="<>v"+$name+"Bash_DSS"+String:C10($i)
		End if 
	End for 
	ARRAY BOOLEAN:C223(aState;0)
	ARRAY BOOLEAN:C223(aState;<>vlBash_SizeofPool)
	ARRAY TEXT:C222(aProcess;0)
	ARRAY TEXT:C222(aProcess;<>vlBash_SizeofPool)
	ARRAY LONGINT:C221(aProcessID;0)
	ARRAY LONGINT:C221(aProcessID;<>vlBash_SizeofPool)
	COPY ARRAY:C226($arrayNamePtr->;aState)
	COPY ARRAY:C226($procNamePtr->;aProcess)
	COPY ARRAY:C226($procIDPtr->;aProcessID)
	AL_UpdateArrays (xALP_BashVariables;-2)
End if 