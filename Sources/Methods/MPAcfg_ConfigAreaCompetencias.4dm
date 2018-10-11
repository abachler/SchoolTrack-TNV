//%attributes = {}
  // MPAcfg_ConfigAreaCompetencias()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/07/12, 10:38:25
  // ---------------------------------------------
C_LONGINT:C283($l_columnas;$err;$i_etapas;$l_numeroEtapas;$l_numeroNivel;$l_recordNumber;$l_filas)
C_TEXT:C284($t_arrayName;$t_nivelInicio;$grados;$t_nivelTermino)

ARRAY INTEGER:C220($ai_Array2D;0)

  // CÓDIGO
$l_numeroEtapas:=Size of array:C274(atMPA_EtapasArea)
AL_RemoveArrays (xALP_Competencias;1;100)
For ($i_etapas;1;$l_numeroEtapas)
	$l_numeroNivel:=alMPA_NivelDesde{$i_etapas}
	$l_recordNumber:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;$l_numeroNivel)
	GOTO RECORD:C242([xxSTR_Niveles:6];$l_recordNumber)
	$t_nivelInicio:=[xxSTR_Niveles:6]Nivel:1
	$l_numeroNivel:=alMPA_NivelHasta{$i_etapas}
	$l_recordNumber:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;$l_numeroNivel)
	GOTO RECORD:C242([xxSTR_Niveles:6];$l_recordNumber)
	$t_nivelTermino:=[xxSTR_Niveles:6]Nivel:1
	If ($t_nivelInicio#$t_nivelTermino)
		$grados:=":  "+$t_nivelInicio+" a "+$t_nivelTermino+""
	Else 
		$grados:=":  "+$t_nivelInicio+""
	End if 
	$t_arrayName:="atEVLG_Competencias_E"+String:C10($i_etapas)
	$err:=AL_SetArraysNam (xALP_Competencias;$i_etapas;1;$t_arrayName)
	AL_SetHeaders (xALP_Competencias;$i_etapas;1;atMPA_EtapasArea{$i_etapas}+$grados)
	AL_SetWidths (xALP_Competencias;$i_etapas;1;160)
End for 
vi_LineasPorFila:=4
vi_LinePad:=8
ALP_SetDefaultAppareance (xALP_Competencias;9;vi_LineasPorFila;vi_LinePad;1)
AL_SetHdrStyle (xALP_Competencias;0;"Tahoma";11;0)
AL_SetSortOpts (xALP_Competencias;0;0;0;"";0;0)
AL_SetRowOpts (xALP_Competencias;0;1;0;0;1;1)
AL_SetColOpts (xALP_Competencias;1;0;0;0;0;0;0)
AL_SetCellOpts (xALP_Competencias;1;1;1)
AL_SetMiscOpts (xALP_Competencias;0;0;"\\";0;1)
AL_SetCellSel (xALP_Competencias;0;0;0;0)
AL_SetAltRowColor (xALP_Competencias;255;255;255;1)
AL_SetDrgSrc (xALP_Competencias;3;String:C10(xALP_Ejes);String:C10(xALP_Dimensiones);String:C10(xALP_Competencias);String:C10(xALP_AreasMPA))
AL_SetDrgDst (xALP_Competencias;3;String:C10(xALP_Competencias))
AL_SetInterface (xALP_Competencias;AL Default Interface;0;1;0;0;1;0;0)
AL_SetHeight (xALP_Competencias;2;4;vi_LineasPorFila;vi_LinePad)
AL_SetDividers (xALP_Competencias;"";"";0;"";"";0)
AL_UpdateArrays (xALP_Competencias;-2)

For ($l_columnas;1;$l_numeroEtapas)
	AL_SetBackColor (xALP_Competencias;$l_columnas;"";0;"white")
	For ($l_filas;1;Size of array:C274(atEVLG_Competencias_E1))
		If (alEVLG_Competencias_ColorsTexto{$l_filas}{$l_columnas}=0)
			AL_SetCellColor (xALP_Competencias;$l_columnas;$l_filas;$l_columnas;$l_filas;$ai_Array2D;"";16;"";1)
		Else 
			AL_SetCellColor (xALP_Competencias;$l_columnas;$l_filas;$l_columnas;$l_filas;$ai_Array2D;"";alEVLG_Competencias_ColorsTexto{$l_filas}{$l_columnas};"";alEVLG_Competencias_ColorsFondo{$l_filas}{$l_columnas})
		End if 
		KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];alEVLG_Competencias_RecNums{$l_filas}{$l_columnas};False:C215)
		If (([MPA_DefinicionCompetencias:187]ID_Dimension:23=0) & ([MPA_DefinicionCompetencias:187]ID_Eje:2=0))
			AL_SetCellStyle (xALP_Competencias;$l_columnas;$l_filas;$l_columnas;$l_filas;$ai_Array2D;2)
		Else 
			AL_SetCellStyle (xALP_Competencias;$l_columnas;$l_filas;$l_columnas;$l_filas;$ai_Array2D;0)
		End if 
		
		If ([MPA_DefinicionCompetencias:187]DesdeGrado:5=999) & ([MPA_DefinicionCompetencias:187]HastaGrado:13=999)
			AL_SetCellIcon (xALP_Competencias;$l_columnas;$l_filas;Use PicRef:K28:4+31989;0;0;2;5;0)
		Else 
			AL_SetCellIcon (xALP_Competencias;$l_columnas;$l_filas;0)
		End if 
		
	End for 
End for 

MPAcfg_Comp_DistribuyeColumnas 

