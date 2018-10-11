  // Método: Método de Formulario: [SN3_PublicationPrefs]PublicationConfigurator
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 04/08/10, 02:10:52
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //Método de Formulario: [SNT_PublicationPrefs].PublicationConfigurator


  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======




Case of 
	: (Form event:C388=On Load:K2:1)
		
		
		
		hl_DataTypesList:=New list:C375
		$dataST:=New list:C375
		$dataACT:=New list:C375
		$dataMT:=New list:C375
		
		C_BOOLEAN:C305(vb_ct_licenciado)
		vb_ct_licenciado:=False:C215
		
		APPEND TO LIST:C376($dataST;__ ("Agenda");SN3_DTi_EventosAgenda)
		APPEND TO LIST:C376($dataST;__ ("Calificaciones");SN3_DTi_Calificaciones)
		APPEND TO LIST:C376($dataST;__ ("Conducta");SN3_DTi_Conducta)  //MONO TICKET 209421 Separar Conducta y Asistencia
		APPEND TO LIST:C376($dataST;__ ("Asistencia");10011)  //MONO TICKET 209421 Separar Conducta y Asistencia
		APPEND TO LIST:C376($dataST;__ ("Compañeros");SN3_DTi_Companeros)
		APPEND TO LIST:C376($dataST;__ ("Horario");SN3_DTi_Horarios)
		APPEND TO LIST:C376($dataST;__ ("Observaciones");SN3_DTi_Observaciones)
		APPEND TO LIST:C376($dataST;__ ("Salud");SN3_DTi_Salud)
		APPEND TO LIST:C376($dataST;__ ("Planes de Clase");SN3_DTi_PlanesClase)
		APPEND TO LIST:C376($dataST;__ ("Aprendizajes Esperados");SN3_DTi_CalificacionesMPA)
		APPEND TO LIST:C376($dataST;__ ("Actividades Extracurriculares");SN3_DTi_CalificacionesExtraCurr)
		APPEND TO LIST:C376($dataST;__ ("Profesores");SN3_DTi_Profesores)  //MONO 06-11-13: pub profesores
		APPEND TO LIST:C376($dataST;__ ("Sesiones de Clases");10012)  //MONO 22-05-14: pub sesiones, comentado hasta que exista la visualizacion en sn3
		APPEND TO LIST:C376($dataST;__ ("Material Docente");10013)  //ASM agregar comentario
		APPEND TO LIST:C376($dataACT;__ ("Avisos de Cobranza");SN3_DTi_AvisosCobranza)
		APPEND TO LIST:C376($dataACT;__ ("Pagos");SN3_DTi_Pagos)
		  //APPEND TO LIST($dataACT;__ ("Documentos Tributarios");SN3_DTi_DTrib)//MONO comento debido a que en SN3 no está lista la publicación
		
		APPEND TO LIST:C376($dataMT;__ ("Préstamos");SN3_DTi_Prestamos)
		
		APPEND TO LIST:C376(hl_DataTypesList;"SchoolTrack";SchoolTrack;$dataST;True:C214)
		APPEND TO LIST:C376(hl_DataTypesList;"AccountTrack";AccountTrack;$dataACT;True:C214)
		APPEND TO LIST:C376(hl_DataTypesList;"MediaTrack";MediaTrack;$dataMT;True:C214)
		APPEND TO LIST:C376(hl_DataTypesList;__ ("Fotografías");40000)
		APPEND TO LIST:C376(hl_DataTypesList;__ ("Comunicaciones");45000)
		APPEND TO LIST:C376(hl_DataTypesList;__ ("Informes");46000)
		APPEND TO LIST:C376(hl_DataTypesList;__ ("Home");45501)  // HOME NOTICIAS TICKET 198851
		
		SET LIST ITEM PROPERTIES:C386(hl_DataTypesList;SchoolTrack;False:C215;Bold:K14:2;Use PicRef:K28:4+2073)
		SET LIST ITEM PROPERTIES:C386(hl_DataTypesList;AccountTrack;False:C215;Bold:K14:2;Use PicRef:K28:4+2076)
		SET LIST ITEM PROPERTIES:C386(hl_DataTypesList;MediaTrack;False:C215;Bold:K14:2;Use PicRef:K28:4+2074)
		SET LIST ITEM PROPERTIES:C386(hl_DataTypesList;40000;False:C215;Bold:K14:2;0)
		SET LIST ITEM PROPERTIES:C386(hl_DataTypesList;45000;False:C215;Bold:K14:2;0)
		SET LIST ITEM PROPERTIES:C386(hl_DataTypesList;45501;False:C215;Bold:K14:2;0)  // HOME NOTICIAS TICKET 198851
		SET LIST PROPERTIES:C387(hl_DataTypesList;_o_Ala Macintosh:K28:1;0;18)
		_O_REDRAW LIST:C382(hl_DataTypesList)
		ARRAY LONGINT:C221(aDataRefs;0)
		ARRAY LONGINT:C221(aLefts;0)
		ARRAY LONGINT:C221(aTops;0)
		ARRAY TEXT:C222(aObjectNames;0)
		  //ASM cambio la forma de agregar la referencia
		For ($i;1;Count list items:C380($dataST))
			GET LIST ITEM:C378($dataST;$i;$l_refElem;$t_textoElemento;$Sublista;$b_desplegada)
			APPEND TO ARRAY:C911(aDataRefs;$l_refElem)
		End for 
		For ($i;1;Count list items:C380($dataACT))
			APPEND TO ARRAY:C911(aDataRefs;20000+$i)
		End for 
		For ($i;1;Count list items:C380($dataMT))
			APPEND TO ARRAY:C911(aDataRefs;30000+$i)
		End for 
		
		APPEND TO ARRAY:C911(aDataRefs;40000)
		APPEND TO ARRAY:C911(aDataRefs;45000)
		APPEND TO ARRAY:C911(aDataRefs;46000)  //MONO 06-11-13: pub informes
		APPEND TO ARRAY:C911(aDataRefs;45501)  // HOME NOTICIAS TICKET 198851
		
		APPEND TO ARRAY:C911(aLefts;1099)
		APPEND TO ARRAY:C911(aTops;787)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesAgenda")
		APPEND TO ARRAY:C911(aLefts;0)
		APPEND TO ARRAY:C911(aTops;520)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesCalificaciones")
		APPEND TO ARRAY:C911(aLefts;824)
		APPEND TO ARRAY:C911(aTops;520)
		APPEND TO ARRAY:C911(aObjectnames;"opcionesConducta")
		APPEND TO ARRAY:C911(aLefts;824)  //MONO TICKET 209421 Separar Conducta y Asistencia
		APPEND TO ARRAY:C911(aTops;1347)  //MONO TICKET 209421 Separar Conducta y Asistencia
		APPEND TO ARRAY:C911(aObjectNames;"opcionesAsistencia")  //MONO TICKET 209421 Separar Conducta y Asistencia
		APPEND TO ARRAY:C911(aLefts;0)
		APPEND TO ARRAY:C911(aTops;787)
		APPEND TO ARRAY:C911(aObjectnames;"opcionesCompañeros")
		APPEND TO ARRAY:C911(aLefts;819)  //MONO  01-07-2013: pub ver num horario
		APPEND TO ARRAY:C911(aTops;1060)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesHorario")
		APPEND TO ARRAY:C911(aLefts;269)
		APPEND TO ARRAY:C911(aTops;787)
		APPEND TO ARRAY:C911(aObjectnames;"opcionesObservaciones")
		APPEND TO ARRAY:C911(aLefts;544)
		APPEND TO ARRAY:C911(aTops;787)
		APPEND TO ARRAY:C911(aObjectnames;"opcionesEnfermeria")
		APPEND TO ARRAY:C911(aLefts;269)
		APPEND TO ARRAY:C911(aTops;1060)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesPlanes")
		APPEND TO ARRAY:C911(aLefts;819)
		APPEND TO ARRAY:C911(aTops;787)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesAprendizajes")
		APPEND TO ARRAY:C911(aLefts;-1)
		APPEND TO ARRAY:C911(aTops;-1)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesActividades")
		APPEND TO ARRAY:C911(aLefts;0)  //MONO 22-05-14: opcion email profe
		APPEND TO ARRAY:C911(aTops;1346)  //MONO 22-05-14: opcion email profe
		APPEND TO ARRAY:C911(aObjectNames;"opcionesProfesores")
		
		  //ASM agregar comentario
		APPEND TO ARRAY:C911(aLefts;269)
		APPEND TO ARRAY:C911(aTops;1349)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesMaterialDocente")
		
		
		APPEND TO ARRAY:C911(aLefts;-1)  //MONO 22-05-14: pub sesiones
		APPEND TO ARRAY:C911(aTops;-1)  //MONO 22-05-14: pub sesiones
		APPEND TO ARRAY:C911(aObjectNames;"opcionesSesiones")  //MONO 22-05-14: pub sesiones
		APPEND TO ARRAY:C911(aLefts;549)
		APPEND TO ARRAY:C911(aTops;520)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesAvisos")
		APPEND TO ARRAY:C911(aLefts;1099)
		APPEND TO ARRAY:C911(aTops;520)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesPagos")
		  //APPEND TO ARRAY(aLefts;-1)//MONO comento debido a que en SN3 no está lista la publicación
		  //APPEND TO ARRAY(aTops;-1)//MONO comento debido a que en SN3 no está lista la publicación
		  //APPEND TO ARRAY(aObjectNames;"opcionesDocumentos")//MONO comento debido a que en SN3 no está lista la publicación
		APPEND TO ARRAY:C911(aLefts;544)
		APPEND TO ARRAY:C911(aTops;1060)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesPrestamos")
		APPEND TO ARRAY:C911(aLefts;0)
		APPEND TO ARRAY:C911(aTops;1060)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesFotografias")
		APPEND TO ARRAY:C911(aLefts;1099)
		APPEND TO ARRAY:C911(aTops;1060)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesComunicaciones")
		APPEND TO ARRAY:C911(aLefts;-1)
		APPEND TO ARRAY:C911(aTops;-1)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesInformes")  //MONO 06-11-13: pub informes
		APPEND TO ARRAY:C911(aLefts;544)
		APPEND TO ARRAY:C911(aTops;1349)
		APPEND TO ARRAY:C911(aObjectNames;"opcionesHome")  // HOME NOTICIAS TICKET 198851
		
		SELECT LIST ITEMS BY REFERENCE:C630(hl_DataTypesList;SchoolTrack)
		vlSN3_CurrDataType:=SchoolTrack
		vtSN3_CurrDataType:=""
		OBJECT SET VISIBLE:C603(*;"elementosGenerales@";False:C215)
		OBJECT SET VISIBLE:C603(*;"Msg";True:C214)
		
		ARRAY TEXT:C222(at_IDNivel;0)
		ARRAY LONGINT:C221(aiADT_NivNo;0)
		NIV_LoadArrays 
		COPY ARRAY:C226(<>al_NumeroNivelesSchoolNet;aiADT_NivNo)
		COPY ARRAY:C226(<>at_NombreNivelesSchoolNet;at_IDNivel)
		
		vtSNT_ConfigLevel:=at_IDNivel{1}
		vlSN3_CurrConfigLevel:=aiADT_NivNo{1}
		aiADT_NivNo:=1
		vt_NivelEditado:=__ ("Está editando las opciones de publicación para el nivel ")+vtSNT_ConfigLevel
		OBJECT SET TITLE:C194(bSendConfNow;__ ("Enviar ahora ")+vtSNT_ConfigLevel)
		SN3_LoadPubConfig (vlSN3_CurrConfigLevel)
		
		ARRAY LONGINT:C221(aELefts;0)
		ARRAY LONGINT:C221(aETops;0)
		ARRAY TEXT:C222(aEObjectNames;0)
		ARRAY TEXT:C222(aERefs;0)
		
		APPEND TO ARRAY:C911(aELefts;0)
		APPEND TO ARRAY:C911(aETops;270)
		APPEND TO ARRAY:C911(aEObjectNames;"opcionesEAnotaciones")
		APPEND TO ARRAY:C911(aERefs;"Anotaciones")
		
		APPEND TO ARRAY:C911(aELefts;120)
		APPEND TO ARRAY:C911(aETops;270)
		APPEND TO ARRAY:C911(aEObjectNames;"opcionesESuspensiones")
		APPEND TO ARRAY:C911(aERefs;"Suspensiones")
		
		APPEND TO ARRAY:C911(aELefts;0)
		APPEND TO ARRAY:C911(aETops;350)
		APPEND TO ARRAY:C911(aEObjectnames;"opcionesECastigos")
		APPEND TO ARRAY:C911(aERefs;"Castigos")
		
		APPEND TO ARRAY:C911(aELefts;120)
		APPEND TO ARRAY:C911(aETops;350)
		APPEND TO ARRAY:C911(aEObjectnames;"opcionesEAtrasos")
		APPEND TO ARRAY:C911(aERefs;"Atrasos")
		
		APPEND TO ARRAY:C911(aELefts;0)
		APPEND TO ARRAY:C911(aETops;420)
		APPEND TO ARRAY:C911(aEObjectnames;"opcionesECalificaciones")
		APPEND TO ARRAY:C911(aERefs;"Calificaciones")
		
		GET PICTURE FROM LIBRARY:C565("Config_Back_SchoolNet";vp_FondoConfig)
		
		vd_fecha_desde:=Current date:C33(*)
		
		OBJECT SET ENABLED:C1123(cb_ApodAcadSameApodCta;False:C215)  // MONO 191729
		
	: (Form event:C388=On Clicked:K2:4)
		SN3_SetPublicarCheckBox 
		SN3_SetDataObjectsState 
	: (Form event:C388=On Close Box:K2:21)
		SN3_SavePubConfig (vlSN3_CurrConfigLevel)
		SN3_SendPubConfigs (1)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		ARRAY TEXT:C222(SN3_NivelesConfig2Send;0)
		ARRAY TEXT:C222(SN3_Configs2Send;0)
End case 
