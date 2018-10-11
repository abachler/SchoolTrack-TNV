  //Método de Formulario: STR_CFG_Miscelaneos
_O_C_INTEGER:C282(vi_AsistClases)
$event:=Form event:C388
Case of 
	: ($event=On Load:K2:1)
		XS_SetConfigInterface 
		
		  //Secciones de configuración miscelanea
		C_LONGINT:C283(CFG_MISC_secciones)
		CFG_MISC_secciones:=New list:C375
		APPEND TO LIST:C376(CFG_MISC_secciones;__ ("Alumnos y Apoderados");1)
		APPEND TO LIST:C376(CFG_MISC_secciones;__ ("Profesores");2)
		APPEND TO LIST:C376(CFG_MISC_secciones;__ ("Generales");3)
		APPEND TO LIST:C376(CFG_MISC_secciones;__ ("Asignaturas");4)
		APPEND TO LIST:C376(CFG_MISC_secciones;__ ("Orden de Nóminas");5)  // 20181008 Patricio Aliaga Ticket N° 204363
		SELECT LIST ITEMS BY POSITION:C381(CFG_MISC_secciones;1)
		
		<>viSTR_NoModificarNotas:=Num:C11(PREF_fGet (0;"NoModificarNotas";"0"))
		<>viSTR_UtilizarObservaciones:=Num:C11(PREF_fGet (0;"UtilizarListasObservaciones";"0"))
		<>viSTR_AsignarComunaDefecto:=Num:C11(PREF_fGet (0;"ComunaPorDefecto";"1"))
		<>viSTR_AutorizarPropEval:=Num:C11(PREF_fGet (0;"PermitirConfigPropEval";"0"))
		<>viSTR_FirmantesAutorizados:=Num:C11(PREF_fGet (0;"FirmantesAutorizados";"1"))
		<>viSTR_AutoLoadPictures:=Num:C11(PREF_fGet (0;"AutoLoadPictures";"0"))
		<>viSTR_ReligionExtendida:=Num:C11(PREF_fGet (0;"ReligionExtendida";"0"))
		  //<>viSTR_AgruparPorSexo:=Num(PREF_fGet (0;"◊viSTR_AgruparPorSexo";"0")) // 20181008 Patricio Aliaga Ticket N° 204363
		<>viSTR_CreditoAsignatura:=Num:C11(PREF_fGet (0;"CreditoAsignaturas";"0"))
		<>vlSTR_UsarSoloUnApellido:=Num:C11(PREF_fGet (0;"Family1Lastname";"0"))
		vi_AsistClases:=Num:C11(PREF_fGet (0;"LogAsistClases"))
		<>viSTR_UD_NombresComun_Oficial:=Num:C11(PREF_fGet (0;"creaNombreAlumnoAutomatico";"0"))
		  //mono reemplaza inasistencia con atraso
		<>viSTR_CambiaInasistenciaxAtraso:=Num:C11(PREF_fGet (0;"CambiaInasistenciaPorAtraso";"0"))
		<>viSTR_ColegioUsaDiap:=Num:C11(PREF_fGet (0;"ColegioUsaDiap";"0"))
		<>viSTR_ForzarMotivoRetiro:=Num:C11(PREF_fGet (0;"forzarMotivoRetiro";"0"))
		  //MONO TICKET 171875 
		<>d_FechaLimiteParaEventosAsig:=Date:C102(PREF_fGet (0;"BloquearEventosAsigHasta";"00-00-00"))
		  // Modificado por: Alexis Bustamante (02-05-2017)
		  //ticket 179785
		<>viSTR_puedeBloquearDiasCalendar:=Num:C11(PREF_fGet (0;"bloquearDiasCalendarioCurso";"0"))
		OBJECT SET VISIBLE:C603(bDefinirEfemerides;(<>viSTR_ReligionExtendida=1))
		  //o1:=Num([xxSTR_Constants]OrdenNtas=1) // 20181008 Patricio Aliaga Ticket N° 204363
		  //o2:=Num([xxSTR_Constants]OrdenNtas=0) // 20181008 Patricio Aliaga Ticket N° 204363
		  //o3:=Num([xxSTR_Constants]OrdenNtas=2) // 20181008 Patricio Aliaga Ticket N° 204363
		
		  //MONO Ticket 174967 Status Alumnos
		C_POINTER:C301($y_StatusAlumno;$y_StatusAlumnoAlias;$y_StatusAlumnoVisible)
		$y_StatusAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"statusAlumno")
		$y_StatusAlumnoAlias:=OBJECT Get pointer:C1124(Object named:K67:5;"statusAlumnoAlias")
		$y_StatusAlumnoVisible:=OBJECT Get pointer:C1124(Object named:K67:5;"statusAlumnoVisible")
		COPY ARRAY:C226(<>at_StatusAlumno;$y_StatusAlumno->)
		COPY ARRAY:C226(<>at_StatusAlumnoAlias;$y_StatusAlumnoAlias->)
		COPY ARRAY:C226(<>ab_StatusAlumnoVisible;$y_StatusAlumnoVisible->)
		LISTBOX SET PROPERTY:C1440(*;"lbStatusAlumno";lk sortable:K53:45;0)
		OBJECT SET TITLE:C194(*;"tl_statusAlumno";__ ("Status Alumno"))
		OBJECT SET TITLE:C194(*;"tl_statusAluAlias";__ ("Status Alias"))
		OBJECT SET TITLE:C194(*;"tl_statusAluVisible";__ ("Visible"))
		
		  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
		C_LONGINT:C283(l_lbNivPosSel)
		C_OBJECT:C1216(o_nomEvaGral)
		o_nomEvaGral:=PREF_fGetObject (0;"PrefObj_NombreColumnasEvaluacionesGenerales";o_nomEvaGral)
		l_lbNivPosSel:=0
		C_POINTER:C301($y_NivelesEvaGral;$y_nombreEvaGral;$y_displayEvaGral)
		$y_NivelesEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"SelAsigNiveles")
		$y_nombreEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"nombreEvaGral")
		$y_displayEvaGral:=OBJECT Get pointer:C1124(Object named:K67:5;"displayEvaGral")
		
		COPY ARRAY:C226(<>at_NombreNivelesActivos;$y_NivelesEvaGral->)
		
		  //ASM Ticket 208501 
		$y_CrearAtrasoInitJornada:=OBJECT Get pointer:C1124(Object named:K67:5;"chk_AtrasoInicio")
		$y_CrearAtrasoInitJornada->:=Num:C11(PREF_fGet (0;"CrearAtrasoInicioJornada";"0"))
		
		LISTBOX SET PROPERTY:C1440(*;"lb_selNivEvalGralDisplay";lk sortable:K53:45;0)
		LISTBOX SET PROPERTY:C1440(*;"lb_ConfigDisplayNomEvaGral";lk sortable:K53:45;0)
		
		OBJECT SET TITLE:C194(*;"tl_displayNivelesAsig";__ ("Niveles"))
		OBJECT SET TITLE:C194(*;"tl_nombreEvaGral";__ ("Nombre de la Evaluación"))
		OBJECT SET TITLE:C194(*;"tl_displayEvaGral";__ ("Visualización"))
		
		OBJECT SET ENTERABLE:C238(*;"SelAsigNiveles";False:C215)
		OBJECT SET ENTERABLE:C238(*;"nombreEvaGral";False:C215)
		
		OBJECT SET TITLE:C194(*;"tl_CopyConfigEvalDisplay";__ ("Copiar la configuración de ..."))
		OBJECT SET ENABLED:C1123(*;"btn_CopyConfigEvalDisplay";False:C215)
		
		$y_InasistenciaDiaCompleto:=OBJECT Get pointer:C1124(Object named:K67:5;"chk_registrarInasistenciaDiaCompleto")
		$y_InasistenciaDiaCompleto->:=Num:C11(PREF_fGet (0;"RegistraInasisteDiaCompleto";"1"))
		
		  // 20181008 Patricio Aliaga Ticket N° 204363
		C_OBJECT:C1216($o_conf)
		$o_conf:=STR_ordenNominas ("loadInterfaz")
		
	: (($event=On Clicked:K2:4) | ($event=On Data Change:K2:15))
		
		  // 20181008 Patricio Aliaga Ticket N° 204363
		C_OBJECT:C1216($o_conf)
		$o_conf:=STR_ordenNominas ("saveInterfaz")
		
	: ($event=On Menu Selected:K2:14)
		
	: ($event=On Close Box:K2:21)
		vbCFG_CloseWindow:=True:C214
		POST KEY:C465(27;0)
End case 