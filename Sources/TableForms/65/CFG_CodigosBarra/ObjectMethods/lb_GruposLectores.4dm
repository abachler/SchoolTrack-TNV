  // [xxBBL_Preferencias].CFG_CodigosBarra.lb_GruposLectores()
  // Por: Alberto Bachler: 20/11/13, 18:29:35
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($0)

C_LONGINT:C283($l_filaOrigen;$l_procesoOrigen)
C_POINTER:C301($y_objetoOrigen)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			BBLcfg_AccionesGrupoLectores 
		End if 
		
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($y_objetoOrigen;$l_filaOrigen;$l_procesoOrigen)
		If ($y_objetoOrigen#OBJECT Get pointer:C1124(Object current:K67:2))
			$0:=-1
		End if 
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($y_objetoOrigen;$l_filaOrigen;$l_procesoOrigen)
		$l_filaDestino:=Drop position:C608
		$l_idGrupoActual:=<>alBBL_GruposLectores{$l_filaOrigen}
		$l_idGrupoReemplazo:=<>alBBL_GruposLectores{$l_filaDestino}
		BBLcfg_SustituyeGrupoLectores ($l_idGrupoActual;$l_idGrupoReemplazo)
		
End case 



