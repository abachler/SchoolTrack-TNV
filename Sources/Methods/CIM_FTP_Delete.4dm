//%attributes = {}
  // MÉTODO: CIM_FTP_Delete
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 25/06/11, 09:25:38
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // CIM_FTP_Delete()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL


GET LIST ITEM:C378(hlCIM_FTPDirectories;Selected list items:C379(hlCIM_FTPDirectories);$l_itemRef;$t_volumeName;$list;$b_expanded)
GET LIST ITEM PARAMETER:C985(hlCIM_FTPDirectories;$l_itemRef;"FTPpath";$t_Path)

If ($t_path="")
	$t_path:="/"
End if 
$l_ObjectType:=aiFTP_ObjectKind{atFTP_ObjectNames}
FTP_DeleteObject (vlFTP_ConectionID;atFTP_Paths{atFTP_ObjectNames};$l_ObjectType;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftpPassword)
XS_CIM_ObjetMethods ("FTP_ListFiles";$y_Nil;$t_Path)