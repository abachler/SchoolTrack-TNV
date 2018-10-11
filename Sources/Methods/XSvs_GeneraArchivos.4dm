//%attributes = {"executedOnServer":true}
  // XSvs_GeneraArchivos()
  // Por: Alberto Bachler: 07/03/13, 12:47:02
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_fechaCreacion;$d_fechaModificacion)
C_LONGINT:C283($l_numeroTabla;$l_registros;$l_registrosModificados;$ms)
C_TIME:C306($h_horaCreacion;$h_horaModificacion;$h_ReferenciaDocumento)
C_TEXT:C284($t_carpetaPreferenciasLenguajes;$t_documento;$t_dtsModificacion)

ARRAY TEXT:C222($at_alias;0)
ARRAY TEXT:C222($at_DTS;0)
ARRAY TEXT:C222($at_fieldRef;0)
ARRAY TEXT:C222($at_paisLenguaje;0)
ARRAY TEXT:C222($at_tableRef;0)

$ms:=Milliseconds:C459

$t_carpetaPreferenciasLenguajes:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"Virtual"
SYS_CreateFolder ($t_carpetaPreferenciasLenguajes)

  // TABLAS
$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"tablas.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
Else 
	$t_dtsModificacion:=""
End if 
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_Tables:51];[xShell_Tables:51]DTS_modificacion:8>$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If ($l_registrosModificados>0)
	SET CHANNEL:C77(12;$t_documento)
	ALL RECORDS:C47([xShell_Tables:51])
	$l_registros:=Records in selection:C76([xShell_Tables:51])
	SEND VARIABLE:C80($l_registros)
	FIRST RECORD:C50([xShell_Tables:51])
	While (Not:C34(End selection:C36([xShell_Tables:51])))
		SEND RECORD:C78([xShell_Tables:51])
		NEXT RECORD:C51([xShell_Tables:51])
	End while 
	SET CHANNEL:C77(11)
End if 

  // CAMPOS
$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"campos.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
Else 
	$t_dtsModificacion:=""
End if 
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]DTS_modificacion:25>$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If ($l_registrosModificados>0)
	SET CHANNEL:C77(12;$t_documento)
	ALL RECORDS:C47([xShell_Fields:52])
	$l_registros:=Records in selection:C76([xShell_Fields:52])
	SEND VARIABLE:C80($l_registros)
	FIRST RECORD:C50([xShell_Fields:52])
	While (Not:C34(End selection:C36([xShell_Fields:52])))
		SEND RECORD:C78([xShell_Fields:52])
		NEXT RECORD:C51([xShell_Fields:52])
	End while 
	SET CHANNEL:C77(11)
End if 
$ms:=Milliseconds:C459-$ms

  // RELACIONES
$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"relaciones.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
Else 
	$t_dtsModificacion:=""
End if 
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]DTS_modificacion:14>$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If ($l_registrosModificados>0)
	SET CHANNEL:C77(12;$t_documento)
	ALL RECORDS:C47([xShell_Tables_RelatedFiles:243])
	$l_registros:=Records in selection:C76([xShell_Tables_RelatedFiles:243])
	SEND VARIABLE:C80($l_registros)
	FIRST RECORD:C50([xShell_Tables_RelatedFiles:243])
	While (Not:C34(End selection:C36([xShell_Tables_RelatedFiles:243])))
		SEND RECORD:C78([xShell_Tables_RelatedFiles:243])
		NEXT RECORD:C51([xShell_Tables_RelatedFiles:243])
	End while 
	SET CHANNEL:C77(11)
End if 

  // NOMBRES LOCALIZADOS
$ms:=Milliseconds:C459

  // Tablas
$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionTablas.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
Else 
	$h_ReferenciaDocumento:=Create document:C266($t_documento)
	CLOSE DOCUMENT:C267($h_ReferenciaDocumento)
	$t_dtsModificacion:=""
End if 
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_TableAlias:199];[xShell_TableAlias:199]DTS:3;>;$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If ($l_registrosModificados>0)
	ALL RECORDS:C47([xShell_TableAlias:199])
	SELECTION TO ARRAY:C260([xShell_TableAlias:199]TableRef:1;$at_tableRef;[xShell_TableAlias:199]DTS:3;$at_DTS;[xShell_TableAlias:199]PaisLenguaje:4;$at_paisLenguaje;[xShell_TableAlias:199]Alias:2;$at_alias)
	BLOB_Variables2Blob (->$x_blob;0;->$at_tableRef;->$at_DTS;->$at_paisLenguaje;->$at_alias)
	COMPRESS BLOB:C534($x_blob;Compact compression mode:K22:12)
	BLOB TO DOCUMENT:C526($t_documento;$x_blob)
End if 

  // Campos
$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionCampos.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
Else 
	$h_ReferenciaDocumento:=Create document:C266($t_documento)
	CLOSE DOCUMENT:C267($h_ReferenciaDocumento)
	$t_dtsModificacion:=""
End if 
SET QUERY LIMIT:C395(1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosModificados)
QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]DTS:7;>;$t_dtsModificacion)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
SET QUERY LIMIT:C395(0)
If ($l_registrosModificados>0)
	ALL RECORDS:C47([xShell_FieldAlias:198])
	SELECTION TO ARRAY:C260([xShell_FieldAlias:198]TableRef:2;$at_tableRef;[xShell_FieldAlias:198]FieldRef:5;$at_fieldRef;[xShell_FieldAlias:198]DTS:7;$at_DTS;[xShell_FieldAlias:198]PaisLenguaje:6;$at_paisLenguaje;[xShell_FieldAlias:198]Alias:3;$at_alias;[xShell_FieldAlias:198]Referencia_tablaCampo:1;$at_refTablaCampo)
	BLOB_Variables2Blob (->$x_blob;0;->$at_tableRef;->$at_fieldRef;->$at_DTS;->$at_paisLenguaje;->$at_alias;->$at_refTablaCampo)
	COMPRESS BLOB:C534($x_blob;Compact compression mode:K22:12)
	BLOB TO DOCUMENT:C526($t_documento;$x_blob)
End if 
$ms:=Milliseconds:C459-$ms
