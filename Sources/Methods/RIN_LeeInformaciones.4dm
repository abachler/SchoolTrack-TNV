//%attributes = {}
  // RIN_LeeInformaciones()
  // Por: Alberto Bachler K.: 06-08-14, 18:34:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_BLOB:C604($x_blob)
C_LONGINT:C283($l_error;$l_error;$l_recNum;$l_tabla;$l_versionEstructura_Principal;$l_versionEstructura_Revision)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_codigoLenguaje;$t_codigoPais;$t_creadoPor;$t_Description;$t_dtsCreacion;$t_dtsModificacion;$t_ejemploPDF;$t_error;$t_errorWS;$t_historial)
C_TEXT:C284($t_json;$t_modificadoPor;$t_modulo;$t_nodoError;$t_nombre;$t_nombreTabla;$t_refjSon;$t_refNodoError;$t_refNodoInfo;$t_tags)
C_TEXT:C284($t_tipoInforme;$t_url;$t_uuid;$t_version;$t_versionEstructura)


If (False:C215)
	C_TEXT:C284(RIN_LeeInformaciones ;$1)
End if 


$t_uuidActualizacion:=$1

$t_versionEstructura:=SYS_LeeVersionEstructura ("principal";->$l_versionEstructura_Principal)
$t_versionEstructura:=SYS_LeeVersionEstructura ("revision";->$l_versionEstructura_Revision)
$t_version:=String:C10($l_versionEstructura_Principal;"00")+"."+String:C10($l_versionEstructura_Revision;"00")

WEB SERVICE SET PARAMETER:C777("uuidActualizacion";$t_uuidActualizacion)
WEB SERVICE SET PARAMETER:C777("version";$t_version)

$t_errorWS:=WS_CallIntranetWebService ("RINws_InfoInforme";True:C214)
If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($t_json;"json";*)  //20180514 RCH Ticket 206788
	
	C_OBJECT:C1216($ob;$ob_error;$ob_info)
	
	$ob:=OB_Create 
	$ob_error:=OB_Create 
	$ob_info:=OB_Create 
	$ob:=JSON Parse:C1218($t_json;Is object:K8:27)
	OB_GET ($ob;->$ob_error;"error")
	OB_GET ($ob;->$ob_info;"info")
	OB_GET ($ob_error;->$l_error;"codigoError")
	OB_GET ($ob_error;->$t_error;"textoError")
	
	Case of 
		: ($l_error=-1)  // referencia (recNum) inválido
			
		: ($l_error=-2)  // no fue posible acceder al informe
			
		: ($l_error=-3)  // informe removido
			ModernUI_Notificacion (__ ("Información de informe en repositorio");__ ("Este informe está obsoleto. Puede intentar utilizarlo pero es preferible utilizar otro informe."))
			
		: ($l_error=-4)  // version incompatible
			
		Else 
			OB_GET ($ob_info;->$t_nombre;"nombre")  //20170719 RCH Se corrige problema al obtener uuid, desc y nombre
			OB_GET ($ob_info;->$t_uuid;"uuid")
			OB_GET ($ob_info;->$t_Description;"descripcion")
			OB_GET ($ob_info;->$t_creadoPor;"creadoPor")
			OB_GET ($ob_info;->$t_modificadoPor;"modificadoPor")
			OB_GET ($ob_info;->$t_modulo;"modulo")
			OB_GET ($ob_info;->$t_tipoInforme;"tipo")
			OB_GET ($ob_info;->$t_dtsCreacion;"dtsCreacion")
			OB_GET ($ob_info;->$t_dtsModificacion;"dtsModificacion")
			OB_GET ($ob_info;->$t_tags;"tags")
			OB_GET ($ob_info;->$t_codigoPais;"codigoPais")
			OB_GET ($ob_info;->$t_codigoLenguaje;"codigoLenguaje")
			OB_GET ($ob_info;->$l_tabla;"tablaPrincipal")
			OB_GET ($ob_info;->$t_ejemploPDF;"ejemploPDF")
			OB_GET ($ob_info;->$t_historial;"historia")
			
			
			$t_nombreTabla:=API Get Virtual Table Name ($l_tabla)
			Case of 
				: ($t_tipoInforme="GSR2")
					$t_tipoInforme:="SuperReport"
				: ($t_tipoInforme="4DSE")
					$t_tipoInforme:="En columnas"
				: ($t_tipoInforme="4DFO")
					$t_tipoInforme:="Formulario"
				: ($t_tipoInforme="4DET")
					$t_tipoInforme:="Etiquetas"
				: ($t_tipoInforme="4DWR")
					$t_tipoInforme:="Write"
				: ($t_tipoInforme="4DVW")
					$t_tipoInforme:="View"
				: ($t_tipoInforme="4DDW")
					$t_tipoInforme:="Draw"
				: ($t_tipoInforme="4DCT")
					$t_tipoInforme:="Graph"
			End case 
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"detalles"))->:="• Nombre del informe: "+$t_nombre+"\r"+"• Tipo: "+$t_tipoInforme+"\r"+"• Módulo: "+$t_modulo+"\r"+"• Panel: "+$t_nombreTabla+"\r"+"• Creado por: "+$t_creadoPor+" el "\
				+DTS_GetDateTimeString ($t_dtsCreacion)+"\r"+"• Modificado por: "+$t_modificadoPor+" el "+DTS_GetDateTimeString ($t_dtsModificacion)+"\r"+"• Palabras claves: "+$t_tags
			(OBJECT Get pointer:C1124(Object named:K67:5;"descripcion"))->:=$t_Description
			(OBJECT Get pointer:C1124(Object named:K67:5;"historial"))->:=$t_historial
			(OBJECT Get pointer:C1124(Object named:K67:5;"rutaEjemplo"))->:=$t_url
			
			(OBJECT Get pointer:C1124(Object named:K67:5;"informe_informaciones"))->:=(OBJECT Get pointer:C1124(Object named:K67:5;"historial"))->
			OBJECT SET FONT STYLE:C166(*;"informe_boton@";Plain:K14:1)
			OBJECT SET FONT STYLE:C166(*;"informe_botonHistorial";Bold:K14:2)
			Case of 
				: (OBJECT Get font style:C1071(*;"informe_botonHistorial")=Bold:K14:2)
					OBJECT Get pointer:C1124(Object named:K67:5;"informe_informaciones")->:=OBJECT Get pointer:C1124(Object named:K67:5;"historial")->
				: (OBJECT Get font style:C1071(*;"informe_botonDetalles")=Bold:K14:2)
					OBJECT Get pointer:C1124(Object named:K67:5;"informe_informaciones")->:=OBJECT Get pointer:C1124(Object named:K67:5;"detalles")->
				: (OBJECT Get font style:C1071(*;"informe_botonDescripcion")=Bold:K14:2)
					OBJECT Get pointer:C1124(Object named:K67:5;"informe_informaciones")->:=OBJECT Get pointer:C1124(Object named:K67:5;"descripcion")->
			End case 
			
			OBJECT SET TITLE:C194(*;"informe_nombre";$t_nombre)
			OBJECT SET VISIBLE:C603(*;"informe_@";$t_nombre#"")
			OBJECT SET VISIBLE:C603(*;"informe_x4DLiveWindow";(OBJECT Get pointer:C1124(Object named:K67:5;"rutaEjemplo"))->#"")
			OBJECT SET VISIBLE:C603(*;"sinSeleccion";$t_nombre="")
			
			
			If ($t_ejemploPDF#"")
				$t_url:=Temporary folder:C486+$t_uuid+".pdf"
				BASE64 DECODE:C896($t_ejemploPDF;$x_blob)
				BLOB_ExpandBlob_byPointer (->$x_blob)
				If (SYS_TestPathName ($t_url)=1)
					error:=0
					ON ERR CALL:C155("ERR_CreateDeleteDocument")
					DELETE DOCUMENT:C159($t_url)
					ON ERR CALL:C155("")
					If (error=0)
						$h_refDocumento:=Create document:C266($t_url)
						CLOSE DOCUMENT:C267($h_refDocumento)
						BLOB TO DOCUMENT:C526($t_url;$x_blob)
						If ((SYS_GetOSName >="macOS 10.13@") & (Not:C34(4D_isLocal64bit )))
							READ PICTURE FILE:C678($t_url;$p_imagen)
							$t_url:=$t_url+".jpg"
							WRITE PICTURE FILE:C680($t_url;$p_imagen)
						End if 
						WA OPEN URL:C1020(x4DLiveWindow;$t_url)
						OBJECT SET VISIBLE:C603(x4DLiveWindow;True:C214)
					Else 
						CD_Dlog (0;"El documento se encuentra abierto por otra aplicación. Ciérrelo e intente nuevamente.")
					End if 
				Else 
					$h_refDocumento:=Create document:C266($t_url)
					CLOSE DOCUMENT:C267($h_refDocumento)
					BLOB TO DOCUMENT:C526($t_url;$x_blob)
					If ((SYS_GetOSName >="macOS 10.13@") & (Not:C34(4D_isLocal64bit )))
						READ PICTURE FILE:C678($t_url;$p_imagen)
						WRITE PICTURE FILE:C680($t_url+".jpg";$p_imagen)
					End if 
					WA OPEN URL:C1020(x4DLiveWindow;$t_url)
					OBJECT SET VISIBLE:C603(x4DLiveWindow;True:C214)
				End if 
			Else 
				OBJECT SET VISIBLE:C603(x4DLiveWindow;False:C215)
			End if 
	End case 
	
	
Else 
	ModernUI_Notificacion (__ ("Información del informe");__ ("No fue posible establecer la comunicación con el repositorio de informes:\r")+$t_error)
End if 

