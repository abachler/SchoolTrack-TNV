//%attributes = {}
  // MÉTODO: MPA_CambiaEstiloEvaluacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/03/12, 18:28:32
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // MPA_CambiaEstiloEvaluacion()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($b_CalculoDimensiones;$b_CalculoEjes;$b_CalculoResultadoFinal;$b_cancelTransaction)
C_LONGINT:C283($el;$i;$l_estiloActual;$l_estiloNuevo;$l_IdObjeto;$l_tipoObjeto)

ARRAY LONGINT:C221($al_IdMatrices;0)
ARRAY LONGINT:C221($al_RecNums;0)

If (False:C215)
	C_LONGINT:C283(MPA_CambiaEstiloEvaluacion ;$0)
	C_LONGINT:C283(MPA_CambiaEstiloEvaluacion ;$1)
	C_LONGINT:C283(MPA_CambiaEstiloEvaluacion ;$2)
	C_LONGINT:C283(MPA_CambiaEstiloEvaluacion ;$3)
	C_LONGINT:C283(MPA_CambiaEstiloEvaluacion ;$4)
End if 



  // CODIGO PRINCIPAL
$l_tipoObjeto:=$1
$l_IdObjeto:=$2
$l_estiloActual:=$3
$l_estiloNuevo:=$4
$b_cancelTransaction:=False:C215




Case of 
	: ($l_tipoObjeto=Eje_Aprendizaje)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=$l_tipoObjeto;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=$l_IdObjeto)
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		
	: ($l_tipoObjeto=Dimension_Aprendizaje)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=$l_tipoObjeto;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=$l_IdObjeto)
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		
	: ($l_tipoObjeto=Logro_Aprendizaje)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=$l_tipoObjeto;*)
		QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=$l_IdObjeto)
		QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
		
End case 

KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")



If (Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])>0)
	OK:=CD_Dlog (0;__ ("Hay evaluaciones registradas para este ítem.\rSi modifica el estilo de evaluación los valores registrados serán convertidos de acuerdo a la escala del nuevo estilo de evaluación seleccionado.\r\r¿Desea realmente reemplazar el estilo de evaluación?");__ ("");__ ("No");__ ("Si. Convertir al nuevo estilo"))
	If (OK=2)
		EVS_ReadStyleData ($l_estiloNuevo)
		$b_cancelTransaction:=False:C215
		START TRANSACTION:C239
		ARRAY LONGINT:C221($al_RecNums;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos_EvaluacionAprendizajes:203];$al_RecNums)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Aplicando cambio de estilo de evaluación..."))
		For ($i;1;Size of array:C274($al_RecNums))
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_RecNums);__ ("Aplicando cambio de estilo de evaluación..."))
			
			KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$al_RecNums{$i};True:C214)
			If (OK=0)
				$i:=Size of array:C274($al_RecNums)+1
				$b_cancelTransaction:=True:C214
				$0:=0
			Else 
				
				
				  //finales
				If ([Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61#"")
					[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61:=EV2_Real_a_Literal ([Alumnos_EvaluacionAprendizajes:203]Final_Real:59;iEvaluationMode;vlNTA_DecimalesNF)
					[Alumnos_EvaluacionAprendizajes:203]Final_Real:59:=NTA_StringValue2Percent ([Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61)
					If (iEvaluationMode=Simbolos)
						[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=Round:C94([Alumnos_EvaluacionAprendizajes:203]Final_Real:59;1)
						$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61)
						If ($el>0)
							[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62:=aSymbDesc{$el}
						End if 
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60:=Num:C11([Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61)
					End if 
				End if 
				
				
				  // Periodo 1
				If ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13#"")
					[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13:=EV2_Real_a_Literal ([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11;iEvaluationMode;vlNTA_DecimalesPP)
					[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11:=NTA_StringValue2Percent ([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
					If (iEvaluationMode=Simbolos)
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=Round:C94([Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11;1)
						$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
						If ($el>0)
							[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=aSymbDesc{$el}
						Else 
							[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14:=""
						End if 
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12:=Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13)
					End if 
				End if 
				
				
				
				  //periodo 2
				If ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25#"")
					[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25:=EV2_Real_a_Literal ([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23;iEvaluationMode;vlNTA_DecimalesPP)
					[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23:=NTA_StringValue2Percent ([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
					If (iEvaluationMode=Simbolos)
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=Round:C94([Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23;1)
						$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
						If ($el>0)
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=aSymbDesc{$el}
						Else 
							[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26:=""
						End if 
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24:=Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25)
					End if 
				End if 
				
				
				  //periodo 3
				If ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37#"")
					[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37:=EV2_Real_a_Literal ([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35;iEvaluationMode;vlNTA_DecimalesPP)
					[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35:=NTA_StringValue2Percent ([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
					If (iEvaluationMode=Simbolos)
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=Round:C94([Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35;1)
						$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
						If ($el>0)
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=aSymbDesc{$el}
						Else 
							[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38:=""
						End if 
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36:=Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37)
					End if 
				End if 
				
				  //periodo 4
				If ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49#"")
					[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49:=EV2_Real_a_Literal ([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47;iEvaluationMode;vlNTA_DecimalesPP)
					[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47:=NTA_StringValue2Percent ([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49)
					If (iEvaluationMode=Simbolos)
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=Round:C94([Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47;1)
						$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49)
						If ($el>0)
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=aSymbDesc{$el}
						Else 
							[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50:=""
						End if 
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48:=Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49)
					End if 
				End if 
				
				
				
				  //periodo 5
				If ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66#"")
					[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66:=EV2_Real_a_Literal ([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64;iEvaluationMode;vlNTA_DecimalesPP)
					[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64:=NTA_StringValue2Percent ([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66)
					If (iEvaluationMode=Simbolos)
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=Round:C94([Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64;1)
						$el:=Find in array:C230(aSymbol;[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66)
						If ($el>0)
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=aSymbDesc{$el}
						Else 
							[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67:=""
						End if 
					Else 
						[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65:=Num:C11([Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66)
					End if 
				End if 
				
				
				SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
			End if 
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		
		If (Not:C34($b_cancelTransaction))
			VALIDATE TRANSACTION:C240
			UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
			
			Case of 
				: ($l_tipoObjeto=Eje_Aprendizaje)
					LOG_RegisterEvt ("Cambio de estilo de evaluación en Eje de aprendizaje ID# "+String:C10($l_IdObjeto)+" ("+[MPA_DefinicionEjes:185]Nombre:3+")")
					
				: ($l_tipoObjeto=Dimension_Aprendizaje)
					LOG_RegisterEvt ("Cambio de estilo de evaluación en Eje de aprendizaje ID# "+String:C10($l_IdObjeto)+" ("+[MPA_DefinicionDimensiones:188]Dimensión:4+")")
					
				: ($l_tipoObjeto=Logro_Aprendizaje)
					LOG_RegisterEvt ("Cambio de estilo de evaluación en Eje de aprendizaje ID# "+String:C10($l_IdObjeto)+" ("+[MPA_DefinicionCompetencias:187]Competencia:6+")")
					
			End case 
			$0:=1
		Else 
			CD_Dlog (0;__ ("No fue posible cambiar el estilo de evaluación.\rAlgunos registros de evaluación eran utilizados en otros procesos o por otros usuarios.\r\rPor favor inténtelo nuevam ente más tarde."))
			CANCEL TRANSACTION:C241
			$0:=0
		End if 
	Else 
		$0:=0
	End if 
Else 
	$0:=1
End if 

