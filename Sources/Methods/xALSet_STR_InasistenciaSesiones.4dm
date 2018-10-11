//%attributes = {}
  // xALSet_STR_InasistenciaSesiones()
  // Por: Alberto Bachler K.: 19-03-14, 15:11:33
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_columna;$l_Error)

ARRAY LONGINT:C221($al_horasEnHorario;0)
ARRAY TEXT:C222($at_horasAlias;0)  //MONO Ticket 144924

ALP_RemoveAllArrays (xALP_Subsectores)

  //specify arrays to display
  //$l_Error:=AL_SetArraysNam (xALP_Subsectores;1;1;"aiSTK_Hora")//MONO Ticket 144924
$l_Error:=AL_SetArraysNam (xALP_Subsectores;1;1;"atSTK_HoraAlias")  //MONO Ticket 144924
$l_Error:=AL_SetArraysNam (xALP_Subsectores;2;1;"atSTK_Subsectores")
  //$l_Error:=AL_SetArraysNam (xALP_Subsectores;3;1;"apSTK_isActive")
$l_Error:=AL_SetArraysNam (xALP_Subsectores;3;1;"alSTK_SesionID")
$l_Error:=AL_SetArraysNam (xALP_Subsectores;4;1;"alSTK_IDsubsector")
$l_Error:=AL_SetArraysNam (xALP_Subsectores;5;1;"aimpartida")
$l_Error:=AL_SetArraysNam (xALP_Subsectores;6;1;"ab_InasistenciaTomada")
$l_Error:=AL_SetArraysNam (xALP_Subsectores;7;1;"aiSTK_Hora")  //MONO Ticket 144924

  //column 1 settings
AL_SetHeaders (xALP_Subsectores;1;1;__ ("#"))
AL_SetWidths (xALP_Subsectores;1;1;20)
AL_SetFormat (xALP_Subsectores;1;"";0;0;0;0)  //MONO Ticket 144924 sin formato ahora
AL_SetHdrStyle (xALP_Subsectores;1;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Subsectores;1;"Tahoma";9;0)
AL_SetStyle (xALP_Subsectores;1;"Tahoma";9;1)
AL_SetForeColor (xALP_Subsectores;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Subsectores;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Subsectores;1;1)
AL_SetEntryCtls (xALP_Subsectores;1;0)

  //column 2 settings
AL_SetHeaders (xALP_Subsectores;2;1;__ ("Asignaturas"))
AL_SetWidths (xALP_Subsectores;2;1;160)
AL_SetFormat (xALP_Subsectores;2;"";0;0;0;0)
AL_SetHdrStyle (xALP_Subsectores;2;"Tahoma";9;1)
AL_SetFtrStyle (xALP_Subsectores;2;"Tahoma";9;0)
AL_SetStyle (xALP_Subsectores;2;"Tahoma";9;0)
AL_SetForeColor (xALP_Subsectores;2;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Subsectores;2;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Subsectores;2;1)
AL_SetEntryCtls (xALP_Subsectores;2;0)

  //general options
ALP_SetDefaultAppareance (xALP_Subsectores;11;3;4;1;4)
AL_SetColOpts (xALP_Subsectores;1;1;1;4;0)
AL_SetRowOpts (xALP_Subsectores;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Subsectores;0;1;1)
AL_SetMiscOpts (xALP_Subsectores;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Subsectores;"";"")
AL_SetScroll (xALP_Subsectores;0;-3)
AL_SetEntryOpts (xALP_Subsectores;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Subsectores;0;30;0)
AL_SetInterface (xALP_Subsectores;AL Force OSX Interface;1;1;0;0;1;0;0)

For ($i_horas;1;Size of array:C274(aiSTR_Horario_HoraNo))
	If (alSTR_Horario_RefTipoHora{$i_horas}=1)
		APPEND TO ARRAY:C911($al_horasEnHorario;aiSTR_Horario_HoraNo{$i_horas})
		APPEND TO ARRAY:C911($at_horasAlias;atSTR_Horario_HoraAlias{$i_horas})  //MONO Ticket 144924
	End if 
End for 

ALP_RemoveAllArrays (xALP_Inasistencias)
$l_Error:=AL_SetArraysNam (xALP_Inasistencias;1;1;"atSTK_StudentNames")
AL_SetHeaders (xALP_Inasistencias;1;1;__ ("Alumnos"))
AL_SetWidths (xALP_Inasistencias;1;1;220)
AL_SetFormat (xALP_Inasistencias;1;"";0;0;0;0)
AL_SetHdrStyle (xALP_Inasistencias;1;"Tahoma";11;0)
AL_SetFtrStyle (xALP_Inasistencias;1;"Tahoma";11;0)
AL_SetStyle (xALP_Inasistencias;1;"Tahoma";11;0)
AL_SetForeColor (xALP_Inasistencias;1;"Black";0;"Black";0;"Black";0)
AL_SetBackColor (xALP_Inasistencias;1;"White";0;"White";0;"White";0)
AL_SetEnterable (xALP_Inasistencias;1;1)
AL_SetEntryCtls (xALP_Inasistencias;1;0)

For ($i_horas;1;Size of array:C274($al_horasEnHorario))
	$l_columna:=$i_horas+1
	$l_Error:=AL_SetArraysNam (xALP_Inasistencias;$l_columna;1;"alSTK_Hora"+String:C10($i_horas))
	  //AL_SetHeaders (xALP_Inasistencias;$l_columna;1;__ ("H")+String($al_horasEnHorario{$i_horas}))//MONO Ticket 144924
	AL_SetHeaders (xALP_Inasistencias;$l_columna;1;__ ("H-")+$at_horasAlias{$i_horas})  //MONO Ticket 144924
	AL_SetWidths (xALP_Inasistencias;$l_columna;1;25)
	AL_SetFormat (xALP_Inasistencias;$l_columna;"";0;0;0;0)
	AL_SetHdrStyle (xALP_Inasistencias;$l_columna;"Tahoma";11;1)
	AL_SetStyle (xALP_Inasistencias;$l_columna;"Tahoma";11;0)
	AL_SetForeColor (xALP_Inasistencias;$l_columna;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_Inasistencias;$l_columna;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_Inasistencias;$l_columna;1)
	AL_SetEntryCtls (xALP_Inasistencias;$l_columna;0)
End for 
$l_Error:=AL_SetArraysNam (xALP_Inasistencias;$l_columna+1;1;"alSTK_StudentIDs")
$l_Error:=AL_SetArraysNam (xALP_Inasistencias;$l_columna+2;1;"adSTK_FechaIngreso")
$l_Error:=AL_SetArraysNam (xALP_Inasistencias;$l_columna+3;1;"adSTK_FechaRetiro")

ALP_SetDefaultAppareance (xALP_Inasistencias;11;1;6;1;4)
AL_SetColOpts (xALP_Inasistencias;1;1;1;3;0)
AL_SetRowOpts (xALP_Inasistencias;0;0;0;0;1;0)
AL_SetCellOpts (xALP_Inasistencias;2;1;1)
AL_SetMiscOpts (xALP_Inasistencias;0;0;"\\";0;1)
AL_SetMainCalls (xALP_Inasistencias;"";"")
AL_SetScroll (xALP_Inasistencias;0;0)
AL_SetEntryOpts (xALP_Inasistencias;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
AL_SetDrgOpts (xALP_Inasistencias;0;30;0)
AL_SetInterface (xALP_Inasistencias;AL Force OSX Interface;1;1;0;0;1;0;0)

