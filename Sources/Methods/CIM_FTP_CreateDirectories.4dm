//%attributes = {}
  // MÉTODO: CIM_FTP_CreateDirectories
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/06/11, 09:35:53
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // CIM_FTP_CreateDirectories()
  // ----------------------------------------------------

  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($l_ConnexionID;$l_error;$1)
C_TEXT:C284($t_destinationPath;$t_path;$2;$3;$4;$5;$6)
$l_ConnexionID:=$1
$t_URl:=$2
$t_login:=$3
$t_Password:=$4


  // CODIGO PRINCIPAL
$t_dirName:=CD_Request (__ ("Nombre de la carpeta");__ ("OK");__ ("Cancelar"))

If ($t_dirName#"")
	$l_found:=Find in array:C230(atFTP_ObjectNames;$t_dirName)
	If ($l_Found<0)
		GET LIST ITEM:C378(hlCIM_FTPDirectories;Selected list items:C379(hlCIM_FTPDirectories);$l_itemRef;$t_volumeName;$list;$b_expanded)
		GET LIST ITEM PARAMETER:C985(hlCIM_FTPDirectories;$l_itemRef;"FTPpath";$t_destinationPath)
		If ($t_destinationPath="")
			$t_destinationPath:="/"
		End if 
		$t_Path:=$t_destinationPath+"/"+$t_dirName
		FTP_CreatePath ($l_ConnexionID;$t_Path;$t_URl;$t_login;$t_Password)
		XS_CIM_ObjetMethods ("FTP_ListFiles";$y_Nil;$t_destinationPath)
	Else 
		CD_Dlog (0;__ ("Ya existe una carpeta con el mismo nombre en este directorio."))
	End if 
End if 