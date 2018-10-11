//%attributes = {}
  //xALSet_Log


C_LONGINT:C283($Error)

$error:=AL_SetFile (xALP_Log;Table:C252(->[xShell_Logs:37]))
$error:=AL_SetFields (xALP_Log;Table:C252(->[xShell_Logs:37]);1;1;Field:C253(->[xShell_Logs:37]Module:8))
$error:=AL_SetFields (xALP_Log;Table:C252(->[xShell_Logs:37]);2;1;Field:C253(->[xShell_Logs:37]Event_Date:3))
$error:=AL_SetFields (xALP_Log;Table:C252(->[xShell_Logs:37]);3;1;Field:C253(->[xShell_Logs:37]Event_Time:4))
$error:=AL_SetFields (xALP_Log;Table:C252(->[xShell_Logs:37]);4;1;Field:C253(->[xShell_Logs:37]Event_Description:5))
$error:=AL_SetFields (xALP_Log;Table:C252(->[xShell_Logs:37]);5;1;Field:C253(->[xShell_Logs:37]UserName:2))

  //column 1 settings
AL_SetHeaders (xALP_Log;1;1;__ ("Módulo"))
AL_SetFormat (xALP_Log;1;"";0;2;0;0)
AL_SetWidths (xALP_Log;1;1;150)
AL_SetHdrStyle (xALP_Log;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Log;1;"Tahoma";9;0)
AL_SetStyle (xALP_Log;1;"Tahoma";9;0)
AL_SetForeColor (xALP_Log;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Log;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Log;1;0)
AL_SetEntryCtls (xALP_Log;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Log;2;1;__ ("Fecha"))
AL_SetFormat (xALP_Log;2;"";0;2;0;0)
AL_SetWidths (xALP_Log;2;1;70)
AL_SetHdrStyle (xALP_Log;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Log;2;"Tahoma";9;0)
AL_SetStyle (xALP_Log;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Log;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Log;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Log;2;0)
AL_SetEntryCtls (xALP_Log;2;0)

  //column 3 settings
AL_SetHeaders (xALP_Log;3;1;__ ("Hora"))
AL_SetFormat (xALP_Log;3;"&/1";0;2;0;0)
AL_SetWidths (xALP_Log;3;1;70)
AL_SetHdrStyle (xALP_Log;3;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Log;3;"Tahoma";9;0)
AL_SetStyle (xALP_Log;3;"Tahoma";9;0)
AL_SetForeColor (xALP_Log;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Log;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Log;3;0)
AL_SetEntryCtls (xALP_Log;3;0)

  //column 4 settings
AL_SetHeaders (xALP_Log;4;1;__ ("Evento"))
AL_SetFormat (xALP_Log;4;"";0;2;0;0)
AL_SetWidths (xALP_Log;4;1;301)
AL_SetHdrStyle (xALP_Log;4;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Log;4;"Tahoma";9;0)
AL_SetStyle (xALP_Log;4;"Tahoma";9;0)
AL_SetForeColor (xALP_Log;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Log;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Log;4;0)
AL_SetEntryCtls (xALP_Log;4;0)

  //column 5 settings
AL_SetHeaders (xALP_Log;5;1;__ ("Usuario"))
AL_SetFormat (xALP_Log;5;"";0;2;0;0)
AL_SetWidths (xALP_Log;5;1;140)
AL_SetHdrStyle (xALP_Log;5;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Log;5;"Tahoma";9;0)
AL_SetStyle (xALP_Log;5;"Tahoma";9;0)
AL_SetForeColor (xALP_Log;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Log;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Log;5;0)
AL_SetEntryCtls (xALP_Log;5;0)

  //general options
ALP_SetDefaultAppareance (xALP_Log;9;4;6;1;8)
AL_SetColOpts (xALP_Log;1;1;1;0;0)
AL_SetRowOpts (xALP_Log;1;1;0;0;1;0)
AL_SetCellOpts (xALP_Log;0;1;1)
AL_SetMainCalls (xALP_Log;"";"")
AL_SetScroll (xALP_Log;0;-3)
AL_SetEntryOpts (xALP_Log;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Log;0;30;0)
AL_SetCalcCall (xALP_Log;4;"LOG_DevuelveTextoNormal")