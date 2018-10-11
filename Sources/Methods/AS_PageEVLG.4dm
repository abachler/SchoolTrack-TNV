//%attributes = {}
  // AS_PageEVLG()
  // Por: Alberto Bachler K.: 09-05-14, 18:09:07
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_IdObjeto;$l_Pagina_a_activar;$l_recNumObjeto;$l_TipoObjeto)
C_LONGINT:C283($l_Pagina_a_activar)
C_POINTER:C301($y_listaEnunciados)
C_TEXT:C284($t_enunciado)


If (False:C215)
	C_TEXT:C284(AS_PageEVLG ;$1)
End if 

C_LONGINT:C283(vlb_HeaderID;vl_PeriodoSeleccionado)
C_TEXT:C284(vtEVLG_VistaActual;vlb_Header)
If (Count parameters:C259=1)
	vtEVLG_VistaActual:=$1
End if 

If (vtEVLG_VistaActual="")
	vtEVLG_VistaActual:="Alumnos"
End if 

PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

vl_year:=<>gYear
If (vl_PeriodoSeleccionado#vlSTR_PeriodoSeleccionado)
	vl_PeriodoSeleccionado:=vlSTR_PeriodoSeleccionado
End if 



Case of 
	: ((vl_PeriodoSeleccionado=0) | ((vl_PeriodoSeleccionado>0) & (vl_PeriodoSeleccionado>Size of array:C274(atSTR_Periodos_Nombre))))
		$devolverPeriodoMasCercano:=True:C214
		$periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);$devolverPeriodoMasCercano)
		atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;$periodo)
		vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$periodo}
		vt_periodo:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
		vl_PeriodoSeleccionado:=$periodo
		If (vl_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
			vb_AvisaSiCambioPeriodo:=True:C214
			OBJECT SET COLOR:C271(vt_periodo;-3)
		Else 
			OBJECT SET COLOR:C271(vt_periodo;-5)
		End if 
		
	: ((vl_PeriodoSeleccionado>0) & (vl_PeriodoSeleccionado<=Size of array:C274(atSTR_Periodos_Nombre)))
		atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vl_PeriodoSeleccionado)
		vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{vl_PeriodoSeleccionado}
		vt_periodo:=atSTR_Periodos_Nombre{atSTR_Periodos_Nombre}
		
		
	: (vl_PeriodoSeleccionado=-1)
		vl_PeriodoSeleccionado:=-1
		atSTR_Periodos_Nombre:=0
		vlSTR_PeriodoSeleccionado:=0
		vt_periodo:="Evaluación Final"
		OBJECT SET COLOR:C271(vt_periodo;-5)
		vb_AvisaSiCambioPeriodo:=False:C215
		
		
		
End case 

If (vl_PeriodoSeleccionado=0)
	vl_PeriodoSeleccionado:=-1
End if 

vlEVLG_mostrarObservacion:=Num:C11(PREF_fGet (0;"Indicador/Observación";"0"))
  //ALP_RemoveAllArrays (xALP_Aprendizajes)
ALP_RemoveAllArrays (xALP_Evaluaciones)

ARRAY TEXT:C222(atEVLG_LLavesEjes;0)
ARRAY TEXT:C222(atEVLG_Alumnos;0)
ARRAY TEXT:C222(atEVLG_Indicadores;0)
ARRAY TEXT:C222(atEVLG_Observaciones_Final;0)
_O_ARRAY STRING:C218(5;asEVLG_EvaluacionSimbolos;0)
_O_ARRAY STRING:C218(5;asEVLG_EvaluacionSimbolos_Final;0)
ARRAY REAL:C219(arEVLG_EvaluacionReal;0)
ARRAY REAL:C219(arEVLG_EvaluacionReal_Final;0)
ARRAY LONGINT:C221(alEVLG_IdsAlumnosEValuaciones;0)
ARRAY LONGINT:C221(alEVLG_RecNumAlumnos;0)


ARRAY TEXT:C222(atEVLG_EjesLogros;0)
ARRAY LONGINT:C221(alEVLG_Ids;0)
ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
ARRAY TEXT:C222(atEVLG_Icons;0)

  // leo los registros de evaluaciones para poner en un arreglo los id's de los alumnos inscritos
READ ONLY:C145([MPA_AsignaturasMatrices:189])


AS_MPA_ListaAlumnos ([Asignaturas:18]Numero:1)


  //verificamos si el usuario puede editar la configuración
QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
If (Records in selection:C76([MPA_AsignaturasMatrices:189])=1)
	vtMPA_MatrizDefecto:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
	vlMPA_RecNumMatrizDefecto:=Record number:C243([MPA_AsignaturasMatrices:189])
	vlMPA_IDMatrizDefecto:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
	vbMPA_ConfiguracionesPropias:=[MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21
	
	If ([MPA_AsignaturasMatrices:189]PersonalizacionPermitida:21)
		$offset:=0
		If (BLOB size:C605([MPA_AsignaturasMatrices:189]xPermisos:5)>0)
			vbMPA_ConfiguracionesPropias:=False:C215
			hlQR_authorizedGroups:=BLOB to list:C557([MPA_AsignaturasMatrices:189]xPermisos:5;$offset)
			hlQR_authorizedUsers:=BLOB to list:C557([MPA_AsignaturasMatrices:189]xPermisos:5;$offset)
			For ($i;1;Count list items:C380(hlQR_authorizedGroups))
				GET LIST ITEM:C378(hlQR_authorizedGroups;$i;$groupId;$groupName)
				If (USR_IsGroupMember_by_GrpID ($groupId))
					vbMPA_ConfiguracionesPropias:=True:C214
					$i:=Count list items:C380(hlQR_authorizedGroups)+1
				End if 
			End for 
			If (Not:C34(vbMPA_ConfiguracionesPropias))
				$userName:=HL_FindInListByReference (hlQR_authorizedUsers;USR_GetUserID )
				If ($userName#"")
					vbMPA_ConfiguracionesPropias:=True:C214
				End if 
			End if 
		Else 
			vbMPA_ConfiguracionesPropias:=True:C214
		End if 
	Else 
		vbMPA_ConfiguracionesPropias:=False:C215
	End if 
	
	If (vbMPA_ConfiguracionesPropias)
		$isAut:=((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (USR_checkRights ("M";->[Asignaturas:18])))
		If (Not:C34($isAut))
			vbMPA_ConfiguracionesPropias:=False:C215
		End if 
	End if 
End if 


vtEVLG_ObjetoEvaluado:=""
If ([Asignaturas:18]EVAPR_IdMatriz:91>0)
	$recNum:=KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91)
	If ($recNum<0)
		$answer:=CD_Dlog (0;__ ("No se encontró la matriz de Aprendizajes esperados.\r\r¿Desea recrearla con la configuración por omisión?");__ ("");__ ("Sí");__ ("No"))
		If ($answer=1)
			$readOnlyState:=Read only state:C362([Asignaturas:18])
			If ($readOnlyState)
				KRL_ReloadInReadWriteMode (->[Asignaturas:18])
			End if 
			[Asignaturas:18]EVAPR_IdMatriz:91:=0
			SAVE RECORD:C53([Asignaturas:18])
			KRL_ResetPreviousRWMode (->[Asignaturas:18];$readOnlyState)
		End if 
	End if 
End if 

If ([Asignaturas:18]EVAPR_IdMatriz:91=0)
	QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Asignatura:3;=;[Asignaturas:18]Asignatura:3;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
	QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
		$el:=Find in array:C230(<>aAsign;[Asignaturas:18]Asignatura:3)
		If ($el>0)
			$area:=<>aAsgAreaMPA{$el}
			QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]Area:13;=;$area;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=[Asignaturas:18]Numero_del_Nivel:6;*)
			QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]ConfiguracionPrincipal:19;=;True:C214)
		End if 
	End if 
	If (Records in selection:C76([MPA_AsignaturasMatrices:189])=0)
		$readOnlyState:=Read only state:C362([Asignaturas:18])
		If ($readOnlyState)
			KRL_ReloadInReadWriteMode (->[Asignaturas:18])
		End if 
		[Asignaturas:18]EVAPR_IdMatriz:91:=MPA_CreaMatrizPorDefecto 
		SAVE RECORD:C53([Asignaturas:18])
		KRL_ResetPreviousRWMode (->[Asignaturas:18];$readOnlyState)
		If ([Asignaturas:18]EVAPR_IdMatriz:91=0)
			$ignore:=CD_Dlog (0;__ ("Esta asignatura no está asociada a ningún área de aprendizaje o no se ha definido ningún Eje, Dimensión o Competencia susceptible de ser evaluado."))
		End if 
	Else 
		$readOnlyState:=Read only state:C362([Asignaturas:18])
		If ($readOnlyState)
			KRL_ReloadInReadWriteMode (->[Asignaturas:18])
		End if 
		[Asignaturas:18]EVAPR_IdMatriz:91:=[MPA_AsignaturasMatrices:189]ID_Matriz:1
		SAVE RECORD:C53([Asignaturas:18])
		KRL_ResetPreviousRWMode (->[Asignaturas:18];$readOnlyState)
	End if 
End if 

  //MONO 11-02-13: ticket 117546
$l_Pagina_a_activar:=1
If (((<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33))))
	Case of 
		: (USR_checkRights ("L";->[Alumnos_Calificaciones:208]))
			$l_Pagina_a_activar:=3
		: (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168]))
			$l_Pagina_a_activar:=7
		Else 
			$l_Pagina_a_activar:=3
	End case 
End if 

$isOpen:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
$entryAllowed:=((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))) & ($isOpen))

If (($entryAllowed) | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)))
	$enterableObs:=True:C214
Else 
	$enterableObs:=False:C215
End if 
If (<>vb_BloquearModifSituacionFinal)
	$enterableObs:=False:C215
End if 

OBJECT SET ENTERABLE:C238(*;"vtObservaciones";$enterableObs)

If ([Asignaturas:18]EVAPR_IdMatriz:91>0)
	If (Not:C34(Test semaphore:C652("UsoMatrizLogros"+String:C10([Asignaturas:18]EVAPR_IdMatriz:91))))
		vtEVLG_TipoEvaluacion:="Evaluación"
		$recNum:=KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91)
		If ($recNum>=0)
			vtEVLG_Configuración:=[MPA_AsignaturasMatrices:189]NombreMatriz:2
			vlEVLG_MatrizLogros_RecNum:=Record number:C243([MPA_AsignaturasMatrices:189])
			
			Case of 
				: (vtEVLG_VistaActual="Aprendizajes")
					$y_listaEnunciados:=OBJECT Get pointer:C1124(Object named:K67:5;"asignatura.mpa.enunciados")
					MPA_ListaEnunciadosMatriz (vlEVLG_MatrizLogros_RecNum;vl_PeriodoSeleccionado;$y_listaEnunciados)
					If (Count list items:C380($y_listaEnunciados->)>0)
						SELECT LIST ITEMS BY POSITION:C381($y_listaEnunciados->;1)
						GET LIST ITEM:C378($y_listaEnunciados->;*;$l_recNumObjeto;$t_enunciado)
						GET LIST ITEM PARAMETER:C985($y_listaEnunciados->;*;"IdObjeto";$l_IdObjeto)
						GET LIST ITEM PARAMETER:C985($y_listaEnunciados->;*;"TipoObjeto";$l_TipoObjeto)
						AS_EVLG_CargaEvaluacion ($l_TipoObjeto;[Asignaturas:18]Numero:1;$l_IdObjeto;vl_PeriodoSeleccionado)
						  //GET LIST PROPERTIES($y_listaEnunciados->;Ala Macintosh;Macintosh node;20)
						GOTO OBJECT:C206(*;"asignatura.mpa.enunciados")
						
					Else 
						CD_Dlog (0;__ ("La matriz de evaluación asignada a esta asignatura no incluye ningún item susceptible de evaluación.\r\rNo es posible registrar evaluaciones de aprendizaje en esta asignatura."))
					End if 
					
					vtEVLG_InstanciaEvaluación:="Aprendizajes esperados:"
					FORM GOTO PAGE:C247(11)
					GOTO OBJECT:C206(*;"lb_enunciados")
					
				: (vtEVLG_VistaActual="Alumnos")
					$y_alumnosId:=OBJECT Get pointer:C1124(Object named:K67:5;"alumnosId")
					If (vlMPA_IDAlumnoSeleccionado=0)
						If (Size of array:C274($y_alumnosId->)>0)
							$y_alumnosId->:=1
						End if 
						$l_idAlumno:=$y_alumnosId->{$y_alumnosId->}
						vlMPA_IDAlumnoSeleccionado:=$l_idAlumno
					Else 
						$y_alumnosId->:=Find in array:C230($y_alumnosId->;vlMPA_IDAlumnoSeleccionado)
					End if 
					LISTBOX SELECT ROW:C912(*;"lb_alumnos";$y_alumnosId->)
					EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;vlMPA_IDAlumnoSeleccionado;[Asignaturas:18]EVAPR_IdMatriz:91)
					GOTO OBJECT:C206(*;"lb_alumnos")
					
					
					  //aNtaStdNme:=aNtaIdAlumno
					  //If (Size of array(aNtaIdAlumno)>0)
					  //EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;vlMPA_IDAlumnoSeleccionado;[Asignaturas]EVAPR_IdMatriz)
					  //End if 
					  //LISTBOX DELETE COLUMN(*;"lb_Alumnos";1)
					  //LISTBOX DELETE COLUMN(*;"lb_Alumnos";2)
					  //LISTBOX INSERT COLUMN(*;"lb_Alumnos";1;"Alumnos";aNtaStdNme;"HeaderAlumnos";vlb_Header)
					  //LISTBOX INSERT COLUMN(*;"lb_Alumnos";2;"IDAlumnos";aNtaIdAlumno;"HeaderIDAlumnos";vlb_HeaderID)
					  //OBJECT SET ENTERABLE(*;"lb_Alumnos";False)
					  //OBJECT SET FONT(*;"lb_Alumnos";"Tahoma")
					  //OBJECT SET FONT SIZE(*;"lb_Alumnos";9)
					  //OBJECT SET RGB COLORS(*;"lb_alumnos";0x0000;0x00FFFFFF;(<>vl_AltBackground_Red << 16)+(<>vl_AltBackground_Green << 8)+<>vl_AltBackground_Blue)
					  //OBJECT SET SCROLL POSITION(*;"lb_alumnos";aNtaIdAlumno)
					vtEVLG_InstanciaEvaluación:="Aprendizajes esperados:"
					FORM GOTO PAGE:C247(10)
			End case 
		End if 
		
	Else 
		CD_Dlog (0;__ ("La matriz de evaluación utilizada en esta asignatura esta siendo modificada por otro usuario. \rNo es posible acceder a la Evaluación de Aprendizajes en este momento. Por favor inténtelo más tarde."))
		AS_OnRecordLoad ($l_Pagina_a_activar)
	End if 
Else 
	AS_OnRecordLoad ($l_Pagina_a_activar)
End if 




