//%attributes = {}
  // MPAcfg_Area_Lista()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 14/07/12, 18:15:30
  // ---------------------------------------------





  // CÓDIGO
AL_UpdateArrays (xALP_AreasMPA;0)
ARRAY TEXT:C222(atEVLG_MarcosCurriculares;0)
READ ONLY:C145([MPA_DefinicionAreas:186])
QUERY:C277([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]ID:1#0)

If (Records in selection:C76([MPA_DefinicionAreas:186])>0)
	SELECTION TO ARRAY:C260([MPA_DefinicionAreas:186];alEVLG_Marcos_RecNums;[MPA_DefinicionAreas:186]AreaAsignatura:4;atEVLG_Marcos_Nombres)
	SORT ARRAY:C229(atEVLG_Marcos_Nombres;alEVLG_Marcos_RecNums;>)
	AL_UpdateArrays (xALP_AreasMPA;-2)
	OBJECT SET VISIBLE:C603(*;"taskwheel@";True:C214)
Else 
	ALP_RemoveAllArrays (xALP_Competencias)
	AL_UpdateArrays (xALP_Ejes;0)
	AL_UpdateArrays (xALP_Dimensiones;0)
	AL_SetScroll (xALP_Competencias;0;0)
	AT_Initialize (->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta;->aiEVLG_EtapasMPA)
	AT_Initialize (->alEVLG_Ejes_RecNums;->alEVLG_Ejes_IDs;->atEVLG_Ejes_Nombres;->atEVLG_Ejes_Etapas)
	AT_Initialize (->alEVLG_Dimensiones_RecNums;->atEVLG_Dimensiones_Nombres;->atEVLG_Dimensiones_Etapas)
	vlMPA_recNumArea:=-1
	vlMPA_recNumEje:=-1
	vlEVLG_IDEje:=0
	vlMPA_TipoEvaluacionEje:=0
	vlMPA_EstiloEvaluacionEje:=0
	vlMPA_recNumDimension:=-1
	vlEVLG_IDDimension:=0
	vlEVLG_IDCompetencia:=0
	vlMPA_recNumCompetencia:=-1
	vlMPA_TipoEvaluacionDimension:=0
	vlMPA_EstiloEvaluacionDimension:=0
	vlMPA_TipoEvaluacionComp:=0
	vlMPA_EstiloEvaluacionComp:=0
	vtEVLG_labelCompetencias:=""
	vt_Competencia:=""
	vl_competenciasEvaluados:=0
	vl_competenciasEnMatrices:=0
	vt_Eje:=""
	vl_ejeEvaluados:=0
	vl_ejeEvaluados_asociados:=0
	vl_ejeEnMatrices:=0
	vl_ejeEnMatrices_asociados:=0
	vt_Dimension:=""
	vl_dimEvaluados:=0
	vl_dimEvaluados_Asociados:=0
	vl_dimEnMatrices:=0
	vl_dimEnMatrices_Asociados:=0
	OBJECT SET TITLE:C194(bArea;"")
	OBJECT SET TITLE:C194(bCompetencia;"")
	OBJECT SET TITLE:C194(*;"P01_AreaEje@";"")
	OBJECT SET TITLE:C194(*;"P01_AreaDim@";"")
	OBJECT SET TITLE:C194(*;"bInfo@";"")
	IT_SetButtonState (False:C215;->bDeleteArea;->bAddCompetencia;->bAddEje;->bAddCompetencia)
	IT_SetButtonState (False:C215;->bDeleteEje;->bAddDimension)
	IT_SetButtonState (False:C215;->bDeleteDimension)
	IT_SetButtonState (False:C215;->bDeleteCompetencia)
	OBJECT SET VISIBLE:C603(*;"taskwheel@";False:C215)
End if 