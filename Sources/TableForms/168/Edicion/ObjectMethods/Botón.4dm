  // [Asignaturas_RegistroSesiones].Edicion.Botón()
  // Por: Alberto Bachler: 01/07/13, 11:10:48
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------




$b_usuarioAutorizado:=USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168])
$b_usuarioAutorizado:=$b_usuarioAutorizado | ([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=<>lUSR_RelatedTableUserID)

OBJECT SET FONT STYLE:C166(*;"TipoInfo_@";Plain:K14:1)
Case of 
	: (vl_tipoInformacionSesion=1)
		OBJECT SET FONT STYLE:C166(b1_Actividades;Bold:K14:2)
	: (vl_tipoInformacionSesion=2)
		OBJECT SET FONT STYLE:C166(b2_Contenidos;Bold:K14:2)
	: (vl_tipoInformacionSesion=3)
		OBJECT SET FONT STYLE:C166(b3_Observaciones;Bold:K14:2)
	: (vl_tipoInformacionSesion=4)
		OBJECT SET FONT STYLE:C166(b4_Inasistencias;Bold:K14:2)
End case 

OBJECT SET VISIBLE:C603([Asignaturas_RegistroSesiones:168]Actividades:7;vl_tipoInformacionSesion=1)
OBJECT SET VISIBLE:C603([Asignaturas_RegistroSesiones:168]Contenidos:6;vl_tipoInformacionSesion=2)
OBJECT SET VISIBLE:C603([Asignaturas_RegistroSesiones:168]Observacion:12;vl_tipoInformacionSesion=3)
OBJECT SET VISIBLE:C603(vt_alumnosAusentes;vl_tipoInformacionSesion=4)
OBJECT SET ENTERABLE:C238(*;"infoSesion@";$b_usuarioAutorizado)
