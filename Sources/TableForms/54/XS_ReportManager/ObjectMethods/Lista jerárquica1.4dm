  // Método: [xShell_Reports].XS_ReportManager.Lista jerárquica1
  // ----------------------------------------------------

C_BOOLEAN:C305($b_licenciaSchoolNet;$b_publicable;$b_editable;$b_listaExpandida;$sourceItemExpanded)
C_LONGINT:C283($i;$l_icono;$l_campo;$l_elemento;$l_elementoOrigen;$l_iconoCarpeta;$l_iconoNoEditable;$l_iconoQR;$l_iconoSRP;$l_idCarpetaFavoritos)
C_LONGINT:C283($l_IdReport;$l_itemRef;$l_itemSeleccionado;$l_ItemsEnLista;$l_posicionDestinoArrastre;$l_posicionElemento;$l_procesoOrigen;$l_proximoItemRef;$l_refElementoListaOrigen;$l_refItemDestino)
C_LONGINT:C283($l_refSubLista;$l_tabla;$number;$recNum;$sourceItemSubList;$l_estilo;$subItemRef;$tempRef;$vlButton;$vlMouseX)
C_LONGINT:C283($vlMouseY)
C_POINTER:C301($y_objetoOrigen)
C_TEXT:C284($itemText;$reportName;$subItemText;$t_accion;$t_menuRef;$t_nombreCarpetaFavoritos;$t_nombreElemento;$t_nombreElementoListaOrigen;$t_nombreObjetoOrigen)

ARRAY LONGINT:C221($al_recNumInformes;0)
ARRAY TEXT:C222($at_nombreInformes;0)
C_LONGINT:C283(vlQR_ReportType)

$l_iconoCarpeta:=Use PicRef:K28:4+27511
$l_iconoSRP:=Use PicRef:K28:4+27512
$l_iconoNoEditable:=Use PicRef:K28:4+27513
$l_iconoQR:=Use PicRef:K28:4+27514
Case of 
	: (Form event:C388=On Drop:K2:12)
		$l_posicionDestinoArrastre:=Drop position:C608
		DRAG AND DROP PROPERTIES:C607($y_objetoOrigen;$l_elementoOrigen;$l_procesoOrigen)
		RESOLVE POINTER:C394($y_objetoOrigen;$t_nombreObjetoOrigen;$l_tabla;$l_campo)
		
		Case of 
			: ($t_nombreObjetoOrigen="hl_FavoriteReports")
				  //MONO 203509: voy a evitar el movimiento de objetos de esta misma area debido a que he tenido comportamiento erratico entre compilado e interpretado que no he podido
				  //definir, no sé si hay problemas con las referencias actualemtne de las listas o diferencias con el comportamiento de la función.
				
				  //GET LIST ITEM(hl_FavoriteReports;$l_elementoOrigen;$l_refElementoListaOrigen;$t_nombreElementoListaOrigen;$l_refSubListaOrigen;$b_listaExpandida)
				  //GET LIST ITEM PROPERTIES(hl_FavoriteReports;$l_refElementoListaOrigen;$b_editable;$l_estilo;$l_icono)
				  //GET LIST ITEM(hl_FavoriteReports;$l_posicionDestinoArrastre;$l_refItemDestino;$itemText;$l_refSubListaDestino;$b_listaExpandida)
				
				  //$vlPadreElemRefOrigen:=List item parent(hl_FavoriteReports;$l_refElementoListaOrigen)
				  //$vlPadreElemRefDestino:=List item parent(hl_FavoriteReports;$l_refItemDestino)
				
				  //  //MONO: Reviso que la referencia de origen y destino sean distintas, también que al mover subreferencias tengas destinos distintos a su origen
				  //  //evitamos meter una carpeta sobre si misma, querer asignar una subcarpeta nuevamente a su carpeta de origeno o meter la carpeta madre a su propia hija.
				  //$b_continuar:=(($l_refElementoListaOrigen#$l_refItemDestino) & ($vlPadreElemRefOrigen#$l_refItemDestino) & ($vlPadreElemRefDestino#$l_refElementoListaOrigen))
				
				  //If ($b_continuar)
				
				  //$tempRef:=-$l_refElementoListaOrigen
				  //If ($l_refItemDestino=0)
				  //APPEND TO LIST(hl_FavoriteReports;$t_nombreElementoListaOrigen;$tempRef;$vlPadreElemRefDestino;True)
				  //DELETE FROM LIST(hl_FavoriteReports;$l_refElementoListaOrigen)
				  //APPEND TO LIST(hl_FavoriteReports;$t_nombreElementoListaOrigen;$l_refElementoListaOrigen;$vlPadreElemRefDestino;True)
				  //DELETE FROM LIST(hl_FavoriteReports;$tempRef)
				  //SET LIST ITEM PROPERTIES(hl_FavoriteReports;$l_refElementoListaOrigen;$b_editable;$l_estilo;$l_icono)
				  //Else 
				  //$l_refSubLista:=New list
				  //APPEND TO LIST($l_refSubLista;$t_nombreElementoListaOrigen;$l_refElementoListaOrigen;$l_refSubLista;$b_listaExpandida)
				  //DELETE FROM LIST(hl_FavoriteReports;$l_refElementoListaOrigen)
				  //SET LIST ITEM(hl_FavoriteReports;$l_refItemDestino;$itemText;$l_refElementoListaOrigen;$l_refSubLista;True)
				  //SET LIST ITEM PROPERTIES($l_refSubLista;$l_refElementoListaOrigen;$b_editable;$l_estilo;$l_icono)
				  //SORT LIST($l_refSubLista)
				  //End if 
				
				  //End if 
				
				  //QR_SaveFavoritesList 
				  //QR_BuildFavoritesList 
				
				  //GET LIST ITEM(hl_FavoriteReports;$l_elementoOrigen;$l_refElementoListaOrigen;$t_nombreElementoListaOrigen;$l_refSubLista;$b_listaExpandida)
				  //GET LIST ITEM PROPERTIES(hl_FavoriteReports;$l_refElementoListaOrigen;$b_editable;$l_estilo;$l_icono)
				  //GET LIST ITEM(hl_FavoriteReports;$l_posicionDestinoArrastre;$l_refItemDestino;$itemText;$l_refSubLista;$b_listaExpandida)
				  //If ($l_refSubLista=0)
				  //$l_refSubLista:=New list
				  //End if 
				  //$tempRef:=-$l_refElementoListaOrigen
				  //APPEND TO LIST($l_refSubLista;$t_nombreElementoListaOrigen;$tempRef;$l_refSubLista;$b_listaExpandida)
				  //SET LIST ITEM(hl_FavoriteReports;$l_refItemDestino;$itemText;$l_refItemDestino;$l_refSubLista;True)
				  //DELETE FROM LIST(hl_FavoriteReports;$l_refElementoListaOrigen)
				  //SET LIST ITEM(hl_FavoriteReports;$tempRef;$t_nombreElementoListaOrigen;$l_refElementoListaOrigen;$l_refSubLista;$b_listaExpandida)
				  //SET LIST ITEM PROPERTIES(hl_FavoriteReports;$l_refElementoListaOrigen;$b_editable;$l_estilo;$l_icono)
				  //SORT LIST($l_refSubLista)
				  //QR_SaveFavoritesList 
				  //QR_BuildFavoritesList 
				
				
			: ($t_nombreObjetoOrigen="hl_Informes")
				GET LIST ITEM:C378(hl_Informes;$l_elementoOrigen;$l_refElementoListaOrigen;$t_nombreElementoListaOrigen)
				READ ONLY:C145([xShell_Reports:54])
				KRL_GotoRecord (->[xShell_Reports:54];$l_refElementoListaOrigen)
				$l_IdReport:=[xShell_Reports:54]ID:7
				GET LIST ITEM:C378(hl_FavoriteReports;$l_posicionDestinoArrastre;$l_idCarpetaFavoritos;$t_nombreCarpetaFavoritos)
				READ WRITE:C146([xShell_FavoriteReports:183])
				QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
				QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportId:2;=;$l_IdReport)
				If (Records in selection:C76([xShell_FavoriteReports:183])=0)
					READ ONLY:C145([xShell_Reports:54])
					QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ID:7=$l_IdReport)
					CREATE RECORD:C68([xShell_FavoriteReports:183])
					[xShell_FavoriteReports:183]UserID:1:=<>lUSR_CurrentUserID
					[xShell_FavoriteReports:183]ReportId:2:=$l_IdReport
					[xShell_FavoriteReports:183]ReportParentListId:7:=$l_idCarpetaFavoritos
					[xShell_FavoriteReports:183]ReportName:4:=$t_nombreElementoListaOrigen
					[xShell_FavoriteReports:183]ReportTable:5:=Table:C252(vyQR_TablePointer)
					[xShell_FavoriteReports:183]IsListDef:9:=False:C215
					[xShell_FavoriteReports:183]ReportType:8:=[xShell_Reports:54]ReportType:2
					SAVE RECORD:C53([xShell_FavoriteReports:183])
					KRL_ReloadAsReadOnly (->[xShell_FavoriteReports:183])
				Else 
					BEEP:C151
				End if 
		End case 
		
	: (Form event:C388=On Data Change:K2:15)
		QR_SaveFavoritesList 
		
	: (Form event:C388=On Clicked:K2:4)
		QR_GetFolderReports 
		
		If (Contextual click:C713)
			HL_CopyReferencedListToArray (hl_informes;->$at_nombreInformes;->$al_recNumInformes)
			
			$b_licenciaSchoolNet:=LICENCIA_esModuloAutorizado (1;SchoolNet)
			
			For ($i;Size of array:C274($al_recNumInformes);1;-1)
				GOTO RECORD:C242([xShell_Reports:54];$al_recNumInformes{$i})
				$b_publicable:=(((<>lUSR_CurrentUserID=[xShell_Reports:54]Propietary:9) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001))))
				$b_publicable:=$b_publicable | (QR_IsReportAllowed )
				$b_publicable:=$b_publicable & ((Records in selection:C76(vyQR_TablePointer->)>0) | ([xShell_Reports:54]NoRequiereSeleccion:40))
				$b_publicable:=$b_publicable & [xShell_Reports:54]isOneRecordReport:11 & (vtQR_CurrentReportType="gSR2") & $b_licenciaSchoolNet
				$b_publicable:=$b_publicable & (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
				If (Not:C34($b_publicable))
					AT_Delete ($i;1;->$at_nombreInformes;->$al_recNumInformes)
				End if 
			End for 
			
			$l_elemento:=Selected list items:C379(Self:C308->)
			$t_menuRef:=Create menu:C408
			MNU_Append ($t_menuRef;__ ("Nueva carpeta…");"nuevaCarpeta";True:C214;"";"")
			MNU_Append ($t_menuRef;__ ("Nueva subcarpeta…");"subCarpeta";True:C214;"";"")
			MNU_Append ($t_menuRef;"(-")
			MNU_Append ($t_menuRef;__ ("Eliminar carpeta…");"eliminar";($l_elemento>0);"";"")
			MNU_Append ($t_menuRef;"(-")
			  //120618 MONO TICKET 208538
			MNU_Append ($t_menuRef;__ ("Previsualizar todos los informes…");"CarpetaPreview";($l_elemento>0))
			MNU_Append ($t_menuRef;__ ("Imprimir todos los informes…");"CarpetaPrinter";($l_elemento>0))
			MNU_Append ($t_menuRef;__ ("Imprimir todos los informes en formato PDF…");"CarpetaPdf";($l_elemento>0))
			MNU_Append ($t_menuRef;__ ("Previsualizar agrupados los informes …");"CarpetaPreviewAgrupado";($l_elemento>0))
			MNU_Append ($t_menuRef;__ ("Imprimir agrupados los informes …");"CarpetaPrinterAgrupado";($l_elemento>0))
			MNU_Append ($t_menuRef;__ ("Digitalizar agrupados los informes …");"CarpetaPdfAgrupado";($l_elemento>0))  //MONO 215660
			  //120618 MONO TICKET 208538
			MNU_Append ($t_menuRef;"(-")
			MNU_Append ($t_menuRef;__ ("Publicar en SchoolNet…");"publicar";(Size of array:C274($al_recNumInformes)>0))
			$t_accion:=Dynamic pop up menu:C1006($t_menuRef)
			
			If ($t_accion#"")
				Case of 
					: ($t_accion="nuevaCarpeta")
						$t_nombreCarpetaFavoritos:=CD_Request (__ ("Nombre de la nueva carpeta:");__ ("Aceptar");__ ("Cancelar");__ ("");__ (""))
						If ($t_nombreCarpetaFavoritos#"")
							If (HL_FindElement (Self:C308->;$t_nombreCarpetaFavoritos)=-1)
								$l_proximoItemRef:=HL_GetNextItemRefNumber (hl_FavoriteReports)
								APPEND TO LIST:C376(hl_FavoriteReports;$t_nombreCarpetaFavoritos;$l_proximoItemRef)
								SET LIST ITEM PROPERTIES:C386(hl_FavoriteReports;0;True:C214;0;$l_iconoCarpeta)
								SELECT LIST ITEMS BY REFERENCE:C630(hl_FavoriteReports;$l_proximoItemRef)
								SORT LIST:C391(hl_FavoriteReports)
								QR_SaveFavoritesList 
							Else 
								CD_Dlog (0;__ ("Ya existe una carpeta con el mismo nombre."))
							End if 
						End if 
						
						
					: ($t_accion="subcarpeta")
						$l_itemSeleccionado:=Selected list items:C379(Self:C308->)
						$l_refSubLista:=0
						GET LIST ITEM:C378(Self:C308->;$l_itemSeleccionado;$l_itemRef;$t_nombreElemento;$l_refSubLista)
						$t_nombreCarpetaFavoritos:=CD_Request (__ ("Nombre de la nueva sub-carpeta en la carpeta ")+$t_nombreElemento+__ ("");__ ("Aceptar");__ ("Cancelar");__ ("");__ (""))
						If ($t_nombreCarpetaFavoritos#"")
							If (Is a list:C621($l_refSubLista))
								$number:=Count list items:C380($l_refSubLista)
								$l_posicionElemento:=HL_FindElement ($l_refSubLista;$t_nombreCarpetaFavoritos)
								If ($l_posicionElemento=-1)  //
									$l_proximoItemRef:=HL_GetNextItemRefNumber (hl_FavoriteReports)
									APPEND TO LIST:C376($l_refSubLista;$t_nombreCarpetaFavoritos;$l_proximoItemRef)
									SET LIST ITEM PROPERTIES:C386($l_refSubLista;0;True:C214;0;$l_iconoCarpeta)
									SORT LIST:C391($l_refSubLista)
									SET LIST ITEM:C385(hl_FavoriteReports;$l_itemRef;$t_nombreElemento;$l_itemRef;$l_refSubLista;True:C214)
									SELECT LIST ITEMS BY REFERENCE:C630(hl_FavoriteReports;$l_proximoItemRef)
									QR_SaveFavoritesList 
								Else 
									CD_Dlog (0;__ ("Ya existe una carpeta con el mismo nombre en esta misma rama."))
								End if 
							Else 
								$l_proximoItemRef:=HL_GetNextItemRefNumber (hl_FavoriteReports)
								$l_refSubLista:=New list:C375
								APPEND TO LIST:C376($l_refSubLista;$t_nombreCarpetaFavoritos;$l_proximoItemRef)
								SET LIST ITEM PROPERTIES:C386($l_refSubLista;0;True:C214;0;$l_iconoCarpeta)
								SORT LIST:C391($l_refSubLista)
								SET LIST ITEM:C385(hl_FavoriteReports;$l_itemRef;$t_nombreElemento;$l_itemRef;$l_refSubLista;True:C214)
								SELECT LIST ITEMS BY REFERENCE:C630(hl_FavoriteReports;$l_proximoItemRef)
								QR_SaveFavoritesList 
							End if 
						End if 
						
					: ($t_accion="eliminar")
						$l_itemSeleccionado:=Selected list items:C379(Self:C308->)
						GET LIST ITEM:C378(Self:C308->;$l_itemSeleccionado;$l_itemRef;$t_nombreElemento;$l_refSublista)
						If ($l_refSublista#0)
							HL_ExpandAll ($l_refSublista)
							$l_ItemsEnLista:=Count list items:C380($l_refSublista)
						Else 
							$l_ItemsEnLista:=0
						End if 
						READ WRITE:C146([xShell_FavoriteReports:183])
						If ($l_ItemsEnLista>0)
							OK:=CD_Dlog (0;__ ("¿Desea usted realmente eliminar la carpeta ")+$t_nombreElemento+__ (" y todos los items que contiene de la lista de sus Favoritos?");__ ("");__ ("Si, Eliminar");__ ("No"))
							If (OK=1)
								For ($i;$l_ItemsEnLista;1;-1)
									GET LIST ITEM:C378($l_refSublista;$i;$subItemRef;$subItemText)
									QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
									QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportParentListId:7=$l_itemRef;*)
									QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer);*)
									QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]IsListDef:9=False:C215)
									DELETE SELECTION:C66([xShell_FavoriteReports:183])
								End for 
								DELETE FROM LIST:C624(hl_FavoriteReports;$l_itemRef;*)
							End if 
						Else 
							QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
							QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportParentListId:7=$l_itemRef;*)
							QUERY:C277([xShell_FavoriteReports:183]; & [xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer);*)
							QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]IsListDef:9=False:C215)
							If (Records in selection:C76([xShell_FavoriteReports:183])>0)
								OK:=CD_Dlog (0;__ ("¿Desea usted realmente eliminar la carpeta ")+$t_nombreElemento+__ (" y los informes que contiene de la lista de sus Favoritos?");__ ("");__ ("Si, Eliminar");__ ("No"))
								If (OK=1)
									DELETE SELECTION:C66([xShell_FavoriteReports:183])
									DELETE FROM LIST:C624(hl_FavoriteReports;$l_itemRef;*)
								End if 
							Else 
								DELETE FROM LIST:C624(hl_FavoriteReports;$l_itemRef;*)
							End if 
						End if 
						  // Modificado por: Saúl Ponce (15-03-2017) Ticket 175838. Almacena el registro [xShell_FavoriteReports] después de haber eliminado una carpeta o informe.
						QR_SaveFavoritesList 
						READ ONLY:C145([xShell_FavoriteReports:183])
						
					: ($t_accion="publicar")
						  //MONO PUBLICAR CARPETA DE INFORMES EN SN3
						vb_isReportFolder:=True:C214
						CREATE SET:C116(vyQR_TablePointer->;"previa")
						GET LIST ITEM:C378(hl_informes;Selected list items:C379(hl_informes);$recNum;$reportName)
						WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"gestionReportesSN";0;4;__ ("Gestión de Informe "+$reportName+" en SchoolNet"))
						DIALOG:C40([SN3_PublicationPrefs:161];"gestionReportesSN")
						CLOSE WINDOW:C154
						USE SET:C118("previa")
						CLEAR SET:C117("previa")
						
					: ($t_accion="Carpeta@")  //120618 MONO TICKET 208538
						
						$b_agrupados:=False:C215
						$t_agrupadosTipo:=""
						ARRAY LONGINT:C221($al_recnumInformes;0)
						GET LIST ITEM:C378(hl_FavoriteReports;Selected list items:C379(hl_FavoriteReports);$l_idCarpetaFavoritos;$t_nombreCarpetaFavoritos)
						READ ONLY:C145([xShell_FavoriteReports:183])
						READ ONLY:C145([xShell_Reports:54])
						QUERY:C277([xShell_FavoriteReports:183];[xShell_FavoriteReports:183]UserID:1=<>lUSR_CurrentUserID;*)
						QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportParentListId:7=$l_idCarpetaFavoritos;*)
						QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]ReportTable:5;=;Table:C252(vyQR_TablePointer);*)
						QUERY:C277([xShell_FavoriteReports:183]; & ;[xShell_FavoriteReports:183]IsListDef:9=False:C215)
						KRL_RelateSelection (->[xShell_Reports:54]ID:7;->[xShell_FavoriteReports:183]ReportId:2;"")
						ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>)
						LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$al_recnumInformes;"")
						
						Case of 
							: ($t_accion="CarpetaPreview")
								QR_ImprimeGrupo ("preview";->$al_recnumInformes)
								
							: ($t_accion="CarpetaPrinter")
								QR_ImprimeGrupo ("printer";->$al_recnumInformes)
								
							: ($t_accion="CarpetaPdf")
								QR_ImprimeGrupo ("pdf";->$al_recnumInformes)
								
							: ($t_accion="CarpetaPreviewAgrupado")  //MONO 208538
								$b_agrupados:=True:C214
								$t_agrupadosTipo:="preview"
								
							: ($t_accion="CarpetaPrinterAgrupado")  //MONO 208538
								$b_agrupados:=True:C214
								$t_agrupadosTipo:="printer"
								
							: ($t_accion="CarpetaPdfAgrupado")  //MONO 215660
								$b_agrupados:=True:C214
								$t_agrupadosTipo:=""
								
						End case 
						
						If ($b_agrupados)
							  //Carpeta agrupada es para reportes que tengan un documento por registro.
							CREATE SELECTION FROM ARRAY:C640([xShell_Reports:54];$al_recnumInformes)
							QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]isOneRecordReport:11=False:C215)
							If (Records in selection:C76([xShell_Reports:54])>0)
								ARRAY TEXT:C222($at_nombreReporteInvalido;0)
								SELECTION TO ARRAY:C260([xShell_Reports:54]ReportName:26;$at_nombreReporteInvalido)
								CD_Dlog (0;__ ("La impresión agrupada es para reportes que tengan la propiedada de un documento por registro. Los siguientes reportes de la carpeta seleccionada no cumplen con esto:\r ^0";AT_array2text (->$at_nombreReporteInvalido;"\r")))
							Else 
								ARRAY LONGINT:C221($al_recNumTablaPanel;0)
								LONGINT ARRAY FROM SELECTION:C647(vyQR_TablePointer->;$al_recNumTablaPanel;"")
								QR_impresionAgrupadaxRegistros ($t_agrupadosTipo;->$al_recnumInformes;->$al_recNumTablaPanel;vyQR_TablePointer)
								CREATE SELECTION FROM ARRAY:C640(vyQR_TablePointer->;$al_recNumTablaPanel)
							End if 
						End if 
						
				End case 
			End if 
			
		Else 
			If (Selected list items:C379(Self:C308->)>0)
				vbQR_FavoritesSelected:=True:C214
				QR_GetFolderReports 
				QR_LoadSelectedReport 
				
				  //Mono 11-10-2011: creo una lista temporal para tener un respaldo cuando editen los nombres de las carpetas
				C_LONGINT:C283(hl_Informes_temp)
				hl_Informes_temp:=New list:C375
				hl_Informes_temp:=Copy list:C626(hl_FavoriteReports)
				
				OBJECT SET COLOR:C271(*;"4DFO_Title";-15)
				OBJECT SET COLOR:C271(*;"4DSE_Title";-15)
				OBJECT SET COLOR:C271(*;"4DET_Title";-15)
				OBJECT SET COLOR:C271(*;"gSR2_Title";-15)
				OBJECT SET COLOR:C271(*;"4DWR_Title";-15)
				OBJECT SET FONT STYLE:C166(*;"4DFO_Title";Plain:K14:1)
				OBJECT SET FONT STYLE:C166(*;"4DSE_Title";Plain:K14:1)
				OBJECT SET FONT STYLE:C166(*;"4DET_Title";Plain:K14:1)
				OBJECT SET FONT STYLE:C166(*;"gSR2_Title";Plain:K14:1)
				bSuperReport:=0
				bQuickReports:=0
				bForms:=0
				bLabels:=0
				bWrite:=0
			End if 
		End if 
End case 

