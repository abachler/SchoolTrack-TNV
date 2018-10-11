//%attributes = {}
  // AS_xALP_AreaCalificaciones()
  // Por: Alberto Bachler K.: 09-12-13, 17:43:19
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_calculosSobreCompetencias;$b_calificacionesEditables;$b_examenesEditables;$b_PromediosEditables;$b_mostrarPTC)
C_LONGINT:C283($i_elementos;$l_BloqueoColumna;$l_colorAlternoFilas;$l_colorEncabezado;$l_colorMarco;$l_columnasBloquedas;$l_Error;$l_examenes_son_Ingresables;$l_iconoConsolidante;$l_iconoEditable)
C_LONGINT:C283($l_iconoNoEditable;$l_iconoSubAsignatura;$l_ModoVisualizacion;$l_numeroColumnaEsfuerzo;$l_numeroColumnaEXP;$l_numeroColumnas;$l_numeroColumnasInvisibles;$l_primeraColumnaParciales;$l_promedios_son_Ingresables;$l_ultimaColumnaVisible)
C_LONGINT:C283($l_modoRegistroAsistencia)
C_TEXT:C284($t_encabezado;$t_enterableIcon;$t_formato;$t_InfoCalificacion;$t_listaOrdenamientos)

ARRAY LONGINT:C221($al_ColumnasVisibles;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY TEXT:C222($at_encabezados;0)
ARRAY TEXT:C222($at_nombreArreglos;0)

  //C_LONGINT(vi_lastGradeView;<>viSTR_AgruparPorSexo) // 20181008 Patricio Aliaga Ticket N° 204363
C_LONGINT:C283(vi_lastGradeView)
C_BOOLEAN:C305(vb_ComparacionPromedios)

C_OBJECT:C1216($ob_displayEvalGralCol)
C_TEXT:C284($t_colName)
  // CODIGO PRINCIPAL
  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
LOC_ObjNombreColumnasEval ("consultar";->$ob_displayEvalGralCol;[Asignaturas:18]Numero_del_Nivel:6)
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
vb_AvisaSiOrdenModificado:=False:C215

$l_iconoEditable:=8
$l_iconoNoEditable:=9
$l_iconoSubAsignatura:=10
$l_iconoConsolidante:=11

$b_calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
OBJECT SET VISIBLE:C603(*;"EvaluacionAprendizajes";$b_calculosSobreCompetencias)

$b_calificacionesEditables:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_calificacionesEditables:=$b_calificacionesEditables & Not:C34($b_calculosSobreCompetencias)
$b_calificacionesEditables:=$b_calificacionesEditables & (((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
$b_calificacionesEditables:=$b_calificacionesEditables & ((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!))
$b_calificacionesEditables:=$b_calificacionesEditables | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))

$b_PromediosEditables:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_PromediosEditables:=$b_PromediosEditables & (((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
$b_PromediosEditables:=$b_PromediosEditables | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
$b_PromediosEditables:=$b_PromediosEditables & AS_PromediosSonEditables ([Asignaturas:18]Numero:1)

$b_examenesEditables:=Not:C34(<>vb_BloquearModifSituacionFinal)
$b_examenesEditables:=$b_examenesEditables & (((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
$b_examenesEditables:=$b_examenesEditables | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))


If ($b_PromediosEditables)
	$l_iconoPromedios:=$l_iconoEditable
	$l_promedios_son_Ingresables:=1
Else 
	$l_iconoPromedios:=$l_iconoNoEditable
	$l_promedios_son_Ingresables:=0
End if 

$l_examenes_son_Ingresables:=Num:C11($b_examenesEditables)

If (<>vb_BloquearModifSituacionFinal)
	$l_promedios_son_Ingresables:=0
	$l_examenes_son_Ingresables:=0
Else 
	$l_examenes_son_Ingresables:=1
End if 

$l_ModoVisualizacion:=vi_lastGradeView
If ($l_ModoVisualizacion=0)
	$l_ModoVisualizacion:=iEvaluationMode
End if 

$l_colorMarco:=0xFF000000 | (154 << 16) | (154 << 8) | 154
$l_colorEncabezado:=0xFF000000 | (252 << 16) | (252 << 8) | 252
$l_colorAlternoFilas:=0xFF000000 | (<>vl_AltBackground_Red << 16) | (<>vl_AltBackground_Green << 8) | <>vl_AltBackground_Blue
OBJECT SET RGB COLORS:C628(*;"barraOpciones";(154 << 16) | (154 << 8) | 154;(252 << 16) | (252 << 8) | 252)


$t_formato:=""
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_TraceOnError;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_Compatibility;0)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_MinHdrHeight;30)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_MinRowHeight;20)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_HeaderMode;1)
AL_SetAreaRealProperty (xALP_ASNotas;ALP_Area_HdrIndentV;10)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_RowHeightFixed;0)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ShowFocus;0)
AL_SetAreaLongProperty (XALP_ASNotas;ALP_Area_AllowSortEditor;0)
AL_SetAreaLongProperty (XALP_ASNotas;ALP_Area_UserSort;0)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_EntryClick;2)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ClickDelay;8)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_EntryAllowArrows;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_EntryMapEnter;2)
AL_SetAreaTextProperty (xALP_ASNotas;ALP_Area_CallbackMethOnEvent;"AS_xALP_EventosAsignaturas")
AL_SetAreaTextProperty (xALP_ASNotas;ALP_Area_CallbackMethEntryEnd;"AS_xALP_EdicionNotas")
AL_SetAreaTextProperty (xALP_ASNotas;ALP_Area_CallbackMethEntryStart;"AS_xALP_EntradaCelda")  //20180424 RCH
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ShowSortIndicator;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_DrawFrame;0)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ShowColDividers;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ShowRowDividers;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ColDivColor;0xFFEEEEEE)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_RowDivColor;0xFFEEEEEE)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_MiscColor1;$l_colorEncabezado)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ColumnLock;0)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ColumnResize;0)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_SmallScrollbar;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_AltRowColor;$l_colorAlternoFilas)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_AltRowOptions;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_SelMultiple;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_SelPreserve;1)
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_SelNoCtrlSelect;1)
  //AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ShowFooters;1)



AL_RemoveColumn (xALP_ASNotas;-2)



$l_Error:=AL_AddColumn (xALP_ASNotas;->aNtaOrden;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaStdNme;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaCurso;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->alSTR_InasistenciasPeriodo;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaP1;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaP2;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaP3;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaP4;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaP5;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaPF;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaEX;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaEXX;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaF;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaOf;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaPTC_literal;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaBX;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaEsfuerzo;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaEXP;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta1;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta2;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta3;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta4;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta5;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta6;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta7;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta8;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta9;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta10;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta11;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNta12;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaStatus;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaReprobada;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaRegEximicion;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaIDAlumno;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aRealNtaEsfuerzo;0)
For ($i_elementos;1;Size of array:C274(aNtaRealArrPointers);1)
	$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;aNtaRealArrPointers{$i_elementos};0)
End for 
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aRealNtaPresentP;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aNtaRecNum;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aSexoAlumnos;0)
$l_Error:=$l_Error+AL_AddColumn (xALP_ASNotas;->aRealEXRecuperatorio;0)

  //If (True)
  //AL_AddColumn (xALP_ASNotas;->aNtaPCT_Literal;14)
  //AL_SetColumnLongProperty (xALP_ASNotas;14;ALP_Column_Enterable;0)
  //AL_AddColumn (xALP_ASNotas;->aNtaPCT_Real;0)
  //End if 

  //PROPIEDADES POR DEFECTO PARA TODAS LAS COLUMNAS
AL_SetColumnTextProperty (xALP_ASNotas;-2;ALP_Column_HdrFontName;"Tahoma")
AL_SetColumnLongProperty (xALP_ASNotas;-2;ALP_Column_HdrStyleF;Plain:K14:1)
AL_SetColumnLongProperty (xALP_ASNotas;-2;ALP_Column_HdrSize;9)
AL_SetColumnTextProperty (xALP_ASNotas;-2;ALP_Column_FontName;"Tahoma")
AL_SetColumnLongProperty (xALP_ASNotas;-2;ALP_Column_StyleF;Plain:K14:1)
AL_SetColumnLongProperty (xALP_ASNotas;-2;ALP_Column_Size;9)
AL_SetColumnLongProperty (XALP_ASNotas;-2;ALP_Column_CalcHeight;1)
AL_SetColumnRealProperty (xALP_ASNotas;-2;ALP_Column_HdrRotation;90)


  //PROPIEDADES ESPECIALES DE ALGUNAS COLUMNAS
  // nº de lista
AL_SetColumnTextProperty (xALP_ASNotas;1;ALP_Column_HeaderText;"Número de Lista")
AL_SetColumnLongProperty (xALP_ASNotas;1;ALP_Column_Enterable;0)
AL_SetColumnTextProperty (xALP_ASNotas;1;ALP_Column_Format;"###0")
AL_SetColumnLongProperty (xALP_ASNotas;1;ALP_Column_HdrVertAlign;3)
AL_SetColumnLongProperty (xALP_ASNotas;1;ALP_Column_HdrHorAlign;1)
  // alumno
AL_SetColumnTextProperty (xALP_ASNotas;2;ALP_Column_HeaderText;"Alumno")
AL_SetColumnLongProperty (xALP_ASNotas;2;ALP_Column_Enterable;0)
AL_SetColumnRealProperty (xALP_ASNotas;2;ALP_Column_HdrRotation;0)
AL_SetColumnLongProperty (xALP_ASNotas;2;ALP_Column_HdrVertAlign;2)
AL_SetColumnLongProperty (xALP_ASNotas;2;ALP_Column_HdrStyleF;Bold:K14:2)

  // curso
AL_SetColumnTextProperty (xALP_ASNotas;3;ALP_Column_HeaderText;"Curso")
AL_SetColumnLongProperty (xALP_ASNotas;3;ALP_Column_Enterable;0)
  // inasistencia acumulada

  // Modificado por: Alexis Bustamante (12/09/2017)188685 
AL_SetColumnTextProperty (xALP_ASNotas;4;ALP_Column_HeaderText;"AUS")
AL_SetColumnTextProperty (xALP_ASNotas;4;ALP_Column_Format;"###0")
  //AL_SetColumnLongProperty (xALP_ASNotas;4;ALP_Column_Enterable;0)
AL_SetColumnLongProperty (xALP_ASNotas;4;ALP_Column_Enterable;1)

  // promedios
AL_SetColumnTextProperty (xALP_ASNotas;5;ALP_Column_HdrFontName;"Tahoma";9)
AL_SetColumnLongProperty (xALP_ASNotas;5;ALP_Column_HdrStyleF;Bold:K14:2;9)
AL_SetColumnLongProperty (xALP_ASNotas;5;ALP_Column_StyleF;Bold:K14:2;9)
AL_SetColumnLongProperty (xALP_ASNotas;5;ALP_Column_HorAlign;2;9)
AL_SetColumnLongProperty (xALP_ASNotas;5;ALP_Column_Enterable;$l_promedios_son_Ingresables)
AL_SetCellLongProperty (xALP_ASNotas;0;5;ALP_Cell_RightIconID;$l_iconoPromedios;0;13)



  //
For ($i_elementos;1;Size of array:C274(atSTR_Periodos_Nombre))
	$t_encabezado:=atSTR_Periodos_Nombre{$i_elementos}
	If (Length:C16($t_encabezado)>18)
		$t_encabezado:=Substring:C12($t_encabezado;1;16)+"…"
	End if 
	AL_SetColumnTextProperty (xALP_ASNotas;$i_elementos+4;ALP_Column_HeaderText;$t_encabezado)
	AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos+4;ALP_Column_Enterable;$l_promedios_son_Ingresables)
End for 

  //column 10 settings
OB_GET ($ob_displayEvalGralCol;->$t_colName;"PA")  // nombre a desplegar en la columna Promedio Anual
AL_SetColumnTextProperty (xALP_ASNotas;10;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;10;ALP_Column_Enterable;$l_promedios_son_Ingresables)

  //column 11 settings
OB_GET ($ob_displayEvalGralCol;->$t_colName;"EX")  // nombre a desplegar en la columna Examen
AL_SetColumnTextProperty (xALP_ASNotas;11;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;11;ALP_Column_Enterable;Num:C11($b_examenesEditables))
AL_SetCellLongProperty (xALP_ASNotas;0;11;ALP_Cell_RightIconID;Choose:C955($b_examenesEditables;$l_iconoEditable;$l_iconoNoEditable))

  //column 12 settings
OB_GET ($ob_displayEvalGralCol;->$t_colName;"EXX")  // nombre a desplegar en la columna Examen Extra
AL_SetColumnTextProperty (xALP_ASNotas;12;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;12;ALP_Column_Enterable;Num:C11($b_examenesEditables))
AL_SetCellLongProperty (xALP_ASNotas;0;12;ALP_Cell_RightIconID;Choose:C955($b_examenesEditables;$l_iconoEditable;$l_iconoNoEditable))

  //column 13 settings
OB_GET ($ob_displayEvalGralCol;->$t_colName;"NF")  // nombre a desplegar en la columna Nota Final
AL_SetColumnTextProperty (xALP_ASNotas;13;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;13;ALP_Column_Enterable;$l_promedios_son_Ingresables)

  //column 14 settings
OB_GET ($ob_displayEvalGralCol;->$t_colName;"NO")  // nombre a desplegar en la columna Nota Oficial
AL_SetColumnTextProperty (xALP_ASNotas;14;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;14;ALP_Column_Enterable;0)

  // propiedades columna PTC (promedio todas calificaciones)
$t_colName:=OB Get:C1224($ob_displayEvalGralCol;"PTE")  //MONO 114780
AL_SetColumnTextProperty (xALP_ASNotas;15;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;15;ALP_Column_Enterable;0)

  // propiedades columna Bonificación
$t_colName:=OB Get:C1224($ob_displayEvalGralCol;"BONO")  //MONO 114780
AL_SetColumnTextProperty (xALP_ASNotas;16;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;16;ALP_Column_Enterable;Num:C11($b_CalificacionesEditables))

  // propiedades columna Esfuerzo
OB_GET ($ob_displayEvalGralCol;->$t_colName;"Esfuerzo")  // nombre a desplegar en la columna Esfuerzo
AL_SetColumnTextProperty (xALP_ASNotas;17;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;17;ALP_Column_Enterable;1)

  // propiedades columna Examen período
OB_GET ($ob_displayEvalGralCol;->$t_colName;"CP")  // nombre a desplegar en la columna Esfuerzo
AL_SetColumnTextProperty (xALP_ASNotas;18;ALP_Column_HeaderText;$t_colName)
AL_SetColumnLongProperty (xALP_ASNotas;18;ALP_Column_Enterable;Num:C11($b_CalificacionesEditables))

vb_NotaOficialVisible:=[Asignaturas:18]Incide_en_promedio:27 & (vb_NotaOficialVisible | (AT_IsEqual (->aNtaF;->aNtaOF)=0))

$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Columns;$ay_Columnas)
$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Source;$at_nombreArreglos)
$l_Error:=AL_GetObjects (xALP_ASNotas;ALP_Object_HeaderText;$at_encabezados)

If (Not:C34(OB Is defined:C1231([Asignaturas:18]Opciones:57;"mostrarPTC")))
	OB SET:C1220([Asignaturas:18]Opciones:57;"mostrarPTC";False:C215)
End if 
$b_mostrarPTC:=OB Get:C1224([Asignaturas:18]Opciones:57;"mostrarPTC")
viSTR_ColumnaInasistencias:=Find in array:C230($ay_Columnas;->alSTR_InasistenciasPeriodo)
$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->alSTR_InasistenciasPeriodo);ALP_Column_Visible;Num:C11($l_modoRegistroAsistencia=4))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaCurso);ALP_Column_Visible;Num:C11([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaP5);ALP_Column_Visible;Num:C11(viSTR_Periodos_NumeroPeriodos=5))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaP4);ALP_Column_Visible;Num:C11(viSTR_Periodos_NumeroPeriodos>=4))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaP3);ALP_Column_Visible;Num:C11(viSTR_Periodos_NumeroPeriodos>=3))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaP2);ALP_Column_Visible;Num:C11(viSTR_Periodos_NumeroPeriodos>=2))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaPF);ALP_Column_Visible;Num:C11(vi_UsarExamenes))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaEX);ALP_Column_Visible;Num:C11(vi_UsarExamenes))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaEXX);ALP_Column_Visible;Num:C11(vi_UsarExamenExtra))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaOf);ALP_Column_Visible;Num:C11(vb_NotaOficialVisible))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaOf);ALP_Column_Visible;Num:C11(vb_NotaOficialVisible))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaEsfuerzo);ALP_Column_Visible;Num:C11([Asignaturas:18]Ingresa_Esfuerzo:40))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaEXP);ALP_Column_Visible;Num:C11(vi_UsarControlesFinPeriodo))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaPTC_Literal);ALP_Column_Visible;Num:C11($b_mostrarPTC))
AL_SetColumnLongProperty (xALP_ASNotas;Find in array:C230($ay_Columnas;->aNtaBX);ALP_Column_Visible;Num:C11(vi_UsarBonificacion))
$l_numeroColumnas:=Size of array:C274($ay_Columnas)
$l_columnasBloquedas:=Find in array:C230($ay_Columnas;->aNta1)
$l_ultimaColumnaVisible:=Find in array:C230($ay_Columnas;->aNta12)
$l_numeroColumnasInvisibles:=Size of array:C274($ay_Columnas)-$l_ultimaColumnaVisible
AL_SetColumnLongProperty (xALP_ASNotas;$l_ultimaColumnaVisible+1;ALP_Column_Visible;0;$l_numeroColumnasInvisibles)
AL_SetColumnLongProperty (xALP_ASNotas;-2;ALP_Column_HdrBackColor;$l_colorEncabezado)


  // determino la posción del bloqueo de columnas
$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Visible;$al_ColumnasVisibles)


$l_numeroColumnaBX:=Find in array:C230($ay_Columnas;->aNtaBX)
$l_numeroColumnaEsfuerzo:=Find in array:C230($ay_Columnas;->aNtaEsfuerzo)
$l_numeroColumnaEXP:=Find in array:C230($ay_Columnas;->aNtaEXP)
$l_primeraColumnaParciales:=Find in array:C230($ay_Columnas;->aNta1)
Case of 
	: ($al_ColumnasVisibles{$l_numeroColumnaBX}=1)
		$l_BloqueoColumna:=$l_numeroColumnaBX-1
	: ($al_ColumnasVisibles{$l_numeroColumnaEsfuerzo}=1)
		$l_BloqueoColumna:=$l_numeroColumnaEsfuerzo-1
	: ($al_ColumnasVisibles{$l_numeroColumnaEXP}=1)
		$l_BloqueoColumna:=$l_numeroColumnaEXP-1
	Else 
		$l_BloqueoColumna:=$l_primeraColumnaParciales-1
End case 
For ($i_elementos;1;$l_BloqueoColumna;1)
	If ($al_ColumnasVisibles{$i_elementos}=0)
		$l_BloqueoColumna:=$l_BloqueoColumna-1
	End if 
End for 
AL_SetAreaLongProperty (xALP_ASNotas;ALP_Area_ColsLocked;$l_BloqueoColumna)


AL_SetColumnTextProperty (xALP_ASNotas;$l_numeroColumnaBX;ALP_Column_HdrFontName;"Tahoma")
AL_SetColumnLongProperty (xALP_ASNotas;$l_numeroColumnaBX;ALP_Column_HdrStyleF;Underline:K14:4)
AL_SetColumnTextProperty (xALP_ASNotas;$l_numeroColumnaEXP;ALP_Column_HdrFontName;"Tahoma")
AL_SetColumnLongProperty (xALP_ASNotas;$l_numeroColumnaEXP;ALP_Column_HdrStyleF;Underline:K14:4)
AL_SetColumnTextProperty (xALP_ASNotas;$l_numeroColumnaEsfuerzo;ALP_Column_HdrFontName;"Tahoma")
AL_SetColumnLongProperty (xALP_ASNotas;$l_numeroColumnaEsfuerzo;ALP_Column_HdrStyleF;Underline:K14:4)
AL_SetCellLongProperty (xALP_ASNotas;0;$l_numeroColumnaBX;ALP_Cell_RightIconID;Choose:C955($b_CalificacionesEditables;$l_iconoEditable;$l_iconoNoEditable);0;13)
AL_SetColumnLongProperty (xALP_ASNotas;$l_numeroColumnaBX;ALP_Column_HorAlign;2)
AL_SetCellLongProperty (xALP_ASNotas;0;$l_numeroColumnaEXP;ALP_Cell_RightIconID;Choose:C955($b_CalificacionesEditables;$l_iconoEditable;$l_iconoNoEditable);0;13)
AL_SetColumnLongProperty (xALP_ASNotas;$l_numeroColumnaEXP;ALP_Column_HorAlign;2)


$t_listaOrdenamientos:=""
  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
If (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
	If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
		$t_listaOrdenamientos:=String:C10((($l_numeroColumnas-1)*-1))+","
	Else 
		$t_listaOrdenamientos:=String:C10(($l_numeroColumnas-1))+","
	End if 
End if 
Case of 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		$t_listaOrdenamientos:=$t_listaOrdenamientos+"1"
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		If ([Asignaturas:18]Seleccion:17 | [Asignaturas:18]Electiva:11)
			$t_listaOrdenamientos:=$t_listaOrdenamientos+"3,2"
		Else 
			$t_listaOrdenamientos:=$t_listaOrdenamientos+"2"
		End if 
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		$t_listaOrdenamientos:=$t_listaOrdenamientos+"2"
End case 
  //If (<>viSTR_AgruparPorSexo=1)
  //$t_listaOrdenamientos:=String($l_numeroColumnas-1)+","
  //End if 
  //Case of 
  //: (<>gOrdenNta=0)
  //If ([Asignaturas]Seleccion | [Asignaturas]Electiva)
  //$t_listaOrdenamientos:=$t_listaOrdenamientos+"3,2"
  //Else 
  //$t_listaOrdenamientos:=$t_listaOrdenamientos+"2"
  //End if 
  //Else 
  //$t_listaOrdenamientos:=$t_listaOrdenamientos+String(<>gOrdenNta)
  //End case 
AL_SetAreaTextProperty (xALP_ASNotas;ALP_Area_SortList;$t_listaOrdenamientos)

AS_xALP_EstiloCalificaciones 

  //MONO BLOQUEO DE PARCIALES
$y_array_bloq:=Get pointer:C304("ad_BloqueoParcial_P"+String:C10(vlSTR_PeriodoSeleccionado))

$b_calculosSobreCompetencias:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
If ($b_calculosSobreCompetencias)
	$t_InfoCalificacion:=__ ("Resultados calculados sobre la base de evaluación de competencias")
	vi_PrimeraColumnaParciales:=0
	AL_SetColumnLongProperty (xALP_ASNotas;$l_primeraColumnaParciales;ALP_Column_Visible;0;12)
	
	
Else 
	vi_PrimeraColumnaParciales:=$l_primeraColumnaParciales
	For ($i_elementos;$l_primeraColumnaParciales;$l_primeraColumnaParciales+11;1)
		AS_ReadEvalProperties 
		AL_SetColumnTextProperty (xALP_ASNotas;$i_elementos;ALP_Column_Format;$t_formato)
		AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos;ALP_Column_HorAlign;2)
		
		If (atAS_EvalPropPrintName{$i_elementos-vi_PrimeraColumnaParciales+1}="")
			$t_encabezado:="Parcial "+String:C10($i_elementos-vi_PrimeraColumnaParciales+1)
			AL_SetColumnTextProperty (xALP_ASNotas;$i_elementos;ALP_Column_HeaderText;"Parcial "+String:C10($i_elementos-vi_PrimeraColumnaParciales+1))
		Else 
			$t_encabezado:=atAS_EvalPropPrintName{$i_elementos-vi_PrimeraColumnaParciales+1}
		End if 
		If (Length:C16($t_encabezado)>20)
			$t_encabezado:=Substring:C12($t_encabezado;1;12)+"…"+Substring:C12($t_encabezado;Length:C16($t_encabezado)-12)
		End if 
		AL_SetColumnTextProperty (xALP_ASNotas;$i_elementos;ALP_Column_HeaderText;$t_encabezado)
		
		Case of 
			: (alAS_EvalPropSourceID{$i_elementos-vi_PrimeraColumnaParciales+1}>0)
				AL_SetCellLongProperty (xALP_ASNotas;0;$i_elementos;ALP_Cell_RightIconID;$l_iconoConsolidante)
				AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos;ALP_Column_Enterable;0)
				
			: (alAS_EvalPropSourceID{$i_elementos-vi_PrimeraColumnaParciales+1}<0)
				AL_SetCellLongProperty (xALP_ASNotas;0;$i_elementos;ALP_Cell_RightIconID;$l_iconoSubAsignatura)
				AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos;ALP_Column_Enterable;0)
				
				  //MONO BLOQUEO DE PARCIALES
			: ($y_array_bloq->{$i_elementos-vi_PrimeraColumnaParciales+1}>!00-00-00!) & ($y_array_bloq->{$i_elementos-vi_PrimeraColumnaParciales+1}<Current date:C33(*))
				AL_SetCellLongProperty (xALP_ASNotas;0;$i_elementos;ALP_Cell_RightIconID;$l_iconoNoEditable)
				AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos;ALP_Column_Enterable;0)
				
			: (($b_CalificacionesEditables) & (aiAS_EvalPropEnterable{$i_elementos-vi_PrimeraColumnaParciales+1}=1))
				AL_SetCellLongProperty (xALP_ASNotas;0;$i_elementos;ALP_Cell_RightIconID;$l_iconoEditable)
				AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos;ALP_Column_Enterable;1)
				
			: ((Not:C34($b_CalificacionesEditables)) | (aiAS_EvalPropEnterable{$i_elementos-vi_PrimeraColumnaParciales+1}=0))
				AL_SetCellLongProperty (xALP_ASNotas;0;$i_elementos;ALP_Cell_RightIconID;$l_iconoNoEditable)
				AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos;ALP_Column_Enterable;0)
				
			Else 
				AL_SetCellLongProperty (xALP_ASNotas;0;$i_elementos;ALP_Cell_RightIconID;$l_iconoNoEditable)
				AL_SetColumnLongProperty (xALP_ASNotas;$i_elementos;ALP_Column_Enterable;0)
		End case 
	End for 
	
	
	
End if 
AL_SetColumnLongProperty (xALP_ASNotas;-2;ALP_Column_Width;0)


$l_Error:=AL_GetAreaLongProperty (0;ALP_Area_LastError)

  // ASM 20170613 Ticket 183457 Código para deshabilitar el ingreso de notas para los alumnos con status distinto a activo
For ($i;1;Size of array:C274(aNtaStatus))
	  //If (aNtaStatus{$i}#"Activo") ASM 20180416 Ticket 204306
	If ((aNtaStatus{$i}="Retirado@") | (aNtaStatus{$i}="Promovido@"))  //20180912 ASM Ticket 216503 (se agregan los promovidos)
		vi_PrimeraColumnaParciales:=$l_primeraColumnaParciales
		For ($i_elementos;$l_primeraColumnaParciales;$l_primeraColumnaParciales+11;1)
			AL_SetCellLongProperty (xALP_ASNotas;$i;$i_elementos;ALP_Column_Enterable;0)
		End for 
		AL_SetCellLongProperty (xALP_ASNotas;$i;15;ALP_Column_Enterable;0)  //Bonificacion  de CPABC TICKET 187017 
		AL_SetCellLongProperty (xALP_ASNotas;$i;16;ALP_Column_Enterable;0)  //ESZ
		AL_SetCellLongProperty (xALP_ASNotas;$i;17;ALP_Column_Enterable;0)  //CP 
	End if 
	If (aNtaEX{$i}="")
		AL_SetCellLongProperty (xALP_ASNotas;12;$i_elementos;ALP_Column_Enterable;0)  // edición imposible si no examen normal registrado
	End if 
End for 


  //$b_modificacionRestringida:=((<>viSTR_NoModificarNotas=1) & (Not(USR_checkRights ("M";->[Alumnos_Calificaciones]))))
  //20181001 ASM Ticket 215901 (No se validaba al profesor de la asignatura)
$b_modificacionRestringida:=(((<>viSTR_NoModificarNotas=1) & (Not:C34(USR_checkRights ("M";->[Alumnos_Calificaciones:208])))) & ((Not:C34(USR_checkRights ("L";->[Alumnos_Calificaciones:208]))) & (Not:C34(<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4))))

For ($i_columna;1;Size of array:C274($at_nombreArreglos))
	$l_columnaVisible:=AL_GetColumnLongProperty (xALP_ASNotas;$i_columna;ALP_Column_Visible)
	$l_columnaEditable:=AL_GetColumnLongProperty (xALP_ASNotas;$i_columna;ALP_Column_Enterable)
	If (($l_columnaVisible+$l_columnaEditable)=2)
		For ($i_filas;1;Size of array:C274(aNtaRecNum))
			If ((Type:C295($ay_Columnas{$i_columna}->{$i_filas})=Is integer:K8:5) | (Type:C295($ay_Columnas{$i_columna}->{$i_filas})=Is longint:K8:6) | (Type:C295($ay_Columnas{$i_columna}->{$i_filas})=Is real:K8:4))
				$t_columna:=String:C10($ay_Columnas{$i_columna}->{$i_filas})
			Else 
				$t_columna:=$ay_Columnas{$i_columna}->{$i_filas}
			End if 
			
			If (($t_columna#"") & ($at_nombreArreglos{$i_columna}="aNta@") & ($b_modificacionRestringida))
				AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$i_Columna;ALP_Cell_Enterable;0)
			End if 
		End for 
	End if 
End for 




AS_xALP_PropiedadesCalificación (0;0)
AS_OpcionesPaginaEvaluacion 

