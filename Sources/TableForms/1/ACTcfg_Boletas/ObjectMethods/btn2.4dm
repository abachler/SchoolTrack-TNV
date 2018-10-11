ACTcfgbol_OpcionesMultiNum ("llenaPopUpDesdeForm";->atACT_RBDList)
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)

If (Self:C308->=1)  //20170704 RCH
	CD_Dlog (0;"Esta opción funciona correctamente con la opción "+ST_Qte (OBJECT Get title:C1068(cb_EmiteXCuenta))+" marcada y con el Rol Base de Datos ingresado en la ficha de cada curso.")
End if 