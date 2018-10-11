//%attributes = {}
  // EVS_FijaEstadoObjetosInterfaz()
  //
  //
  // creado por: Alberto Bachler Klein: 12-06-16, 12:47:35
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_estiloEnUso;$b_tablaEditable;$b_calculosEscalaAlternativa)
C_LONGINT:C283($l_abajo;$l_alto;$l_ancho;$l_aprendizajesEvaluados;$l_arr;$l_arriba;$l_arribaLB;$l_columna;$l_der;$l_derechaLB)
C_LONGINT:C283($l_fila;$l_izq;$l_izquierda;$l_omitir;$l_registrosEvaluados)
C_POINTER:C301($y_usoAsignaturas;$y_usoCompetencias;$y_usoDimensiones;$y_usoEjes;$y_usoEvaluaciones;$y_usoNivelInterno;$y_usoNivelOficial)
C_REAL:C285($r_ponderacionesB;$r_ponderacionesB5;$r_ponderacionesS;$r_ponderacionesT)

  // TITULO VENTANA
SET WINDOW TITLE:C213(__ ("Estilos de evaluación: ")+[xxSTR_EstilosEvaluacion:44]Name:2)


  // PAGINA MODO
  // activación/inactivación de las opciones para el uso de evaluación de esfuerzo
OBJECT SET ENABLED:C1123(*;"@EvEsfuerzoIndicadores";cb_EvaluaEsfuerzo=1)



  // PAGINA ESCALAS
  // selecciono los items de las listas desplegables correspondientes a los "modos" en funcion de lo definido en el estilo
aEvMode:=iEvaluationMode
aEvViewMode:=iViewMode
aEvPrintMode:=iPrintMode
aEvActas:=iPrintActa

OBJECT SET TITLE:C194(*;"creacion";"Creado el: "+Choose:C955([xxSTR_EstilosEvaluacion:44]dtsCreacion:13#"";DT_FechaISO_a_FechaHora ([xxSTR_EstilosEvaluacion:44]dtsCreacion:13);"N/D"))
OBJECT SET TITLE:C194(*;"modificación";"Modificado el: "+Choose:C955([xxSTR_EstilosEvaluacion:44]dtsModificacion:14#"";DT_FechaISO_a_FechaHora ([xxSTR_EstilosEvaluacion:44]dtsModificacion:14);"?"))


OBJECT SET FONT STYLE:C166(*;"escala@";Plain:K14:1)
Case of 
	: (iEvaluationMode=Notas)
		  // obtengo las equivalencias en símbolos para los máximos y mínimos de las escalas
		OBJECT SET TITLE:C194(*;"escalaSimbolos_Desde";EV2_Nota_a_Simbolo (rGradesFrom))
		OBJECT SET TITLE:C194(*;"escalaSimbolos_Hasta";EV2_Nota_a_Simbolo (rGradesTo))
		sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
		  // pongo en negritas los atributos de la escala de evaluación de referencia
		OBJECT SET FONT STYLE:C166(*;"escalaNotas@";Bold:K14:2)
		
	: (iEvaluationMode=Puntos)
		  // obtengo las equivalencias en símbolos para los máximos y mínimos de las escalas
		OBJECT SET TITLE:C194(*;"escalaSimbolos_Desde";EV2_Puntos_a_Simbolo (rPointsFrom))
		OBJECT SET TITLE:C194(*;"escalaSimbolos_Hasta";EV2_Puntos_a_Simbolo (rPointsTo))
		sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
		  // pongo en negritas los atributos de la escala de evaluación de referencia
		OBJECT SET FONT STYLE:C166(*;"escalaPuntos@";Bold:K14:2)
		
	: (iEvaluationMode=Porcentaje)
		  // obtengo las equivalencias en símbolos para los máximos y mínimos de las escalas
		If (Size of array:C274(aSymbol)>0)  //20170426 ASM
			OBJECT SET TITLE:C194(*;"escalaSimbolos_Desde";Choose:C955(Size of array:C274(aSymbol)>0;aSymbol{1};"No definido"))
			OBJECT SET TITLE:C194(*;"escalaSimbolos_Hasta";Choose:C955(Size of array:C274(aSymbol)>0;aSymbol{Size of array:C274(aSymbol)};"No definido"))
		End if 
		sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
		  // pongo en negritas los atributos de la escala de evaluación de referencia
		OBJECT SET FONT STYLE:C166(*;"escalaPorcentaje@";Bold:K14:2)
		
	: (iEvaluationMode=Simbolos)
		  // obtengo las equivalencias en símbolos para los máximos y mínimos de las escalas
		If (Size of array:C274(aSymbol)>0)  //20170426 ASM
			OBJECT SET TITLE:C194(*;"escalaSimbolos_Desde";Choose:C955(Size of array:C274(aSymbol)>0;aSymbol{1};"No definido"))
			OBJECT SET TITLE:C194(*;"escalaSimbolos_Hasta";Choose:C955(Size of array:C274(aSymbol)>0;aSymbol{Size of array:C274(aSymbol)};"No definido"))
		End if 
		sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
		  // pongo en negritas los atributos de la escala de evaluación de referencia
		OBJECT SET FONT STYLE:C166(*;"escalaSimbolos@";Bold:K14:2)
End case 

If (iEvaluationMode=Porcentaje) | ((iEvaluationMode=Simbolos) & (iPrintMode=Simbolos) & (iPrintActa=Simbolos))
	rAprobatorioPorcentaje:=Round:C94(rPctMinimum;1)
	rPctMinimum:=Round:C94(rPctMinimum;1)
	rPointsMinimum:=Round:C94(rPointsTo*rPctMinimum/100;iPointsDec)
	rGradesMinimum:=Round:C94(rGradesTo*rPctMinimum/100;iGradesDec)
	sSymbolMinimum:=EV2_Real_a_Simbolo (rPctMinimum)
End if 


Case of 
	: (iEvaluationMode=Notas)
		OBJECT SET ENABLED:C1123(*;"conversion_restablecer";rPctMinimum#(rGradesMinimum/rGradesTo*100))
	: (iEvaluationMode=Puntos)
		OBJECT SET ENABLED:C1123(*;"conversion_restablecer";rPctMinimum#(rPointsMinimum/rPointsTo*100))
	: (iEvaluationMode=Porcentaje)
		OBJECT SET ENABLED:C1123(*;"conversion_restablecer";rPctMinimum#(rAprobatorioPorcentaje/100*100))
End case 






  // PAGINA CALCULOS
  //activo/inactivo opciones para el calculo de la nota de presentación al examen
OBJECT SET ENABLED:C1123(*;"calculosNotaFinal_Presentacion@";vi_gTrEXNF=1)
r1:=Choose:C955(iResults=1;1;0)
r2:=Choose:C955(iResults=2;1;0)
r3:=Choose:C955(iResults=3;1;0)
  //
OBJECT SET ENABLED:C1123(v1_ModoCalculoNF;vi_gTrEXNF>0)
OBJECT SET ENABLED:C1123(v2_ModoCalculoNF;vi_gTrEXNF>0)
OBJECT SET ENABLED:C1123(v3_ModoCalculoNF;vi_gTrEXNF>0)
  //vi_ModoCalculoNF:=Choose(vi_gTrEXNF=0;0;1)//20171218 RCH Cuando la variable es vi_ModoCalculoNF, el valor de vi_ModoCalculoNF quedaba siempre en 1.
v1_ModoCalculoNF:=Choose:C955(vi_ModoCalculoNF=0;1;0)
v2_ModoCalculoNF:=Choose:C955(vi_ModoCalculoNF=1;1;0)
v3_ModoCalculoNF:=Choose:C955(vi_ModoCalculoNF=2;1;0)
  //
bConvertSymbolicAverages:=vi_ConvertSymbolicAverage




  // establezco las propiedades de los objetos para el manejo de ponderaciones en el promedio general final
OBJECT SET FORMAT:C236(*;"PonderacionesPeriodos@";"##0"+<>tXS_RS_DecimalSeparator+"00%")
$r_ponderacionesB5:=vrEVS_PonderacionQ1+vrEVS_PonderacionQ2+vrEVS_PonderacionQ3+vrEVS_PonderacionQ4+vrEVS_PonderacionQ5
$r_ponderacionesB:=vrEVS_PonderacionB1+vrEVS_PonderacionB2+vrEVS_PonderacionB3+vrEVS_PonderacionB4
$r_ponderacionesT:=vrEVS_PonderacionT1+vrEVS_PonderacionT2+vrEVS_PonderacionT3
$r_ponderacionesS:=vrEVS_PonderacionS1+vrEVS_PonderacionS2
  // 5 periodos
If (($r_ponderacionesB5#100) & ($r_ponderacionesB5#0))
	OBJECT SET TITLE:C194(*;"statusPonderacion5P";"Error: "+String:C10($r_ponderacionesB5;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	OBJECT SET COLOR:C271(*;"statusPonderacion5P";-3)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion5P";1)
Else 
	If ($r_ponderacionesB5=100)
		OBJECT SET TITLE:C194(*;"statusPonderacion5P";"OK: "+String:C10($r_ponderacionesB5;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	Else 
		OBJECT SET TITLE:C194(*;"statusPonderacion5P";__ ("No ponderados"))
	End if 
	OBJECT SET COLOR:C271(*;"statusPonderacion5P";-11)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion5P";0)
End if 
  //4 periodos
If (($r_ponderacionesB#100) & ($r_ponderacionesB#0))
	OBJECT SET TITLE:C194(*;"statusPonderacion4P";"Error: "+String:C10($r_ponderacionesB;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	OBJECT SET COLOR:C271(*;"statusPonderacion4P";-3)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion4P";1)
Else 
	If ($r_ponderacionesB=100)
		OBJECT SET TITLE:C194(*;"statusPonderacion4P";"OK: "+String:C10($r_ponderacionesB;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	Else 
		OBJECT SET TITLE:C194(*;"statusPonderacion4P";__ ("No ponderados"))
	End if 
	OBJECT SET COLOR:C271(*;"statusPonderacion4P";-11)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion4P";0)
End if 
  // 3 periodos
If (($r_ponderacionesT#100) & ($r_ponderacionesT#0))
	OBJECT SET TITLE:C194(*;"statusPonderacion3P";"OK: "+String:C10($r_ponderacionesT;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	OBJECT SET COLOR:C271(*;"statusPonderacion3P";-3)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion3P";1)
Else 
	If ($r_ponderacionesT=100)
		OBJECT SET TITLE:C194(*;"statusPonderacion3P";"OK: "+String:C10($r_ponderacionesT;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	Else 
		OBJECT SET TITLE:C194(*;"statusPonderacion3P";__ ("No ponderados"))
	End if 
	OBJECT SET COLOR:C271(*;"statusPonderacion3P";-11)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion3P";0)
End if 
  // 2 periodos
If (($r_ponderacionesS#100) & ($r_ponderacionesS#0))
	OBJECT SET TITLE:C194(*;"statusPonderacion2P";"OK: "+String:C10($r_ponderacionesS;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	OBJECT SET COLOR:C271(*;"statusPonderacion2P";-3)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion2P";1)
Else 
	If ($r_ponderacionesS=100)
		OBJECT SET TITLE:C194(*;"statusPonderacion2P";"OK: "+String:C10($r_ponderacionesS;"##0"+<>tXS_RS_DecimalSeparator+"00%"))
	Else 
		OBJECT SET TITLE:C194(*;"statusPonderacion2P";__ ("No ponderados"))
	End if 
	OBJECT SET COLOR:C271(*;"statusPonderacion2P";-11)
	OBJECT SET FONT STYLE:C166(*;"statusPonderacion2P";0)
End if 
  // -------------




  //PAGINA SIMBOLOS
cbEVS_EquivalenciasAbsolutas:=viEVS_EquivalenciasAbsolutas
If ((iGradesDecPP=0) & (iGradesDecPF=0) & (iGradesDecNF=0) & (iGradesDecNO=0) & (iEvaluationMode=Simbolos))
	_O_ENABLE BUTTON:C192(cbEVS_EquivalenciasAbsolutas)
Else 
	_O_DISABLE BUTTON:C193(cbEVS_EquivalenciasAbsolutas)
	cbEVS_EquivalenciasAbsolutas:=0
	viEVS_EquivalenciasAbsolutas:=0
End if 
If (cbEVS_EquivalenciasAbsolutas=1)
	OBJECT SET VISIBLE:C603(*;"aEvEquMethod@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"aEvEquMethod@";True:C214)
End if 



  // los estilos de evaluación por defecto solo pueden ser editados por desarrolladores


  // ciertas propiedades de los estilos en uso no deben ser modificadas por nadie ya que pueden alterar las evaluaciones ya registradas,
  // al menos en algunas de sus representaciones, o, en el mejor de los casos, generar una inconsistencia entre la evaluaciones registradas y las propiedades del estilo
  // las propiedades no editables son
  // - escalas: todas las propiedades

  // determino el uso en niveles como estilo oficial
$y_usoNivelOficial:=OBJECT Get pointer:C1124(Object named:K67:5;"usoNivelOficial")
SET QUERY DESTINATION:C396(Into variable:K19:4;$y_usoNivelOficial->)
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EvStyle_oficial:23;=;[xxSTR_EstilosEvaluacion:44]ID:1;*)
QUERY:C277([xxSTR_Niveles:6]; & ;[xxSTR_Niveles:6]EsNIvelActivo:30;=;True:C214)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

  // determino el uso en niveles como estilo interno
$y_usoNivelInterno:=OBJECT Get pointer:C1124(Object named:K67:5;"usoNivelInterno")
SET QUERY DESTINATION:C396(Into variable:K19:4;$y_usoNivelInterno->)
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EvStyle_interno:33;=;[xxSTR_EstilosEvaluacion:44]ID:1;*)
QUERY:C277([xxSTR_Niveles:6]; & ;[xxSTR_Niveles:6]EsNIvelActivo:30;=;True:C214)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

  // determino el uso en asignaturas
$y_usoAsignaturas:=OBJECT Get pointer:C1124(Object named:K67:5;"usoAsignaturas")
SET QUERY DESTINATION:C396(Into variable:K19:4;$y_usoAsignaturas->)
QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_de_EstiloEvaluacion:39;=;[xxSTR_EstilosEvaluacion:44]ID:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

  // determino el uso en ejes
$y_usoEjes:=OBJECT Get pointer:C1124(Object named:K67:5;"usoEjes")
SET QUERY DESTINATION:C396(Into variable:K19:4;$y_usoEjes->)
QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]EstiloEvaluación:13;=;[xxSTR_EstilosEvaluacion:44]ID:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

  // determino el uso en dimensiones
$y_usoDimensiones:=OBJECT Get pointer:C1124(Object named:K67:5;"usoDimensiones")
SET QUERY DESTINATION:C396(Into variable:K19:4;$y_usoDimensiones->)
QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;=;[xxSTR_EstilosEvaluacion:44]ID:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

  // determino el uso en competencias
$y_usoCompetencias:=OBJECT Get pointer:C1124(Object named:K67:5;"usoCompetencias")
SET QUERY DESTINATION:C396(Into variable:K19:4;$y_usoCompetencias->)
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;=;[xxSTR_EstilosEvaluacion:44]ID:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

  // DETERMINO SI EL ESTILO PUEDE O NO SER MODIFICADO
  // uso en calificaciones registradas
If ($y_usoAsignaturas->>0)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registrosEvaluados)
	QUERY:C277([Alumnos_Calificaciones:208];[Asignaturas:18]Numero_de_EstiloEvaluacion:39;=;[xxSTR_EstilosEvaluacion:44]ID:1;*)
	QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=<>gYear;*)
	QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 

  // uso en evaluaciones de aprendizajes registradas
If (($y_usoEjes->+$y_usoDimensiones->+$y_usoCompetencias->)>0)  // uso
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_aprendizajesEvaluados)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[MPA_DefinicionCompetencias:187]EstiloEvaluacion:7;=;[xxSTR_EstilosEvaluacion:44]ID:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; | ;[MPA_DefinicionDimensiones:188]EstiloEvaluacion:11;=;[xxSTR_EstilosEvaluacion:44]ID:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; | ;[MPA_DefinicionEjes:185]EstiloEvaluación:13;=;[xxSTR_EstilosEvaluacion:44]ID:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
End if 


$y_usoEvaluaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"usoEvaluaciones")
$y_usoEvaluaciones->:=$l_registrosEvaluados+$l_aprendizajesEvaluados

  // si el estilo está en uso no es posible eliminarlo
$b_estiloEnUso:=(($y_usoNivelOficial->+$y_usoNivelInterno->+$y_usoEjes->+$y_usoDimensiones->+$y_usoCompetencias->)>0)
OBJECT SET ENABLED:C1123(*;"botonEliminar";Not:C34($b_estiloEnUso) & ([xxSTR_EstilosEvaluacion:44]ID:1>0))

  // activación / inactivación de atributos que implicarían recalcular las distintas representaciones de las evaluaciones registradas
OBJECT SET ENTERABLE:C238(*;"escalaNotas_MinimoAprobatorio";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"escalaPuntos_MinimoAprobatorio";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"escalaPorcentaje_MinimoAprobatorio";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"escalaSimbolos_MinimoAprobatorio";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"conversion_regla";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"@_MinimoAprobatorio";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"@_desde";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"@_hasta";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"@_decimalesPeriodicas";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"simbolos_@";$y_usoEvaluaciones->=0)
OBJECT SET ENABLED:C1123(*;"Modo_@";$y_usoEvaluaciones->=0)
  //OBJECT SET ENABLED(*;"usarTablaConversion";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"conversion_minimoReferencia";$y_usoEvaluaciones->=0)
OBJECT SET ENTERABLE:C238(*;"intervalosNota";(iEvaluationMode=Puntos) & ($y_usoEvaluaciones->=0))
OBJECT SET ENTERABLE:C238(*;"intervalosPuntos";(iEvaluationMode=Notas) & ($y_usoEvaluaciones->=0))

OBJECT SET TITLE:C194(*;"statusEdicionSimbolos";\
Choose:C955($y_usoEvaluaciones->>0;__ ("No se pueden introducir modificaciones en la tabla de equivalencia de símbolos ya que hay evaluaciones registradas con este estilo de evaluación.");""))
OBJECT SET TITLE:C194(*;"statusEdicionConversion";\
Choose:C955($y_usoEvaluaciones->>0;__ ("No se pueden introducir modificaciones en la tabla de conversión ya que hay evaluaciones registradas con este estilo de evaluación.");""))


  //PAGINA CONVERSION ENTRE ESCALAS
(OBJECT Get pointer:C1124(Object named:K67:5;"conversion_tabla"))->:=Choose:C955(iconversionTable=1;1;0)
(OBJECT Get pointer:C1124(Object named:K67:5;"conversion_matematica"))->:=Choose:C955(iconversionTable=0;1;0)
OBJECT SET ENABLED:C1123(*;"conversion_tabla";$y_usoEvaluaciones->=0)
OBJECT SET ENABLED:C1123(*;"conversion_matematica";$y_usoEvaluaciones->=0)
$b_tablaEditable:=(OBJECT Get enterable:C1067(*;"intervalosNotas") | OBJECT Get enterable:C1067(*;"intervalosPuntos"))
OBJECT SET ENTERABLE:C238(*;"bonificacion";(($y_usoEvaluaciones->=0) & ($b_tablaEditable)))


  // PAGINA ESFUERZOS
OBJECT SET ENTERABLE:C238(*;"esfuerzo_indicador";($y_usoEvaluaciones->=0))
OBJECT SET ENTERABLE:C238(*;"esfuerzo_descripcion";($y_usoEvaluaciones->=0))
OBJECT SET ENTERABLE:C238(*;"esfuerzo_factor";($y_usoEvaluaciones->=0))
OBJECT SET ENABLED:C1123(r1_EvEsfuerzoIndicadores;cb_EvaluaEsfuerzo=1)
OBJECT SET ENABLED:C1123(r2_EvEsfuerzoBonificacion;cb_EvaluaEsfuerzo=1)
OBJECT SET ENABLED:C1123(*;"menuContextual_esfuerzo";($y_usoEvaluaciones->=0))  //MONO TICKET 172479 

If (cb_EvaluaEsfuerzo=1)
	OBJECT GET COORDINATES:C663(*;"lbesfuerzo";$l_omitir;$l_arribaLB;$l_derechaLB;$l_omitir)
	LISTBOX GET CELL POSITION:C971(*;"lbesfuerzo";$l_columna;$l_fila)
	$l_columna:=3
	LISTBOX GET CELL COORDINATES:C1330(*;"lbesfuerzo";$l_columna;$l_fila;$l_izquierda;$l_arriba;$l_omitir;$l_abajo)
	$l_ancho:=IT_Objeto_Ancho ("menuContextual_esfuerzo")
	$l_alto:=IT_Objeto_Alto ("menuContextual_esfuerzo")
	OBJECT GET COORDINATES:C663(*;"menuContextual_esfuerzo";$l_izq;$l_arr;$l_der;$l_abajo)
	If ($l_fila=0)
		$l_arriba:=Int:C8($l_arribaLB+(LISTBOX Get rows height:C836(*;"lbesfuerzo";lk pixels:K53:22)/2))
	End if 
	OBJECT SET COORDINATES:C1248(*;"menuContextual_esfuerzo";$l_derechaLB+3;$l_arriba+6)
End if 


OBJECT SET VISIBLE:C603(*;"menuContextual_esfuerzo";cb_EvaluaEsfuerzo=1)

$l_fila:=LB_GetSelectedRows (OBJECT Get pointer:C1124(Object named:K67:5;"lbSimbolos"))
If ((LISTBOX Get number of rows:C915(*;"lbSimbolos")=0) | ($l_fila=-1))
	  //LISTBOX GET CELL POSITION(*;"lbSimbolos";$l_columna;$l_fila)
	OBJECT GET COORDINATES:C663(*;"lbSimbolos";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	$l_ancho:=IT_Objeto_Ancho ("menuContextual")
	$l_alto:=IT_Objeto_Alto ("menuContextual")
	OBJECT GET COORDINATES:C663(*;"menuContextual";$l_izq;$l_arr;$l_der;$l_abajo)
	OBJECT SET COORDINATES:C1248(*;"menuContextual";$l_derecha+3;$l_arriba)
	OBJECT SET VISIBLE:C603(*;"menuContextual";True:C214)
Else 
	  //LISTBOX GET CELL POSITION(*;"lbSimbolos";$l_columna;$l_fila)
	
	  //LISTBOX GET CELL COORDINATES(*;"lbSimbolos";5;$l_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
	LISTBOX GET CELL COORDINATES:C1330(*;"lbSimbolos";6;$l_fila;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)  //ASM 20180714 Ticket 211218
	$l_ancho:=IT_Objeto_Ancho ("menuContextual")
	$l_alto:=IT_Objeto_Alto ("menuContextual")
	OBJECT GET COORDINATES:C663(*;"menuContextual";$l_izq;$l_arr;$l_der;$l_abajo)
	OBJECT SET COORDINATES:C1248(*;"menuContextual";$l_derecha+3;$l_arriba+6)
	OBJECT SET VISIBLE:C603(*;"menuContextual";$l_fila>0)
End if 


  // determino si es posible calcular promedios en la escala alternativa con evaluaciones parciales convertidas a esa escala
$l_ConversionTable:=iConversionTable
iConversionTable:=0
If (Size of array:C274(arEVS_ConvGrades)>0)
	For ($i;1;Size of array:C274(arEVS_ConvGrades))
		Case of 
			: (iEvaluationMode=Notas)
				$r_realNota:=EV2_Nota_a_Real (arEVS_ConvGrades{$i})
				$r_puntos:=EV2_Real_a_Puntos ($r_realNota)
				If ($r_puntos#arEVS_ConvPoints{$i})
					$b_calculosEscalaAlternativa:=True:C214
					$i:=Size of array:C274(arEVS_ConvGrades)
				End if 
				
			: (iEvaluationMode=Puntos)
				$r_realPuntos:=EV2_Puntos_a_Real (arEVS_ConvPoints{$i})
				$r_nota:=EV2_Real_a_Nota ($r_realPuntos)
				If ($r_nota#arEVS_ConvGrades{$i})
					$b_calculosEscalaAlternativa:=True:C214
					$i:=Size of array:C274(arEVS_ConvGrades)
				End if 
		End case 
	End for 
End if 
iConversionTable:=$l_ConversionTable
$b_calculosEscalaAlternativa:=$b_calculosEscalaAlternativa | (AT_CountNulValues (->arEVS_ConvGradesOfficial)#Size of array:C274(arEVS_ConvGradesOfficial))
If ($b_calculosEscalaAlternativa)
	Case of 
		: ((iEvaluationMode=Puntos) & ((iPrintMode=Notas) | (iPrintActa=Notas)))
			OBJECT SET TITLE:C194(*;"calcularConEscala";__ ("Calcular promedio en notas con las calificaciones de la escala"))
		: ((iEvaluationMode=Notas) & ((iPrintMode=Puntos) | (iPrintActa=Puntos)))
			OBJECT SET TITLE:C194(*;"calcularConEscala";__ ("Calcular promedio en puntos con las calificaciones de la escala"))
	End case 
End if 
OBJECT SET ENABLED:C1123(*;"calcularConEscala";$b_calculosEscalaAlternativa)