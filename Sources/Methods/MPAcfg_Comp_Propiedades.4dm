//%attributes = {}
  // MPAcfg_Comp_Propiedades(recNumCompetencia)
  // - recNumCompetencia: Longint: recNum de la competencia a editar
  // Abre el formulario de propiedades de la competencia cuyo recNum se pasó en argumento
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 22/07/12, 13:15:14
  // ---------------------------------------------
C_LONGINT:C283($l_recNumCompetencia)


  // CÓDIGO
$l_recNumCompetencia:=$1

READ WRITE:C146([MPA_DefinicionCompetencias:187])
GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$l_recNumCompetencia)

WDW_OpenFormWindow (->[MPA_DefinicionCompetencias:187];"Propiedades";-1;8)
KRL_ModifyRecord (->[MPA_DefinicionCompetencias:187];"Propiedades")
CLOSE WINDOW:C154