//%attributes = {}
  // PICT_GetNoPictureImage()
  // Por: Alberto Bachler: 17/09/13, 13:44:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_PICTURE:C286($0)
If (False:C215)
	C_PICTURE:C286(PICT_GetNoPictureImage ;$0)
End if 
C_PICTURE:C286(<>p_noPicture)
If (Picture size:C356(<>p_noPicture)=0)
	READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"img"+Folder separator:K24:12+"noImagen.png";<>p_noPicture)
End if 
$0:=<>p_noPicture

