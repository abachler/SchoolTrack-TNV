//%attributes = {"executedOnServer":true}
  // XSvs_RestauraLocalizaciones()
  // Por: Alberto Bachler: 08/03/13, 10:13:59
  //  ---------------------------------------------
  //
  //
  //  --------------u-------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_bloqueado;$b_invisible)
C_DATE:C307($d_fechaCreacion;$d_fechaModificacion)
C_LONGINT:C283($l_recNum;$i)
C_TIME:C306($h_horaCreacion;$h_horaModificacion)
C_TEXT:C284($t_carpetaPreferenciasLenguajes;$t_documento;$t_dtsModificacion;$t_referenciaCampo;$t_referenciaTabla)

ARRAY TEXT:C222($at_alias;0)
ARRAY TEXT:C222($at_aliasAlmacenado;0)
ARRAY TEXT:C222($at_DTS;0)
ARRAY TEXT:C222($at_DtsAlmacenado;0)
ARRAY TEXT:C222($at_fieldRef;0)
ARRAY TEXT:C222($at_paisLenguaje;0)
ARRAY TEXT:C222($at_RefCampoAlmacenado;0)
ARRAY TEXT:C222($at_RefTablaAlmacenada;0)
ARRAY TEXT:C222($at_RefTablaAlmacenado;0)
ARRAY TEXT:C222($at_refTablaCampo;0)
ARRAY TEXT:C222($at_tableRef;0)




  //LECTURA DE LA TOTALIDAD DE TABLAS Y CAMPOS LOCALIZADOS, TODOS LOS PAISES/IDIOMAS
$t_carpetaPreferenciasLenguajes:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"Virtual"

  // TABLAS
  // Preservo los alias creados o modificados después de la última generación del archivo "localizacionTablas.txt"
$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionTablas.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
	QUERY:C277([xShell_TableAlias:199];[xShell_TableAlias:199]DTS:3;>;$t_dtsModificacion)
	SELECTION TO ARRAY:C260([xShell_TableAlias:199]TableRef:1;$at_RefTablaAlmacenada;[xShell_TableAlias:199]Alias:2;$at_aliasAlmacenado;[xShell_TableAlias:199]DTS:3;$at_DtsAlmacenado)
	
	
	  // elimino todos los registros de localizacion
	KRL_ClearTable (->[xShell_TableAlias:199])
	
	  // recreo las localizaciones a partir de "localizacionTablas.txt"
	DOCUMENT TO BLOB:C525($t_documento;$x_blob)
	BLOB_ExpandBlob_byPointer (->$x_blob)
	BLOB_Blob2Vars (->$x_blob;0;->$at_tableRef;->$at_DTS;->$at_paisLenguaje;->$at_alias)
	READ WRITE:C146([xShell_TableAlias:199])
	ARRAY TO SELECTION:C261($at_tableRef;[xShell_TableAlias:199]TableRef:1;$at_DTS;[xShell_TableAlias:199]DTS:3;$at_paisLenguaje;[xShell_TableAlias:199]PaisLenguaje:4;$at_alias;[xShell_TableAlias:199]Alias:2)
	KRL_UnloadReadOnly (->[xShell_TableAlias:199])
	
	  // restauro los alias creados o modificados después de la última generación del archivo "localizacionTablas.txt"
	For ($i;1;Size of array:C274($at_RefTablaAlmacenada))
		$t_referenciaTabla:=$at_RefTablaAlmacenada{$i}
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_TableAlias:199]TableRef:1;->$t_referenciaTabla;True:C214)
		If ($l_recNum<0)
			CREATE RECORD:C68([xShell_TableAlias:199])
			[xShell_TableAlias:199]TableRef:1:=$t_referenciaTabla
		End if 
		[xShell_TableAlias:199]Alias:2:=$at_aliasAlmacenado{$i}
		[xShell_TableAlias:199]DTS:3:=$at_DtsAlmacenado{$i}
		SAVE RECORD:C53([xShell_TableAlias:199])
	End for 
End if 

  // CAMPOS
$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionCampos.txt"
If (Test path name:C476($t_documento)=Is a document:K24:1)
	  // Preservo los alias creados o modificados después de la última generación del archivo "localizacionCampos.txt"
	GET DOCUMENT PROPERTIES:C477($t_documento;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacion:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
	QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]DTS:7;>;$t_dtsModificacion)
	SELECTION TO ARRAY:C260([xShell_FieldAlias:198]FieldRef:5;$at_RefCampoAlmacenado;[xShell_FieldAlias:198]TableRef:2;$at_RefTablaAlmacenado;[xShell_FieldAlias:198]Alias:3;$at_aliasAlmacenado;[xShell_FieldAlias:198]DTS:7;$at_DtsAlmacenado)
	
	  // elimino todos los registros de localizacion
	KRL_ClearTable (->[xShell_FieldAlias:198])
	
	  // recreo las localizaciones a partir de "localizacionCampos.txt"
	DOCUMENT TO BLOB:C525($t_documento;$x_blob)
	BLOB_ExpandBlob_byPointer (->$x_blob)
	BLOB_Blob2Vars (->$x_blob;0;->$at_tableRef;->$at_fieldRef;->$at_DTS;->$at_paisLenguaje;->$at_alias;->$at_refTablaCampo)
	KRL_ClearTable (->[xShell_FieldAlias:198])
	READ WRITE:C146([xShell_FieldAlias:198])
	ARRAY TO SELECTION:C261($at_fieldRef;[xShell_FieldAlias:198]FieldRef:5;$at_tableRef;[xShell_FieldAlias:198]TableRef:2;$at_DTS;[xShell_FieldAlias:198]DTS:7;$at_paisLenguaje;[xShell_FieldAlias:198]PaisLenguaje:6;$at_alias;[xShell_FieldAlias:198]Alias:3;$at_refTablaCampo;[xShell_FieldAlias:198]Referencia_tablaCampo:1)
	KRL_UnloadReadOnly (->[xShell_FieldAlias:198])
	
	  // restauro los alias creados o modificados después de la última generación del archivo "localizacionCampos.txt"
	For ($i;1;Size of array:C274($at_RefCampoAlmacenado))
		$t_referenciaCampo:=$at_RefCampoAlmacenado{$i}
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_FieldAlias:198]FieldRef:5;->$t_referenciaCampo;True:C214)
		If ($l_recNum<0)
			CREATE RECORD:C68([xShell_FieldAlias:198])
			[xShell_FieldAlias:198]FieldRef:5:=$t_referenciaCampo
			[xShell_FieldAlias:198]TableRef:2:=$at_RefTablaAlmacenado{$i}
		End if 
		[xShell_FieldAlias:198]Alias:3:=$at_aliasAlmacenado{$i}
		[xShell_FieldAlias:198]DTS:7:=$at_DtsAlmacenado{$i}
		SAVE RECORD:C53([xShell_FieldAlias:198])
	End for 
End if 
