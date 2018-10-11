//%attributes = {}
  // SOPORTE_ImportaItemsAlexandria()
  // Por: Alberto Bachler: 17/09/13, 13:44:55
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
READ WRITE:C146([BBL_Items:61])
$ref:=Open document:C264("";"TEXT";Read mode:K24:5)
If ($ref#?00:00:00?)
	$folderPath:=SYS_GetParentNme (document)
	RECEIVE PACKET:C104($ref;$text;"\r")
	ARRAY TEXT:C222($aLogRecords;0)
	$copies:=0
	$created:=0
	$procesed:=0
	$rechazados:=0
	$avisos:=0
	WDW_Open (300;100;0;1986;"Importando Registros")
	
	TRACE:C157
	While ($text#"")
		$vb_Reject:=False:C215
		ARRAY TEXT:C222(aText1;0)
		AT_Text2Array (->aText1;$text;"\t")
		ARRAY TEXT:C222(aText1;43)
		AT_Inc (0)
		$barCode_Original:=ST_Uppercase (Replace string:C233(ST_GetCleanString (aText1{AT_Inc });" ";""))
		$tituloPrincipal:=ST_GetCleanString (aText1{AT_Inc })
		$copia_Volumen:=ST_GetCleanString (aText1{AT_Inc })
		$Volumen:=ST_GetCleanString (aText1{AT_Inc })
		$ClasificacionDewey:=ST_GetCleanString (aText1{AT_Inc })
		$autorPrincipal:=ST_GetCleanString (aText1{AT_Inc })
		$serie_Coleccion:=ST_GetCleanString (aText1{AT_Inc })
		$notasGenerales:=ST_GetCleanString (aText1{AT_Inc })
		$edicion:=ST_GetCleanString (aText1{AT_Inc })
		$resumen:=ST_GetCleanString (aText1{AT_Inc })
		$LCCN:=ST_GetCleanString (aText1{AT_Inc })
		$ISBN:=ST_GetCleanString (aText1{AT_Inc })
		$lugar:=ST_GetCleanString (aText1{AT_Inc })
		$copia_Proveedor:=ST_GetCleanString (aText1{AT_Inc })
		$Editor:=ST_GetCleanString (aText1{AT_Inc })
		$LugarEdicion:=ST_GetCleanString (aText1{AT_Inc })
		$agnoEdicion:=ST_GetCleanString (aText1{AT_Inc })
		$copia_Comentario:=ST_GetCleanString (aText1{AT_Inc })
		$copia_NotaAlerta:=ST_GetCleanString (aText1{AT_Inc })
		$No_copia:=Num:C11(ST_GetCleanString (aText1{AT_Inc }))
		$Descripcion:=ST_GetCleanString (aText1{AT_Inc })
		$Materias1:=ST_GetCleanString (aText1{AT_Inc })
		$Materias2:=ST_GetCleanString (aText1{AT_Inc })
		$Materias3:=ST_GetCleanString (aText1{AT_Inc })
		$Materias4:=ST_GetCleanString (aText1{AT_Inc })
		$Materias5:=ST_GetCleanString (aText1{AT_Inc })
		$materias:=$Materias1+";"+$Materias2+";"+$Materias3+";"+$Materias4+";"+$Materias5
		$materias:=Replace string:C233($materias;";;";";")
		$copia_fechaInventario:=BBLio_ConvAlexDate (ST_GetCleanString (aText1{AT_Inc }))
		$copia_FechaAdquisicion:=BBLio_ConvAlexDate (ST_GetCleanString (aText1{AT_Inc }))
		$copia_ValorRemplazo:=Num:C11(ST_GetCleanString (aText1{AT_Inc }))
		$copia_Costo:=Num:C11(ST_GetCleanString (aText1{AT_Inc }))
		$regla:=ST_GetCleanString (aText1{AT_Inc })
		$coleccionEspecial:=ST_GetCleanString (aText1{AT_Inc })
		$Media:=ST_GetCleanString (aText1{AT_Inc })
		$descripcionFisica:=ST_GetCleanString (aText1{AT_Inc })
		$dimensiones:=ST_GetCleanString (aText1{AT_Inc })
		$materialAdjunto:=ST_GetCleanString (aText1{AT_Inc })
		$Descripcion:=ST_ClearExtraCR ($Descripcion+"\r"+$descripcionFisica+"\r"+$dimensiones+"\r"+$materialAdjunto)
		$notasContenido:=ST_GetCleanString (aText1{AT_Inc })
		$prefijo_Barcode:=ST_Uppercase (ST_GetCleanString (aText1{AT_Inc }))
		$indiceBarCode:=Num:C11(ST_GetCleanString (aText1{AT_Inc }))
		
		$l_elemento:=Find in array:C230(<>atBBL_Media;$Media)
		If ($l_elemento>0)
			$idMedia:=<>alBBL_IDMedia{$l_elemento}
		Else 
			$media:=""
		End if 
		
		
		$ID_importacion:=0
		$TipoRegistro:=""
		$TítulosSecundarios:=""
		  //
		$AutoresSecundarios:=""
		$No_Volumenes:=""
		
		$Idioma:=""
		$ISSN:=""
		$Frecuencia:=""
		
		$NoEnSerie:=""
		$FechaPublicación:=!00-00-00!
		$Cutter:=""
		
		
		
		
		
		
		
		QUERY:C277([xxBBL_ReglasParaItems:69];[xxBBL_ReglasParaItems:69]Codigo_regla:1=$regla)
		If (Records in selection:C76([xxBBL_ReglasParaItems:69])=0)
			CREATE RECORD:C68([xxBBL_ReglasParaItems:69])
			[xxBBL_ReglasParaItems:69]Codigo_regla:1:=$regla
			[xxBBL_ReglasParaItems:69]Nombre Regla:2:=$regla
			SAVE RECORD:C53([xxBBL_ReglasParaItems:69])
		End if 
		
		
		$procesed:=$procesed+1
		
		If ($media="")
			$media:="Libro"
		End if 
		
		$barcode:=""
		If (($prefijo_Barcode="") & ($indiceBarCode#0) & ($barCode_Original#""))
			$indiceBarcode:=0
		End if 
		Case of 
			: ($Tituloprincipal="")  //1
				$vb_Reject:=True:C214
				$rechazados:=$rechazados+1
				INSERT IN ARRAY:C227($aLogRecords;1;1)
				$aLogRecords{1}:="ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"SIN TITULO:"+"\t"+$text
				
		End case 
		
		$recNum:=Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$barCode_Original)
		If ($recNum>=0)
			$vb_Reject:=True:C214
			$rechazados:=$rechazados+1
			INSERT IN ARRAY:C227($aLogRecords;1;1)
			$aLogRecords{1}:="ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"BARCODE DUPLICADO:"+"\t"+$text
		End if 
		
		If ($ID_importacion#0)
			$recNum:=Find in field:C653([BBL_Registros:66]No_Registro:25;$ID_importacion)
			If ($recNum>=0)
				$vb_Reject:=True:C214
				$rechazados:=$rechazados+1
				INSERT IN ARRAY:C227($aLogRecords;1;1)
				$aLogRecords{1}:="ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"ID IMPORTACION DUPLICADO:"+"\t"+$text
			End if 
		End if 
		
		If (Not:C34($vb_Reject))
			If ($TipoRegistro="")
				$TipoRegistro:="Monografía"
			End if 
			
			If ($AutoresSecundarios#"")
				$autor:=$AutorPrincipal+"\r"+$AutoresSecundarios
			Else 
				$autor:=$AutorPrincipal
			End if 
			If ($TítulosSecundarios#"")
				$titulo:=$Tituloprincipal+"\r"+$TítulosSecundarios
			Else 
				$titulo:=$Tituloprincipal
			End if 
			$titulo:=Replace string:C233($titulo;";";"\r")
			$autor:=Replace string:C233($autor;";";"\r")
			$Editor:=Replace string:C233($Editor;";";"\r")
			
			
			
			CREATE RECORD:C68([BBL_Items:61])
			[BBL_Items:61]Titulos:5:=$titulo
			[BBL_Items:61]Autores:7:=$autor
			[BBL_Items:61]Editores:9:=$Editor
			BBLitm_NormalizaAutores 
			BBLitm_NormalizaTitulos 
			BBLitm_NormalizaEditores 
			$primerTitulo:=[BBL_Items:61]Primer_título:4
			$primerAutor:=[BBL_Items:61]Primer_autor:6
			$primerEditor:=[BBL_Items:61]Editores:9
			UNLOAD RECORD:C212([BBL_Items:61])
			
			
			
			QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Clasificacion:2=$ClasificacionDewey;*)
			QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Primer_título:4=$primerTitulo;*)
			QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Primer_autor:6=$primerAutor;*)
			QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Fecha_de_edicion:10=$agnoEdicion;*)
			QUERY:C277([BBL_Items:61]; & [BBL_Items:61]Primer_editor:8=$primerEditor)
			
			If (Records in selection:C76([BBL_Items:61])=0)
				CREATE RECORD:C68([BBL_Items:61])
				[BBL_Items:61]Numero:1:=SQ_SeqNumber (->[BBL_Items:61]Numero:1)
				[BBL_Items:61]Clasificacion:2:=$ClasificacionDewey
				[BBL_Items:61]LCCN:23:=$lccn
				[BBL_Items:61]Clasificacion_principal:45:=Substring:C12([BBL_Items:61]Clasificacion:2;3)
				[BBL_Items:61]Fecha_de_creacion:36:=Current date:C33(*)
				[BBL_Items:61]Fecha_de_modificacion:37:=Current date:C33(*)
				[BBL_Items:61]Tipo_de_registro:18:=$TipoRegistro
				[BBL_Items:61]Creado_por:33:="Importación"
				[BBL_Items:61]Modificado_por:34:=[BBL_Items:61]Creado_por:33
				[BBL_Items:61]Media:15:=$media
				[BBL_Items:61]ID_Media:48:=$idMedia
				[BBL_Items:61]Nivel_de_registro:19:="Monografía"
				[BBL_Items:61]Autores:7:=Replace string:C233($autor;";";"\r")
				[BBL_Items:61]Titulos:5:=Replace string:C233($titulo;";";"\r")
				[BBL_Items:61]Editores:9:=$Editor
				[BBL_Items:61]Fecha_de_edicion:10:=$agnoEdicion
				[BBL_Items:61]Lugar_de_edicion:12:=$LugarEdicion
				[BBL_Items:61]Edicion:11:=$edicion
				[BBL_Items:61]Descripción:14:=$Descripcion
				[BBL_Items:61]Notas:16:=$notasGenerales
				[BBL_Items:61]NotasDeContenido:50:=$notasContenido
				[BBL_Items:61]Resumen:17:=$Resumen
				[BBL_Items:61]ISBN:3:=$ISBN
				[BBL_Items:61]Serie_No:27:=$NoEnSerie
				[BBL_Items:61]Serie_Nombre:26:=$serie_Coleccion
				[BBL_Items:61]Volumen:30:=$Volumen
				[BBL_Items:61]Media:15:=$Media
				If ($materias#"")
					$numberOfWords:=ST_CountWords ($materias;1;";")
					For ($i;1;$numberOfWords)
						$keyword:=ST_GetWord ($materias;$i;";")
						BBLitm_AgregaMateria ([BBL_Items:61]Numero:1;$keyWord)
					End for 
				End if 
				BBLitm_NormalizaAutores 
				BBLitm_NormalizaTitulos 
				BBLitm_NormalizaEditores 
				SAVE RECORD:C53([BBL_Items:61])
				$created:=$created+1
			End if 
			
			If ($No_copia#0)
				QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1=[BBL_Items:61]Numero:1;*)
				QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]Número_de_copia:2=$No_copia)
				If (Records in selection:C76([BBL_Registros:66])=0)
					  //se mantiene el numero de copia del archivo
				Else 
					$No_copia:=[BBL_Items:61]UltimoNumeroDeCopia:49
					$avisos:=$avisos+1
					INSERT IN ARRAY:C227($aLogRecords;1;1)
					$aLogRecords{1}:="AVISO"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"Numero de copia existente. Reasignado "+"\t"+$text
				End if 
			Else 
				$No_copia:=[BBL_Items:61]UltimoNumeroDeCopia:49+1
			End if 
			
			$barCode:=$barCode_Original
			CREATE RECORD:C68([BBL_Registros:66])
			[BBL_Registros:66]ID:3:=SQ_SeqNumber (->[BBL_Registros:66]ID:3)
			[BBL_Registros:66]Número_de_item:1:=[BBL_Items:61]Numero:1
			If ($id_importacion#0)
				[BBL_Registros:66]No_Registro:25:=$id_importacion
			Else 
				[BBL_Registros:66]No_Registro:25:=SQ_SeqNumber (->[BBL_Registros:66]No_Registro:25)
			End if 
			[BBL_Registros:66]Código_de_barra:20:="*"+Replace string:C233($barCode;"*";"")+"*"
			[BBL_Registros:66]Barcode_SinFormato:26:=Replace string:C233($barCode;"*";"")
		End if 
		[BBL_Registros:66]Creado_por:16:="Importación"
		[BBL_Registros:66]Número_de_copia:2:=$No_copia
		[BBL_Registros:66]StatusID:34:=Disponible
		[BBL_Registros:66]Lugar:13:=$lugar
		[BBL_Registros:66]Comentario:11:=$copia_Comentario
		[BBL_Registros:66]Costo:8:=$copia_Costo
		[BBL_Registros:66]Fecha_de_adquisición:17:=$copia_FechaAdquisicion
		[BBL_Registros:66]Ultimo_inventario:6:=$copia_fechaInventario
		[BBL_Registros:66]Proveedor:4:=$copia_Proveedor
		[BBL_Registros:66]Valor_de_remplazo:9:=$copia_ValorRemplazo
		[BBL_Registros:66]Número_de_volumen:19:=$copia_Volumen
		[BBL_Registros:66]NotaDeAlerta:29:=$copia_NotaAlerta
		[BBL_Registros:66]ColeccionEspecial:30:=$coleccionEspecial
		
		
		
		$recNum:=Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$barCode)
		If ($recNum>=0)
			$rechazados:=$rechazados+1
			INSERT IN ARRAY:C227($aLogRecords;1;1)
			$aLogRecords{1}:="ERROR"+"\t"+"Línea: "+String:C10($procesed)+"\t"+"BARCODE DUPLICADO:"+"\t"+$text
		Else 
			[BBL_Items:61]Copias:24:=[BBL_Items:61]Copias:24+1
			[BBL_Items:61]Copias_disponibles:43:=[BBL_Items:61]Copias_disponibles:43+1
			If ([BBL_Registros:66]Número_de_copia:2>[BBL_Items:61]UltimoNumeroDeCopia:49)
				[BBL_Items:61]UltimoNumeroDeCopia:49:=[BBL_Registros:66]Número_de_copia:2
			End if 
			SAVE RECORD:C53([BBL_Items:61])
			BBLreg_GeneraCodigoBarra 
			SAVE RECORD:C53([BBL_Registros:66])
			$copies:=$copies+1
		End if 
		GOTO XY:C161(0;0)
		MESSAGE:C88("Registros procesados: "+String:C10($procesed)+"\r"+"Items creados: "+String:C10($created)+"\r"+"Copias creadas: "+String:C10($copies)+"\r"+"Copias rechazadas: "+String:C10($rechazados)+"\r"+"Avisos: "+String:C10($avisos))
		RECEIVE PACKET:C104($ref;$text;"\r")
	End while 
	CLOSE DOCUMENT:C267($ref)
	CLOSE WINDOW:C154
	FLUSH CACHE:C297
	BBLdbu_BuildCards 
	SQ_SetSequences 
	FLUSH CACHE:C297
	
	If (Size of array:C274($aLogRecords)>0)
		$fileName:=$folderPath+"Bitácora de importación.txt"
		$ref:=Create document:C266($fileName)
		SORT ARRAY:C229($aLogRecords;>)
		For ($i;1;Size of array:C274($aLogRecords))
			SEND PACKET:C103($ref;$aLogRecords{$i}+"\r")
		End for 
		CLOSE DOCUMENT:C267($ref)
		CD_Dlog (0;__ ("Se detectaron algunos problemas durante la importación.\r\rPor favor consulte el archivo: ")+$filename)
	End if 
End if 




