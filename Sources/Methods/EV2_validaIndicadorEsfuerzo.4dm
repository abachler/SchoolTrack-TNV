//%attributes = {}
  // MÉTODO: EV2_validaIndicadorEsfuerzo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 29/03/12, 09:36:42
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_validaIndicadorEsfuerzo()
  // ----------------------------------------------------
C_BOOLEAN:C305($0;$b_valorAceptado)
C_POINTER:C301($2;$y_literalEsfuerzo;$3;$y_realEsfuerzo)
C_TEXT:C284($1;$t_indicadorEsfuerzo)
C_REAL:C285($r_valorRealEsfuerzo)

  // CODIGO PRINCIPAL
$t_indicadorEsfuerzo:=$1
$y_literalEsfuerzo:=$2
$y_realEsfuerzo:=$3
$y_literalEsfuerzo->:=$t_indicadorEsfuerzo
Case of 
	: (r1_EvEsfuerzoIndicadores=1)
		If ($t_indicadorEsfuerzo#"")
			$l_indiceIndicadorEsfuerzo:=Find in array:C230(aIndEsfuerzo;$t_indicadorEsfuerzo)
			If ($l_indiceIndicadorEsfuerzo<0)
				CD_Dlog (0;__ ("El valor ingresado no está definido como indicador de evaluación de esfuerzo."))
				$y_realEsfuerzo->:=-10
				$y_literalEsfuerzo->:=""
			Else 
				$y_realEsfuerzo->:=aFactorEsfuerzo{$l_indiceIndicadorEsfuerzo}/100
				$b_valorAceptado:=True:C214
				$y_literalEsfuerzo->:=aIndEsfuerzo{$l_indiceIndicadorEsfuerzo}  //para que guarde el valor configurado independiente de si lo ingreso en mayus o minus 20121120 JHB
			End if 
		Else 
			$y_realEsfuerzo->:=-10
			$y_literalEsfuerzo->:=""
			$b_valorAceptado:=True:C214
		End if 
		
	: (r2_EvEsfuerzoBonificacion=1)
		  //MONO Ticket 172479
		$b_valorAceptado:=EV2_validaCalificacion ($t_indicadorEsfuerzo;->$t_indicadorEsfuerzo;->$r_valorRealEsfuerzo)
		If ($b_valorAceptado)
			$y_realEsfuerzo->:=$r_valorRealEsfuerzo
			$y_literalEsfuerzo->:=EV2_Real_a_Literal ($r_valorRealEsfuerzo;iEvaluationMode)
		Else 
			$y_realEsfuerzo->:=-10
			$y_literalEsfuerzo->:=""
			$b_valorAceptado:=False:C215
		End if 
		
		  //If ($t_indicadorEsfuerzo#"")
		  //$r_valorNumericoEsfuerzo:=Num($t_indicadorEsfuerzo)
		  //Case of 
		  //: (iEvaluationMode=Notas)
		  //$r_valorRealEsfuerzo:=Round($r_valorNumericoEsfuerzo/rGradesTo*100;11)
		  //If (($r_valorNumericoEsfuerzo#0) & ($r_valorNumericoEsfuerzo<=rGradesTo))
		  //aRealNtaEsfuerzo{0}:=$r_valorRealEsfuerzo
		  //$y_realEsfuerzo->:=$r_valorRealEsfuerzo
		  //$b_valorAceptado:=True
		  //Else 
		  //CD_Dlog (0;__ ("El valor de la bonificación no puede ser superior al máximo de la escala."))
		  //$y_realEsfuerzo->:=-10
		  //$y_literalEsfuerzo->:=""
		  //End if 
		
		  //: (iEvaluationMode=Puntos)
		  //$r_valorRealEsfuerzo:=Round($r_valorNumericoEsfuerzo/rPointsTo*100;11)
		  //If (($r_valorNumericoEsfuerzo#0) & ($r_valorNumericoEsfuerzo<=rPointsTo))
		  //$y_realEsfuerzo->:=$r_valorRealEsfuerzo
		  //$b_valorAceptado:=True
		  //Else 
		  //CD_Dlog (0;__ ("El valor de la bonificación no puede ser superior al máximo de la escala."))
		  //$y_realEsfuerzo->:=-10
		  //$y_literalEsfuerzo->:=""
		  //End if 
		
		  //: (iEvaluationMode=Porcentaje)
		  //$r_valorRealEsfuerzo:=Round($r_valorNumericoEsfuerzo/100*100;11)
		  //If (($r_valorNumericoEsfuerzo#0) & ($r_valorNumericoEsfuerzo<=100))
		  //$y_realEsfuerzo->:=$r_valorRealEsfuerzo
		  //$b_valorAceptado:=True
		  //Else 
		  //CD_Dlog (0;__ ("El valor de la bonificación no puede ser superior al máximo de la escala."))
		  //$y_realEsfuerzo->:=-10
		  //$y_literalEsfuerzo->:=""
		  //End if 
		
		  //End case 
		
		  //Else 
		  //$y_realEsfuerzo->:=-10
		  //$y_literalEsfuerzo->:=""
		  //$b_valorAceptado:=True
		  //End if 
End case 
  //MONO ticket 172479
  //si estamos en ST hay que pasarlos a los array de la interfaz
If ((Not:C34(Undefined:C82(aRealNtaEsfuerzo))) & (Not:C34(Undefined:C82(aNtaEsfuerzo))))
	aRealNtaEsfuerzo{0}:=$y_realEsfuerzo->
	aNtaEsfuerzo{0}:=$y_literalEsfuerzo->
End if 

$0:=$b_valorAceptado