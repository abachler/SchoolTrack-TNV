//%attributes = {}
  //SRcust_LeeFotografiaExterna
C_LONGINT:C283($table)


$picturePointer:=$1

  //UTLIZAR SOLO MIENTRAS NO FINALIZE LA IMPLEMENTACIÓN DE ALMACENAMIENTO DE FOTOS EN BD EXTERNA.
If (True:C214)
	$table:=Table:C252($picturePointer)
	$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
	
	
	Case of 
		: ($table=Table:C252(->[Alumnos:2]))
			  //$folder:="0002"
			$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Alumnos:2]numero:1)+PICT_GetDefaultExtension 
		: ($table=Table:C252(->[Profesores:4]))
			  //$folder:="0004"
			$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Profesores:4]Numero:1)+PICT_GetDefaultExtension 
		: ($table=Table:C252(->[Personas:7]))
			  //$folder:="0007"
			$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Personas:7]No:1)+PICT_GetDefaultExtension 
		: ($table=Table:C252(->[BBL_Lectores:72]))
			  //$folder:="0066"
			$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([BBL_Lectores:72]ID:1)+PICT_GetDefaultExtension 
			
			  //PS 20/08/2011 se agrega siguiente condicion ya que no leia fotos de familias
		: ($table=Table:C252(->[Familia:78]))
			$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+PICT_GetDefaultExtension 
			
	End case 
	$0:=xDOC_ReadExternalPicture ($folder;$fileName)
End if 


If (False:C215)  //utilizar cuando se implemente el almacenamiento en BD externas
	  //C_POINTER($1;$tablePointer;$picturePointer)
	  //C_PICTURE($picture;$0)
	  //C_LONGINT($table;$w;$h)
	  //C_TEXT($fileName)
	  //$picturePointer:=$1
	  //$tablePointer:=Table(Table($picturePointer))
	  //$useThumbnail:=True
	  //
	  //If (Count parameters=2)
	  //$useThumbnail:=$2
	  //End if 
	  //
	  //If ($useThumbnail)
	  //$0:=$picturePointer->
	  //Else 
	  //  //para leer el archivo con la foto almacenada externamente
	  //$table:=Table($picturePointer)
	  //PICTURE PROPERTIES($picturePointer->;$w;$h)
	  //
	  //Case of 
	  //: ($table=Table(->[Alumnos]))
	  //$blob:=xDOC_Picture_GetBlob ([Alumnos]UUID)
	  //: ($table=Table(->[Profesores]))
	  //$blob:=xDOC_Picture_GetBlob ([Profesores]UUID)
	  //: ($table=Table(->[Personas]))
	  //$blob:=xDOC_Picture_GetBlob ([Personas]UUID)
	  //: ($table=Table(->[BBL_Lectores]))
	  //$blob:=xDOC_Picture_GetBlob ([BBL_Lectores]UUID)
	  //End case 
	  //BLOB TO PICTURE($blob;$picture;".jpg")
	  //$0:=$picture
	
End if 