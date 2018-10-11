//%attributes = {}
  // XS_ImportTranslations()
  // Por: Alberto Bachler: 12/02/13, 10:40:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_continuar;$b_conversionWin2Mac;$b_editable)
C_LONGINT:C283($i;$i_itemsLista;$l_estilo;$l_HLBrowser;$l_HLConfig;$l_HLServicios;$l_HLWizards;$l_IdComando;$l_IdField;$l_IdItem)
C_LONGINT:C283($l_posicionBrowser;$l_posicionConfig;$l_posicionPanel;$l_posicionServicios;$l_posicionWizards;$l_recNumField;$l_referenciaIcono;$l_referenciaItem;$l_referenciaModulo;$l_referenciaPanel)
C_LONGINT:C283($l_respuesta)
C_TIME:C306($h_refDocumento)
C_TEXT:C284($t_alias;$t_codigoLenguaje;$t_codigoPais;$t_descripcionComando;$t_lenguajeTemp;$t_metodo;$t_nombreBlob;$t_nuevoTexto;$t_paisLenguaje;$t_referenciaTabla)
C_TEXT:C284($t_rutaCarpeta;$t_rutaDocumento;$t_texto;$t_textoItem;$t_tipoTraduccion)

ARRAY TEXT:C222($at_Documentos;0)




$t_rutaCarpeta:=xfGetDirName ("Por favor seleccione la carpeta de origen")
If (ok=1)
	$l_respuesta:=CD_Dlog (0;__ ("Especifique el formato de los archivos...");__ ("");__ ("Mac");__ ("Windows"))
	If ($l_respuesta=1)
		$b_conversionWin2Mac:=False:C215
	Else 
		$b_conversionWin2Mac:=True:C214
	End if 
	
	DOCUMENT LIST:C474($t_rutaCarpeta;$at_Documentos)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando traducciones..."))
	For ($i;1;Size of array:C274($at_Documentos))
		$t_rutaDocumento:=$t_rutaCarpeta+$at_Documentos{$i}
		$t_tipoTraduccion:=Substring:C12($at_Documentos{$i};1;5)
		$t_paisLenguaje:=Substring:C12($at_Documentos{$i};Position:C15("_";$at_Documentos{$i})+1)
		$t_codigoPais:=ST_GetWord ($t_paisLenguaje;1;"_")
		$t_lenguajeTemp:=ST_GetWord ($t_paisLenguaje;2;"_")
		$t_codigoLenguaje:=Substring:C12($t_lenguajeTEMP;1;Position:C15(".";$t_lenguajeTemp)-1)
		$h_refDocumento:=Open document:C264($t_rutaDocumento;"TEXT";Read mode:K24:5)
		$t_texto:=""
		RECEIVE PACKET:C104($h_refDocumento;$t_texto;"\r")
		If ($b_conversionWin2Mac)
			$t_texto:=_O_Win to Mac:C464($t_texto)
		End if 
		$l_posicionConfig:=1
		$l_posicionWizards:=1
		$l_posicionServicios:=1
		$l_posicionBrowser:=1
		$l_posicionPanel:=1
		$b_continuar:=True:C214
		While (($t_texto#"") & ($b_continuar))
			
			Case of 
				: ($t_tipoTraduccion="table")
					$t_referenciaTabla:=ST_GetWord ($t_texto;1;"\t")
					$t_alias:=ST_GetWord ($t_texto;3;"\t")
					READ WRITE:C146([xShell_TableAlias:199])
					QUERY:C277([xShell_TableAlias:199];[xShell_TableAlias:199]TableRef:1=$t_referenciaTabla)
					[xShell_TableAlias:199]Alias:2:=$t_alias
					SAVE RECORD:C53([xShell_TableAlias:199])
					
				: ($t_tipoTraduccion="field")
					$t_referenciaCampo:=ST_GetWord ($t_texto;1;"\t")
					$t_alias:=ST_GetWord ($t_texto;3;"\t")
					$l_recNumField:=KRL_FindAndLoadRecordByIndex (->[xShell_Fields:52]ReferenciaTablaCampo:7;->$t_referenciaCampo;False:C215)
					If ($l_recNumField>=0)
						XSvs_ActualizaLocalizacionCampo ($l_recNumField;$t_codigoPais;$t_codigoLenguaje;$t_alias)
					End if 
					
				: ($t_tipoTraduccion="comma")
					$l_IdComando:=Num:C11(ST_GetWord ($t_texto;1;"\t"))
					$t_alias:=ST_GetWord ($t_texto;3;"\t")
					$t_descripcionComando:=ST_GetWord ($t_texto;5;"\t")
					READ WRITE:C146([xShell_ExecCommands_Localized:232])
					QUERY:C277([xShell_ExecCommands_Localized:232];[xShell_ExecCommands_Localized:232]ID_ExecCommand:6;=$l_IdComando;*)
					QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Country_Code:1;=;$t_codigoPais;*)
					QUERY:C277([xShell_ExecCommands_Localized:232]; & ;[xShell_ExecCommands_Localized:232]Language_Code:2;=;$t_codigoLenguaje)
					[xShell_ExecCommands_Localized:232]Alias:3:=$t_alias
					[xShell_ExecCommands_Localized:232]Description:4:=$t_descripcionComando
					SAVE RECORD:C53([xShell_ExecCommands_Localized:232])
					KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
					KRL_UnloadReadOnly (->[xShell_ExecCommands_Localized:232])
					
				: ($t_tipoTraduccion="confi")
					$l_referenciaModulo:=Num:C11($at_Documentos{$i})
					$t_nombreBlob:=XS_GetBlobName ("config";$l_referenciaModulo;$t_codigoPais;$t_codigoLenguaje)
					$x_blob:=PREF_fGetBlob (0;$t_nombreBlob)
					If (BLOB size:C605($x_blob)>0)
						$l_HLConfig:=BLOB to list:C557($x_blob)
						ARRAY LONGINT:C221(alXS_ConfigIconsRefs;Count list items:C380($l_HLConfig))
						For ($i_itemsLista;1;Count list items:C380($l_HLConfig))
							GET LIST ITEM:C378($l_HLConfig;$i_itemsLista;$l_IdItem;$t_textoItem)
							GET LIST ITEM PROPERTIES:C631($l_HLConfig;$l_IdItem;$b_editable;$l_estilo;$l_referenciaIcono)
							alXS_ConfigIconsRefs{$i_itemsLista}:=$l_referenciaIcono-Use PicRef:K28:4
						End for 
						
						$l_HLConfig:=HL_ReReferenceList ($l_HLConfig;->alXS_ConfigIconsRefs)
						$t_nuevoTexto:=ST_GetWord ($t_texto;2;"\t")
						GET LIST ITEM:C378($l_HLConfig;$l_posicionConfig;$l_referenciaItem;$t_textoItem)
						$t_metodo:=ST_GetWord ($t_textoItem;2;";")
						$t_nuevoTexto:=$t_nuevoTexto+(";"*Num:C11($t_metodo#""))+$t_metodo
						SET LIST ITEM:C385($l_HLConfig;$l_referenciaItem;$t_nuevoTexto;$l_referenciaItem)
						SET BLOB SIZE:C606($x_blob;0)
						LIST TO BLOB:C556($l_HLConfig;$x_blob)
						PREF_SetBlob (0;$t_nombreBlob;$x_blob)
						$l_posicionConfig:=$l_posicionConfig+1
					End if 
					
				: ($t_tipoTraduccion="wizar")
					$l_referenciaModulo:=Num:C11($at_Documentos{$i})
					$t_nombreBlob:=XS_GetBlobName ("wizard";$l_referenciaModulo;$t_codigoPais;$t_codigoLenguaje)
					$x_blob:=PREF_fGetBlob (0;$t_nombreBlob)
					If (BLOB size:C605($x_blob)>0)
						$l_HLWizards:=BLOB to list:C557($x_blob)
						ARRAY LONGINT:C221(alXS_WizardsIconsRefs;Count list items:C380($l_HLWizards))
						For ($i_itemsLista;1;Count list items:C380($l_HLWizards))
							GET LIST ITEM:C378($l_HLWizards;$i_itemsLista;$l_IdItem;$t_textoItem)
							GET LIST ITEM PROPERTIES:C631($l_HLWizards;$l_IdItem;$b_editable;$l_estilo;$l_referenciaIcono)
							alXS_WizardsIconsRefs{$i_itemsLista}:=$l_referenciaIcono-Use PicRef:K28:4
						End for 
						$l_HLWizards:=HL_ReReferenceList ($l_HLWizards;->alXS_WizardsIconsRefs)
						$t_nuevoTexto:=ST_GetWord ($t_texto;2;"\t")
						GET LIST ITEM:C378($l_HLWizards;$l_posicionWizards;$l_referenciaItem;$t_textoItem)
						$t_metodo:=ST_GetWord ($t_textoItem;2;";")
						$t_nuevoTexto:=$t_nuevoTexto+(";"*Num:C11($t_metodo#""))+$t_metodo
						SET LIST ITEM:C385($l_HLWizards;$l_referenciaItem;$t_nuevoTexto;$l_referenciaItem)
						SET BLOB SIZE:C606($x_blob;0)
						LIST TO BLOB:C556($l_HLWizards;$x_blob)
						PREF_SetBlob (0;$t_nombreBlob;$x_blob)
						$l_posicionWizards:=$l_posicionWizards+1
					End if 
					
				: ($t_tipoTraduccion="servi")
					$l_referenciaModulo:=Num:C11($at_Documentos{$i})
					$t_nombreBlob:=XS_GetBlobName ("service";$l_referenciaModulo;$t_codigoPais;$t_codigoLenguaje)
					$x_blob:=PREF_fGetBlob (0;$t_nombreBlob)
					If (BLOB size:C605($x_blob)>0)
						$l_HLServicios:=BLOB to list:C557($x_blob)
						ARRAY LONGINT:C221(alXS_ServicesIconsRefs;Count list items:C380($l_HLServicios))
						For ($i_itemsLista;1;Count list items:C380($l_HLServicios))
							GET LIST ITEM:C378($l_HLServicios;$i_itemsLista;$l_IdItem;$t_textoItem)
							GET LIST ITEM PROPERTIES:C631($l_HLServicios;$l_IdItem;$b_editable;$l_estilo;$l_referenciaIcono)
							alXS_ServicesIconsRefs{$i_itemsLista}:=$l_referenciaIcono-Use PicRef:K28:4
						End for 
						$l_HLServicios:=HL_ReReferenceList ($l_HLServicios;->alXS_ServicesIconsRefs)
						$t_nuevoTexto:=ST_GetWord ($t_texto;2;"\t")
						GET LIST ITEM:C378($l_HLServicios;$l_posicionServicios;$l_referenciaItem;$t_textoItem)
						$t_metodo:=ST_GetWord ($t_textoItem;2;";")
						$t_nuevoTexto:=$t_nuevoTexto+(";"*Num:C11($t_metodo#""))+$t_metodo
						SET LIST ITEM:C385($l_HLServicios;$l_referenciaItem;$t_nuevoTexto;$l_referenciaItem)
						SET BLOB SIZE:C606($x_blob;0)
						LIST TO BLOB:C556($l_HLServicios;$x_blob)
						PREF_SetBlob (0;$t_nombreBlob;$x_blob)
						$l_posicionServicios:=$l_posicionServicios+1
					End if 
					
				: ($t_tipoTraduccion="brows")
					$l_referenciaModulo:=Num:C11($at_Documentos{$i})
					$t_nombreBlob:=XS_GetBlobName ("browser";$l_referenciaModulo;$t_codigoPais;$t_codigoLenguaje)
					$x_blob:=PREF_fGetBlob (0;$t_nombreBlob)
					If (BLOB size:C605($x_blob)>0)
						$l_HLBrowser:=BLOB to list:C557($x_blob)
						$t_nuevoTexto:=ST_GetWord ($t_texto;2;"\t")
						GET LIST ITEM:C378($l_HLBrowser;$l_posicionBrowser;$l_referenciaItem;$t_textoItem)
						SET LIST ITEM:C385($l_HLBrowser;$l_referenciaItem;$t_nuevoTexto;$l_referenciaItem)
						SET BLOB SIZE:C606($x_blob;0)
						LIST TO BLOB:C556($l_HLBrowser;$x_blob)
						PREF_SetBlob (0;$t_nombreBlob;$x_blob)
						$l_posicionBrowser:=$l_posicionBrowser+1
					End if 
					
				: ($t_tipoTraduccion="panel")
					$l_referenciaModulo:=Num:C11(Substring:C12($at_Documentos{$i};Position:C15("Module";$at_Documentos{$i})))
					$l_referenciaPanel:=Num:C11(Substring:C12($at_Documentos{$i};1;Position:C15("Module";$at_Documentos{$i})-1))
					$t_nombreBlob:=XS_GetBlobName ("panel";$l_referenciaModulo;$t_codigoPais;$t_codigoLenguaje;$l_referenciaPanel)
					$x_blob:=PREF_fGetBlob (0;$t_nombreBlob)
					If (BLOB size:C605($x_blob)>0)
						ARRAY TEXT:C222(atVS_HeaderInt;0)
						BLOB_Blob2Vars (->$x_blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_HeaderInt;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
						$t_alias:=ST_GetWord ($t_texto;2;"\t")
						atVS_HeaderInt{$l_posicionPanel}:=$t_alias
						BLOB_Variables2Blob (->$x_blob;0;->alVS_TableNumber;->alVS_FieldNumber;->atVS_HeaderInt;->alVS_BrowserPosition;->atVS_BrowserFormat;->atVS_FieldNames;->alVS_ColumnWidth;->vtBWR_OnLoadMethod;->vtBWR_OnClickMethod;->vtBWR_OnDClickMethod;->vtBWR_OnRClickMethod;->alVS_QFSourceTableNumber;->alVS_QFSourceFieldNumber;->alVS_QFRelateToFieldNumber;->atVS_QFSourceFieldAlias;->aiVS_QFSourceFieldOrder;->alVS_QFRelateFromField;->atVS_QFSpecialRelationMethod;->viBWR_LockColumns;->vtBWR_sortOrder;->vsBWR_defaultInputForm;->vtBWR_OnEClickMethod;->vtBWR_OnEDClickMethod;->vtBWR_OnERClickMethod;->vtBWR_OnHRClickMethod;->viBWR_HiddenColumns)
						PREF_SetBlob (0;$t_nombreBlob;$x_blob)
						$l_posicionPanel:=$l_posicionPanel+1
					End if 
				Else 
					$b_continuar:=False:C215
			End case 
			
			RECEIVE PACKET:C104($h_refDocumento;$t_texto;"\r")
			If ($b_conversionWin2Mac)
				$t_texto:=_O_Win to Mac:C464($t_texto)
			End if 
		End while 
		CLOSE DOCUMENT:C267($h_refDocumento)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($at_Documentos))
		FLUSH CACHE:C297
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	CD_Dlog (0;__ ("Importación concluída. Recuerde guardar la configuración para preservar los valores importados."))
	KRL_UnloadReadOnly (->[xShell_TableAlias:199])
	KRL_UnloadReadOnly (->[xShell_FieldAlias:198])
	KRL_UnloadReadOnly (->[xShell_ExecutableCommands:19])
	
Else 
	CD_Dlog (0;__ ("Acción cancelada por el usuario o carpeta incorrecta seleccionada."))
End if 