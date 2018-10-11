//%attributes = {}
  // SYS_GetLocalDocumentList()
  // Por: Alberto Bachler K.: 04-11-14, 11:56:09
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_esAlias;$b_invisible;$b_locked)
C_DATE:C307($d_createdOn;$d_modifiedOn)
C_LONGINT:C283($i)
C_TIME:C306($h_createdAt;$h_modifiedAt)
C_PICTURE:C286($p_Icon)
C_POINTER:C301($y_FechaCreacion;$y_FechaModificacion;$y_Icono;$y_nombreDocumento;$y_RutaDocumento;$y_Tamaño)
C_REAL:C285($r_Size;$r_SizeGB;$r_SizeKB;$r_SizeMB)
C_TEXT:C284($t_filePath;$t_nombreUsuario;$t_ruta;$t_rutaCarpeta;$t_rutaOriginal;$t_tipoDocumento)

ARRAY TEXT:C222($at_carpetas;0)
ARRAY TEXT:C222($at_Documents;0)


If (False:C215)
	C_TEXT:C284(SYS_GetLocalDocumentList ;$1)
	C_POINTER:C301(SYS_GetLocalDocumentList ;$2)
	C_POINTER:C301(SYS_GetLocalDocumentList ;$3)
	C_POINTER:C301(SYS_GetLocalDocumentList ;$4)
	C_POINTER:C301(SYS_GetLocalDocumentList ;$5)
	C_POINTER:C301(SYS_GetLocalDocumentList ;$6)
End if 

$t_rutaCarpeta:=$1
$y_nombreDocumento:=$2
$y_RutaDocumento:=$3
$y_FechaCreacion:=$4
$y_FechaModificacion:=$5
$y_Tamaño:=$6
$y_Icono:=$7

AT_Initialize ($y_nombreDocumento;$y_RutaDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono)

$t_nombreUsuario:=Current system user:C484
If ($t_rutaCarpeta#"")
	ON ERR CALL:C155("ERR_GenericOnError")
	FOLDER LIST:C473($t_rutaCarpeta;$at_carpetas)
	ARRAY TEXT:C222($at_creacionCarpeta;Size of array:C274($at_carpetas))
	ARRAY TEXT:C222($at_ModificacionCarpeta;Size of array:C274($at_carpetas))
	ARRAY BOOLEAN:C223($abPack_Locked;Size of array:C274($at_carpetas))
	ARRAY TEXT:C222($atPack_Size;Size of array:C274($at_carpetas))
	ARRAY PICTURE:C279($ap_IconoCarpeta;Size of array:C274($at_carpetas))
	For ($i;Size of array:C274($at_carpetas);1;-1)
		$t_ruta:=$t_rutaCarpeta+Folder separator:K24:12+$at_carpetas{$i}
		Case of 
			: ((SYS_IsMacintosh ) & (($at_carpetas{$i}="Volumes") | ($at_carpetas{$i}="usr") | ($at_carpetas{$i}="sbin") | ($at_carpetas{$i}="bin") | ($at_carpetas{$i}="cores") | ($at_carpetas{$i}="Network") | ($at_carpetas{$i}="Private") | ($at_carpetas{$i}="Home") | ($at_carpetas{$i}="Net") | ($at_carpetas{$i}=$t_nombreUsuario)))
				AT_Delete ($i;1;->$at_carpetas;->$ap_IconoCarpeta;->$atPack_Size;->$abPack_Locked;->$at_ModificacionCarpeta;->$at_creacionCarpeta)
			: (($at_carpetas{$i}=".@") | ($at_carpetas{$i}="{@"))
				AT_Delete ($i;1;->$at_carpetas;->$ap_IconoCarpeta;->$atPack_Size;->$abPack_Locked;->$at_ModificacionCarpeta;->$at_creacionCarpeta)
			: (($at_carpetas{$i}="@.app") | ($at_carpetas{$i}="@.bundle") | ($at_carpetas{$i}="@.4dbase") | ($at_carpetas{$i}="@.pkg"))
				GET DOCUMENT ICON:C700($t_ruta;$p_Icon;16)
				$ap_IconoCarpeta{$i}:=$p_Icon
			Else 
				GET DOCUMENT ICON:C700($t_ruta;$p_Icon;16)
				$ap_IconoCarpeta{$i}:=$p_Icon
		End case 
	End for 
	
	DOCUMENT LIST:C474($t_rutaCarpeta;$y_nombreDocumento->)
	AT_RedimArrays (Size of array:C274($y_nombreDocumento->);$y_RutaDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono)
	  //ARRAY PICTURE($y_Icono->;Size of array($y_nombreDocumento->))
	
	For ($i;Size of array:C274($y_nombreDocumento->);1;-1)
		$y_RutaDocumento->{$i}:=$t_rutaCarpeta+Folder separator:K24:12+$y_nombreDocumento->{$i}
		$t_tipoDocumento:=_o_Document type:C528($y_RutaDocumento->{$i})
		RESOLVE ALIAS:C695($y_RutaDocumento->{$i};$t_rutaOriginal)
		If (OK=1)
			$b_esAlias:=True:C214
			$y_RutaDocumento->{$i}:=$t_rutaOriginal
		End if 
		
		error:=0
		Case of 
			: (($b_esAlias) & ($t_rutaOriginal=""))
				AT_Delete ($i;1;$y_nombreDocumento;$y_RutaDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono)
				
			: (Test path name:C476($y_RutaDocumento->{$i})=Is a document:K24:1)
				error:=0
				GET DOCUMENT PROPERTIES:C477($y_RutaDocumento->{$i};$b_locked;$b_invisible;$d_createdOn;$h_createdAt;$d_modifiedOn;$h_modifiedAt)
				$t_tipoDocumento:=_o_Document type:C528($y_RutaDocumento->{$i})
				  //If (($b_invisible) | (error#0))
				If ($b_invisible)
					AT_Delete ($i;1;$y_RutaDocumento;$y_nombreDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono)
				Else 
					GET DOCUMENT ICON:C700($y_RutaDocumento->{$i};$p_Icon;16)
					$r_Size:=Get document size:C479($y_RutaDocumento->{$i})
					$r_SizeKB:=Round:C94($r_Size/1000;0)
					$r_SizeMB:=Round:C94($r_SizeKB/1000;1)
					$r_SizeGB:=Round:C94($r_SizeMB/1000;1)
					Case of 
						: ($r_SizeGB>=1)
							$y_Tamaño->{$i}:=String:C10($r_SizeGB;"### ##0,0 GB")
						: ($r_SizeMB>=1)
							$y_Tamaño->{$i}:=String:C10($r_SizeMB;"### ##0,0 MB")
						: ($r_SizeKB>=1)
							$y_Tamaño->{$i}:=String:C10($r_SizeKB;"### ##0 KB")
						Else 
							$y_Tamaño->{$i}:=String:C10($r_Size;"### ##0 bytes")
					End case 
					$y_FechaCreacion->{$i}:=String:C10($d_createdOn;Internal date short:K1:7)+", "+String:C10($h_createdAt;HH MM SS:K7:1)
					$y_FechaModificacion->{$i}:=String:C10($d_modifiedOn;Internal date short:K1:7)+", "+String:C10($h_modifiedAt;HH MM SS:K7:1)
					$y_Icono->{$i}:=$p_Icon
				End if 
				
			: (Test path name:C476($y_RutaDocumento->{$i})=Is a folder:K24:2)
				$y_FechaCreacion->{$i}:=""
				$y_FechaModificacion->{$i}:=""
				Case of 
					: ((SYS_IsMacintosh ) & (($y_nombreDocumento->{$i}="Volumes") | ($y_nombreDocumento->{$i}="usr") | ($y_nombreDocumento->{$i}="sbin") | ($y_nombreDocumento->{$i}="bin") | ($y_nombreDocumento->{$i}="cores") | ($y_nombreDocumento->{$i}="Network") | ($y_nombreDocumento->{$i}="Private") | ($y_nombreDocumento->{$i}="home") | ($y_nombreDocumento->{$i}="net") | ($y_RutaDocumento->{$i}=$t_nombreUsuario)))
						AT_Delete ($i;1;$y_nombreDocumento;$y_RutaDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono)
						
					: (($y_RutaDocumento->{$i}=".@") | ($y_RutaDocumento->{$i}="{@"))
						AT_Delete ($i;1;$y_nombreDocumento;$y_RutaDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono)
						
					: (($y_RutaDocumento->{$i}="@.app") | ($y_RutaDocumento->{$i}="@.bundle") | ($y_RutaDocumento->{$i}="@.4dbase") | ($y_RutaDocumento->{$i}="@.pkg"))
						GET DOCUMENT ICON:C700($y_RutaDocumento->{$i};$p_Icon;16)
						$y_Icono->{$i}:=$p_Icon
					Else 
						GET DOCUMENT ICON:C700($y_RutaDocumento->{$i};$p_Icon;16)
						$y_Icono->{$i}:=$p_Icon
				End case 
				
			Else 
				AT_Delete ($i;1;$y_nombreDocumento;$y_RutaDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono)
		End case 
	End for 
	
	For ($i;1;Size of array:C274($at_carpetas))
		APPEND TO ARRAY:C911($y_rutaDocumento->;$t_rutaCarpeta+Folder separator:K24:12+$at_carpetas{$i})
		APPEND TO ARRAY:C911($y_nombreDocumento->;$at_carpetas{$i})
		APPEND TO ARRAY:C911($y_FechaCreacion->;$at_creacionCarpeta{$i})
		APPEND TO ARRAY:C911($y_FechaModificacion->;$at_ModificacionCarpeta{$i})
		APPEND TO ARRAY:C911($y_Tamaño->;"– –")
		APPEND TO ARRAY:C911($y_Icono->;$ap_IconoCarpeta{$i})
	End for 
	
	SORT ARRAY:C229($y_nombreDocumento;$y_RutaDocumento;$y_FechaCreacion;$y_FechaModificacion;$y_Tamaño;$y_Icono;>)
	ON ERR CALL:C155("")
End if 