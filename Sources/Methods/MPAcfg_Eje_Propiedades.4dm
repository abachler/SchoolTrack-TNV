//%attributes = {}
  // MPAcfg_Eje_Propiedades()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 07/07/12, 12:25:54
  // ---------------------------------------------





  // CÓDIGO
$l_filaEjes:=AL_GetLine (xALP_Ejes)
READ WRITE:C146([MPA_DefinicionEjes:185])
KRL_GotoRecord (->[MPA_DefinicionEjes:185];alEVLG_Ejes_RecNums{$l_filaEjes};True:C214)

WDW_OpenFormWindow (->[MPA_DefinicionEjes:185];"Propiedades";-1;8)
KRL_ModifyRecord (->[MPA_DefinicionEjes:185];"Propiedades")
MPAcfg_ContenidoAreas 