Case of 
	: (Form event:C388=On Load:K2:1)
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
		cb_Log_VerInfo:=1
		cb_Log_VerErrores:=1
		cb_Log_VerGeneracion:=1
		cb_Log_VerEnvios:=1
		vd_Log_SelectedFecha:=!00-00-00!
		SN3_Log_LoadST (vd_Log_SelectedFecha;cb_Log_VerErrores;cb_Log_VerInfo;cb_Log_VerGeneracion;cb_Log_VerEnvios)
		ARRAY DATE:C224(SN3_Log_Fecha_Menu;0)
		COPY ARRAY:C226(SN3_Log_Fecha;SN3_Log_Fecha_Menu)
		vFechaHeader:=0
		vHoraHeader:=0
		vEventoHeader:=0
		vLastLinea:=-1
		r_ST:=1
		r_SN:=0
		OBJECT SET VISIBLE:C603(bReload;False:C215)
		b_SNLogLoaded:=False:C215
		
		C_DATE:C307(vdSN3_LogDesde;vdSN3_LogHasta)
		vdSN3_LogDesde:=Add to date:C393(Current date:C33(*);0;0;-14)
		vdSN3_LogHasta:=Current date:C33(*)+1
		OBJECT SET VISIBLE:C603(*;"bReload@";(r_SN=1))
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		ARRAY DATE:C224(SN3_Log_Fecha;0)
		ARRAY LONGINT:C221(SN3_Log_Hora;0)
		ARRAY TEXT:C222(SN3_Log_Descripcion;0)
		ARRAY LONGINT:C221(SN3_Log_Colores;0)
		ARRAY LONGINT:C221(SN3_Log_Estilos;0)
		_O_ARRAY STRING:C218(14;$dts;0)
		ARRAY LONGINT:C221(SN3_Log_Tipo;0)
		ARRAY TEXT:C222(SN3_Log_DescError;0)
		ARRAY TEXT:C222(SN3_Log_Maquina;0)
		ARRAY DATE:C224(SN3_Log_FechaSN;0)
		ARRAY LONGINT:C221(SN3_Log_HoraSN;0)
		ARRAY TEXT:C222(SN3_Log_DescripcionSN;0)
		ARRAY LONGINT:C221(SN3_Log_ColoresSN;0)
		ARRAY LONGINT:C221(SN3_Log_EstilosSN;0)
		ARRAY LONGINT:C221(SN3_Log_TipoSN;0)
		ARRAY TEXT:C222(SN3_Log_DescErrorSN;0)
		ARRAY TEXT:C222(SN3_Log_MaquinaSN;0)
End case 