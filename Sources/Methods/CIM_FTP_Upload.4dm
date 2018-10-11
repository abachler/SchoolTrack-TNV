//%attributes = {}
  // CIM_FTP_Upload()
  // Por: Alberto Bachler K.: 06-11-14, 17:27:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_eliminarComprimido;$b_expanded)
C_LONGINT:C283($l_ConnexionID;$l_draggedElement;$l_dropPosition;$l_itemRef;$l_processID)
C_POINTER:C301($y_rutaArchivo;$y_source)
C_REAL:C285($l_numeroCampo;$l_numeroTabla;$l_refSublista;$p)
C_TEXT:C284($t_destinationPath;$t_login;$t_nombreVariable;$t_Password;$t_resultado;$t_rutaArchivo;$t_SourceMachine;$t_URl;$t_volumeName)


DRAG AND DROP PROPERTIES:C607($y_source;$l_draggedElement;$l_processID)


  //AS. 20110726 se agrega validación para cuando se tratan de mover los archivos en la ventana de FTP.
If (Is nil pointer:C315($y_source))
	$t_rutaArchivo:=IT_archivosArrastrados 
	
Else 
	RESOLVE POINTER:C394($y_source;$t_nombreVariable;$l_numeroTabla;$l_numeroCampo)
	
	If ($t_nombreVariable#"lb_FTP_List")
		$y_rutaArchivo:=OBJECT Get pointer:C1124(Object named:K67:5;"localRuta")
		$t_rutaArchivo:=$y_rutaArchivo->{$l_draggedElement}
	End if 
End if 

If ($t_rutaArchivo#"")
	
	If (Test path name:C476($t_rutaArchivo)=Is a folder:K24:2)
		$l_processID:=IT_UThermometer (1;0;"Comprimiendo carpeta o aplicacion...";-5)
		DELAY PROCESS:C323(Current process:C322;15)
		SYS_CompresionDescompresion ($t_rutaArchivo;"";"";->$t_resultado)
		$l_processID:=IT_UThermometer (-2;$l_processID;"Comprimiendo carpeta o aplicacion...")
		$t_rutaArchivo:=$t_resultado
		$b_eliminarComprimido:=True:C214
	End if 
	
	$l_ConnexionID:=$1
	$t_URl:=$2
	$t_login:=$3
	$t_Password:=$4
	$t_SourceMachine:=$5
	
	
	$l_dropPosition:=Drop position:C608
	GET LIST ITEM:C378(hlCIM_FTPDirectories;Selected list items:C379(hlCIM_FTPDirectories);$l_itemRef;$t_volumeName;$l_refSublista;$b_expanded)
	GET LIST ITEM PARAMETER:C985(hlCIM_FTPDirectories;$l_itemRef;"FTPpath";$t_destinationPath)
	If ($l_dropPosition<0)
		  //$t_destinationPath:="//"+SYS_Path2FileName ($t_rutaArchivo)
	Else 
		Case of 
			: (aiFTP_ObjectKind{$l_dropPosition}=1)
				$l_tipoObjeto:=aiFTP_ObjectKind{$l_dropPosition}
				$t_destinationPath:=atFTP_Paths{$l_dropPosition}+"/"
			: (aiFTP_ObjectKind{$l_dropPosition}=0)
				
		End case 
	End if 
	
	If ($t_destinationPath="")
		$t_destinationPath:="/"
	End if 
	
	Case of 
		: (($t_SourceMachine="Client") | ($t_SourceMachine=""))
			FTP_Upload (0;$t_destinationPath;$t_rutaArchivo;$t_URl;$t_login;$t_Password;$t_SourceMachine;<>RegisteredName;$b_eliminarComprimido)
			CIM_FTP_ExplorerEvents ("updateDirectory")
	End case 
End if 

