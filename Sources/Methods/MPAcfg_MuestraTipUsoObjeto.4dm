//%attributes = {}
  // MÉTODO: MPAcfg_MuestraTipUsoObjeto
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 16/08/12, 10:27:26
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPAcfg_MuestraTipUsoObjeto()
  // ----------------------------------------------------
C_LONGINT:C283($l_abajo;$l_arriba;$l_derecha;$l_izquierda;$l_numeroCampo;$l_NumeroTabla;$l_usoObjeto)
C_POINTER:C301($y_Objeto)
C_TEXT:C284($t_infoEvaluaciones;$t_nombreObjeto;$t_nombreVar;$t_tip)


$y_Objeto:=$1
RESOLVE POINTER:C394($y_Objeto;$t_nombreVar;$l_NumeroTabla;$l_numeroCampo)
OBJECT GET COORDINATES:C663($y_Objeto->;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
Case of 
	: ($t_nombreVar="bInfoMatrizEje")
		Case of 
			: ((vl_ejeEnMatrices+vl_ejeEnMatrices_asociados)=0)
				$t_tip:=__ ("El eje y las dimensiones y competencias asociadas no son utilizadas en ninguna matriz de evaluación.")
			: ((vl_ejeEnMatrices+vl_ejeEnMatrices_asociados)=1)
				$t_tip:=__ ("El eje esta asignado a 1 matriz de evaluación.")
			Else 
				$t_tip:=__ ("^0 asignación(es) del eje a las matrices de evaluación y ^1 de las dimensiones y competencias asociadas.";String:C10(vl_ejeEnMatrices);String:C10(vl_ejeEnMatrices_asociados))
		End case 
		
	: ($t_nombreVar="bInfoEvalEje")
		Case of 
			: ((vl_ejeEvaluados+vl_ejeEvaluados_asociados)=0)
				$t_tip:=__ ("No hay evaluaciones registradas para el eje ni para las dimensiones o competencias asociados.")
			: ((vl_ejeEvaluados=1) & (vl_ejeEvaluados_Asociados=0))
				$t_tip:=__ ("^0 evaluación registrada para este eje.";String:C10(vl_ejeEvaluados))
			: ((vl_ejeEvaluados>1) & (vl_ejeEvaluados_Asociados=0))
				$t_tip:=__ ("^0 evaluaciones registradas para este eje.";String:C10(vl_ejeEvaluados))
			: ((vl_ejeEvaluados=0) & (vl_ejeEvaluados_Asociados>0))
				$t_tip:=__ ("^0 evaluacion(es) registradas para el eje y ^1 para las dimensiones y competencias asociadas.";String:C10(vl_ejeEvaluados);String:C10(vl_ejeEvaluados_Asociados))
			: ((vl_ejeEvaluados>1) & (vl_ejeEvaluados_Asociados>0))
				$t_tip:=__ ("^0 evaluacion(es) registradas para el eje y ^1 para las dimensiones y competencias asociadas.";String:C10(vl_ejeEvaluados);String:C10(vl_ejeEvaluados_Asociados))
		End case 
		
	: ($t_nombreVar="bInfoMatrizDim")
		Case of 
			: ((vl_dimEnMatrices+vl_DimEnMatrices_asociados)=0)
				$t_tip:=__ ("La dimensión y las competencias asociadas no son utilizadas en ninguna matriz de evaluación.")
			: ((vl_dimEnMatrices+vl_DimEnMatrices_asociados)=1)
				$t_tip:=__ ("La dimensión esta asignada a 1 matriz de evaluación.")
			Else 
				$t_tip:=__ ("^0 asignación(es) de la dimensión a matrices de evaluación y ^1 de las competencias asociadas.";String:C10(vl_dimEnMatrices);String:C10(vl_dimEnMatrices_asociados))
		End case 
		
	: ($t_nombreVar="bInfoEvalDim")
		Case of 
			: ((vl_dimEvaluados+vl_ejeEvaluados_asociados)=0)
				$t_tip:=__ ("No hay evaluaciones registradas para la dimensión ni para las competencias asociados.")
			: ((vl_dimEvaluados=1) & (vl_dimEvaluados_Asociados=0))
				$t_tip:=__ ("^0 evaluación registrada para este dimensión.";String:C10(vl_dimEvaluados))
			: ((vl_dimEvaluados>1) & (vl_dimEvaluados_Asociados=0))
				$t_tip:=__ ("^0 evaluaciones registradas para este dimensión.";String:C10(vl_dimEvaluados))
			: ((vl_dimEvaluados>1) & (vl_dimEvaluados_Asociados>0))
				$t_tip:=__ ("^0 evaluacion(es) registradas para la dimensión y ^1 para las competencias asociadas.";String:C10(vl_dimEvaluados);String:C10(vl_dimEvaluados_Asociados))
		End case 
		
	: ($t_nombreVar="bInfoMatrizComp")
		Case of 
			: (vl_competenciasEnMatrices=0)
				$t_tip:=__ ("La competencia no es utilizada en ninguna matriz de evaluación.")
			: (vl_competenciasEnMatrices=1)
				$t_tip:=__ ("La competencia es utilizada en 1 matriz de evaluación.")
			Else 
				$t_tip:=__ ("La competencia es utilizada en ^0 matrices de evaluación.";String:C10(vl_competenciasEnMatrices))
		End case 
		
	: ($t_nombreVar="bInfoEvalComp")
		Case of 
			: (vl_competenciasEvaluados=0)
				$t_tip:=__ ("No hay evaluaciones registradas para la competencia.")
			: (vl_competenciasEvaluados=1)
				$t_tip:=__ ("1 evaluación registrada para la competencia.")
			Else 
				$t_tip:=__ ("^0 evaluaciones registradas para la competencia.";String:C10(vl_competenciasEvaluados))
		End case 
		
End case 

API Create Tip ($t_tip;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
