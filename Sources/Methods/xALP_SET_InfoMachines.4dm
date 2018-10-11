//%attributes = {}
  //xALP_SET_InfoMachines

  //Configuration commands for ALP object 'xALP_InfoMachines'
  //You can paste this into an ALP object's method, rather than
  //use the Advanced Properties dialog to control the configuration.
  //Commands always have priority over the settings in the dialog.

C_LONGINT:C283($Error)

AL_RemoveFields (xALP_InfoMachines;1;9)

  //specify fields to display
$Error:=AL_SetFile (xALP_InfoMachines;Table:C252(->[xShell_InfoMachines:151]))  //[xShell_InfoMachines]
$Error:=AL_SetFields (xALP_InfoMachines;151;1;1;2)  //[xShell_InfoMachines]MachineName
$Error:=AL_SetFields (xALP_InfoMachines;151;2;1;1)  //[xShell_InfoMachines]MacAddress
$Error:=AL_SetFields (xALP_InfoMachines;151;3;1;5)  //[xShell_InfoMachines]version_4D
$Error:=AL_SetFields (xALP_InfoMachines;151;4;1;6)  //[xShell_InfoMachines]MachineType
$Error:=AL_SetFields (xALP_InfoMachines;151;5;1;10)  //[xShell_InfoMachines]Physical_RAM
$Error:=AL_SetFields (xALP_InfoMachines;151;6;1;7)  //[xShell_InfoMachines]OS
$Error:=AL_SetFields (xALP_InfoMachines;151;7;1;0)  //Calculated column (string)
$Error:=AL_SetFields (xALP_InfoMachines;151;8;1;9)  //[xShell_InfoMachines]ScreenResolution
$Error:=AL_SetFields (xALP_InfoMachines;151;9;1;4)  //[xShell_InfoMachines]LastInfo

  //column 1 settings
AL_SetHeaders (xALP_InfoMachines;1;1;__ ("Computador"))
AL_SetFormat (xALP_InfoMachines;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_InfoMachines;1;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;1;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;1;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;1;1)
AL_SetEntryCtls (xALP_InfoMachines;1;0)

  //column 2 settings
AL_SetHeaders (xALP_InfoMachines;2;1;__ ("ID Ethernet"))
AL_SetFormat (xALP_InfoMachines;2;"##.##.##.##.##.##";0;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;2;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;2;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;2;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;2;1)
AL_SetEntryCtls (xALP_InfoMachines;2;0)
AL_SetWidths (xALP_InfoMachines;2;1;100)

  //column 3 settings
AL_SetHeaders (xALP_InfoMachines;3;1;__ ("Versión (4D)"))
AL_SetFormat (xALP_InfoMachines;3;"";0;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;3;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;3;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;3;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;3;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;3;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;3;1)
AL_SetEntryCtls (xALP_InfoMachines;3;0)
AL_SetWidths (xALP_InfoMachines;3;1;80)

  //column 4 settings
AL_SetHeaders (xALP_InfoMachines;4;1;__ ("Tipo Computador"))
AL_SetFormat (xALP_InfoMachines;4;"";0;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;4;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;4;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;4;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;4;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;4;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;4;1)
AL_SetEntryCtls (xALP_InfoMachines;4;0)

  //column 5 settings
AL_SetHeaders (xALP_InfoMachines;5;1;__ ("RAM"))
AL_SetFormat (xALP_InfoMachines;5;"### ##0";0;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;5;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;5;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;5;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;5;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;5;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;5;1)
AL_SetEntryCtls (xALP_InfoMachines;5;0)
AL_SetWidths (xALP_InfoMachines;5;1;40)

  //column 6 settings
AL_SetHeaders (xALP_InfoMachines;6;1;__ ("Sistema Operativo"))
AL_SetFormat (xALP_InfoMachines;6;"";0;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;6;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;6;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;6;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;6;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;6;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;6;1)
AL_SetEntryCtls (xALP_InfoMachines;6;0)

  //column 7 settings
AL_SetCalcCall (xALP_InfoMachines;7;"xALP_CB_InfoMachines")
AL_SetHeaders (xALP_InfoMachines;7;1;__ ("HD (Gb)")+"\r"+__ ("Libre/Total"))
AL_SetFormat (xALP_InfoMachines;7;"";2;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;7;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;7;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;7;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;7;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;7;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;7;1)
AL_SetEntryCtls (xALP_InfoMachines;7;0)
AL_SetWidths (xALP_InfoMachines;7;1;60)

  //column 8 settings
AL_SetHeaders (xALP_InfoMachines;8;1;__ ("Resolución"))
AL_SetFormat (xALP_InfoMachines;8;"";0;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;8;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;8;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;8;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;8;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;8;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;8;1)
AL_SetEntryCtls (xALP_InfoMachines;8;0)

  //column 9 settings
AL_SetHeaders (xALP_InfoMachines;9;1;__ ("Fecha"))
AL_SetFormat (xALP_InfoMachines;9;"";0;2;0;0)
AL_SetHdrStyle (xALP_InfoMachines;9;"tahoma";9;1)
AL_SetFtrStyle (xALP_InfoMachines;9;"tahoma";9;0)
AL_SetStyle (xALP_InfoMachines;9;"tahoma";9;0)
AL_SetForeColor (xALP_InfoMachines;9;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_InfoMachines;9;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_InfoMachines;9;1)
AL_SetEntryCtls (xALP_InfoMachines;9;0)

  //general options

AL_SetColOpts (xALP_InfoMachines;1;1;1;0;0)
AL_SetColLock (xALP_InfoMachines;2)
AL_SetRowOpts (xALP_InfoMachines;0;0;0;0;1;0)
AL_SetCellOpts (xALP_InfoMachines;0;1;1)
AL_SetMiscOpts (xALP_InfoMachines;0;0;"\\";0;1)
AL_SetMiscColor (xALP_InfoMachines;0;"White";0)
AL_SetMiscColor (xALP_InfoMachines;1;"White";0)
AL_SetMiscColor (xALP_InfoMachines;2;"White";0)
AL_SetMiscColor (xALP_InfoMachines;3;"White";0)
AL_SetMainCalls (xALP_InfoMachines;"";"")
AL_SetScroll (xALP_InfoMachines;0;0)
AL_SetCopyOpts (xALP_InfoMachines;0;"\t";"\r";Char:C90(0))
AL_SetSortOpts (xALP_InfoMachines;0;1;0;"Select the columns to sort:";0)
AL_SetEntryOpts (xALP_InfoMachines;1;0;0;0;0;".")
AL_SetHeight (xALP_InfoMachines;1;2;1;1;2)
AL_SetDividers (xALP_InfoMachines;"No line";"Black";0;"No line";"Black";0)
AL_SetDrgOpts (xALP_InfoMachines;0;30;0)

  //dragging options

AL_SetDrgSrc (xALP_InfoMachines;1;"";"";"")
AL_SetDrgSrc (xALP_InfoMachines;2;"";"";"")
AL_SetDrgSrc (xALP_InfoMachines;3;"";"";"")
AL_SetDrgDst (xALP_InfoMachines;1;"";"";"")
AL_SetDrgDst (xALP_InfoMachines;1;"";"";"")
AL_SetDrgDst (xALP_InfoMachines;1;"";"";"")

ALP_SetDefaultAppareance (xALP_InfoMachines)

AL_SetLine (xALP_InfoMachines;0)

