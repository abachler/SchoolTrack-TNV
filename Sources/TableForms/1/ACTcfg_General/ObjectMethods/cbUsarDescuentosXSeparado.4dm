If (vb_muestraMensaje)
	CD_Dlog (0;__ ("La modificación en la configuración será tomada en cuenta en la próxima emisión y/o generación"))
	vb_muestraMensaje:=False:C215
End if 

  //OBJECT SET ENABLED(*;"Barras 2D1";(self->=1))
OBJECT SET ENTERABLE:C238(*;"Barras 2D1";(Self:C308->=1))


LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)