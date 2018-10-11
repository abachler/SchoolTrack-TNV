//%attributes = {}
  // ASrs_CargaSesion()
  // Por: Alberto Bachler: 20/05/13, 12:23:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_EdicionAutorizada;$b_RegistroCargado)
C_LONGINT:C283($l_columnaSeleccionada;$l_filaSeleccionada)

ARRAY INTEGER:C220($ai_Hora;0)



OBJECT SET FONT STYLE:C166(*;"tipoInfo@";Plain:K14:1)

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

$l_filaSeleccionada:=LB_GetSelectedRows (->lb_sesiones)
If ($l_filaSeleccionada>0)
	$b_EdicionAutorizada:=(<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("A";->[Asignaturas_RegistroSesiones:168]))
	$b_EdicionAutorizada:=$b_EdicionAutorizada & (vl_tipoInformacionSesion<4)
	KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];alSTK_sesionRecNum{$l_filaSeleccionada};$b_EdicionAutorizada)
	
	
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]ID_Sesion:1#[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
	SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Hora:4;$ai_Hora)
	
	$b_RegistroCargado:=KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];alSTK_sesionRecNum{$l_filaSeleccionada};True:C214)
	APPEND TO ARRAY:C911($ai_Hora;[Asignaturas_RegistroSesiones:168]Hora:4)
	SORT ARRAY:C229($ai_Hora;>)
	vt_InfoSesion:=String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;System date long:K1:3)+"; "
	If (Size of array:C274($ai_Hora)>1)
		For ($i;1;Size of array:C274($ai_Hora)-1)
			vt_InfoSesion:=vt_InfoSesion+String:C10($ai_Hora{$i})+__ ("ª, ")
		End for 
		vt_InfoSesion:=Substring:C12(vt_InfoSesion;1;Length:C16(vt_InfoSesion)-2)
		vt_InfoSesion:=vt_InfoSesion+__ (" y ")+String:C10($ai_Hora{$i})+__ ("ª hora")
	Else 
		vt_InfoSesion:=vt_InfoSesion+String:C10($ai_Hora{Size of array:C274($ai_Hora)})+__ ("ª hora")
	End if 
	
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
	SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnos)
	QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumnos)
	SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_NombresAusentes)
	SORT ARRAY:C229($at_NombresAusentes;>)
	vt_alumnosAusentes:=AT_array2text (->$at_NombresAusentes;"\r")
	
	
	
	If ($b_RegistroCargado)
		OBJECT SET VISIBLE:C603([Asignaturas_RegistroSesiones:168]Actividades:7;vl_tipoInformacionSesion=1)
		OBJECT SET VISIBLE:C603([Asignaturas_RegistroSesiones:168]Contenidos:6;vl_tipoInformacionSesion=2)
		OBJECT SET VISIBLE:C603([Asignaturas_RegistroSesiones:168]Observacion:12;vl_tipoInformacionSesion=3)
		OBJECT SET VISIBLE:C603(vt_alumnosAusentes;vl_tipoInformacionSesion=4)
		OBJECT SET ENTERABLE:C238(*;"infoSesion@";(Not:C34(vb_SesionesAñosAnteriores)) & ($b_EdicionAutorizada))
	Else 
		OBJECT SET ENTERABLE:C238(*;"infoSesion@";False:C215)
		CD_Dlog (0;__ ("Esta sesión de clases no puede ser editada en este momento.\rPor favor intente nuevamente más tarde."))
		KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];alSTK_sesionRecNum{$l_filaSeleccionada};False:C215)
	End if 
Else 
	OBJECT SET ENTERABLE:C238(*;"infoSesion@";(Not:C34(vb_SesionesAñosAnteriores)) & ($b_EdicionAutorizada))
End if 
