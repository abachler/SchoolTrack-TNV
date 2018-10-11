//%attributes = {"executedOnServer":true}
  // XSvs_LeeLocalizacion()
  // Por: Alberto Bachler: 04/03/13, 10:13:10
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_blob;$x_blob2)
C_BOOLEAN:C305($b_bloqueado;$b_crearDiccionario;$b_Indexado;$b_invisible;$b_leerNombreVirtual;$b_unico)
C_DATE:C307($d_fechaCreacion;$d_fechaModificacion)
C_LONGINT:C283($i;$i_campos;$i_tablas;$l_esUnObjeto;$l_largo;$l_modificacionesCampos;$l_modificacionesTablas;$l_OTRefs;$l_referenciaObjeto;$l_tipo)
C_LONGINT:C283($l_tipoCampo)
C_TIME:C306($h_horaCreacion;$h_horaModificacion;$h_referenciaDocumento)
C_POINTER:C301($y_Tabla)
C_TEXT:C284($t_carpetaPreferenciasLenguajes;$t_codigoLenguaje;$t_codigoPais;$t_codigoPaisLenguaje;$t_documento;$t_documentoLenguaje;$t_documentoLocalizacionCampos;$t_documentoLocalizacionTablas;$t_dtsModificacionCampos;$t_dtsModificacionTablas)
C_TEXT:C284($t_dtsModificacionVS_local;$t_indice;$t_nombreTabla)

ARRAY INTEGER:C220($ai_numerocampos;0)
ARRAY INTEGER:C220($ai_numerosTablas;0)
ARRAY TEXT:C222($at_nombresCampos;0)
ARRAY TEXT:C222($at_nombresTablas;0)



If (False:C215)
	C_BLOB:C604(XSvs_LeeLocalizacion ;$0)
	C_TEXT:C284(XSvs_LeeLocalizacion ;$1)
	C_TEXT:C284(XSvs_LeeLocalizacion ;$2)
End if 

$t_codigoPais:=<>vtXS_CountryCode
$t_codigoLenguaje:=<>vtXS_langage
Case of 
	: (Count parameters:C259=2)
		$t_codigoPais:=$1
		$t_codigoLenguaje:=$2
	: (Count parameters:C259=1)
		$t_codigoPais:=$1
End case 

$t_carpetaPreferenciasLenguajes:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+"Virtual"
SYS_CreateFolder ($t_carpetaPreferenciasLenguajes)


$t_documentoLocalizacionTablas:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionTablas.txt"
If (Test path name:C476($t_documentoLocalizacionTablas)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documentoLocalizacionTablas;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacionTablas:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
End if 

$t_documentoLocalizacionCampos:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionCampos.txt"
If (Test path name:C476($t_documentoLocalizacionCampos)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documentoLocalizacionCampos;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacionCampos:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
End if 

$t_documentoLenguaje:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"vs."+$t_codigoPais+"."+$t_codigoLenguaje+".blob"
If (Test path name:C476($t_documentoLenguaje)=Is a document:K24:1)
	GET DOCUMENT PROPERTIES:C477($t_documentoLenguaje;$b_bloqueado;$b_invisible;$d_fechaCreacion;$h_horaCreacion;$d_fechaModificacion;$h_horaModificacion)
	$t_dtsModificacionVS_local:=DTS_Get_GMT_TimeStamp ($d_fechaModificacion;$h_horaModificacion)
End if 


  // determino si es necesario crear el diccionario virtual para el pais/idioma recibido en argumento
Case of 
	: (Test path name:C476($t_documentoLenguaje)#Is a document:K24:1)
		$b_crearDiccionario:=True:C214
		$h_referenciaDocumento:=Create document:C266($t_documentoLenguaje)
		CLOSE DOCUMENT:C267($h_referenciaDocumento)
		
	: (($t_dtsModificacionTablas>$t_dtsModificacionVS_local) | ($t_dtsModificacionCampos>$t_dtsModificacionVS_local))
		$b_crearDiccionario:=True:C214
		
	: ((Records in table:C83([xShell_TableAlias:199])=0) | (Records in table:C83([xShell_FieldAlias:198])=0))
		$b_crearDiccionario:=True:C214
	Else 
		
		
		
		DOCUMENT TO BLOB:C525($t_documentoLenguaje;$x_blob)
		BLOB_ExpandBlob_byPointer (->$x_blob)
		If (BLOB size:C605($x_blob)>0)
			$l_referenciaObjeto:=OT BLOBToObject ($x_Blob)
			If ($l_referenciaObjeto#0)
				$l_esUnObjeto:=OT IsObject ($l_referenciaObjeto)
				If ($l_esUnObjeto=1)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_modificacionesTablas)
					QUERY:C277([xShell_TableAlias:199];[xShell_TableAlias:199]PaisLenguaje:4;=;$t_codigoPais+"."+$t_codigoLenguaje;*)
					QUERY:C277([xShell_TableAlias:199]; & ;[xShell_TableAlias:199]DTS:3>$t_dtsModificacionVS_local)
					
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_modificacionesCampos)
					QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]PaisLenguaje:6;=;$t_codigoPais+"."+$t_codigoLenguaje;*)
					QUERY:C277([xShell_FieldAlias:198]; & ;[xShell_FieldAlias:198]DTS:7>$t_dtsModificacionVS_local)
					
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					
					$b_crearDiccionario:=(($l_modificacionesTablas+$l_modificacionesCampos)>0)
					
					OT Clear ($l_referenciaObjeto)
				Else 
					$b_crearDiccionario:=True:C214
				End if 
			Else 
				$b_crearDiccionario:=True:C214
			End if 
		Else 
			$b_crearDiccionario:=True:C214
		End if 
End case 

If ($b_crearDiccionario)
	
	$t_codigoPaisLenguaje:=KRL_MakeStringAccesKey (->$t_codigoPais;->$t_codigoLenguaje)
	$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionTablas.txt"
	If (Test path name:C476($t_documento)=Is a document:K24:1)
		XSvs_LeeLocalizacion_Tablas ($t_documento;$t_codigoPaisLenguaje;$t_dtsModificacionVS_local)
	End if 
	
	
	$t_codigoPaisLenguaje:=KRL_MakeStringAccesKey (->$t_codigoPais;->$t_codigoLenguaje)
	$t_documento:=$t_carpetaPreferenciasLenguajes+Folder separator:K24:12+"localizacionCampos.txt"
	If (Test path name:C476($t_documento)=Is a document:K24:1)
		XSvs_LeeLocalizacion_Campos ($t_documento;$t_codigoPaisLenguaje;$t_dtsModificacionVS_local)
	End if 
	
	
	
	$l_OTRefs:=OT New 
	QUERY:C277([xShell_Tables:51];[xShell_Tables:51]EsTablaOcultaEnEditores:35;=;False:C215)
	SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;$ai_numerosTablas)
	ARRAY TEXT:C222($at_nombresTablas;Size of array:C274($ai_numerosTablas))
	For ($i;Size of array:C274($ai_numerosTablas);1;-1)
		If (Is table number valid:C999($ai_numerosTablas{$i}))
			GET TABLE PROPERTIES:C687($ai_numerosTablas{$i};$b_invisible)
			$t_nombreTabla:=Table name:C256($ai_numerosTablas{$i})
			If (($b_invisible) | ($t_nombreTabla="zz@") | ($t_nombreTabla="xx@") | ($t_nombreTabla="xShell@") | (USR_checkRights ("L";Table:C252($ai_numerosTablas{$i}))=False:C215))
				DELETE FROM ARRAY:C228($ai_numerosTablas;$i)
				DELETE FROM ARRAY:C228($at_nombresTablas;$i)
			Else 
				$b_leerNombreVirtual:=False:C215
				$at_nombresTablas{$i}:=XSvs_nombreTablaLocal_Numero ($ai_numerosTablas{$i};$t_codigoPais;$t_codigoLenguaje;$b_leerNombreVirtual)
			End if 
		Else 
			DELETE FROM ARRAY:C228($ai_numerosTablas;$i)
			DELETE FROM ARRAY:C228($at_nombresTablas;$i)
		End if 
	End for 
	SORT ARRAY:C229($at_nombresTablas;$ai_numerosTablas;>)
	OT PutArray ($l_OTRefs;"ArregloNumerosTablas";$ai_numerosTablas)
	OT PutArray ($l_OTRefs;"ArregloNombresTablas";$at_nombresTablas)
	
	SORT ARRAY:C229($at_nombresTablas;$ai_numerosTablas;>)
	For ($i_tablas;1;Size of array:C274($ai_numerosTablas))
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$ai_numerosTablas{$i_tablas})
		SELECTION TO ARRAY:C260([xShell_Fields:52]NumeroCampo:2;$ai_numerocampos)
		ARRAY TEXT:C222($at_nombresCampos;Size of array:C274($ai_numerocampos))
		For ($i_campos;Size of array:C274($ai_numerocampos);1;-1)
			If (Is field number valid:C1000($ai_numerosTablas{$i_tablas};$ai_numerocampos{$i_campos}))
				GET FIELD PROPERTIES:C258($ai_numerosTablas{$i_tablas};$ai_numerocampos{$i_campos};$l_tipoCampo;$l_largo;$b_Indexado;$b_unico;$b_invisible)
				If ((Not:C34($b_invisible)) & ($l_tipoCampo#Is BLOB:K8:12) & ($l_tipoCampo#Is subtable:K8:11))
					$b_leerNombreVirtual:=False:C215
					$at_nombresCampos{$i_campos}:=XSvs_nombreCampoLocal_Numero ($ai_numerosTablas{$i_tablas};$ai_numerocampos{$i_campos};$t_codigoPais;$t_codigoLenguaje;$b_leerNombreVirtual)
				Else 
					DELETE FROM ARRAY:C228($ai_numerocampos;$i_campos)
					DELETE FROM ARRAY:C228($at_nombresCampos;$i_campos)
				End if 
			Else 
				DELETE FROM ARRAY:C228($ai_numerocampos;$i_campos)
				DELETE FROM ARRAY:C228($at_nombresCampos;$i_campos)
			End if 
		End for 
		SORT ARRAY:C229($ai_numerocampos;$at_nombresCampos)
		$t_indice:=String:C10($ai_numerosTablas{$i_tablas})
		$y_Tabla:=Table:C252($ai_numerosTablas{$i_tablas})
		OT PutArray ($l_OTRefs;"ArregloNumerosCampos"+$t_indice;$ai_numerocampos)
		OT PutArray ($l_OTRefs;"ArregloNombresCampos"+$t_indice;$at_nombresCampos)
	End for 
	$x_Blob:=OT ObjectToNewBLOB ($l_OTRefs)
	OT Clear ($l_OTRefs)
	
	COMPRESS BLOB:C534($x_Blob;Compact compression mode:K22:12)
	BLOB TO DOCUMENT:C526($t_documentoLenguaje;$x_Blob)
	
End if 
$0:=$x_Blob