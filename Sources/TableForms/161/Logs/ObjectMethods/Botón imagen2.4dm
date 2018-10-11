$ref:=Create document:C266("")
If (ok=1)
	If (r_ST=1)
		IO_SendPacket ($ref;__ ("Registro de Actividades SchoolNet, lado SchoolTrack")+"\r\r")
	Else 
		IO_SendPacket ($ref;__ ("Registro de Actividades SchoolNet, lado SchoolNet")+"\r\r")
	End if 
	IO_SendPacket ($ref;vt_Log_Msg+"\r\r")
	$headers:=__ ("Fecha")+"\t"+__ ("Hora")+"\t"+__ ("Tipo")+"\t"+__ ("Evento")
	If (r_ST=1)
		If (Find in array:C230(SN3_Log_Tipo;SN3_Log_Error)>-1)
			$headers:=$headers+"\t"+__ ("Descripción Error")+"\t"+__ ("Máquina")
		End if 
	End if 
	$headers:=$headers+"\r"
	IO_SendPacket ($ref;$headers)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Grabando entradas del registro al archivo..."))
	For ($i;1;Size of array:C274(SN3_Log_Fecha))
		$line:=String:C10(SN3_Log_Fecha{$i};Internal date short:K1:7)+"\t"+String:C10(Time:C179(Time string:C180(SN3_Log_Hora{$i}));HH MM:K7:2)+"\t"
		Case of 
			: (SN3_Log_Tipo{$i}=SN3_Log_Error)
				$line:=$line+__ ("Error")+"\t"
			: (SN3_Log_Tipo{$i}=SN3_Log_FileGeneration)
				$line:=$line+ST_Boolean2Str ((r_ST=1);__ ("Generación de Archivos");__ ("Proceso de Archivo"))+"\t"
			: (SN3_Log_Tipo{$i}=SN3_Log_FileSent)
				$line:=$line+ST_Boolean2Str ((r_ST=1);__ ("Envío de Archivos");__ ("Recepción de Archivos"))+"\t"
			: (SN3_Log_Tipo{$i}=SN3_Log_Info)
				$line:=$line+__ ("Información")+"\t"
		End case 
		$line:=$line+SN3_Log_Descripcion{$i}
		If (r_ST=1)
			If (SN3_Log_Tipo{$i}=SN3_Log_Error)
				$line:=$line+"\t"+SN3_Log_DescError{$i}+"\t"+SN3_Log_Maquina{$i}
			End if 
		End if 
		$line:=$line+"\r"
		IO_SendPacket ($ref;$line)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(SN3_Log_Fecha))
	End for 
	$footer:="\r"+__ ("Archivo generado el ")+String:C10(Current date:C33(*);Internal date short:K1:7)+__ (" a las ")+String:C10(Current time:C178(*);HH MM:K7:2)+__ (" por ")+USR_GetUserName (USR_GetUserID )
	IO_SendPacket ($ref;$footer)
	CLOSE DOCUMENT:C267($ref)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	$r:=CD_Dlog (0;__ ("Archivo generado con exito.\rEstá guardado en ")+document;__ ("");__ ("Aceptar");__ ("Mostrar"))
	If ($r=2)
		SHOW ON DISK:C922(document)
	End if 
End if 