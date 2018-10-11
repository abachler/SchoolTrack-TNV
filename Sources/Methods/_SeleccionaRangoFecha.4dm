//%attributes = {}
  //_SeleccionaRangoFecha

vi_TipoInforme:=3
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño";0;Palette form window:K39:9;__ ("Selección del período de generación"))
DIALOG:C40([xxSTR_Constants:1];"ACT_SeleccionaDiaMesAño")
CLOSE WINDOW:C154