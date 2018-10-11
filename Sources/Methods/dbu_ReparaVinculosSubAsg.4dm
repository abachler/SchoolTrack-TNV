//%attributes = {}
  // MÉTODO: dbu_ReparaVinculosSubAsg
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 21/12/11, 19:36:01
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // dbu_ReparaVinculosSubAsg()
  // ----------------------------------------------------
C_BLOB:C604($x_blob;$x_RecNumsArray)
C_BOOLEAN:C305($b_reconstruirPropiedades;$b_vinculosCorruptos)
C_LONGINT:C283($i;$l_Evals;$l_Periodos;$l_ProgressProcID;$l_recNum;$l_resultado)
C_REAL:C285($r_sumaRealesAsignatura;$r_sumaRealesSubasignatura)
C_TEXT:C284($t_textoError;$t_textoReporteError;$t_tablaVinculosCorruptos)

ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
ARRAY LONGINT:C221($al_RecNumAsignaturasRecalculo;0)






  // CODIGO PRINCIPAL
EVS_LoadStyles 
PERIODOS_Init 

CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];"subasignaturas")
CREATE EMPTY SET:C140([Asignaturas:18];"asignaturas")

ALL RECORDS:C47([Asignaturas:18])
ARRAY LONGINT:C221($al_RecNumAsignaturas;0)
LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_RecNumAsignaturas;"")
$l_ProgressProcID:=IT_Progress (1;0;0;__ ("Detectando vínculos corruptos entre Asignaturas y Subasignaturas"))
$t_tablaVinculosCorruptos:=""
$b_vinculosCorruptos:=False:C215
$t_tablaVinculosCorruptos:="Nº Asignatura"+"\t"+"Asignatura"+"\t"+"Curso"+"\t"+"Periodo"+"\t"+"Columna"+"\t"+"Descripción del error"+"\r"+$t_tablaVinculosCorruptos
TEXT TO BLOB:C554($t_tablaVinculosCorruptos;$x_blob;Mac text without length:K22:10)

START TRANSACTION:C239
For ($i;1;Size of array:C274($al_RecNumAsignaturas))
	GOTO RECORD:C242([Asignaturas:18];$al_RecNumAsignaturas{$i})
	PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
	For ($l_Periodos;1;Size of array:C274(atSTR_Periodos_Nombre))
		$b_reconstruirPropiedades:=False:C215
		atSTR_Periodos_Nombre:=$l_Periodos
		AS_PropEval_Lectura ("";$l_Periodos)
		EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$l_Periodos)
		For ($l_Evals;1;12)
			If (alAS_EvalPropSourceID{$l_Evals}<0)
				$l_recNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$l_Periodos;$l_Evals;False:C215)
				If ($l_recNum<0)
					$l_recNum:=ASsev_GetGradesFromBlob (alAS_EvalPropSourceID{$l_Evals};$l_Periodos;False:C215)
				Else 
					If ([xxSTR_Subasignaturas:83]Name:2#atAS_EvalPropSourceName{$l_Evals})
						QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=[Asignaturas:18]Numero:1;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12=$l_Periodos;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Columna:13=$l_Evals;*)
						QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Name:2#atAS_EvalPropSourceName{$l_Evals})
						$l_recNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$l_Periodos;$l_Evals;False:C215)
					End if 
				End if 
				Case of 
					: ($l_recNum=-2)
						ADD TO SET:C119([Asignaturas:18];"asignaturas")
						$b_vinculosCorruptos:=True:C214
						$b_reconstruirPropiedades:=True:C214
						$t_textoError:="Subasignatura vinculada a otra asignatura"
						$t_tablaVinculosCorruptos:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$l_Periodos}+"\t"+String:C10($l_Evals)+"\t"+$t_textoError+"\r"
						TEXT TO BLOB:C554($t_tablaVinculosCorruptos;$x_blob;Mac text without length:K22:10;*)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$l_Evals}
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Periodo:12:=$l_Periodos
						[xxSTR_Subasignaturas:83]Columna:13:=$l_Evals
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						
					: ($l_recNum=-1)
						ADD TO SET:C119([Asignaturas:18];"asignaturas")
						$b_vinculosCorruptos:=True:C214
						$b_reconstruirPropiedades:=True:C214
						$t_textoError:="Subasignatura inexistente"
						$t_tablaVinculosCorruptos:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$l_Periodos}+"\t"+String:C10($l_Evals)+"\t"+$t_textoError+"\r"
						TEXT TO BLOB:C554($t_tablaVinculosCorruptos;$x_blob;Mac text without length:K22:10;*)
						CREATE RECORD:C68([xxSTR_Subasignaturas:83])
						[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$l_Evals}
						[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
						[xxSTR_Subasignaturas:83]Periodo:12:=$l_Periodos
						[xxSTR_Subasignaturas:83]Columna:13:=$l_Evals
						SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						
					: ($l_recNum>=0)
						$r_sumaRealesSubasignatura:=AT_GetSumArray (->aRealSubEvalP1;True:C214)
						$r_sumaRealesAsignatura:=AT_GetSumArray (aNtaRealArrPointers{$l_Evals};True:C214)
						Case of 
							: (($r_sumaRealesAsignatura>0) & ($r_sumaRealesSubasignatura=0))
								ADD TO SET:C119([Asignaturas:18];"asignaturas")
								$b_vinculosCorruptos:=True:C214
								$b_reconstruirPropiedades:=True:C214
								$t_textoError:="La subasignatura vinculada no tiene evaluaciones"
								$t_tablaVinculosCorruptos:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$l_Periodos}+"\t"+String:C10($l_Evals)+"\t"+$t_textoError+"\r"
								TEXT TO BLOB:C554($t_tablaVinculosCorruptos;$x_blob;Mac text without length:K22:10;*)
								READ WRITE:C146([xxSTR_Subasignaturas:83])
								DELETE RECORD:C58([xxSTR_Subasignaturas:83])
								CREATE RECORD:C68([xxSTR_Subasignaturas:83])
								[xxSTR_Subasignaturas:83]LongID:7:=[Asignaturas:18]Numero:1
								[xxSTR_Subasignaturas:83]Name:2:=atAS_EvalPropSourceName{$l_Evals}
								[xxSTR_Subasignaturas:83]ID_Mother:6:=[Asignaturas:18]Numero:1
								[xxSTR_Subasignaturas:83]Periodo:12:=$l_Periodos
								[xxSTR_Subasignaturas:83]Columna:13:=$l_Evals
								SAVE RECORD:C53([xxSTR_Subasignaturas:83])
								APPEND TO ARRAY:C911($al_RecNumAsignaturasRecalculo;Record number:C243([Asignaturas:18]))
								
							: (($r_sumaRealesAsignatura=0) & ($r_sumaRealesSubasignatura>0))
								ADD TO SET:C119([Asignaturas:18];"asignaturas")
								$t_textoError:="Columna sin notas, subasignatura vinculada con notas"
								$t_tablaVinculosCorruptos:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$l_Periodos}+"\t"+String:C10($l_Evals)+"\t"+$t_textoError+"\r"
								TEXT TO BLOB:C554($t_tablaVinculosCorruptos;$x_blob;Mac text without length:K22:10;*)
								APPEND TO ARRAY:C911($al_RecNumAsignaturasRecalculo;Record number:C243([Asignaturas:18]))
								
							: ($r_sumaRealesAsignatura#$r_sumaRealesSubasignatura)
								ADD TO SET:C119([Asignaturas:18];"asignaturas")
								$b_vinculosCorruptos:=True:C214
								$b_reconstruirPropiedades:=True:C214
								$t_textoError:="Diferencias entre notas de la subasignatura y las notas la columna"
								$t_tablaVinculosCorruptos:="["+String:C10([Asignaturas:18]Numero:1)+"]"+"\t"+[Asignaturas:18]denominacion_interna:16+"\t"+[Asignaturas:18]Curso:5+"\t"+atSTR_Periodos_Nombre{$l_Periodos}+"\t"+String:C10($l_Evals)+"\t"+$t_textoError+"\r"
								TEXT TO BLOB:C554($t_tablaVinculosCorruptos;$x_blob;Mac text without length:K22:10;*)
								APPEND TO ARRAY:C911($al_RecNumAsignaturasRecalculo;Record number:C243([Asignaturas:18]))
								
							Else 
								KRL_GotoRecord (->[xxSTR_Subasignaturas:83];$l_recNum;True:C214)
								[xxSTR_Subasignaturas:83]Periodo:12:=$l_Periodos
								[xxSTR_Subasignaturas:83]Columna:13:=$l_Evals
								SAVE RECORD:C53([xxSTR_Subasignaturas:83])
						End case 
				End case 
			End if 
		End for 
		If ($b_reconstruirPropiedades)
			If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
				AS_PropEval_Escritura ($l_Periodos)
			Else 
				AS_PropEval_Escritura (0)
			End if 
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_RecNumAsignaturas);__ ("Detectando vínculos corruptos entre Asignaturas y Subasignaturas")+"\r"+[Asignaturas:18]denominacion_interna:16)
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Application type:C494#4D Server:K5:6)
	If ($b_vinculosCorruptos)
		$t_textoReporteError:="Se detectaron vínculos corruptos entre "+String:C10(Records in set:C195("asignaturas"))+" asignaturas y una o más subasignaturas .\rEl detalle puede ser consultado en el texto del reporte"
		$t_textoReporteError:=$t_textoReporteError+"\r\rEs posible reconstruir los vínculos pero las notas de las subasignaturas daña"+"das no podrán ser recuperadas."
		$t_textoReporteError:=$t_textoReporteError+"\r\rSi desea reconstruir los vínculos dañados le recomendamos vivamente hacer un respaldo de su base de datos y ejecutar nuevamente este comando antes de utilizar la opción de reparación"
		$l_resultado:=CD_ReportProblem ("*";$t_textoReporteError;$x_blob)
		If ($l_resultado=1)
			VALIDATE TRANSACTION:C240
			CD_Dlog (0;__ ("Reparación efectuada."))
			If (Size of array:C274($al_RecNumAsignaturasRecalculo)>0)
				BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumAsignaturasRecalculo)
				EV2dbu_Recalculos ($x_RecNumsArray)
			End if 
		Else 
			CANCEL TRANSACTION:C241
		End if 
	Else 
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("No se detectó ningún vinculo dañado."))
	End if 
Else 
	VALIDATE TRANSACTION:C240
	If (Size of array:C274($al_RecNumAsignaturasRecalculo)>0)
		BLOB_Variables2Blob (->$x_RecNumsArray;0;->$al_RecNumAsignaturasRecalculo)
		EV2dbu_Recalculos ($x_RecNumsArray)
	End if 
End if 

  //End if 

