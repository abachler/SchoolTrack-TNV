//%attributes = {}
  // SYS_CopyFileFromServer()
  // Por: Alberto Bachler K.: 02-11-14, 10:30:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)
C_BOOLEAN:C305($3)

C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_mostrarMensaje)
C_LONGINT:C283($l_idProceso;$l_Mbps;$l_MbReceived;$l_megaBytes;$l_ProcessID;$l_segundos;$l_started;$l_UserChoice)
C_TIME:C306($h_docRef)
C_TEXT:C284($t_carpetaDestino;$t_destino;$t_mensaje;$t_nombreDocumento;$t_rutaDestino;$t_rutaDocumento;$t_status)
C_REAL:C285($r_bytes;$r_bytesRecibidos)

If (False:C215)
	C_TEXT:C284(SYS_CopyFileFromServer ;$1)
	C_TEXT:C284(SYS_CopyFileFromServer ;$2)
	C_BOOLEAN:C305(SYS_CopyFileFromServer ;$3)
End if 


$t_rutaDocumento:=$1
$t_rutaDestino:=$2
$b_mostrarMensaje:=True:C214
If (Count parameters:C259=3)
	$b_mostrarMensaje:=$3
End if 


$t_nombreDocumento:=SYS_Path2FileName ($t_rutaDocumento)
$t_carpetaDestino:=SYS_GetParentNme ($t_rutaDestino)


$r_bytes:=SYS_GetServerDocumentSize ($t_rutaDocumento;True:C214)
$l_megaBytes:=Round:C94($r_bytes/1024/1024;0)
$r_bytesRecibidos:=0


  // CODIGO PRINCIPAL
error:=0
ON ERR CALL:C155("SYS_GncOnErr")
If (Test path name:C476($t_rutaDestino)=Is a document:K24:1)
	$l_UserChoice:=CD_Dlog (0;"Ya existe un documento con el mismo nombre.\r\r¿Desea usted reemplazarlo?";"";"No";"Reemplazar")
	If ($l_UserChoice=2)
		DELETE DOCUMENT:C159($t_rutaDestino)
	End if 
Else 
	$l_UserChoice:=2
End if 


If ($l_megaBytes>5)
	If (($l_UserChoice=2) & (error=0))
		$l_idProceso:=IT_Progress (1;0;0;__ ("Copiando..."))
		$h_docRef:=Create document:C266($t_rutaDestino)
		$l_started:=Milliseconds:C459
		Repeat 
			If (error#0)
				$r_bytesRecibidos:=$r_bytes
				$h_docRef:=?00:00:00?
				CLOSE DOCUMENT:C267($h_docRef)
				DELETE DOCUMENT:C159(document)
			Else 
				$t_mensaje:=__ ("Copiando ^0 a  ^1")
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreDocumento)
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_destino)
				$x_Blob:=KRL_GetFileChunk_FromServer ($t_rutaDocumento;$r_bytesRecibidos;True:C214)
				If (BLOB size:C605($x_Blob)=0)
					CLOSE DOCUMENT:C267($h_docRef)
					DELETE DOCUMENT:C159(document)
					$r_bytesRecibidos:=$r_bytes
					$h_docRef:=?00:00:00?
				Else 
					SEND PACKET:C103($h_docRef;$x_Blob)
					$r_bytesRecibidos:=$r_bytesRecibidos+BLOB size:C605($x_Blob)
					$l_segundos:=Round:C94((Milliseconds:C459-$l_started)/1000;0)
					$l_MbReceived:=Round:C94($r_bytesRecibidos/1024/1024;0)
					$l_Mbps:=Round:C94($l_MbReceived/$l_segundos/8;0)
					$t_status:=String:C10($l_MbReceived)+"MB de "+String:C10($l_megaBytes)+"MB copiados ("+String:C10($l_Mbps)+"Mbps)"
					$l_idProceso:=IT_Progress (0;$l_idProceso;$r_bytesRecibidos/$r_bytes;$t_mensaje+"\r"+$t_status)
				End if 
			End if 
		Until ($r_bytes<=$r_bytesRecibidos)
		If ($h_docRef#?00:00:00?)
			CLOSE DOCUMENT:C267($h_docRef)
		End if 
		$l_idProceso:=IT_Progress (-1;$l_idProceso)
	End if 
	
Else 
	If (($l_UserChoice=2) & (error=0))
		If ($b_mostrarMensaje)
			$l_ProcessID:=IT_UThermometer (1;0;__ ("Copiando archivo desde el servidor...\r")+$t_rutaDestino)
		End if 
		$x_Blob:=KRL_GetFileFromServer ($t_rutaDocumento;True:C214)
		$h_docRef:=Create document:C266($t_rutaDestino)
		CLOSE DOCUMENT:C267($h_docRef)
		BLOB TO DOCUMENT:C526($t_rutaDestino;$x_Blob)
		If ($b_mostrarMensaje)
			$l_ProcessID:=IT_UThermometer (-2;$l_ProcessID)
		End if 
	End if 
End if 



