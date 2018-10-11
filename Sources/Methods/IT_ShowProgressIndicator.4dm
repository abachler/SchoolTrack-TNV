//%attributes = {}
  // MÉTODO: IT_ShowProgressIndicator
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/12/11, 09:10:36
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // IT_ShowProgressIndicator()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284(vt_ProgressMessage1;vt_ProgressMessage2;vt_ProgressMessage3)
C_REAL:C285(vr_Progress1;vr_Progress2;vr_Progress3)
C_BOOLEAN:C305(vb_ShowProgress)
C_TIME:C306(vstartTime;vElapsed;vRemain)
C_TEXT:C284(<>vtXS_AppName)

$l_windowsPosition:=3

vb_ShowProgress:=True:C214

  // CODIGO PRINCIPAL
vr_Progress1:=$1
vt_ProgressMessage1:=$2
vr_Progress2:=$3
vt_ProgressMessage2:=$4
vr_Progress3:=$5
vt_ProgressMessage3:=$6

Case of 
	: (vt_ProgressMessage3#"")
		vl_IndicatorsToDisplay:=3
		$l_WindowHeight:=225
	: (vt_ProgressMessage2#"")
		vl_IndicatorsToDisplay:=2
		$l_WindowHeight:=155
	Else 
		vl_IndicatorsToDisplay:=1
		$l_WindowHeight:=85
End case 

vl_ProgressIndicators:=vl_IndicatorsToDisplay

vRemain:=?00:00:00?
vStartTime:=Current time:C178
vElapsed:=?00:00:00?

  //Open window(Palette form window;542;$l_WindowHeight;
C_POINTER:C301($y_Nil)
vl_ProgressWinRef:=WDW_OpenFormWindow ($y_Nil;"IT_ProgressIndicator";$l_windowsPosition;Palette window:K34:3;<>vtXS_AppName;"wdw_Close")
BRING TO FRONT:C326(Current process:C322)
WDW_SetFrontmost (vl_ProgressWinRef)
DIALOG:C40("IT_ProgressIndicator")
CLOSE WINDOW:C154(vl_ProgressWinRef)

