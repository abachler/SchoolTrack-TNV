//%attributes = {}
  // AS_GuardaObservaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 28-12-15, 13:06:24
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_observacionesEditables;$b_ok)
C_LONGINT:C283($i_categorias;$i_observaciones;$l_pagina;$l_recNum)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_Categoria;$t_llave;$t_ObservacionesConsolidadas)

ARRAY TEXT:C222($at_categorias;0)
ARRAY TEXT:C222($at_observaciones;0)

$b_observacionesEditables:=((OBJECT Get pointer:C1124(Object named:K67:5;"observaciones.editables"))->=1)
$l_pagina:=(OBJECT Get pointer:C1124(Object named:K67:5;"observaciones.pagina"))->

If ($b_observacionesEditables)
	Case of 
		: ($l_pagina=1)
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
			
		: ($l_pagina=2)
			  //MONO 213584
			$b_ok:=AS_SaveObsxCatEnCompEva ([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;[Asignaturas:18]Numero:1;vlSTR_PeriodoObservaciones;True:C214)
			If ($b_ok)
				SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
			End if 
	End case 
End if 



