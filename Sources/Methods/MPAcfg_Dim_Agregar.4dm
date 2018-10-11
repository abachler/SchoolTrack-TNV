//%attributes = {}
  // MPAcfg_Dim_Agregar <-recNumDimension
  // Muestra el formulario Propiedades de Dimensión para añadir una nueva dimensión al eje seleccionado
  // - recNumDimension: Longint: record number del registro de definición de Dimensión de aprendizaje añadido
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 22/07/12, 11:34:13
  // ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_recNumDimension)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Dim_Agregar ;$0)
End if 



  // CÓDIGO
$l_recNumDimension:=-1

If ((vlMPA_recNumArea>=0) & (vlMPA_recNumEje>=0))
	KRL_GotoRecord (->[MPA_DefinicionAreas:186];vlMPA_recNumArea;False:C215)
	KRL_GotoRecord (->[MPA_DefinicionEjes:185];vlMPA_recNumEje;False:C215)
	WDW_OpenFormWindow (->[MPA_DefinicionDimensiones:188];"Propiedades";-1;8)
	FORM SET INPUT:C55([MPA_DefinicionDimensiones:188];"Propiedades")
	ADD RECORD:C56([MPA_DefinicionDimensiones:188];*)
	CLOSE WINDOW:C154
	
	If (OK=1)
		$l_recNumDimension:=Record number:C243([MPA_DefinicionDimensiones:188])
		KRL_ReloadAsReadOnly (->[MPA_DefinicionDimensiones:188])
		LOG_RegisterEvt ("Creación de Dimensión en Mapas de Aprendizaje: Area "+[MPA_DefinicionAreas:186]AreaAsignatura:4+", Eje: "+[MPA_DefinicionEjes:185]Nombre:3+", Dimensión: "+[MPA_DefinicionDimensiones:188]Dimensión:4)
		If (cb_AutoActualizaMatricesMPA=1)
			MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Dimension_Aprendizaje;[MPA_DefinicionDimensiones:188]DesdeGrado:6;[MPA_DefinicionDimensiones:188]HastaGrado:7;$l_recNumDimension)
		End if 
		MPAcfg_ContenidoAreas (vlMPA_recNumArea;vlMPA_recNumEje;$l_recNumDimension)
	End if 
End if 

$0:=$l_recNumDimension

