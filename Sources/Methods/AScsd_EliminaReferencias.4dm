//%attributes = {}
  // MÉTODO: AScsd_EliminaReferencias
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 23/08/11, 09:53:38
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AS_EliminaConsolidaciones()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_LONGINT:C283($0;$1;$l_idAsignaturaConsolidable;$2;$l_periodo;$l_IdAsignaturaMadre)
$l_idAsignaturaConsolidable:=$1
  //If (Count parameters=2)
  //$l_Periodo:=$2
  //End if 
Case of 
	: (Count parameters:C259=2)
		$l_Periodo:=$2
		$l_IdAsignaturaMadre:=0
	: (Count parameters:C259=3)
		$l_Periodo:=$2
		$l_IdAsignaturaMadre:=$3
End case 

  // CODIGO PRINCIPAL
QUERY:C277([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_ParentRecord:5;=;$l_idAsignaturaConsolidable)
If ($l_periodo>0)
	QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]Periodo:3;=;String:C10($l_periodo))
End if 
  //20140610 ASM para eliminar solo la consolidacion de la asigantura madre seleccionada
If ($l_IdAsignaturaMadre>0)
	QUERY SELECTION:C341([Asignaturas_Consolidantes:231];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1=$l_IdAsignaturaMadre)
End if 
$0:=KRL_DeleteSelection (->[Asignaturas_Consolidantes:231])
