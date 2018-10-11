  // [TMT_Horario].InfoSesiones.lb_Sesiones()
  // Por: Alberto Bachler: 23/05/13, 20:13:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Selection Change:K2:29)
		$d_FechaSesion:=ad_fechaSesiones{ad_fechaSesiones}
		
		TMT_LeeDetallesSesion (al_RecNUmSesiones{ad_fechaSesiones})
		
		vt_Info:=[Asignaturas_RegistroSesiones:168]Actividades:7
		OBJECT SET FONT STYLE:C166(*;"TipoInfo@";Plain:K14:1)
		OBJECT SET FONT STYLE:C166(*;"TipoInfo_Actividades";Bold:K14:2)
		
End case 

