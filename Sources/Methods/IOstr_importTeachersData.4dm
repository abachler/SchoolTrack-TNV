//%attributes = {}
  //IOstr_importTeachersData

ON ERR CALL:C155("ERR_GenericOnError")
If (Count parameters:C259=1)
	$document:=$1
	READ WRITE:C146([Profesores:4])
	CREATE EMPTY SET:C140([Profesores:4];"Importación")
	
	vi_newTeachers:=0
	$ref:=Append document:C265($document)
	SEND PACKET:C103($ref;"\r")
	CLOSE DOCUMENT:C267($ref)
	
	vH_logRef:=Create document:C266("Importación de profesores.log")
	$logText:="Importación de profesores iniciada el: "+String:C10(Current date:C33(*))+"a las "+String:C10(Current time:C178;2)+" por"+<>tUSR_CurrentUser+"\r"
	$logText:=$logText+"Base de datos: "+SYS_GetServerProperty (XS_DataFileFolder)+SYS_GetServerProperty (XS_DataFileName)+"\r\r"
	SEND PACKET:C103(vH_logRef;$logText)
	
	
	$ref:=Open document:C264($document)
	If (OK=1)
		$size:=SYS_GetFileSize ($document)
		$length:=0
		RECEIVE PACKET:C104($ref;$Header;"\r")
		AT_Text2Array (->aRecordLine;$header;"\t")
		$arrayElements:=Size of array:C274(aRecordLine)
		RECEIVE PACKET:C104($ref;$text;"\r")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando Registros... "))
		While (OK=1)
			$length:=$length+Length:C16($text)+1
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$length/$size;__ ("Importando Registros... "))
			If ($text#"")
				ARRAY TEXT:C222(aRecordLine;0)
				AT_Text2Array (->aRecordLine;$text;"\t")
				ARRAY TEXT:C222(aRecordLine;$arrayElements)
				For ($i;1;$arrayElements)
					aRecordLine{$i}:=ST_GetCleanString (aRecordLine{$i})
				End for 
				vl_teachersRecNum:=-1
				IOstr_ProcessTeacherRecord 
			Else 
				OK:=0
			End if 
			RECEIVE PACKET:C104($ref;$text;"\r")
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		$logText:="Importación de profesores terminada el: "+String:C10(Current date:C33(*))+"a las "+String:C10(Current time:C178;2)+"\r\r"
		$logText:=$logText+"Fueron creados: "+"\r"
		$logText:=$logText+String:C10(vi_newTeachers)+" profesores"+"\r"
		SEND PACKET:C103(vH_logRef;ST_ConvertText ($logText))
		CLOSE DOCUMENT:C267(vH_logRef)
	Else 
		$logText:="Importación de profesores abortada."+"\r\r"
		SEND PACKET:C103(vH_logRef;ST_ConvertText ($logText))
		CLOSE DOCUMENT:C267(vH_logRef)
	End if 
	
	UNLOAD RECORD:C212([Profesores:4])
	READ ONLY:C145([Profesores:4])
	SQ_SetSequences 
	CU_LoadArrays 
	CLOSE DOCUMENT:C267($ref)
	
End if 