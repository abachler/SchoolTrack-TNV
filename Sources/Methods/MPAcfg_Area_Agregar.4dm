//%attributes = {}
  // MPAcfg_Area_Agregar
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/12, 16:08:18
  // ---------------------------------------------





  // CÓDIGO
WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"Input";-1;8)
FORM SET INPUT:C55([MPA_DefinicionAreas:186];"Input")
ADD RECORD:C56([MPA_DefinicionAreas:186];*)
If (OK=1)
	LOG_RegisterEvt ("Creación de Area en Mapas de Aprendizaje: "+[MPA_DefinicionAreas:186]AreaAsignatura:4)
	$l_recNumArea:=Record number:C243([MPA_DefinicionAreas:186])
	MPAcfg_Area_Lista 
	MPAcfg_ContenidoAreas ($l_recNumArea)
End if 
