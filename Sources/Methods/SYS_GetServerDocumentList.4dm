//%attributes = {"executedOnServer":true}
  // Método: SYS_GetServerDocumentList
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/08/10, 12:36:57
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_BLOB:C604($x_blob)
C_TEXT:C284($1)
C_BOOLEAN:C305($b_invisible;$b_locked)
C_DATE:C307($d_createdOn;$d_modifiedOn)
C_TIME:C306($h_createdAt;$h_modifiedAt)
C_PICTURE:C286($p_Icon)
C_REAL:C285($r_Size;$r_SizeGB;$r_SizeKB;$r_SizeMB)
C_TEXT:C284($t_filePath;$t_path)

ARRAY TEXT:C222($at_Documents;0)
ARRAY TEXT:C222($at_Packages;0)



  // Código principal
$t_path:=$1


If ($t_path#"")
	If ($t_Path[[Length:C16($t_Path)]]=Folder separator:K24:12)
		$t_Path:=Substring:C12($t_Path;1;Length:C16($t_path)-1)
	End if 
	ON ERR CALL:C155("ERR_GenericOnError")
	If (SYS_IsMacintosh )
		FOLDER LIST:C473($t_path;$at_Packages)
		ARRAY TEXT:C222($atPack_DateCreated;Size of array:C274($at_Packages))
		ARRAY TEXT:C222($atPack_DateModified;Size of array:C274($at_Packages))
		ARRAY BOOLEAN:C223($abPack_Locked;Size of array:C274($at_Packages))
		ARRAY TEXT:C222($atPack_Size;Size of array:C274($at_Packages))
		ARRAY PICTURE:C279($apPack_Icon;Size of array:C274($at_Packages))
		For ($i;Size of array:C274($at_Packages);1;-1)
			$t_filePath:=$t_path+Folder separator:K24:12+$at_Packages{$i}
			Case of 
				: ((SYS_IsMacintosh ) & (($at_Packages{$i}="Volumes") | ($at_Packages{$i}="usr") | ($at_Packages{$i}="sbin") | ($at_Packages{$i}="bin") | ($at_Packages{$i}="cores") | ($at_Packages{$i}="Network") | ($at_Packages{$i}="Private")))
					AT_Delete ($i;1;->$at_Packages;->$apPack_Icon;->$atPack_Size;->$abPack_Locked;->$atPack_DateModified;->$atPack_DateCreated)
				: (($at_Packages{$i}=".@") | ($at_Packages{$i}="{@"))
					AT_Delete ($i;1;->$at_Packages;->$apPack_Icon;->$atPack_Size;->$abPack_Locked;->$atPack_DateModified;->$atPack_DateCreated)
				: (($at_Packages{$i}="@.app") | ($at_Packages{$i}="@.bundle") | ($at_Packages{$i}="@.4dbase") | ($at_Packages{$i}="@.pkg"))
					GET DOCUMENT ICON:C700($t_filePath;$p_Icon;16)
					$apPack_Icon{$i}:=$p_Icon
				Else 
					GET DOCUMENT ICON:C700($t_filePath;$p_Icon;16)
					$apPack_Icon{$i}:=$p_Icon
					
			End case 
		End for 
	End if 
	
	DOCUMENT LIST:C474($t_path;$at_Documents)
	ARRAY TEXT:C222($at_DateCreated;Size of array:C274($at_Documents))
	ARRAY TEXT:C222($at_DateModified;Size of array:C274($at_Documents))
	ARRAY BOOLEAN:C223($ab_Locked;Size of array:C274($at_Documents))
	ARRAY TEXT:C222($at_Size;Size of array:C274($at_Documents))
	ARRAY PICTURE:C279($ap_Icon;Size of array:C274($at_Documents))
	
	For ($i;Size of array:C274($at_Documents);1;-1)
		$t_filePath:=$t_path+Folder separator:K24:12+$at_Documents{$i}
		If (Test path name:C476($t_filePath)=1)
			error:=0
			GET DOCUMENT PROPERTIES:C477($t_filePath;$b_locked;$b_invisible;$d_createdOn;$h_createdAt;$d_modifiedOn;$h_modifiedAt)
			
			If (($b_invisible) | (error#0))
				AT_Delete ($i;1;->$at_Documents;->$at_DateCreated;->$at_DateModified;->$ab_Locked;->$at_Size;->$ap_Icon)
			Else 
				GET DOCUMENT ICON:C700($t_filePath;$p_Icon;16)
				$r_Size:=Get document size:C479($t_filePath)
				$r_SizeKB:=Round:C94($r_Size/1000;0)
				$r_SizeMB:=Round:C94($r_SizeKB/1000;1)
				$r_SizeGB:=Round:C94($r_SizeMB/1000;1)
				Case of 
					: ($r_SizeGB>=1)
						$at_Size{$i}:=String:C10($r_SizeGB;"### ##0,0 GB")
					: ($r_SizeMB>=1)
						$at_Size{$i}:=String:C10($r_SizeMB;"### ##0,0 MB")
					: ($r_SizeKB>=1)
						$at_Size{$i}:=String:C10($r_SizeKB;"### ##0 KB")
					Else 
						$at_Size{$i}:=String:C10($r_Size;"### ##0 bytes")
				End case 
				$at_DateCreated{$i}:=String:C10($d_createdOn;Internal date short:K1:7)+", "+String:C10($h_createdAt;HH MM SS:K7:1)
				$at_DateModified{$i}:=String:C10($d_modifiedOn;Internal date short:K1:7)+", "+String:C10($h_modifiedAt;HH MM SS:K7:1)
				$ab_Locked{$i}:=$b_locked
				$ap_Icon{$i}:=$p_Icon
			End if 
		Else 
			AT_Delete ($i;1;->$at_Documents;->$at_DateCreated;->$at_DateModified;->$ab_Locked;->$at_Size;->$ap_Icon)
		End if 
	End for 
	
	For ($i;1;Size of array:C274($at_Packages))
		APPEND TO ARRAY:C911($at_Documents;$at_Packages{$i})
		APPEND TO ARRAY:C911($at_DateCreated;$atPack_DateCreated{$i})
		APPEND TO ARRAY:C911($at_DateModified;$atPack_DateModified{$i})
		APPEND TO ARRAY:C911($ab_Locked;$abPack_Locked{$i})
		APPEND TO ARRAY:C911($at_Size;"– –")
		APPEND TO ARRAY:C911($ap_Icon;$apPack_Icon{$i})
	End for 
	
	SORT ARRAY:C229($at_Documents;$at_DateModified;$at_Size;$ap_Icon;$ab_Locked;>)
	
	BLOB_Variables2Blob (->$x_blob;0;->$at_Documents;->$at_DateModified;->$at_Size;->$ap_Icon;->$ab_Locked)
	$0:=$x_blob
	ON ERR CALL:C155("")
	
End if 