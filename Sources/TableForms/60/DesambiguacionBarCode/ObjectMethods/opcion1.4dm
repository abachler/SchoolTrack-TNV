  // [BBL_Préstamos].DesambiguacionBarCode.opcion1()
  // Por: Alberto Bachler: 30/08/13, 11:27:39
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_boton;$l_coordenadaH;$l_coordenadaH_abs;$l_coordenadaV;$l_coordenadaV_abs;$l_indexObjeto;$l_refVentana)
C_POINTER:C301($y_Imagen)
C_TEXT:C284($t_nombreObjeto;$t_nombreObjetoImagen)
C_PICTURE:C286(vp_Imagen)

Case of 
	: ((Form event:C388=On Mouse Enter:K2:33) | (Form event:C388=On Mouse Move:K2:35))
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
		$l_indexObjeto:=Num:C11($t_nombreObjeto)
		$t_nombreObjetoImagen:="vpBBL_imagen"+String:C10($l_indexObjeto)
		$y_Imagen:=OBJECT Get pointer:C1124(Object named:K67:5;$t_nombreObjetoImagen)
		If (Picture size:C356($y_Imagen->)>0)
			vp_Imagen:=$y_Imagen->
			GET MOUSE:C468($l_coordenadaH;$l_coordenadaV;$l_boton)
			GET MOUSE:C468($l_coordenadaH_abs;$l_coordenadaV_abs;$l_boton;*)
			If (($l_coordenadaH>=1) & ($l_coordenadaH<=70))
				vb_muestraImagen:=True:C214
				$l_refVentana:=Open form window:C675("DetalleImagen";Pop up form window:K39:11;$l_coordenadaH_abs-128;$l_coordenadaV_abs-128)
				DIALOG:C40("DetalleImagen")
				CLOSE WINDOW:C154
			End if 
		End if 
		
	: (Form event:C388=On Mouse Leave:K2:34)
		vb_muestraImagen:=False:C215
		
	: ((Form event:C388=On Double Clicked:K2:5) | (Form event:C388=On Clicked:K2:4))
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
		vl_ObjetoSeleccionado:=Num:C11($t_nombreObjeto)
		ACCEPT:C269
End case 

