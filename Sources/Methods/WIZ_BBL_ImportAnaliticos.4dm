//%attributes = {}
  //WIZ_BBL_ImportAnaliticos


ARRAY TEXT:C222($aLogRecords;0)
C_TEXT:C284($filePlatform)
C_LONGINT:C283($procesed;$creados;$actualizados)

If (SYS_IsWindows )
	ARRAY TEXT:C222($aKeys;0)
	ARRAY TEXT:C222($aNames;0)
	$err:=sys_GetRegEnum (GR_HKEY_LOCAL_MACHINE;"Software\\Adobe\\Acrobat Reader";$aKeys;$aNames)
	If (Size of array:C274($aKeys)=0)
		$m:="Para visualizar correctamente este formulario se requiere  Adobe Reader."
		$m:=$m+Char:C90(Carriage return:K15:38)+"Si no lo tiene instalado puede descargarlo e instalala desde el sitio web de Adob"+"e®: www.adobe.com.\r\r"
		$m:=$m+"Si ya está instalado o utiliza otro visualizador de documentos PDF haga click en "+"el botón Continuar."
		OK:=CD_Dlog (0;$m;__ ("");__ ("Continuar");__ ("Cancelar"))
	Else 
		OK:=1
	End if 
Else 
	OK:=1
End if 


WDW_OpenFormWindow (->[xxSTR_Constants:1];"WIZ_ImportAnaliticos_BBL";2;8)
DIALOG:C40([xxSTR_Constants:1];"WIZ_ImportAnaliticos_BBL")
CLOSE WINDOW:C154

If (OK=1)
	Case of 
		: (r1Mac=1)
			$filePlatform:="MAC"
			USE CHARACTER SET:C205("MacRoman";1)
		: (r2Win=1)
			$filePlatform:="WIN"
			USE CHARACTER SET:C205("windows-1252";1)
	End case 
	
	
	
	VS_LoadAutoFormatRefs 
	STR_CargaArreglosInterproceso 
	STR_LeeConfiguracion 
	EVS_initialize 
	EVS_LoadStyles 
	EVS_CargaMatrizEstilosEval 
	BBL_LeeConfiguracion 
	
	READ WRITE:C146([BBL_Items:61])
	$ref:=Open document:C264(document)
	If ($ref#?00:00:00?)
		$folderPath:=SYS_GetParentNme (document)
		RECEIVE PACKET:C104($ref;$text;"\r")
		If ($filePlatform="WIN")
			$text:=_O_Win to Mac:C464($text)
		End if 
		
		WDW_Open (300;100;0;Palette form window:K39:9)
		$rechazados:=0
		$creados:=0
		$procesed:=0
		$actualizados:=0
		While ((ok=1) & ($text#""))
			$procesed:=$procesed+1
			
			ARRAY TEXT:C222(aText1;0)
			AT_Text2Array (->aText1;$text;"\t")
			ARRAY TEXT:C222(aText1;9)
			AT_Inc (0)
			$isbn:=Substring:C12(ST_GetCleanString (aText1{AT_Inc });1;20)
			$issn:=Substring:C12(ST_GetCleanString (aText1{AT_Inc });1;20)
			$nEnSerie:=ST_GetCleanString (aText1{AT_Inc })
			$barCode:=ST_GetCleanString (aText1{AT_Inc })
			$nRegistro:=Num:C11(ST_GetCleanString (aText1{AT_Inc }))
			$titulo:=ST_GetCleanString (aText1{AT_Inc })
			$autor:=ST_GetCleanString (aText1{AT_Inc })
			$ubicacionEnItem:=ST_GetCleanString (aText1{AT_Inc })
			$volumen:=ST_GetCleanString (aText1{AT_Inc })
			
			
			$vb_Reject:=False:C215
			Case of 
				: ($isbn#"")
					$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]ISBN:3;->$isbn)
					If ($recNum>=0)
						$idItem:=[BBL_Items:61]Numero:1
					Else 
						$vb_Reject:=True:C214
						$rechazados:=$rechazados+1
						APPEND TO ARRAY:C911($aLogRecords;"ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"ISBN INEXISTENTE:"+"\t"+$text)
					End if 
					
					
				: ($issn#"")
					If ($nEnSerie="")
						$vb_Reject:=True:C214
						$rechazados:=$rechazados+1
						APPEND TO ARRAY:C911($aLogRecords;"ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"ISSN SIN NUMERO DE PUBLICACION:"+"\t"+$text)
					Else 
						QUERY:C277([BBL_Items:61];[BBL_Items:61]Serie_ISSN:31;=;$issn;*)
						QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Serie_No:27;=;$nEnSerie)
						$idItem:=[BBL_Items:61]Numero:1
					End if 
					
					
				: (($barcode#"") & ($nRegistro>0))
					$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]Barcode_SinFormato:26;->$barcode)
					If ($recNum>=0)
						If ($nRegistro#[BBL_Registros:66]No_Registro:25)
							$idItem:=[BBL_Registros:66]Número_de_item:1
						Else 
							$vb_Reject:=True:C214
							$rechazados:=$rechazados+1
							APPEND TO ARRAY:C911($aLogRecords;"ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"NUMERO DE REGISTRO NO CORRESPONDE AL CODIGO DE BARRA:"+"\t"+$text)
						End if 
					Else 
						$vb_Reject:=True:C214
						$rechazados:=$rechazados+1
						APPEND TO ARRAY:C911($aLogRecords;"ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"CODIGO DE BARRA INEXISTENTE:"+"\t"+$text)
					End if 
					
				: ($barcode#"")
					$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]Barcode_SinFormato:26;->$barcode)
					If ($recNum>=0)
						$idItem:=[BBL_Registros:66]Número_de_item:1
					Else 
						$vb_Reject:=True:C214
						$rechazados:=$rechazados+1
						APPEND TO ARRAY:C911($aLogRecords;"ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"CODIGO DE BARRA INEXISTENTE:"+"\t"+$text)
					End if 
					
				: ($nRegistro>0)
					$recNum:=KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]No_Registro:25;->$nRegistro)
					If ($recNum>=0)
						$idItem:=[BBL_Registros:66]Número_de_item:1
					Else 
						$vb_Reject:=True:C214
						$rechazados:=$rechazados+1
						APPEND TO ARRAY:C911($aLogRecords;"ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"Nº DE REGISTRO INEXISTENTE:"+"\t"+$text)
					End if 
			End case 
			
			If (Not:C34($vb_Reject))
				QUERY:C277([BBL_RegistrosAnaliticos:74];[BBL_RegistrosAnaliticos:74]ID:1=$idItem;*)
				QUERY:C277([BBL_RegistrosAnaliticos:74]; & [BBL_RegistrosAnaliticos:74]Titulos:3=$titulo;*)
				QUERY:C277([BBL_RegistrosAnaliticos:74]; & [BBL_RegistrosAnaliticos:74]Autores:5=$autor)
				If (Records in selection:C76([BBL_RegistrosAnaliticos:74])=0)
					CREATE RECORD:C68([BBL_RegistrosAnaliticos:74])
					[BBL_RegistrosAnaliticos:74]ID:1:=$idItem
					[BBL_RegistrosAnaliticos:74]ID_sub:8:=SQ_SeqNumber (->[BBL_RegistrosAnaliticos:74]ID_sub:8)
					$creados:=$creados+1
				Else 
					$actualizados:=$actualizados+1
				End if 
				[BBL_RegistrosAnaliticos:74]Titulos:3:=$titulo
				[BBL_RegistrosAnaliticos:74]Autores:5:=$autor
				[BBL_RegistrosAnaliticos:74]Paginas:6:=$ubicacionEnItem
				[BBL_RegistrosAnaliticos:74]NoVolumen:7:=$volumen
				SAVE RECORD:C53([BBL_RegistrosAnaliticos:74])
				UNLOAD RECORD:C212([BBL_RegistrosAnaliticos:74])
				$procesed:=$procesed+1
			End if 
			RECEIVE PACKET:C104($ref;$text;"\r")
			If ($filePlatform="WIN")
				$text:=_O_Win to Mac:C464($text)
			End if 
		End while 
		CLOSE DOCUMENT:C267($ref)
		CLOSE WINDOW:C154
		FLUSH CACHE:C297
		BBLdbu_BuildCards 
		SQ_SetSequences 
		FLUSH CACHE:C297
		
		CD_Dlog (0;__ ("Registros analíticos procesados: ")+String:C10($procesed)+__ ("\rRegistros analíticos creados: ")+String:C10($creados)+__ ("\rRegistros analíticos actualizados: ")+String:C10($actualizados)+__ ("\rRegistros analíticos rechazados: ")+String:C10($rechazados))
		
		
		If (Size of array:C274($aLogRecords)>0)
			$fileName:=$folderPath+"ImportacionRegistrosAnalíticos.log"
			$ref:=Create document:C266($fileName)
			SORT ARRAY:C229($aLogRecords;>)
			For ($i;1;Size of array:C274($aLogRecords))
				SEND PACKET:C103($ref;$aLogRecords{$i}+"\r")
			End for 
			CLOSE DOCUMENT:C267($ref)
			CD_Dlog (0;__ ("Se detectaron algunos problemas durante la importación.\r\rPor favor consulte el archivo: ")+$filename)
		End if 
		USE CHARACTER SET:C205(*;0)
	End if 
End if 