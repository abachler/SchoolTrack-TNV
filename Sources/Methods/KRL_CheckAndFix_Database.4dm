//%attributes = {}
  // KRL_CheckAndFix_Database()
  // Por: Alberto Bachler: 09/03/13, 18:24:49
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_BLOB:C604($x_blob)
C_LONGINT:C283($i;$l_indexDañados;$l_numeroTabla;$l_registrosDañados;$l_milisegundos)
C_TIME:C306($h_cronometro1;$h_cronometro2;$h_refArchivo)
C_TEXT:C284($t_rutaCarpetaDatosExportados;$t_rutaInforme)

If (False:C215)
	C_LONGINT:C283(KRL_CheckAndFix_Database ;$0)
End if 

If (Application type:C494=4D Remote mode:K5:5)
	CD_Dlog (0;__ ("Este comando no puede ser ejecutado en modo cliente servidor."))
	
Else 
	KRL_UnloadAll 
	ARRAY POINTER:C280(aBadIndexesFieldPointers;0)
	ARRAY POINTER:C280(aTablePointers;0)
	ARRAY LONGINT:C221(aTableNumbers;0)
	ARRAY TEXT:C222(aErrorDescriptions;0)
	
	$l_milisegundos:=Milliseconds:C459
	EM_ErrorManager ("Install")
	KRL_VerifyRecordStructure (->aErrorDescriptions;False:C215;->aTablePointers)
	EM_ErrorManager ("clear")
	$l_milisegundos:=Milliseconds:C459-$l_milisegundos
	$h_cronometro1:=Round:C94($l_milisegundos/1000;0)
	
	SET BLOB SIZE:C606($x_blob;0)
	
	$l_registrosDañados:=Size of array:C274(aErrorDescriptions)
	
	TEXT TO BLOB:C554("VERIFICACIÓN DE LA ESTRUCTURA DE LOS REGISTROS DE LA BASE DE DATOS.\rTiempo de eje"+"cución: "+String:C10($h_cronometro1)+"\r";$x_blob;Mac text without length:K22:10;*)
	If (Size of array:C274(aErrorDescriptions)>0)
		TEXT TO BLOB:C554("Se detectaron "+String:C10($l_registrosDañados)+" situaciones de corrupción de datos.";$x_blob;Mac text without length:K22:10;*)
		For ($i;1;Size of array:C274(aErrorDescriptions))
			TEXT TO BLOB:C554((aErrorDescriptions{$i}+Char:C90(Carriage return:K15:38));$x_blob;Mac text without length:K22:10;*)
		End for 
	Else 
		TEXT TO BLOB:C554("No se detectó ningún daño en la estructura de los registros.";$x_blob;Mac text without length:K22:10;*)
	End if 
	
	ARRAY POINTER:C280(aBadIndexesFieldPointers;0)
	ARRAY POINTER:C280(aTablePointers;0)
	ARRAY TEXT:C222(aErrorDescriptions;0)
	EM_ErrorManager ("Install")
	KRL_VerifyIndexes (->aErrorDescriptions;->aBadIndexesFieldPointers;False:C215;->aTablePointers)
	EM_ErrorManager ("clear")
	$l_milisegundos:=Milliseconds:C459-$l_milisegundos
	$h_cronometro2:=Round:C94($l_milisegundos/1000;0)
	
	$l_indexDañados:=Size of array:C274(aErrorDescriptions)
	TEXT TO BLOB:C554("\r\rVERIFICACIÓN DE LOS INDEX DE LA BASE DE DATOS.\rTiempo de eje"+"cución: "+String:C10($h_cronometro1+$h_cronometro2)+"\r";$x_blob;Mac text without length:K22:10;*)
	If (Size of array:C274(aErrorDescriptions)>0)
		TEXT TO BLOB:C554("Se detectaron "+String:C10($l_indexDañados)+" index dañados:\r";$x_blob;Mac text without length:K22:10;*)
		For ($i;1;Size of array:C274(aErrorDescriptions))
			TEXT TO BLOB:C554((aErrorDescriptions{$i}+Char:C90(Carriage return:K15:38));$x_blob;Mac text without length:K22:10;*)
		End for 
	Else 
		TEXT TO BLOB:C554("No se detectó ningún daño en los index.";$x_blob;Mac text without length:K22:10;*)
	End if 
	
	CLEAR PASTEBOARD:C402
	APPEND DATA TO PASTEBOARD:C403("TEXT";$x_blob)
	
	Case of 
		: ($l_registrosDañados>0)
			$t_rutaInforme:=SYS_GetServerProperty (XS_DataFileFolder)+"Informe Verificación BD.txt"
			$h_refArchivo:=Create document:C266($t_rutaInforme;"TEXT")
			CLOSE DOCUMENT:C267($h_refArchivo)
			BLOB TO DOCUMENT:C526($t_rutaInforme;$x_blob)
			OK:=CD_Dlog (0;__ ("Se detectaron problemas SERIOS en la base de datos. Un informe detallado fue guardado en:\r")+$t_rutaInforme+__ ("\r\rLa base de datos puede ser reconstruida por exportación e importación en una base de datos nueva.\r¿Desea exportar los datos ahora?\r\rSi necesita asistencia para este proceso, pongáse en contacto con el Departamento Técnico de Colegium");__ ("");__ ("Exportar datos");__ ("No"))
			If (OK=1)
				$t_rutaCarpetaDatosExportados:=SYS_GetServerProperty (XS_DataFileFolder)+"Datos Exportados"+Folder separator:K24:12
				SYS_CreatePath ($t_rutaCarpetaDatosExportados)
				IO_ExportDatabase (True:C214;$t_rutaCarpetaDatosExportados)
			End if 
			OK:=0
			
		: ($l_indexDañados>0)
			$t_rutaInforme:=SYS_GetServerProperty (XS_DataFileFolder)+"Informe Verificación BD.txt"
			$h_refArchivo:=Create document:C266($t_rutaInforme;"TEXT")
			CLOSE DOCUMENT:C267($h_refArchivo)
			BLOB TO DOCUMENT:C526($t_rutaInforme;$x_blob)
			OK:=CD_Dlog (0;__ ("Se detectaron index dañados en la base de datos. Un informe detallado fue guardado en:\r")+$t_rutaInforme+__ ("\r\rLos index pueden normalmente ser reconstruidos.\r¿Deseas reconstruir los index ahora?");__ ("");__ ("Reconstruir Index");__ ("No"))
			If (OK=1)
				
				ARRAY LONGINT:C221(aTableNumbers;0)
				For ($i;1;Size of array:C274(aBadIndexesFieldPointers))
					$l_numeroTabla:=Table:C252(aBadIndexesFieldPointers{$i})
					If (Find in array:C230(aTableNumbers;$l_numeroTabla)<0)
						APPEND TO ARRAY:C911(aTableNumbers;$l_numeroTabla)
						APPEND TO ARRAY:C911(aTablePointers;Table:C252($l_numeroTabla))
					End if 
					KRL_UnloadAll 
					SET INDEX:C344(aBadIndexesFieldPointers{$i}->;False:C215)
					SET INDEX:C344(aBadIndexesFieldPointers{$i}->;True:C214)
				End for 
				
				ARRAY TEXT:C222(aErrorDescriptions;0)
				ARRAY POINTER:C280(aBadIndexesFieldPointers;0)
				KRL_VerifyIndexes (->aErrorDescriptions;->aBadIndexesFieldPointers;False:C215;->aTablePointers)
				ARRAY POINTER:C280(aTablePointers;0)
				
				If (Size of array:C274(aErrorDescriptions)>0)
					OK:=CD_Dlog (0;__ ("No fue posible reconstruir todos los index dañados. Esto puede indicar un daño SERIO en la base de datos.\r\rPuede intentar reconstruir la base de datos por exportación e importación en una base de datos nueva.\r¿Desea exportar los datos ahora?\r\rSi "+"ita asistencia para este proceso, pongáse en contacto con el Departamento Técnico de Colegium");__ ("");__ ("Exportar datos");__ ("No"))
					If (OK=1)
						$t_rutaCarpetaDatosExportados:=SYS_GetServerProperty (XS_DataFileFolder)+"Datos Exportados"+Folder separator:K24:12
						SYS_CreatePath ($t_rutaCarpetaDatosExportados)
						IO_ExportDatabase (True:C214;$t_rutaCarpetaDatosExportados)
					End if 
					OK:=0
				Else 
					OK:=CD_Dlog (0;__ ("Los index dañados fueron reconstruidos exitosamente."))
					OK:=1
				End if 
			Else 
				OK:=0
			End if 
			
		Else 
			OK:=CD_Dlog (0;__ ("La verificación concluyó exitosamente.\rTiempo de ejecución: ")+String:C10($h_cronometro1+$h_cronometro2)+__ (".\r\rNo se encontró ningún daño en la base de datos."))
			OK:=1
	End case 
	KRL_UnloadAll 
End if 

$0:=OK
