//%attributes = {}
  //xDOC_AutoLoadPictures

C_LONGINT:C283($table)
If (<>viSTR_AutoLoadPictures=1)
	$picturePointer:=$1
	If (Picture size:C356($picturePointer->)=0)
		$table:=Table:C252($picturePointer)
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
		Case of 
			: ($table=Table:C252(->[Alumnos:2]))
				$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Alumnos:2]numero:1)+".pic"
			: ($table=Table:C252(->[Profesores:4]))
				$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Profesores:4]Numero:1)+".pic"
			: ($table=Table:C252(->[Personas:7]))
				$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Personas:7]No:1)+".pic"
			: ($table=Table:C252(->[BBL_Lectores:72]))
				$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([BBL_Lectores:72]ID:1)+".pic"
			: ($table=Table:C252(->[Familia:78]))
				$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+".pic"
		End case 
		$picture:=xDOC_ReadExternalPicture ($folder;$fileName;False:C215)
		If (Picture size:C356($picture)>0)
			CREATE THUMBNAIL:C679($picture;$thumbnail;96;96;Scaled to fit prop centered:K6:6)
			$picturePointer->:=$thumbnail
		End if 
	End if 
End if 