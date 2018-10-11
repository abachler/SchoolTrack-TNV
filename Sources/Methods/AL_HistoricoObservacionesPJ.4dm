//%attributes = {}
  // Método: AL_HistoricoObservacionesPJ
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 02/11/09, 09:38:22
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
$key:=String:C10(<>gInstitucion)+"."+String:C10(vl_Year_Historico)+"."+String:C10(vl_NivelSeleccionado_Historico)+"."+String:C10([Alumnos_Historico:25]Alumno_Numero:1)
$recNUm:=Record number:C243([Alumnos_SintesisAnual:210])
asigHist:="Observaciones Finales Profesor Jefe"
vtSTR_AL_Observaciones:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
vtSTR_AL_LabelObservaciones:="Comentario final del profesor jefe:"
  //0000_TestsRCB
PERIODOS_LeeDatosHistoricos (vl_NivelSeleccionado_Historico;vl_Year_Historico)
SORT ARRAY:C229(aiSTR_Periodos_Numero;atSTR_Periodos_Nombre;<)

ARRAY TEXT:C222(aObsPJTerm;0)
ARRAY TEXT:C222(aPJobs;0)
APPEND TO ARRAY:C911(aObsPJTerm;"Finales")
ARRAY TEXT:C222(aPJobs;Size of array:C274(aObsPJTerm))
For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	APPEND TO ARRAY:C911(aObsPJTerm;atSTR_Periodos_Nombre{$i})
End for 
ARRAY TEXT:C222(aPJobs;Size of array:C274(aObsPJTerm))



If ($recNum>=0)
	Case of 
		: (Size of array:C274(aPJObs)=3)
			aPJObs{1}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
			aPJObs{2}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
			aPJObs{3}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
		: (Size of array:C274(aPJObs)=4)
			aPJObs{1}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
			aPJObs{2}:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
			aPJObs{3}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
			aPJObs{4}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
		: (Size of array:C274(aPJObs)=5)
			aPJObs{1}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
			aPJObs{2}:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
			aPJObs{3}:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
			aPJObs{4}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
			aPJObs{5}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
		: (Size of array:C274(aPJObs)=6)
			aPJObs{1}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
			aPJObs{2}:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
			aPJObs{3}:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
			aPJObs{4}:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
			aPJObs{5}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
			aPJObs{6}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
	End case 
	
	C_LONGINT:C283($Error)
	
	  //specify arrays to display
	$Error:=AL_SetArraysNam (xALP_HNotasECursos;1;1;"aObsPJTerm")
	$Error:=AL_SetArraysNam (xALP_HNotasECursos;2;1;"aPJObs")
	
	  //column 1 settings
	AL_SetHeaders (xALP_HNotasECursos;1;1;__ ("Período"))
	AL_SetWidths (xALP_HNotasECursos;1;1;100)
	AL_SetFormat (xALP_HNotasECursos;1;"";0;0;0;0)
	AL_SetHdrStyle (xALP_HNotasECursos;1;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_HNotasECursos;1;"Tahoma";9;0)
	AL_SetStyle (xALP_HNotasECursos;1;"Tahoma";9;0)
	AL_SetForeColor (xALP_HNotasECursos;1;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_HNotasECursos;1;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_HNotasECursos;1;0)
	AL_SetEntryCtls (xALP_HNotasECursos;1;0)
	
	  //column 2 settings
	AL_SetHeaders (xALP_HNotasECursos;2;1;__ ("Observaciones"))
	AL_SetWidths (xALP_HNotasECursos;2;1;476)
	AL_SetFormat (xALP_HNotasECursos;2;"";0;0;0;0)
	AL_SetHdrStyle (xALP_HNotasECursos;2;"Tahoma";9;1)
	AL_SetFtrStyle (xALP_HNotasECursos;2;"Tahoma";9;0)
	AL_SetStyle (xALP_HNotasECursos;2;"Tahoma";9;0)
	AL_SetForeColor (xALP_HNotasECursos;2;"Black";0;"Black";0;"Black";0)
	AL_SetBackColor (xALP_HNotasECursos;2;"White";0;"White";0;"White";0)
	AL_SetEnterable (xALP_HNotasECursos;2;Num:C11(vb_HistoricoEditable))
	AL_SetEntryCtls (xALP_HNotasECursos;2;0)
	
	  //general options
	
	AL_SetColOpts (xALP_HNotasECursos;1;1;1;0;0)
	AL_SetRowOpts (xALP_HNotasECursos;0;1;0;0;1;0)
	AL_SetCellOpts (xALP_HNotasECursos;0;1;1)
	AL_SetMiscOpts (xALP_HNotasECursos;0;0;"\\";0;1)
	AL_SetCallbacks (xALP_HNotasECursos;"";"xALCB_EX_HObs_ProfesorJefe")
	AL_SetMiscColor (xALP_HNotasECursos;0;"White";0)
	AL_SetMiscColor (xALP_HNotasECursos;1;"White";0)
	AL_SetMiscColor (xALP_HNotasECursos;2;"White";0)
	AL_SetMiscColor (xALP_HNotasECursos;3;"White";0)
	AL_SetMainCalls (xALP_HNotasECursos;"";"")
	AL_SetScroll (xALP_HNotasECursos;0;-3)
	AL_SetCopyOpts (xALP_HNotasECursos;0;"\t";"\r";Char:C90(0))
	AL_SetSortOpts (xALP_HNotasECursos;0;1;0;"Select the columns to sort:";0)
	AL_SetEntryOpts (xALP_HNotasECursos;3;1;0;0;0;<>tXS_RS_DecimalSeparator)
	AL_SetHeight (xALP_HNotasECursos;1;2;4;3;2)
	AL_SetDividers (xALP_HNotasECursos;"Black";"Light Gray";0;"Black";"Light Gray";0)
	AL_SetDrgOpts (xALP_HNotasECursos;0;30;0)
	AL_SetColLock (xALP_HNotasECursos;1)
	
	  //dragging options
	
	AL_SetDrgSrc (xALP_HNotasECursos;1;"";"";"")
	AL_SetDrgSrc (xALP_HNotasECursos;2;"";"";"")
	AL_SetDrgSrc (xALP_HNotasECursos;3;"";"";"")
	AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
	AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
	AL_SetDrgDst (xALP_HNotasECursos;1;"";"";"")
	
	  //ALP_SetDefaultAppareance (xALP_HNotasECursos;9;11)//MONO Ticket 186325 
	AL_UpdateArrays (xALP_HNotasECursos;-2)
	AL_SetLine (xALP_HNotasECursos;0)
End if 


