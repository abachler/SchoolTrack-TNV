//%attributes = {}
  // MPAcfg_Comp_Agregar()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/07/12, 11:06:59
  // ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($l_recNumCompetencia;$l_tipoContenedor)
C_TEXT:C284($t_textoEventoLog)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Comp_Agregar ;$1)
End if 



  // CÓDIGO
$l_tipoContenedor:=$1
Case of 
	: ($l_tipoContenedor=0)  // area. La competencia se crea en el área
		KRL_GotoRecord (->[MPA_DefinicionAreas:186];vlMPA_recNumArea;False:C215)
		vlEVLG_IDEje:=[MPA_DefinicionEjes:185]ID:1
		vlEVLG_IDDimension:=0
		$t_textoEventoLog:="Creación de Competencia en Mapas de Aprendizaje: Area "+[MPA_DefinicionAreas:186]AreaAsignatura:4+", Competencia: "+[MPA_DefinicionCompetencias:187]Competencia:6
		
	: ($l_tipoContenedor=Eje_Aprendizaje)  // eje. La competencia se crea asociada al eje seleccionado
		KRL_GotoRecord (->[MPA_DefinicionEjes:185];vlMPA_recNumEje;False:C215)
		KRL_GotoRecord (->[MPA_DefinicionAreas:186];vlMPA_recNumArea;False:C215)
		vlEVLG_IDEje:=[MPA_DefinicionEjes:185]ID:1
		vlEVLG_IDDimension:=0
		$t_textoEventoLog:="Creación de Competencia en Mapas de Aprendizaje: Area "+[MPA_DefinicionAreas:186]AreaAsignatura:4+", Eje: "+[MPA_DefinicionEjes:185]Nombre:3+", Competencia: "+[MPA_DefinicionCompetencias:187]Competencia:6
		
	: ($l_tipoContenedor=Dimension_Aprendizaje)  // dimension. La competencia se crea asociada a la dimensión seleccionada
		KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];vlMPA_recNumDimension;False:C215)
		KRL_GotoRecord (->[MPA_DefinicionEjes:185];vlMPA_recNumEje;False:C215)
		KRL_GotoRecord (->[MPA_DefinicionAreas:186];vlMPA_recNumArea;False:C215)
		vlEVLG_IDEje:=[MPA_DefinicionEjes:185]ID:1
		vlEVLG_IDDimension:=[MPA_DefinicionDimensiones:188]ID:1
		$t_textoEventoLog:="Creación de Competencia en Mapas de Aprendizaje: Area "+[MPA_DefinicionAreas:186]AreaAsignatura:4+", Eje: "+[MPA_DefinicionEjes:185]Nombre:3+", Dimensión: "+[MPA_DefinicionDimensiones:188]Dimensión:4+", Competencia: "+[MPA_DefinicionCompetencias:187]Competencia:6
		
End case 

$l_recNumCompetencia:=-1
WDW_OpenFormWindow (->[MPA_DefinicionCompetencias:187];"Propiedades";-1;8)
FORM SET INPUT:C55([MPA_DefinicionCompetencias:187];"Propiedades")
ADD RECORD:C56([MPA_DefinicionCompetencias:187];*)
If (OK=1)
	$l_recNumCompetencia:=Record number:C243([MPA_DefinicionCompetencias:187])
	LOG_RegisterEvt ($t_textoEventoLog)
	If (cb_AutoActualizaMatricesMPA=1)
		MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;$l_recNumCompetencia)
	End if 
	Case of 
		: ($l_tipoContenedor=0)
			MPAcfg_ContenidoAreas (vlMPA_recNumArea;-1;-1;$l_recNumCompetencia)
		: ($l_tipoContenedor=Eje_Aprendizaje)
			MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;-1;$l_recNumCompetencia)
		: ($l_tipoContenedor=Dimension_Aprendizaje)
			MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;vlMPA_recNumDimension;$l_recNumCompetencia)
	End case 
	KRL_UnloadReadOnly (->[MPA_DefinicionCompetencias:187])
End if 

$0:=$l_recNumCompetencia