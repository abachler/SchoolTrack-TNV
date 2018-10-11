  // [xShell_Reports].EnvioRepositorio.rutaPdf()
  // Por: Alberto Bachler K.: 13-08-14, 17:27:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_itemSeleccionado)
C_POINTER:C301($y_rutaPdf)
C_TEXT:C284($t_extension;$t_ruta_a_mostrar;$t_rutaArchivo)

ARRAY TEXT:C222($at_Documentos;0)
ARRAY TEXT:C222($at_RutaDocumento;0)

$y_rutaPdf:=OBJECT Get pointer:C1124(Object named:K67:5;"rutaPdf")

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If (Test path name:C476($y_rutaPdf->)=Is a document:K24:1)
			SHOW ON DISK:C922($y_rutaPdf->)
		Else 
			$y_rutaPdf->:=Select document:C905(5;".pdf";__ ("Por favor selecciona el documento PDF que contiene el ejemplo");0;$at_Documentos)
			$y_rutaPdf->:=$at_Documentos{1}
		End if 
		RIN_ComparaInforme ([xShell_Reports:54]UUID:47)
		
	: (Form event:C388=On Clicked:K2:4)
		If (Test path name:C476($y_rutaPdf->)=Is a document:K24:1)
			SYS_PathToArray ($y_rutaPdf->;->$at_RutaDocumento)
			APPEND TO ARRAY:C911($at_RutaDocumento;"(-")
			APPEND TO ARRAY:C911($at_RutaDocumento;__ ("Mostrar en el escritorio..."))
			APPEND TO ARRAY:C911($at_RutaDocumento;__ ("Seleccionar otro..."))
			APPEND TO ARRAY:C911($at_RutaDocumento;__ ("Quitar"))
			$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_RutaDocumento)
			Case of 
				: ($l_itemSeleccionado=Size of array:C274($at_RutaDocumento))
					$y_rutaPdf->:=""
					
				: ($l_itemSeleccionado=(Size of array:C274($at_RutaDocumento)-1))
					$y_rutaPdf->:=Select document:C905(5;".pdf";__ ("Por favor selecciona el documento PDF que contiene el ejemplo");0;$at_Documentos)
					$y_rutaPdf->:=$at_Documentos{1}
					
				: ($l_itemSeleccionado=(Size of array:C274($at_RutaDocumento)-2))
					SHOW ON DISK:C922($y_rutaPdf->)
					
				: ($l_itemSeleccionado=1)
					OPEN URL:C673($y_rutaPdf->)
					
				: ($l_itemSeleccionado>1)
					$t_ruta_a_mostrar:=$at_RutaDocumento{$l_itemSeleccionado}
					For ($i;$l_itemSeleccionado+1;(Size of array:C274($at_RutaDocumento)-3))
						$t_ruta_a_mostrar:=$at_RutaDocumento{$i}+Folder separator:K24:12+$t_ruta_a_mostrar
					End for 
					SHOW ON DISK:C922($t_ruta_a_mostrar)
					
			End case 
			RIN_ComparaInforme ([xShell_Reports:54]UUID:47)
		Else 
			APPEND TO ARRAY:C911($at_RutaDocumento;"Seleccionar...")
			$l_itemSeleccionado:=IT_DynamicPopupMenu_Array (->$at_RutaDocumento)
			If ($l_itemSeleccionado=1)
				$y_rutaPdf->:=Select document:C905(5;".pdf";__ ("Por favor selecciona el documento PDF que contiene el ejemplo");0;$at_Documentos)
				$y_rutaPdf->:=$at_Documentos{1}
			End if 
		End if 
		
		
		
		
		
	: (Form event:C388=On Drag Over:K2:13)
		$t_rutaArchivo:=IT_archivosArrastrados 
		If ($t_rutaArchivo#"")
			$t_extension:=SYS_extensionDocumento ($t_rutaArchivo)
			If ($t_extension#".pdf")
				$0:=-1
			End if 
		End if 
		
		
	: (Form event:C388=On Drop:K2:12)
		$y_rutaPdf->:=IT_archivosArrastrados 
		RIN_ComparaInforme ([xShell_Reports:54]UUID:47)
		
End case 

