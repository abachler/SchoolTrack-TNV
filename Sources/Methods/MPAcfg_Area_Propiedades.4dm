//%attributes = {}
  // MPAcfg_Area_Propiedades()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 14/07/12, 17:25:30
  // ---------------------------------------------





  // CÓDIGO
$l_recNumArea:=$1
GOTO RECORD:C242([MPA_DefinicionAreas:186];$l_recNumArea)
WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"Input";-1;8)
KRL_ModifyRecord (->[MPA_DefinicionAreas:186];"Input")
CLOSE WINDOW:C154
