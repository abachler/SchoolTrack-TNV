//%attributes = {}
  // MPAcfg_Eje_Agregar()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 09/07/12, 11:24:47
  // ---------------------------------------------





  // CÓDIGO
$l_recNumEje:=-1
KRL_GotoRecord (->[MPA_DefinicionAreas:186];vlMPA_recNumArea;False:C215)
WDW_OpenFormWindow (->[MPA_DefinicionEjes:185];"Propiedades";-1;8;__ ("Ejes de Aprendizaje"))
FORM SET INPUT:C55([MPA_DefinicionEjes:185];"Propiedades")
ADD RECORD:C56([MPA_DefinicionEjes:185];*)
CLOSE WINDOW:C154

If (OK=1)
	$l_recNumEje:=Record number:C243([MPA_DefinicionEjes:185])
	KRL_ReloadAsReadOnly (->[MPA_DefinicionEjes:185])
	LOG_RegisterEvt ("Creación de Eje en Mapas de Aprendizaje: Area "+[MPA_DefinicionAreas:186]AreaAsignatura:4+" Eje: "+[MPA_DefinicionEjes:185]Nombre:3)
	If (cb_AutoActualizaMatricesMPA=1)
		MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Eje_Aprendizaje;[MPA_DefinicionEjes:185]DesdeGrado:4;[MPA_DefinicionEjes:185]HastaGrado:5;$l_recNumEje)
	End if 
	MPAcfg_ContenidoAreas (-1;$l_recNumEje)
End if 

$0:=$l_recNumEje