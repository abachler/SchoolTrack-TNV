$folderIcon:=Use PicRef:K28:4+27511
$y_lista:=OBJECT Get pointer:C1124(Object current:K67:2)
Case of 
	: (Form event:C388=On Expand:K2:41)
		GET LIST ITEM:C378($y_lista->;*;$l_refItem;$t_nombreItem;$l_refSublista;$expanded)
		$refManual:=$ref
		If ($ref<0)
			If ($expanded)
				$refDir:=$ref
				SET LIST ITEM:C385(Self:C308->;$ref;$manual;$ref;0;False:C215)
				$dir:=""
				$parent:=List item parent:C633(Self:C308->;$ref)
				While ($parent#0)
					SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$parent)
					GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
					$dir:=$text+"/"+$dir
					$parent:=List item parent:C633(Self:C308->;$parent)
				End while 
				$dir:="/Manuales/"+$dir+$manual
				SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$refDir)
				FTP_ChangeDirectory (vlFTP_ConectionID;$dir)
				For ($i;Size of array:C274(atFTP_ObjectNames);1;-1)
					If ((atFTP_ObjectNames{$i}=".") | (atFTP_ObjectNames{$i}=".."))
						AT_Delete ($i;1;->atFTP_ObjectNames;->alFTP_ObjectSize;->aiFTP_ObjectKind;->adFTP_ObjectDate)
					End if 
				End for 
				
				$subList2:=New list:C375
				For ($i;1;Size of array:C274(atFTP_ObjectNames))
					If (aiFTP_ObjectKInd{$i}=0)
						vl_PositiveNextRef:=vl_PositiveNextRef+1
						APPEND TO LIST:C376($subList2;_O_Win to Mac:C464(atFTP_ObjectNames{$i});vl_PositiveNextRef;0;False:C215)
					Else 
						$subList:=New list:C375
						vl_NegativeNextRef:=vl_NegativeNextRef-1
						vl_PositiveNextRef:=vl_PositiveNextRef+1
						APPEND TO LIST:C376($subList;"";vl_PositiveNextRef)
						APPEND TO LIST:C376($subList2;_O_Win to Mac:C464(atFTP_ObjectNames{$i});vl_NegativeNextRef;$subList;False:C215)
						SET LIST ITEM PROPERTIES:C386($subList2;0;False:C215;0;$folderIcon)
					End if 
				End for 
				SET LIST ITEM:C385(Self:C308->;$refDir;$manual;$refDir;$subList2;True:C214)
				_O_REDRAW LIST:C382(Self:C308->)
			End if 
			_O_DISABLE BUTTON:C193(bDescargar)
		Else 
			$filePath:=""
			$parent:=List item parent:C633(Self:C308->;$ref)
			While ($parent#0)
				SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$parent)
				GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
				$filePath:=$text+"/"+$filePath
				$parent:=List item parent:C633(Self:C308->;$parent)
			End while 
			$filePath:="/Manuales/"+$filePath+$manual
			SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$refManual)
			_O_ENABLE BUTTON:C192(bDescargar)
			FTP_Manual ($filePath)
		End if 
	: (Form event:C388=On Clicked:K2:4)
		GET LIST ITEM:C378($y_lista->;*;$l_refItem;$t_nombreItem;$l_refSublista;$expanded)
		GET LIST ITEM PARAMETER:C985($y_lista->;*;"url";$t_url)
		$t_rutaLocal:=System folder:C487(Desktop:K41:16)+Generate UUID:C1066+".pdf"
		$t_destinationPath:="Macintosh:Desarrollo:"+Generate UUID:C1066+".pdf"
		$l_error:=Test path name:C476($t_destinationPath)
		  //$error:=FTP_Progress (100;100;"Descargando '"+$t_nombreItem+"'";"*";"*")
		  //If ($error=0)
		  //$error:=FTP_Receive (vlFTP_ConectionID;$t_url;$t_rutaLocal;1)
		  //If ($error#10000)  // Cancel by the user
		  //If ($error#0)
		  //CD_Dlog (0;IT_ErrorText ($error))
		  //Else 
		  //CD_Dlog (0;__ ("Descarga completa."))
		  //End if 
		  //End if 
		  //Else 
		  //CD_Dlog (0;IT_ErrorText ($error))
		  //End if 
		
		  //$t_destinationPath:=$t_destinationPath+Folder separator+$t_nombreItem
		$l_error:=FTP_VerifyConexionStatus (vlFTP_ConectionID;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;->vlFTP_ConectionID)
		If ($l_error=0)
			FTP_GetFile ($t_url;$t_destinationPath)
			  //XS_CIM_ObjetMethods ("LocalDirectoriesBrowser";$y_Nil;"updateDirectory")
		End if 
		
		  //$t_rutaLocal:=Temporary folder+Generate UUID+".pdf"
		  //$error:=FTP_Progress (100;100;"Descargando '"+$t_nombreItem+"'";"*";"*")
		  //If ($error=0)
		  //$vt_LocalPath:=""
		  //$error:=FTP_Receive (vlFTP_ConectionID;$t_url;$t_rutaLocal;1)
		  //If ($error#10000)  // Cancel by the user
		  //If ($error#0)
		  //CD_Dlog (0;IT_ErrorText ($error))
		  //End if 
		  //End if 
		  //End if 
		
		
		  //FTP_GetFile ($t_url;$t_rutaLocal)
		SHOW ON DISK:C922($t_rutaLocal)
		  //FTP_Manual ($filePath)
		  //WA OPEN URL(*;"webArea";$t_url)
		  //WA OPEN URL(*;"webArea";"http://www.apple.com")
End case 