//%attributes = {}
  //IT_ShowLockedStatusIcon

  //`xShell, Alberto Bachler
  //Metodo: IT_ShowLockedStatusIcon
  //Por abachler
  // basada en códido de Bertrand Soubeyrand
  //Creada el 07/10/2003, 08:44:12
  //Modificaciones:
If ("DESCRIPCION"="")
	  // $vp_WritableIcon contains the pencil 
	  // $vp_NotWritableIcone contains the pencil with an X on it 
	  // vp_LockedStatusIcon is a picture variable to be displayed on your input 
	  // output form 
End if 

  //****DECLARACIONES****
C_PICTURE:C286(vp_LockedStatusIcon;$vp_WritableIcon;$vp_NotWritableIcone)

  //****INICIALIZACIONES****
GET PICTURE FROM LIBRARY:C565("editable.png";$vp_WritableIcon)
GET PICTURE FROM LIBRARY:C565("noEditable.png";$vp_NotWritableIcone)
  //****CUERPO****
Case of 
	: ((Form event:C388=On Load:K2:1) | (Form event:C388=On Header:K2:17))
		
		$P_Table:=Current form table:C627
		$B_ReadOnly:=Read only state:C362($P_Table->)
		$B_Locked:=Locked:C147($P_Table->)
		
		vp_LockedStatusIcon:=$vp_WritableIcon
		If ($B_ReadOnly) | ($B_Locked)
			vp_LockedStatusIcon:=$vp_NotWritableIcone
		End if 
		
End case 

  //****LIMPIEZA****






