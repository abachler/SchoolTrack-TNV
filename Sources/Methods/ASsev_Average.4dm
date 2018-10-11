//%attributes = {}
  // MÉTODO: ASsev_Average
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 09/04/12, 21:36:29
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // ASsev_Average()
  // ----------------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_calificacionesValidas;$l_filaEditada)
C_REAL:C285($r_calificacion;$r_sumaCalificaciones)
C_TEXT:C284($t_motivoParaNoCalcular)

If (False:C215)
	C_LONGINT:C283(ASsev_Average ;$1)
End if 



  // CODIGO PRINCIPAL
$l_filaEditada:=$1

$l_calificacionesValidas:=0
$r_sumaCalificaciones:=0
$t_motivoParaNoCalcular:=""
For ($i;1;12)
	Case of 
		: (aRealSubEvalArrPtr{$i}->{$l_filaEditada}=-3)  //-3 corresponde a "X" (eximido de la calificación). Los promedios se calculan con las otras calificaciones
			aREalSubEvalP1{$l_filaEditada}:=-3
			aREalSubEvalPresentacion{$l_filaEditada}:=-3
			
			
		: (aRealSubEvalArrPtr{$i}->{$l_filaEditada}=-2)  // -2 corresponde a "P" (pendiente). Si el alumno tienen una calificación pendiente el promedio queda también pendiente
			$t_motivoParaNoCalcular:="P"
			aSubEvalP1{$l_filaEditada}:="P"
			aREalSubEvalP1{$l_filaEditada}:=-2
			aREalSubEvalPresentacion{$l_filaEditada}:=-2
			
			
		: (aRealSubEvalArrPtr{$i}->{$l_filaEditada}=-4)  // -4 corresponde a "*" (alumno no fue calificado). El promedio es calculado con las otras calificaciones
			aREalSubEvalP1{$l_filaEditada}:=-4
			aREalSubEvalPresentacion{$l_filaEditada}:=-4
			
			
		: (aRealSubEvalArrPtr{$i}->{$l_filaEditada}>=vrNTA_MinimoEscalaReferencia)  //la calificación registrada es válida y superior al mínimo de la escala
			$r_calificacion:=aRealSubEvalArrPtr{$i}->{$l_filaEditada}
			$r_sumaCalificaciones:=$r_sumaCalificaciones+$r_calificacion
			$l_calificacionesValidas:=$l_calificacionesValidas+Num:C11($r_calificacion>=vrNTA_MinimoEscalaReferencia)
			
			
	End case 
End for 


If ($t_motivoParaNoCalcular="")  // si no hay motivos para no recalcular, se calculan los promedios
	Case of 
		: ((iResults=2) & ([xxSTR_Subasignaturas:83]CalcularPromedios:18=False:C215) & ($r_sumaCalificaciones>=vrNTA_MinimoEscalaReferencia) & ($r_sumaCalificaciones<=100) & ($l_calificacionesValidas>0))  //presentacion examen calculado con suma de calificaciones
			aREalSubEvalPresentacion{$l_filaEditada}:=$r_sumaCalificaciones
			aREalSubEvalP1{$l_filaEditada}:=$r_sumaCalificaciones
		: ((iResults=2) & ([xxSTR_Subasignaturas:83]CalcularPromedios:18=False:C215) & ($r_sumaCalificaciones>=vrNTA_MinimoEscalaReferencia) & ($r_sumaCalificaciones>100) & ($l_calificacionesValidas>0))  //presentacion examen calculado con suma de calificaciones. Si la suma es superior a 100 el resultado es 100, no puede superior al 100% de la escala)
			aREalSubEvalPresentacion{$l_filaEditada}:=100
			aREalSubEvalP1{$l_filaEditada}:=100
		Else 
			If (($r_sumaCalificaciones>=vrNTA_MinimoEscalaReferencia) & ($l_calificacionesValidas>0))
				If (vi_gTrPAvg=1)
					aREalSubEvalPresentacion{$l_filaEditada}:=Trunc:C95(100*($r_sumaCalificaciones/$l_calificacionesValidas)/100;11)
				Else 
					aREalSubEvalPresentacion{$l_filaEditada}:=Round:C94(100*($r_sumaCalificaciones/$l_calificacionesValidas)/100;11)
				End if 
				If (([xxSTR_Subasignaturas:83]ModoControles:5>0) & (aREalSubEvalControles{$l_filaEditada}>=vrNTA_MinimoEscalaReferencia))
					ASsev_PromediosConControles ($l_filaEditada;$r_sumaCalificaciones;$l_calificacionesValidas)
				Else 
					aREalSubEvalP1{$l_filaEditada}:=aREalSubEvalPresentacion{$l_filaEditada}
				End if 
			Else 
				aREalSubEvalPresentacion{$l_filaEditada}:=-10
				aREalSubEvalP1{$l_filaEditada}:=-10
				aSubEvalP1{$l_filaEditada}:=""
				aSubEvalPresentacion{$l_filaEditada}:=""
			End if 
	End case 
	
	Case of 
		: (iEvaluationMode=Notas)
			  //aSubEvalP1{$l_filaEditada}:=EV2_Real_a_Literal (aREalSubEvalP1{$l_filaEditada};Notas)
			aSubEvalP1{$l_filaEditada}:=EV2_Real_a_Literal (aREalSubEvalP1{$l_filaEditada};Notas;iGradesDecPP)  //ASM Ticket 216848
			$r_Nota:=EV2_Real_a_Nota (aREalSubEvalP1{$l_filaEditada};0;iGradesDecPP)
			aREalSubEvalP1{$l_filaEditada}:=EV2_Nota_a_Real ($r_Nota)
			
		: (iEvaluationMode=Puntos)
			aSubEvalP1{$l_filaEditada}:=EV2_Real_a_Literal (aREalSubEvalP1{$l_filaEditada};Puntos)
			$r_Puntos:=EV2_Real_a_Puntos (aREalSubEvalP1{$l_filaEditada};0;iPointsDecPP)
			aREalSubEvalP1{$l_filaEditada}:=EV2_Puntos_a_Real ($r_Puntos)
			
		: (iEvaluationMode=Porcentaje)
			aSubEvalP1{$l_filaEditada}:=String:C10(aREalSubEvalP1{$l_filaEditada};vs_PercentFormat)
			aREalSubEvalP1{$l_filaEditada}:=Trunc:C95(aREalSubEvalP1{$l_filaEditada};1)
			
		: (iEvaluationMode=Simbolos)
			aSubEvalP1{$l_filaEditada}:=EV2_Real_a_Simbolo (aREalSubEvalP1{$l_filaEditada})
			If ((vi_ConvertSymbolicAverage=1) | (iPrintMode=Simbolos) | (iPrintActa=Simbolos))
				aREalSubEvalP1{$l_filaEditada}:=EV2_Simbolo_a_Real (aSubEvalP1{$l_filaEditada})
			End if 
	End case 
End if 



