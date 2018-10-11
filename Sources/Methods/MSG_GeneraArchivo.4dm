//%attributes = {}
  // MSG_ActualizaArchivo()
  // Por: Alberto Bachler: 22/04/13, 15:59:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_fechaCreacion;$d_fechaModificacion)
_O_C_INTEGER:C282($i_recNums)
C_LONGINT:C283($l_IdRegistro;$l_registros)
C_TIME:C306($h_horaCreacion;$h_horaModificacion)
C_TEXT:C284($t_carpetaPreferenciasMensajes;$t_documento;$t_dts;$t_dtsModificacion)

ARRAY LONGINT:C221($al_RecNums;0)

$t_carpetaPreferenciasMensajes:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"Mensajes"
SYS_CreateFolder ($t_carpetaPreferenciasMensajes)

$t_documento:=$t_carpetaPreferenciasMensajes+Folder separator:K24:12+"mensajes.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
Else 
	$t_dtsModificacion:=""
End if 

QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]DTS_modificacion:8>$t_dtsModificacion)
If (Records in selection:C76([xShell_MensajesAplicacion:244])>0)
	QUERY:C277([xShell_MensajesAplicacion:244];[xShell_MensajesAplicacion:244]ID:5>0)
	SET CHANNEL:C77(12;$t_documento)
	If (OK=1)
		LONGINT ARRAY FROM SELECTION:C647([xShell_MensajesAplicacion:244];$al_RecNums;"")
		READ ONLY:C145([xShell_MensajesAplicacion:244])
		$l_registros:=Size of array:C274($al_RecNums)
		SEND VARIABLE:C80($l_registros)
		For ($i_recNums;1;Size of array:C274($al_RecNums))
			READ ONLY:C145([xShell_MensajesAplicacion:244])
			GOTO RECORD:C242([xShell_MensajesAplicacion:244];$al_RecNums{$i_recNums})
			$l_IdRegistro:=[xShell_MensajesAplicacion:244]ID:5
			$t_dts:=[xShell_MensajesAplicacion:244]DTS_modificacion:8
			SEND VARIABLE:C80($l_IdRegistro)
			SEND VARIABLE:C80($t_dts)
			SEND RECORD:C78([xShell_MensajesAplicacion:244])
		End for 
		KRL_UnloadReadOnly (->[xShell_MensajesAplicacion:244])
		SET CHANNEL:C77(11)
	End if 
End if 

