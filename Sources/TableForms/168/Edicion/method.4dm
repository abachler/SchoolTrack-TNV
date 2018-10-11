  // [Asignaturas_RegistroSesiones].Edicion()
  // Por: Alberto Bachler: 01/07/13, 10:28:40
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



Case of 
	: (Form event:C388=On Load:K2:1)
		READ ONLY:C145([Asignaturas:18])
		RELATE ONE:C42([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
		vt_fechaHoraSesion:=String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;System date long:K1:3)+", "+String:C10([Asignaturas_RegistroSesiones:168]Hora:4)+__ ("ª hora")
		If ([Asignaturas_RegistroSesiones:168]Impartida:5=False:C215)
			vl_TipoInformacionSesion:=0
			OBJECT SET ENTERABLE:C238(*;"infoSesion@";False:C215)
			OBJECT SET VISIBLE:C603(*;"infoSesion@";False:C215)
			OBJECT GET COORDINATES:C663([Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16;$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
			GET WINDOW RECT:C443($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajoVentana)
			SET WINDOW RECT:C444($l_izquierdaVentana;$l_arribaVentana;$l_derechaVentana;$l_abajo+120)
			$b_usuarioAutorizado:=USR_GetMethodAcces ("Asignatura no impartida";0)
			$b_usuarioAutorizado:=$b_usuarioAutorizado | (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168]))
			$b_usuarioAutorizado:=$b_usuarioAutorizado | ([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=<>lUSR_RelatedTableUserID)
			OBJECT SET ENTERABLE:C238([Asignaturas_RegistroSesiones:168]Motivo_para_no_impartir:16;$b_usuarioAutorizado)
			FORM GOTO PAGE:C247(2)
		Else 
			
			READ ONLY:C145([Asignaturas_Inasistencias:125])
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnos)
			QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumnos)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_NombresAusentes)
			SORT ARRAY:C229($at_NombresAusentes;>)
			vt_alumnosAusentes:=AT_array2text (->$at_NombresAusentes;"\r")
			
			$l_recnum:=Record number:C243([Asignaturas_RegistroSesiones:168])
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
			QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]ID_Sesion:1#[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
			SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]Hora:4;$ai_Hora)
			
			$b_RegistroCargado:=KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$l_recnum;True:C214)
			APPEND TO ARRAY:C911($ai_Hora;[Asignaturas_RegistroSesiones:168]Hora:4)
			SORT ARRAY:C229($ai_Hora;>)
			vt_InfoSesion:=String:C10([Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;System date long:K1:3)+"; "
			If (Size of array:C274($ai_Hora)>1)
				For ($i;1;Size of array:C274($ai_Hora)-1)
					vt_InfoSesion:=vt_InfoSesion+String:C10($ai_Hora{$i})+__ ("ª, ")
				End for 
				vt_InfoSesion:=Substring:C12(vt_InfoSesion;1;Length:C16(vt_InfoSesion)-2)
				vt_InfoSesion:=__ ("Sesiones del ")+vt_InfoSesion+__ (" y ")+String:C10($ai_Hora{$i})+__ ("ª hora")
			Else 
				vt_InfoSesion:=__ ("Sesión del ")+vt_InfoSesion+String:C10($ai_Hora{Size of array:C274($ai_Hora)})+__ ("ª hora")
			End if 
			
			OBJECT SET VISIBLE:C603(*;"infoSesion@";False:C215)
			vl_TipoInformacionSesion:=1
			If ([Asignaturas_RegistroSesiones:168]hasData:8=False:C215)
				$l_recnum:=Record number:C243([Asignaturas_RegistroSesiones:168])
				SET QUERY DESTINATION:C396(Into set:K19:2;"$conDatos")
				QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
				QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]hasData:8=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If (Records in set:C195("$conDatos")>0)
					USE SET:C118("$conDatos")
				End if 
				KRL_ReloadInReadWriteMode (->[Asignaturas_RegistroSesiones:168])
			End if 
			POST KEY:C465(Character code:C91("*");256)
			FORM GOTO PAGE:C247(1)
			
		End if 
		
		SET WINDOW TITLE:C213([Asignaturas:18]denominacion_interna:16+": "+vt_fechaHoraSesion)
		
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 



