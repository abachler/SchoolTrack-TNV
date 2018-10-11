//%attributes = {}
  // EV2_Calculos_PromedioBonificado()
  //
  //
  // creado por: Alberto Bachler Klein: 21-11-16, 16:45:37
  // -----------------------------------------------------------
C_REAL:C285($0)
C_REAL:C285($1)
C_REAL:C285($2)

C_REAL:C285($r_bonificacion;$r_Nota;$r_ponderacionBonificacion;$r_ponderacionPeriodo;$r_presentacion)


If (False:C215)
	C_REAL:C285(EV2_Calculos_PromedioBonificado ;$0)
	C_REAL:C285(EV2_Calculos_PromedioBonificado ;$1)
	C_REAL:C285(EV2_Calculos_PromedioBonificado ;$2)
End if 

$r_presentacion:=$1
$r_bonificacion:=$2
$0:=$r_presentacion



  // calculo de la bonificación de fin de período
If ((vi_UsarBonificacion=1) & ($r_bonificacion>0) & (vr_BonificacionPeriodo>=0) & ($r_presentacion>vrNTA_MinimoEscalaReferencia))
	$r_ponderacionBonificacion:=vr_BonificacionPeriodo/100
	$r_ponderacionPeriodo:=(100-vr_BonificacionPeriodo)/100
	$r_presentacion:=Round:C94($r_presentacion*$r_ponderacionPeriodo;11)
	$r_bonificacion:=Round:C94($r_bonificacion*$r_ponderacionBonificacion;11)
	
	
	If (vi_RoundCPpresent=1)  //si la evaluación de presentación a examen deben ser truncada, es reconvertida con troncatura al estilo de evaluaci—n principal y a partir de ese valor se obtiene el real correspondiente
		Case of 
			: (iEvaluationMode=Notas)
				$r_Nota:=EV2_Real_a_Nota ($r_presentacion;0;11;False:C215)
				$r_presentacion:=EV2_Nota_a_Real ($r_Nota)
				$r_Nota:=EV2_Real_a_Nota ($r_bonificacion;0;11;False:C215)
				$r_bonificacion:=EV2_Nota_a_Real ($r_Nota)
			: (iEvaluationMode=Puntos)
				$r_Nota:=EV2_Real_a_Puntos ($r_presentacion;0;11;False:C215)
				$r_presentacion:=EV2_Puntos_a_Real ($r_Nota)
				$r_Nota:=EV2_Real_a_Puntos ($r_bonificacion;0;11;False:C215)
				$r_bonificacion:=EV2_Puntos_a_Real ($r_Nota)
			: (iEvaluationMode=Porcentaje)
				$r_presentacion:=Round:C94($r_presentacion;1)
				$r_bonificacion:=Round:C94($r_bonificacion;1)
			: (iEvaluationMode=Simbolos)
				$r_presentacion:=Round:C94($r_presentacion;1)
				$r_bonificacion:=Round:C94($r_bonificacion;1)
		End case 
	End if 
	$0:=$r_presentacion+$r_bonificacion
End if 

