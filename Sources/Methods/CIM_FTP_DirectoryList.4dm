//%attributes = {}
  // MÉTODO: CIM_FTP_DirectoryList
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 24/06/11, 17:03:08
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // CIM_FTP_DirectoryList()
  // ----------------------------------------------------
C_DATE:C307($d_date)
C_LONGINT:C283($i;$l_error)
C_TIME:C306($h_docRef;$h_time)
C_PICTURE:C286($p_icon)
C_REAL:C285($r_docSize;$r_Size;$r_SizeGB;$r_SizeKB;$r_SizeMB)
C_TEXT:C284($t_parameters)


  // DECLARACIONES E INICIALIZACIONES
$t_parameters:=$1


  // CODIGO PRINCIPAL
$l_error:=FTP_VerifyConexionStatus (vlFTP_ConectionID;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;->vlFTP_ConectionID)

If ($l_error=0)
	FTP_SetCurrentDirPath ($t_parameters;True:C214)
	FTP_ChangeDirectory (vlFTP_ConectionID;$t_parameters)
	
	ARRAY TEXT:C222(atFTP_Paths;0)
	ARRAY TEXT:C222(atFTP_ObjectSize;0)
	ARRAY TEXT:C222(atFTP_ObjectDate;0)
	ARRAY PICTURE:C279(apFTP_ObjectIcon;0)
	
	ARRAY TEXT:C222(atFTP_Paths;Size of array:C274(atFTP_ObjectNames))
	ARRAY TEXT:C222(atFTP_ObjectSize;Size of array:C274(atFTP_ObjectNames))
	ARRAY TEXT:C222(atFTP_ObjectDate;Size of array:C274(atFTP_ObjectNames))
	ARRAY PICTURE:C279(apFTP_ObjectIcon;Size of array:C274(atFTP_ObjectNames))
	For ($i;Size of array:C274(alFTP_ObjectSize);1;-1)
		Case of 
			: ((atFTP_ObjectNames{$i}=".") | (atFTP_ObjectNames{$i}=".."))
				AT_Delete ($i;1;->atFTP_ObjectNames;->alFTP_ObjectSize;->aiFTP_ObjectKind;->adFTP_ObjectDate;->apFTP_ObjectIcon;->atFTP_ObjectSize;->atFTP_ObjectDate;->alFTP_ObjectTime;->atFTP_Paths)
			: (aiFTP_ObjectKind{$i}=1)
				  //atFTP_ObjectNames{$i}:=atFTP_ObjectNames{$i}
				If (SYS_IsMacintosh )
					GET PICTURE FROM LIBRARY:C565(31981;$p_icon)
				Else 
					GET PICTURE FROM LIBRARY:C565(27511;$p_icon)
				End if 
				apFTP_ObjectIcon{$i}:=$p_icon
				atFTP_ObjectSize{$i}:="– –"
				atFTP_Paths{$i}:=$t_Parameters+"/"+atFTP_ObjectNames{$i}
				
				  //AT_Delete ($i;1;->atFTP_ObjectNames;->alFTP_ObjectSize;->aiFTP_ObjectKind;->adFTP_ObjectDate;->apFTP_ObjectIcon;->atFTP_ObjectSize;->atFTP_ObjectDate;->alFTP_ObjectTime)
			Else 
				$h_docRef:=Create document:C266(atFTP_ObjectNames{$i})
				CLOSE DOCUMENT:C267($h_docRef)
				GET DOCUMENT ICON:C700(document;$p_icon;16)
				DELETE DOCUMENT:C159(document)
				  //atFTP_ObjectNames{$i}:=atFTP_ObjectNames{$i}
				apFTP_ObjectIcon{$i}:=$p_icon
				atFTP_Paths{$i}:=$t_Parameters+"/"+atFTP_ObjectNames{$i}
				
				$r_docSize:=alFTP_ObjectSize{$i}
				$h_time:=alFTP_ObjectTime{$i}
				$d_date:=adFTP_ObjectDate{$i}
				
				$r_Size:=alFTP_ObjectSize{$i}
				$r_SizeKB:=Round:C94($r_Size/1000;0)
				$r_SizeMB:=Round:C94($r_SizeKB/1000;1)
				$r_SizeGB:=Round:C94($r_SizeMB/1000;1)
				Case of 
					: ($r_SizeGB>=1)
						atFTP_ObjectSize{$i}:=String:C10($r_SizeGB;"### ##0,0 GB")
					: ($r_SizeMB>=1)
						atFTP_ObjectSize{$i}:=String:C10($r_SizeMB;"### ##0,0 MB")
					: ($r_SizeKB>=1)
						atFTP_ObjectSize{$i}:=String:C10($r_SizeKB;"### ##0 KB")
					Else 
						atFTP_ObjectSize{$i}:=String:C10($r_Size;"### ##0 bytes")
				End case 
				  //$atSize{$i}:=String(Get document size($filePath))+" bytes"
				atFTP_ObjectDate{$i}:=String:C10($d_date;Internal date short:K1:7)+", "+String:C10($h_time;HH MM SS:K7:1)
		End case 
	End for 
End if 