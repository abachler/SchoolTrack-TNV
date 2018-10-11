//%attributes = {}
  //EVLG_Init

_O_C_STRING:C293(5;vsEVLG_Simbolo_True;vsEVLG_Simbolo_False)
C_TEXT:C284(vsEVLG_DescSimbolo_True;vsEVLG_DescSimbolo_False)
C_LONGINT:C283(hl_Comunes;hl_Electivas;hl_Areas;hl_Niveles;hl_Ejes;hl_periodos;hl_Asignaturas)
C_LONGINT:C283(vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;vlMPA_recNumCompetencia)
C_BOOLEAN:C305(vb_SoloEnunciadosNoAsociados)

REDUCE SELECTION:C351([MPA_DefinicionAreas:186];0)
REDUCE SELECTION:C351([MPA_DefinicionEjes:185];0)
REDUCE SELECTION:C351([MPA_DefinicionDimensiones:188];0)
REDUCE SELECTION:C351([MPA_DefinicionCompetencias:187];0)
vb_SoloEnunciadosNoAsociados:=False:C215
vlMPA_recNumArea:=-1
vlMPA_recNumEje:=-1
vlMPA_recNumDimension:=-1
vlMPA_recNumCompetencia:=-1
vlEVLG_IDEje:=0
vlEVLG_IDArea:=0
vlMPA_TipoEvaluacionComp:=0
vlMPA_EstiloEvaluacionComp:=0
vlMPA_TipoEvaluacionEje:=0
vlMPA_EstiloEvaluacionEje:=0
vlMPA_TipoEvaluacionDimension:=0
vlMPA_EstiloEvaluacionDimension:=0

  //arreglos para mapas de aprendizaje (areas)
ARRAY LONGINT:C221(alEVLG_Marcos_RecNums;0)
ARRAY TEXT:C222(atEVLG_Marcos_Nombres;0)

  //arreglos para las etapas  por áreas
ARRAY INTEGER:C220(aiEVLG_EtapasMPA;0)
ARRAY TEXT:C222(atMPA_EtapasArea;0)
ARRAY LONGINT:C221(alMPA_NivelDesde;0)
ARRAY LONGINT:C221(alMPA_NivelHasta;0)

  //arreglos para ejes de aprendizaje (utilizado en area xALP_Ejes)
ARRAY LONGINT:C221(alEVLG_Ejes_RecNums;0)
ARRAY LONGINT:C221(alEVLG_Ejes_IDs;0)
ARRAY TEXT:C222(atEVLG_Ejes_Nombres;0)
ARRAY TEXT:C222(atEVLG_Ejes_Etapas;0)

  //arreglos para dimensiones de aprendizaje (AreaList xALP_Dimensiones)
ARRAY LONGINT:C221(alEVLG_Dimensiones_RecNums;0)
ARRAY TEXT:C222(atEVLG_Dimensiones_Nombres;0)
ARRAY TEXT:C222(atEVLG_Dimensiones_Etapas;0)

  //arreglos para competencias o logros (uno por por etapa)
ARRAY LONGINT:C221(alEVLG_Competencias_RecNums;0;0)
ARRAY TEXT:C222(atEVLG_Competencias_E1;0)
ARRAY TEXT:C222(atEVLG_Competencias_E2;0)
ARRAY TEXT:C222(atEVLG_Competencias_E3;0)
ARRAY TEXT:C222(atEVLG_Competencias_E4;0)
ARRAY TEXT:C222(atEVLG_Competencias_E5;0)
ARRAY TEXT:C222(atEVLG_Competencias_E6;0)
ARRAY TEXT:C222(atEVLG_Competencias_E7;0)
ARRAY TEXT:C222(atEVLG_Competencias_E8;0)
ARRAY TEXT:C222(atEVLG_Competencias_E9;0)
ARRAY TEXT:C222(atEVLG_Competencias_E10;0)
ARRAY TEXT:C222(atEVLG_Competencias_E11;0)
ARRAY TEXT:C222(atEVLG_Competencias_E12;0)
ARRAY TEXT:C222(atEVLG_Competencias_E13;0)
ARRAY TEXT:C222(atEVLG_Competencias_E14;0)
ARRAY TEXT:C222(atEVLG_Competencias_E15;0)
ARRAY TEXT:C222(atEVLG_Competencias_E16;0)
ARRAY TEXT:C222(atEVLG_Competencias_E17;0)
ARRAY TEXT:C222(atEVLG_Competencias_E18;0)
ARRAY TEXT:C222(atEVLG_Competencias_E19;0)
ARRAY TEXT:C222(atEVLG_Competencias_E20;0)
ARRAY TEXT:C222(atEVLG_Competencias_E21;0)
ARRAY TEXT:C222(atEVLG_Competencias_E22;0)
ARRAY TEXT:C222(atEVLG_Competencias_E23;0)
ARRAY TEXT:C222(atEVLG_Competencias_E24;0)

  //arreglos para indicadores de logros (utilizado en formulario de creación/modificación de logros
ARRAY INTEGER:C220(aiEVLG_Indicadores_Valor;0)
ARRAY TEXT:C222(atEVLG_Indicadores_Descripcion;0)
_O_ARRAY STRING:C218(5;atEVLG_Indicadores_Concepto;0)