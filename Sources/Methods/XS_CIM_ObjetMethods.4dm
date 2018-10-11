//%attributes = {}
  //Método: XS_CIM_ObjetMethods
  //----------------------------------------------
  //Usuario(OS): Alberto Bachler
  //Fecha: 07/9/10, 13:12:03
  //---------------------------------------------
  //Descripción:
  //
  //Parámetros:
  //
  //----------------------------------------------
  //Declaraciones e inicializaciones
C_BLOB:C604($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_TEXT:C284($3)

C_BLOB:C604($x_Blob)
C_BOOLEAN:C305($b_alive;$b_expanded)
C_LONGINT:C283($deleteAt;$foundedRef;$hl_Volumes;$i;$ii;$iSub;$l_ConnexionID;$l_currentPage;$l_directoryRef;$l_docType)
C_LONGINT:C283($l_draggedElement;$l_dropPosition;$l_error;$l_fieldNum;$l_found;$l_itemRef;$l_ObjectType;$l_otRef;$l_processID;$l_processIDage)
C_LONGINT:C283($l_processIDageRef;$l_processIDId;$l_processIDositioninList;$l_Ref;$l_selected;$l_style;$l_subListRef;$l_subListRef2;$l_subListRefRef)
C_LONGINT:C283($l_tableNum;$l_tcp_ID;$l_volumeRef;$list;$p;$subitemRef;$subRef;$vl_CurrentBrowserHList;$vl_Volumes;$l_selectedItem;$l_infoRef)
C_TIME:C306($h_docRef;$time)
C_PICTURE:C286($p_icon;$p_icon)
C_POINTER:C301($y_Nil;$y_objectPointer;$y_source)
C_REAL:C285($r_docSize;$r_free;$r_size;$r_sizeGB;$r_sizeKB;$r_sizeMB;$r_used)
C_TEXT:C284($t_destinationFilePath;$t_directoryPath;$t_fieldName;$t_folderPath;$t_homeName;$t_subPath;$t_subText;$t_currentDirectory;$t_currentPath)
C_TEXT:C284($t_destinationPath;$t_DirName;$t_dirPath;$t_filePath;$t_hostPath;$t_info;$t_IPaddress;$t_ipConfig)
C_TEXT:C284($t_itemText;$t_loggedUser;$t_login;$t_method;$t_parameters;$t_Password;$t_path;$t_SourceMachine;$t_sourcePath;$t_string)
C_TEXT:C284($t_URl;$t_varName;$t_volumeName)

ARRAY LONGINT:C221($al_SelectedTasks;0)
ARRAY DATE:C224($adFTP_ObjectDate;0)
ARRAY DATE:C224($adFTP_SubDirDate;0)
ARRAY INTEGER:C220($aiFTP_ObjectKInd;0)
ARRAY INTEGER:C220($aiFTP_SubDirKInd;0)
ARRAY LONGINT:C221($alFTP_ObjectSize;0)
ARRAY LONGINT:C221($alFTP_ObjectTime;0)
ARRAY LONGINT:C221($alFTP_SubDirSize;0)
ARRAY LONGINT:C221($alFTP_SubDirTime;0)
ARRAY PICTURE:C279($apFTP_ObjectIcon;0)
ARRAY PICTURE:C279($apFTP_SubDirIcon;0)
ARRAY TEXT:C222($atFTP_ObjectNames;0)
ARRAY TEXT:C222($atFTP_ObjectSize;0)
ARRAY TEXT:C222($atFTP_SubDirNames;0)
ARRAY TEXT:C222($atFTP_SubDirSize;0)


If (False:C215)
	C_BLOB:C604(XS_CIM_ObjetMethods ;$0)
	C_TEXT:C284(XS_CIM_ObjetMethods ;$1)
	C_POINTER:C301(XS_CIM_ObjetMethods ;$2)
	C_TEXT:C284(XS_CIM_ObjetMethods ;$3)
End if 

C_LONGINT:C283(vl_CurrentBrowserHList)
C_LONGINT:C283(hl_Volumes)

  //Código principal
Case of 
	: (Count parameters:C259=1)
		$t_method:=$1
	: (Count parameters:C259=2)
		$t_method:=$1
		$y_objectPointer:=$2
	: (Count parameters:C259=3)
		$t_method:=$1
		$y_objectPointer:=$2
		$t_parameters:=$3
End case 

If (Not:C34(Is nil pointer:C315($y_objectPointer)))
	RESOLVE POINTER:C394($y_objectPointer;$t_varName;$l_tableNum;$l_fieldNum)
	If ($l_tableNum>0) & ($l_fieldNum>0)
		$t_fieldName:="["+Table name:C256($l_tableNum)+"]"+Field name:C257($l_tableNum;$l_fieldNum)
	End if 
Else 
	$y_objectPointer:=$y_Nil
End if 

Case of 
	: ($t_method="")
		  //inicializaciones
		vb_CalculateFolderSize:=False:C215
		
		ARRAY LONGINT:C221(al_DBinfo_TableIds;0)
		ARRAY TEXT:C222(at_DBinfo_TableNames;0)
		ARRAY LONGINT:C221(al_DBinfo_recordCount;0)
		ARRAY REAL:C219(ar_DBinfo_avgRecordSize;0)
		ARRAY REAL:C219(ar_DBinfo_tableSize;0)
		ARRAY REAL:C219(ar_DBinfo_maxSize;0)
		ARRAY REAL:C219(ar_DBinfo_minSize;0)
		ARRAY REAL:C219(ar_DBinfo_fragmentation;0)
		
		  //BKP_VerifyPrefFile 
		WDW_OpenFormWindow ($y_Nil;"CIM_Principal";-1;8;__ ("Centro de Ayuda y Mantenimiento"))
		DIALOG:C40("CIM_Principal")
		CLOSE WINDOW:C154
		
	: ($t_method="TableInfoEvents")
		
		
		
		
		
		
		
	: ($t_method="LocalInfo")
		CIM_INFO_Local 
		
	: ($t_method="ServerInfo")
		CIM_INFO_Server 
		
		
		
		
	: ($t_method="ShowUserTasks")
		$y_recNumUsuarios:=OBJECT Get pointer:C1124(Object named:K67:5;"usuariosRecNum")
		If ($y_recNumUsuarios->>0)
			KRL_GotoRecord (->[xShell_UserConnections:281];$y_recNumUsuarios->{$y_recNumUsuarios->})
			$l_idUsuario:=[xShell_UserConnections:281]UserID:1
			QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]UserID:1=$l_idUsuario)
		Else 
			ALL RECORDS:C47([xShell_UserEvents:282])
		End if 
		ARRAY LONGINT:C221($al_SelectedTasks;0)
		If (LB_GetSelectedRows (->lb_TaskTypes;->$al_SelectedTasks)>0)
			For ($i;1;Size of array:C274($al_SelectedTasks))
				$al_SelectedTasks{$i}:=<>al_lbTaskTypes_Ids{$al_SelectedTasks{$i}}
			End for 
			QUERY SELECTION WITH ARRAY:C1050([xShell_UserEvents:282]Event:6;$al_SelectedTasks)
		End if 
		ORDER BY:C49([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3;<)
		
	: ($t_method="ShowTasksbyTask")
		
		
		
	: ($t_method="LocalMachinesBrowser")
		CIM_BWR_LocalDirectoryList 
		
	: ($t_method="LocalDirectoriesBrowser")
		CIM_BWR_ExplorerEvents ("updateDirectory")
		
		
	: ($t_method="ConnectionPrefs")
		CIM_FTP_ConnectionData 
		
	: ($t_method="OpenFTPConnection")
		CIM_FTP_OpenConnexion 
		
	: ($t_method="FTP_GetRootDirectories")
		CIM_FTP_GetRootDirectories 
		
	: ($t_method="FTP_ListFiles")
		CIM_FTP_DirectoryList ($t_Parameters)
		
	: ($t_method="FTP_GetSubDirectories")
		$0:=CIM_FTP_GetSubDirectories ($t_parameters)
		
	: ($t_method="FTPSelectDirectory")
		CIM_FTP_ExplorerEvents 
		
	: ($t_method="FTPListEvents")
		CIM_FTP_DirectoryEvents 
		
	: ($t_method="FTP_Download")
		CIM_FTP_Download (Num:C11($t_parameters))
		
	: ($t_method="FTP_Upload")
		CIM_FTP_Upload (vlFTP_ConectionID;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;vt_CurrentLocalMachine)
		
	: ($t_method="FTP_Delete")
		CIM_FTP_Delete 
		
	: ($t_method="FTP_MakeDir")
		CIM_FTP_CreateDirectories (vlFTP_ConectionID;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword)
End case 

