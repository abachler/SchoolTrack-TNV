Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		SET TIMER:C645(<>vlBash_MonitorUpdate)
		rVariables:=1
		rArreglos:=0
		ARRAY TEXT:C222(atBash_TiposVariables;0)
		ARRAY TEXT:C222(atBash_TiposArreglos;0)
		ARRAY TEXT:C222(atBash_TiposVariables;11)
		ARRAY TEXT:C222(atBash_TiposArreglos;9)
		AT_Inc (0)
		atBash_TiposVariables{AT_Inc }:="Text"
		atBash_TiposVariables{AT_Inc }:="String"
		atBash_TiposVariables{AT_Inc }:="Real"
		atBash_TiposVariables{AT_Inc }:="Longint"
		atBash_TiposVariables{AT_Inc }:="Integer"
		atBash_TiposVariables{AT_Inc }:="Date"
		atBash_TiposVariables{AT_Inc }:="Time"
		atBash_TiposVariables{AT_Inc }:="Boolean"
		atBash_TiposVariables{AT_Inc }:="Picture"
		atBash_TiposVariables{AT_Inc }:="Blob"
		atBash_TiposVariables{AT_Inc }:="Pointer"
		AT_Inc (0)
		atBash_TiposArreglos{AT_Inc }:="Text"
		atBash_TiposArreglos{AT_Inc }:="String"
		atBash_TiposArreglos{AT_Inc }:="Real"
		atBash_TiposArreglos{AT_Inc }:="Longint"
		atBash_TiposArreglos{AT_Inc }:="Integer"
		atBash_TiposArreglos{AT_Inc }:="Date"
		atBash_TiposArreglos{AT_Inc }:="Boolean"
		atBash_TiposArreglos{AT_Inc }:="Picture"
		atBash_TiposArreglos{AT_Inc }:="Pointer"
		vPtrBash_Tipos:=->atBash_TiposVariables
		vtBash_Tipo:=atBash_TiposVariables{1}
		vlBash_Pool:=<>vlBash_SizeofPool
		<>abBash_TrackTextVar{0}:=False:C215
		vlBash_Disponibles:=AT_SearchArray (-><>abBash_TrackTextVar;"=")
		vlBash_Utilizadas:=Size of array:C274(<>abBash_TrackTextVar)-vlBash_Disponibles
		ARRAY TEXT:C222(aNames;0)
		ARRAY TEXT:C222(aNames;<>vlBash_SizeofPool)
		For ($i;1;<>vlBash_SizeofPool)
			aNames{$i}:="<>vtBash_DSS"+String:C10($i)
		End for 
		ARRAY BOOLEAN:C223(aState;0)
		ARRAY BOOLEAN:C223(aState;<>vlBash_SizeofPool)
		ARRAY TEXT:C222(aProcess;0)
		ARRAY TEXT:C222(aProcess;<>vlBash_SizeofPool)
		ARRAY LONGINT:C221(aProcessID;0)
		ARRAY LONGINT:C221(aProcessID;<>vlBash_SizeofPool)
		COPY ARRAY:C226(<>abBash_TrackTextAr;aState)
		COPY ARRAY:C226(<>atBash_TrackLPN4TextVar;aProcess)
		COPY ARRAY:C226(<>alBash_TrackLP4TextVar;aProcessID)
		
		ALP_DefaultColSettings (xALP_BashVariables;1;"aNames";"Variable";150)
		ALP_DefaultColSettings (xALP_BashVariables;2;"aState";"Estado";150;"Ocupada;Disponible")
		ALP_DefaultColSettings (xALP_BashVariables;3;"aProcess";"Proceso";255)
		ALP_DefaultColSettings (xALP_BashVariables;4;"aProcessID";"ID Proceso";90)
		
		ALP_SetDefaultAppareance (xALP_BashVariables;9;1;6;1;8)
		AL_SetColOpts (xALP_BashVariables;1;1;1;0;0)
		AL_SetRowOpts (xALP_BashVariables;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_BashVariables;0;1;1)
		AL_SetMiscOpts (xALP_BashVariables;0;0;"\\";0;1)
		AL_SetMainCalls (xALP_BashVariables;"";"")
		AL_SetCallbacks (xALP_BashVariables;"";"")
		AL_SetScroll (xALP_BashVariables;0;-3)
		AL_SetEntryOpts (xALP_BashVariables;3;0;0;0;0;<>tXS_RS_DecimalSeparator;1)
		AL_SetDrgOpts (xALP_BashVariables;0;30;0)
	: (Form event:C388=On Close Box:K2:21)
		AL_UpdateArrays (xALP_BashVariables;0)
		AT_Initialize (->aNames;->aState;->aProcess;->aProcessID)
		CANCEL:C270
	: (Form event:C388=On Timer:K2:25)
		$row:=AL_GetLine (xALP_BashVariables)
		AL_GetScroll (xALP_BashVariables;$vert;$hor)
		$text:=AT_array2text (vPtrBash_Tipos)
		RESOLVE POINTER:C394(vPtrBash_Tipos;$name;$table;$field)
		If ($name="atBash_TiposVariables")
			$suffix:="Var"
		Else 
			$suffix:="Ar"
		End if 
		Case of 
			: (vtBash_Tipo="Text")
				$arrayName:="<>abBash_TrackText"
				$procName:="<>atBash_TrackLPN4Text"
				$procID:="<>alBash_TrackLP4Text"
				$name:="t"
			: (vtBash_Tipo="String")
				$arrayName:="<>abBash_TrackString"
				$procName:="<>atBash_TrackLPN4String"
				$procID:="<>alBash_TrackLP4String"
				$name:="s"
			: (vtBash_Tipo="Real")
				$arrayName:="<>abBash_TrackReal"
				$procName:="<>atBash_TrackLPN4Real"
				$procID:="<>alBash_TrackLP4Real"
				$name:="r"
			: (vtBash_Tipo="Longint")
				$arrayName:="<>abBash_TrackLongint"
				$procName:="<>atBash_TrackLPN4Longint"
				$procID:="<>alBash_TrackLP4Longint"
				$name:="l"
			: (vtBash_Tipo="Integer")
				$arrayName:="<>abBash_TrackInteger"
				$procName:="<>atBash_TrackLPN4Integer"
				$procID:="<>alBash_TrackLP4Integer"
				$name:="i"
			: (vtBash_Tipo="Date")
				$arrayName:="<>abBash_TrackDate"
				$procName:="<>atBash_TrackLPN4Date"
				$procID:="<>alBash_TrackLP4Date"
				$name:="d"
			: (vtBash_Tipo="Time")
				$arrayName:="<>abBash_TrackTime"
				$procName:="<>atBash_TrackLPN4Time"
				$procID:="<>alBash_TrackLP4Time"
				$name:="tm"
			: (vtBash_Tipo="Boolean")
				$arrayName:="<>abBash_TrackBoolean"
				$procName:="<>atBash_TrackLPN4Boolean"
				$procID:="<>alBash_TrackLP4Boolean"
				$name:="b"
			: (vtBash_Tipo="Picture")
				$arrayName:="<>abBash_TrackPicture"
				$procName:="<>atBash_TrackLPN4Picture"
				$procID:="<>alBash_TrackLP4Picture"
				$name:="p"
			: (vtBash_Tipo="Blob")
				$arrayName:="<>abBash_TrackBlob"
				$procName:="<>atBash_TrackLPN4Blob"
				$procID:="<>alBash_TrackLP4Blob"
				$name:="x"
			: (vtBash_Tipo="Pointer")
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
		AL_SetLine (xALP_BashVariables;$row)
		AL_SetScroll (xALP_BashVariables;$vert;$hor)
End case 