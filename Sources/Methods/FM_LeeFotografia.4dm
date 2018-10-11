//%attributes = {}
  // MÉTODO: FM_LeeFotografia
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/11, 18:37:20
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // FM_LeeFotografia()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_BLOB:C604($xBlob)
C_PICTURE:C286(vp_Picture)
C_LONGINT:C283($table)


  // CODIGO PRINCIPAL
If (Picture size:C356([Familia:78]Fotografia:35)>0)
	$table:=Table:C252(->[Familia:78])
	$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
	$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+PICT_GetDefaultExtension 
	vp_Picture:=xDOC_ReadExternalPicture ($folder;$fileName)
	If (Picture size:C356(vp_Picture)=0)
		vp_Picture:=[Familia:78]Fotografia:35
	End if 
Else 
	vp_Picture:=vp_Picture*0
End if 


If (False:C215)  //activar y reemplazar código anterior una vez que se implemente almacenamiento en BD externa
	If (Picture size:C356([Familia:78]Fotografia:35)>0)
		$xblob:=xDOC_Picture_GetBlob ([Familia:78]Auto_UUID:23)
		If (BLOB size:C605($xblob)>0)
			BLOB TO PICTURE:C682($xblob;vp_Picture;".jpg")
			If (Picture size:C356(vp_Picture)=0)
				CD_Dlog (0;__ ("La fotografía original no puedo ser leída desde la base de datos externa (xDocuments)."))
				vp_Picture:=[Familia:78]Fotografia:35
			End if 
		Else 
			CD_Dlog (0;__ ("La fotografía original no puedo ser leída desde la base de datos externa (xDocuments)."))
		End if 
	Else 
		vp_Picture:=vp_Picture*0
	End if 
End if 