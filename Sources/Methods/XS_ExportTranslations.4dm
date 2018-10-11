//%attributes = {}
  //XS_ExportTranslations

C_POINTER:C301($y_campo)

WDW_OpenFormWindow (->[xShell_Dialogs:114];"XS_ConfigTranslationsExport";0;4;__ ("Configuración de la exportación"))
DIALOG:C40([xShell_Dialogs:114];"XS_ConfigTranslationsExport")
CLOSE WINDOW:C154
If (ok=1)
	$source:="Mac"
	If (bMAC=1)
		$dest:="Mac"
	Else 
		$dest:="Win"
	End if 
	
	
	$what:=atXS_ExportQue
	Case of 
		: ($what=5)
			$ExportBlobs:=False:C215
			$ExportFields:=False:C215
			$ExportCommands:=True:C214
			$ExportTables:=False:C215
		: ($what=6)
			$ExportBlobs:=True:C214
			$ExportFields:=False:C215
			$ExportCommands:=False:C215
			$ExportTables:=False:C215
		: ($what=4)
			$ExportBlobs:=False:C215
			$ExportFields:=True:C214
			$ExportCommands:=False:C215
			$ExportTables:=False:C215
		: ($what=3)
			$ExportBlobs:=False:C215
			$ExportFields:=False:C215
			$ExportCommands:=False:C215
			$ExportTables:=True:C214
		: ($what=1)
			$ExportBlobs:=True:C214
			$ExportFields:=True:C214
			$ExportCommands:=True:C214
			$ExportTables:=True:C214
	End case 
	
	READ ONLY:C145([xShell_TableAlias:199])
	READ ONLY:C145([xShell_FieldAlias:198])
	READ ONLY:C145([xShell_Prefs:46])
	
	ARRAY TEXT:C222($aCountryCodes;0)
	ARRAY TEXT:C222($aLanguageCodes;0)
	
	LIST TO ARRAY:C288("XS_CountryCodes";$aCountryCodes)
	LIST TO ARRAY:C288("XS_LangageCodes";$aLanguageCodes)
	
	
	$folderPath:=xfGetDirName ("Por favor seleccione la carpeta de destino")
	If (ok=1)
		$iterCountryLang:=Size of array:C274($aCountryCodes)*Size of array:C274($aLanguageCodes)
		If ($ExportTables)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando nombres de tablas..."))
			$iterations:=0
			$finalIter:=Records in table:C83([xShell_Tables:51])*$iterCountryLang
			For ($i;1;Size of array:C274($aCountryCodes))
				$country:=ST_GetWord ($aCountryCodes{$i};1;":")
				For ($j;1;Size of array:C274($aLanguageCodes))
					$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
					QUERY:C277([xShell_TableAlias:199];[xShell_TableAlias:199]TableRef:1=("@."+$country+"."+$langage))
					SELECTION TO ARRAY:C260([xShell_TableAlias:199]TableRef:1;$aIntRefs;[xShell_TableAlias:199]Alias:2;$aIntAlias)
					SORT ARRAY:C229($aIntAlias;$aIntRefs;>)
					$fileName:=$folderPath+"Table_"+$country+"_"+$langage+".txt"
					If (SYS_TestPathName ($fileName)=Is a document:K24:1)
						DELETE DOCUMENT:C159($fileName)
					End if 
					$ref:=Create document:C266($fileName)
					For ($o;1;Size of array:C274($aIntRefs))
						$iterations:=$iterations+1
						$line:=$aIntRefs{$o}+"\t"+XSvs_nombreTablaLocal_Numero (Num:C11($aIntRefs{$o});"cl";"es")+"\t"+$aIntAlias{$o}+"\r"
						$line:=ST_ConvertText ($line;$source;$dest)
						SEND PACKET:C103($ref;$line)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
					End for 
					CLOSE DOCUMENT:C267($ref)
				End for 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
		If ($ExportFields)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando nombres de campos..."))
			$iterations:=0
			$finalIter:=Records in table:C83([xShell_Fields:52])*$iterCountryLang
			For ($i;1;Size of array:C274($aCountryCodes))
				$country:=ST_GetWord ($aCountryCodes{$i};1;":")
				For ($j;1;Size of array:C274($aLanguageCodes))
					$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
					QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]PaisLenguaje:6;=;$country+"."+$langage)
					SELECTION TO ARRAY:C260([xShell_FieldAlias:198]Alias:3;$aIntAlias;[xShell_FieldAlias:198]Referencia_tablaCampo:1;$at_referenciaTablaCampo)
					SORT ARRAY:C229($at_referenciaTablaCampo;$aIntAlias;$aIntRefs;>)
					$fileName:=$folderPath+"Field_"+$country+"_"+$langage+".txt"
					If (SYS_TestPathName ($fileName)=Is a document:K24:1)
						DELETE DOCUMENT:C159($fileName)
					End if 
					$ref:=Create document:C266($fileName)
					For ($o;1;Size of array:C274($aIntRefs))
						$iterations:=$iterations+1
						$y_campo:=Field:C253(Num:C11(ST_GetWord ($at_referenciaTablaCampo{$o};1;"."));Num:C11(ST_GetWord ($at_referenciaTablaCampo{$o};2;".")))
						$line:=String:C10($at_referenciaTablaCampo{$o})+"\t"+XSvs_nombreCampoLocal_puntero ($y_campo;"cl";"es")+"\t"+$aIntAlias{$o}+"\r"
						$line:=ST_ConvertText ($line;$source;$dest)
						SEND PACKET:C103($ref;$line)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
					End for 
					CLOSE DOCUMENT:C267($ref)
				End for 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
		
		
		
		If ($ExportCommands)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando nombres y descripciones de comandos..."))
			$iterations:=0
			$finalIter:=$iterCountryLang*Records in table:C83([xShell_ExecutableCommands:19])
			For ($i;1;Size of array:C274($aCountryCodes))
				$country:=ST_GetWord ($aCountryCodes{$i};1;":")
				For ($j;1;Size of array:C274($aLanguageCodes))
					$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
					$fileName:=$folderPath+"Comma_"+$country+"_"+$langage+".txt"
					If (SYS_TestPathName ($fileName)=Is a document:K24:1)
						DELETE DOCUMENT:C159($fileName)
					End if 
					$ref:=Create document:C266($fileName)
					ALL RECORDS:C47([xShell_ExecutableCommands:19])
					ARRAY LONGINT:C221($aCommRecNum;0)
					LONGINT ARRAY FROM SELECTION:C647([xShell_ExecutableCommands:19];$aCommRecNum;"")
					For ($h;1;Size of array:C274($aCommRecNum))
						$iterations:=$iterations+1
						GOTO RECORD:C242([xShell_ExecutableCommands:19];$aCommRecNum{$h})
						$cl:=XS_GetCommandAliasDescription ($aCommRecNum{$h};"cl";"es")
						$int:=XS_GetCommandAliasDescription ($aCommRecNum{$h};$country;$langage)
						$line:=String:C10([xShell_ExecutableCommands:19]ID:10)+"\t"+ST_GetWord ($cl;1;"\t")+"\t"+ST_GetWord ($int;1;"\t")+"\t"+Replace string:C233(ST_GetWord ($cl;2;"\t");"\r";" ")+"\t"+Replace string:C233(ST_GetWord ($int;2;"\t");"\r";" ")+"\r"
						$line:=ST_ConvertText ($line;$source;$dest)
						SEND PACKET:C103($ref;$line)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
					End for 
					CLOSE DOCUMENT:C267($ref)
				End for 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
		
		
		
		
		If ($ExportBlobs)
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Exportando configuraciones de explorador..."))
			$iterations:=0
			$finalIter:=$iterCountryLang*5
			C_BLOB:C604($blob)
			For ($i;1;Size of array:C274($aCountryCodes))
				$country:=ST_GetWord ($aCountryCodes{$i};1;":")
				For ($j;1;Size of array:C274($aLanguageCodes))
					$langage:=ST_GetWord ($aLanguageCodes{$j};1;":")
					QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="XS_CFG_ConfigModule@")
					QUERY SELECTION:C341([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=("@#"+$country+"#"+$langage))
					ARRAY LONGINT:C221($aConfigRecNums;0)
					LONGINT ARRAY FROM SELECTION:C647([xShell_Prefs:46];$aConfigRecNums;"")
					For ($yy;1;Size of array:C274($aConfigRecNums))
						GOTO RECORD:C242([xShell_Prefs:46];$aConfigRecNums{$yy})
						$moduleNo:=Num:C11(ST_GetWord ([xShell_Prefs:46]Reference:1;2;"#"))
						$fileName:=$folderPath+"Confi"+String:C10($moduleNo)+"_"+$country+"_"+$langage+".txt"
						If (SYS_TestPathName ($fileName)=Is a document:K24:1)
							DELETE DOCUMENT:C159($fileName)
						End if 
						$ref:=Create document:C266($fileName)
						$blob:=[xShell_Prefs:46]_blob:10
						$hl_configInt:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						$blob:=PREF_fGetBlob (0;XS_GetBlobName ("config";$moduleNo;"cl";"es"))
						$hl_configcl:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						ARRAY TEXT:C222(aTextcl;0)
						ARRAY TEXT:C222(aTextInt;0)
						If (($hl_configcl#0) & ($hl_configInt#0))
							HL_ReferencedList2Array ($hl_configcl;->aTextcl)
							HL_ReferencedList2Array ($hl_configInt;->aTextInt)
							For ($g;1;Size of array:C274(aTextcl))
								$line:=ST_GetWord (aTextcl{$g};1;";")+"\t"+ST_GetWord (aTextInt{$g};1;";")+"\r"
								$line:=ST_ConvertText ($line;$source;$dest)
								SEND PACKET:C103($ref;$line)
							End for 
						End if 
						CLOSE DOCUMENT:C267($ref)
						AT_Initialize (->aTextcl;->aTextInt)
					End for 
					$iterations:=$iterations+1
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
					QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="XS_CFG_Wizards@")
					QUERY SELECTION:C341([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=("@#"+$country+"#"+$langage))
					ARRAY LONGINT:C221($aWizardsRecNUms;0)
					LONGINT ARRAY FROM SELECTION:C647([xShell_Prefs:46];$aWizardsRecNUms;"")
					For ($yy;1;Size of array:C274($aWizardsRecNUms))
						GOTO RECORD:C242([xShell_Prefs:46];$aWizardsRecNUms{$yy})
						$moduleNo:=Num:C11(ST_GetWord ([xShell_Prefs:46]Reference:1;2;"#"))
						$fileName:=$folderPath+"Wizar"+String:C10($moduleNo)+"_"+$country+"_"+$langage+".txt"
						If (SYS_TestPathName ($fileName)=Is a document:K24:1)
							DELETE DOCUMENT:C159($fileName)
						End if 
						$ref:=Create document:C266($fileName)
						$blob:=[xShell_Prefs:46]_blob:10
						$hl_AssistantsInt:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						$blob:=PREF_fGetBlob (0;XS_GetBlobName ("wizard";$moduleNo;"cl";"es"))
						$hl_Assistantscl:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						ARRAY TEXT:C222(aTextcl;0)
						ARRAY TEXT:C222(aTextInt;0)
						If (($hl_Assistantscl#0) & ($hl_AssistantsInt#0))
							HL_ReferencedList2Array ($hl_Assistantscl;->aTextcl)
							HL_ReferencedList2Array ($hl_AssistantsInt;->aTextInt)
							For ($g;1;Size of array:C274(aTextcl))
								$line:=ST_GetWord (aTextcl{$g};1;";")+"\t"+ST_GetWord (aTextInt{$g};1;";")+"\r"
								$line:=ST_ConvertText ($line;$source;$dest)
								SEND PACKET:C103($ref;$line)
							End for 
						End if 
						CLOSE DOCUMENT:C267($ref)
						AT_Initialize (->aTextcl;->aTextInt)
					End for 
					$iterations:=$iterations+1
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
					QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="XS_CFG_Services@")
					QUERY SELECTION:C341([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=("@#"+$country+"#"+$langage))
					ARRAY LONGINT:C221($aServiceRecNUms;0)
					LONGINT ARRAY FROM SELECTION:C647([xShell_Prefs:46];$aServiceRecNUms;"")
					For ($yy;1;Size of array:C274($aServiceRecNUms))
						GOTO RECORD:C242([xShell_Prefs:46];$aServiceRecNUms{$yy})
						$moduleNo:=Num:C11(ST_GetWord ([xShell_Prefs:46]Reference:1;2;"#"))
						$fileName:=$folderPath+"Servi"+String:C10($moduleNo)+"_"+$country+"_"+$langage+".txt"
						If (SYS_TestPathName ($fileName)=Is a document:K24:1)
							DELETE DOCUMENT:C159($fileName)
						End if 
						$ref:=Create document:C266($fileName)
						$blob:=[xShell_Prefs:46]_blob:10
						$hl_ServicesInt:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						$blob:=PREF_fGetBlob (0;XS_GetBlobName ("service";$moduleNo;"cl";"es"))
						$hl_Servicescl:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						ARRAY TEXT:C222(aTextcl;0)
						ARRAY TEXT:C222(aTextInt;0)
						If (($hl_Servicescl#0) & ($hl_ServicesInt#0))
							HL_ReferencedList2Array ($hl_Servicescl;->aTextcl)
							HL_ReferencedList2Array ($hl_ServicesInt;->aTextInt)
							For ($g;1;Size of array:C274(aTextcl))
								$line:=ST_GetWord (aTextcl{$g};1;";")+"\t"+ST_GetWord (aTextInt{$g};1;";")+"\r"
								$line:=ST_ConvertText ($line;$source;$dest)
								SEND PACKET:C103($ref;$line)
							End for 
						End if 
						CLOSE DOCUMENT:C267($ref)
						AT_Initialize (->aTextcl;->aTextInt)
					End for 
					$iterations:=$iterations+1
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
					QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="XS_CFG_ModuleBrowser@")
					QUERY SELECTION:C341([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=("@#"+$country+"#"+$langage))
					ARRAY LONGINT:C221($aBrowserRecNUms;0)
					LONGINT ARRAY FROM SELECTION:C647([xShell_Prefs:46];$aBrowserRecNUms;"")
					For ($yy;1;Size of array:C274($aBrowserRecNUms))
						GOTO RECORD:C242([xShell_Prefs:46];$aBrowserRecNUms{$yy})
						$moduleNo:=Num:C11(ST_GetWord ([xShell_Prefs:46]Reference:1;2;"#"))
						$fileName:=$folderPath+"Brows"+String:C10($moduleNo)+"_"+$country+"_"+$langage+".txt"
						If (SYS_TestPathName ($fileName)=Is a document:K24:1)
							DELETE DOCUMENT:C159($fileName)
						End if 
						$ref:=Create document:C266($fileName)
						$blob:=[xShell_Prefs:46]_blob:10
						$hl_BrowserInt:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						$blob:=PREF_fGetBlob (0;XS_GetBlobName ("browser";$moduleNo;"cl";"es"))
						$hl_Browsercl:=BLOB to list:C557($blob)
						SET BLOB SIZE:C606($blob;0)
						ARRAY TEXT:C222(aTextcl;0)
						ARRAY TEXT:C222(aTextInt;0)
						If (($hl_Browsercl#0) & ($hl_BrowserInt#0))
							HL_ReferencedList2Array ($hl_Browsercl;->aTextcl)
							HL_ReferencedList2Array ($hl_BrowserInt;->aTextInt)
							For ($g;1;Size of array:C274(aTextcl))
								$line:=ST_GetWord (aTextcl{$g};1;";")+"\t"+ST_GetWord (aTextInt{$g};1;";")+"\r"
								$line:=ST_ConvertText ($line;$source;$dest)
								SEND PACKET:C103($ref;$line)
							End for 
						End if 
						CLOSE DOCUMENT:C267($ref)
						AT_Initialize (->aTextcl;->aTextInt)
					End for 
					$iterations:=$iterations+1
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
					QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="@_Panel@")
					QUERY SELECTION:C341([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=("@#"+$country+"#"+$langage))
					ARRAY LONGINT:C221($aPanelRecNUms;0)
					LONGINT ARRAY FROM SELECTION:C647([xShell_Prefs:46];$aPanelRecNUms;"")
					For ($yy;1;Size of array:C274($aPanelRecNUms))
						GOTO RECORD:C242([xShell_Prefs:46];$aPanelRecNUms{$yy})
						$part1:=ST_GetWord ([xShell_Prefs:46]Reference:1;3;"_")
						$part2:=ST_GetWord ([xShell_Prefs:46]Reference:1;4;"_")
						$moduleNo:=Num:C11(ST_GetWord ($part1;2;"#"))
						$panelNo:=Num:C11(ST_GetWord ($part2;2;"#"))
						$fileName:=$folderPath+"Panel"+String:C10($panelNo)+"Module"+String:C10($moduleNo)+"_"+$country+"_"+$langage+".txt"
						If (SYS_TestPathName ($fileName)=Is a document:K24:1)
							DELETE DOCUMENT:C159($fileName)
						End if 
						$ref:=Create document:C266($fileName)
						ARRAY TEXT:C222(atVS_HeaderInt;0)
						ARRAY TEXT:C222(atVS_Headercl;0)
						$blob:=[xShell_Prefs:46]_blob:10
						BLOB_Blob2Vars (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_HeaderInt;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
						SET BLOB SIZE:C606($blob;0)
						$blob:=PREF_fGetBlob (0;XS_GetBlobName ("panel";$moduleNo;"cl";"es";$panelNo))
						BLOB_Blob2Vars (->$blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_Headercl;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
						SET BLOB SIZE:C606($blob;0)
						For ($g;1;Size of array:C274(atVS_HeaderInt))
							$line:=atVS_Headercl{$g}+"\t"+atVS_HeaderInt{$g}+"\r"
							$line:=ST_ConvertText ($line;$source;$dest)
							SEND PACKET:C103($ref;$line)
						End for 
						CLOSE DOCUMENT:C267($ref)
					End for 
					$iterations:=$iterations+1
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterations/$finalIter)
				End for 
			End for 
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		CD_Dlog (0;__ ("Exportación concluída exitósamente."))
	Else 
		CD_Dlog (0;__ ("Acción cancelada por el usuario o carpeta incorrecta seleccionada."))
	End if 
End if 