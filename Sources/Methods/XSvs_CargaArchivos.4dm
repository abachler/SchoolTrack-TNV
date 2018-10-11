//%attributes = {"executedOnServer":true}
  // XSvs_CargaArchivos()
  // Por: Alberto Bachler: 06/03/13, 19:27:00
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_fechaCreacion;$d_fechaModificacion)
C_LONGINT:C283($l_iCampos;$l_numeroTabla;$l_registros;$l_registrosModificados;$i;$ms)
C_TIME:C306($h_horaCreacion;$h_horaModificacion)
C_TEXT:C284($t_carpetaPreferenciasLenguajes;$t_documento;$t_dtsModificacion)

ARRAY INTEGER:C220($ai_numeroCampos;0)
ARRAY INTEGER:C220($ai_numeroTablas;0)
ARRAY REAL:C219($ar_formatoCampos;0)

$ms:=Milliseconds:C459
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]FormatoNombres:15#0)
SELECTION TO ARRAY:C260([xShell_Fields:52]FormatoNombres:15;$ar_formatoCampos;[xShell_Fields:52]NumeroTabla:1;$ai_numeroTablas;[xShell_Fields:52]NumeroCampo:2;$ai_numeroCampos)

$t_carpetaPreferenciasLenguajes:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"Virtual"
SYS_CreateFolder ($t_carpetaPreferenciasLenguajes)

$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"tablas.txt"
GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_Tables:51];[xShell_Tables:51]DTS_modificacion:8<$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If (($l_registrosModificados>0) | (Records in table:C83([xShell_Tables:51])=0))
	KRL_ClearTable (->[xShell_Tables:51])
	SET CHANNEL:C77(10;$t_documento)
	RECEIVE VARIABLE:C81($l_registros)
	If ($l_registros#0)
		For ($l_iCampos;1;$l_registros)
			RECEIVE RECORD:C79([xShell_Tables:51])
			SAVE RECORD:C53([xShell_Tables:51])
		End for 
	End if 
	SET CHANNEL:C77(11)
End if 

$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"campos.txt"
GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]DTS_modificacion:25<$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If (($l_registrosModificados>0) | (Records in table:C83([xShell_Fields:52])=0))
	KRL_ClearTable (->[xShell_Fields:52])
	SET CHANNEL:C77(10;$t_documento)
	RECEIVE VARIABLE:C81($l_registros)
	If ($l_registros#0)
		For ($l_iCampos;1;$l_registros)
			RECEIVE RECORD:C79([xShell_Fields:52])
			SAVE RECORD:C53([xShell_Fields:52])
		End for 
	End if 
	SET CHANNEL:C77(11)
End if 

$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"relaciones.txt"
GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]DTS_modificacion:14<$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If (($l_registrosModificados>0) | (Records in table:C83([xShell_Tables_RelatedFiles:243])=0))
	KRL_ClearTable (->[xShell_Tables_RelatedFiles:243])
	SET CHANNEL:C77(10;$t_documento)
	RECEIVE VARIABLE:C81($l_registros)
	If ($l_registros#0)
		For ($l_iCampos;1;$l_registros)
			RECEIVE RECORD:C79([xShell_Tables_RelatedFiles:243])
			SAVE RECORD:C53([xShell_Tables_RelatedFiles:243])
		End for 
	End if 
	SET CHANNEL:C77(11)
End if 



  // restaurando configuración de formato de nombres
READ WRITE:C146([xShell_Fields:52])
For ($i;1;Size of array:C274($ar_formatoCampos))
	QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1;=;$ai_numeroTablas{$i};*)
	QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2;=;$ai_numeroCampos{$i})
	[xShell_Fields:52]FormatoNombres:15:=$ar_formatoCampos{$i}
	SAVE RECORD:C53([xShell_Fields:52])
End for 
KRL_UnloadReadOnly (->[xShell_Fields:52])

$ms:=Milliseconds:C459-$ms
  //ALERT("Lectura Estructura virtual: "+String($ms))




