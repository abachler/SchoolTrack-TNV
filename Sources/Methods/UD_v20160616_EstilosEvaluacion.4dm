//%attributes = {}
  // UD_v20160616_EstilosEvaluacion()
  //
  //
  // creado por: Alberto Bachler Klein: 16-06-16, 11:20:25
  // -----------------------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_escala_a_Porcentaje;$b_estiloEnUso;$b_simbolosVerificados)
C_LONGINT:C283($i;$i_registros;$l_aprendizajesEvaluados;$l_decimales;$l_decimalesConversion;$l_fila;$l_itemsEscala;$l_OTref;$l_ProgressProcID;$l_registrosEvaluados)
C_LONGINT:C283($l_simbolos;$l_ultimoElemento;$l_usoAsignaturas;$l_usoCompetencias;$l_usoDimensiones;$l_usoEjes;$l_usoEstilo;$l_usoEvaluaciones;$l_usoNivelInterno;$l_usoNivelOficial)
C_POINTER:C301($y_simbolosConversion;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosDesdePct;$y_simbolosHasta;$y_simbolosHastaPct;$y_simbolosPctEqu;$y_simbolosSimbolo;$y_tabla)
C_REAL:C285($r_Desde;$r_desdeNota;$r_desdePct;$r_desdePuntos;$r_diferencia;$r_diferenciaDecimales;$r_diferenciaEscala;$r_diferenciaPct;$r_hasta;$r_hastaNota)
C_REAL:C285($r_HastaPct;$r_hastaPuntos;$r_maximoEscala;$r_minimoAprobatorio;$r_minimoDiferencia;$r_minimoEscala;$r_valorMediano)
C_TEXT:C284($t_CambioDesde;$t_cambioPctDesde;$t_cambioPctHasta;$t_descripcion;$t_encabezado;$t_uuid)

ARRAY LONGINT:C221($al_recNum;0)
ARRAY REAL:C219($ar_SimbolosDesde;0)
ARRAY REAL:C219($ar_SimbolosHasta;0)
ARRAY TEXT:C222($at_Correccion;0)
ARRAY TEXT:C222($at_Ejes;0)
ARRAY TEXT:C222($at_Error;0)
ARRAY TEXT:C222($at_errores;0)
ARRAY TEXT:C222($at_estilos;0)
ARRAY TEXT:C222($at_EvalDesde;0)
ARRAY TEXT:C222($at_EvalHasta;0)
ARRAY TEXT:C222($at_PctDesde;0)
ARRAY TEXT:C222($at_PctHasta;0)
ARRAY TEXT:C222($at_simbolos;0)
ARRAY TEXT:C222($at_TitulosColumnas;0)

ARRAY LONGINT:C221($al_recNumCompetencias;0)
ARRAY TEXT:C222($at_simboloAprobacion;0)
ARRAY TEXT:C222($at_competencia;0)
ARRAY TEXT:C222($at_estilos;0)
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]TipoEvaluacion:12=3)
$y_tabla:=->[MPA_DefinicionCompetencias:187]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
READ WRITE:C146($y_tabla->)

For ($i_registros;1;Records in selection:C76($y_tabla->);1)
	
	GOTO RECORD:C242($y_tabla->;$al_recNum{$i_registros})
	
	If ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22>0)
		
		EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
		$t_simbolo:=EV2_Real_a_Simbolo ([MPA_DefinicionCompetencias:187]PctParaAprobacion:22)
		
		If (Length:C16($t_simbolo)#0)
			
			APPEND TO ARRAY:C911($al_recNumCompetencias;$al_recNum{$i_registros})
			APPEND TO ARRAY:C911($at_simboloAprobacion;$t_simbolo)
			APPEND TO ARRAY:C911($at_competencia;[MPA_DefinicionCompetencias:187]Competencia:6)
			APPEND TO ARRAY:C911($at_estilos;[xxSTR_EstilosEvaluacion:44]Name:2)
			
		End if 
	End if 
End for 

ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])

  //QUERY([xxSTR_EstilosEvaluacion];[xxSTR_EstilosEvaluacion]ID=7)

$y_tabla:=->[xxSTR_EstilosEvaluacion:44]
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
$l_ProgressProcID:=IT_Progress (1;0;0;"Verificando validez de estilos de evaluación")

For ($i_registros;1;Size of array:C274($al_recNum);1)
	
	$l_registrosEvaluados:=0
	$l_aprendizajesEvaluados:=0
	$b_simbolosVerificados:=False:C215
	KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};True:C214)
	
	If (OK=1)
		
		vlEVS_CurrentEvStyleID:=0
		EVS_ReadStyleData ([xxSTR_EstilosEvaluacion:44]ID:1)
		$x_blob:=[xxSTR_EstilosEvaluacion:44]OT_Data:7
		$l_OTref:=OT BLOBToObject ($x_blob)
		
		If (OT ItemExists ($l_OTref;"iStoreMode")=1)
			
			OT DeleteItem ($l_OTref;"iStoreMode")
			
		End if 
		
		If (rAprobatorioPorcentaje=0)
			
			rAprobatorioPorcentaje:=Round:C94(rPctMinimum;1)
			
		End if 
		
		If ([xxSTR_EstilosEvaluacion:44]ID:1=12)
			
		End if 
		
		  // VERIFICACION DE LAS TABLAS DE CONVERSION A SIMBOLOS
		$y_simbolosDesdePct:=->aSymbPctFrom
		$y_simbolosHastaPct:=->aSymbPctTo
		$y_simbolosSimbolo:=->aSymbol
		$y_simbolosDescripcion:=->aSymbDesc
		$y_simbolosPctEqu:=->aSymbPctEqu
		$l_simbolos:=Size of array:C274(aSymbol)
		
		  // redimensiono los arreglos de simbolo en caso de hayan inconsitencias
		AT_RedimArrays ($l_simbolos;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosDescripcion;$y_simbolosPctEqu)
		
		If ((Size of array:C274(aSymbol)>0)\
			 & (Size of array:C274($y_simbolosDesdePct->)>0)\
			 & (Size of array:C274($y_simbolosHastaPct->)>0))
			
			Case of 
					
					  //________________________________________
				: (iEvaluationMode=Notas)  //& (iPrintMode#Simbolos)&(iViewMode#Simbolos))					\
					
					
					$b_escala_a_Porcentaje:=False:C215
					$l_modo:=Notas
					
					  //________________________________________
				: (iEvaluationMode=Puntos)  //& (iPrintMode#Simbolos)&(iViewMode#Simbolos))					\
					
					
					$b_escala_a_Porcentaje:=False:C215
					$l_modo:=Puntos
					
					  //________________________________________
				: ((iEvaluationMode=Simbolos)\
					 & (iPrintMode=Simbolos)\
					 & (iEvaluationMode=Simbolos))
					
					$b_escala_a_Porcentaje:=False:C215
					$l_modo:=Porcentaje
					
					  //________________________________________
				: ((((iEvaluationMode=Notas)\
					 | ((iEvaluationMode=Simbolos)\
					 & (iPrintMode=Notas)))\
					 | ((viEVS_equMode=Notas)\
					 & (iEvaluationMode=Simbolos)\
					 & (iPrintMode=Simbolos)\
					 & (iViewMode=Simbolos)))\
					 & ((aSymbGradeFrom{1}=rGradesFrom)\
					 & (aSymbGradeTo{Size of array:C274(aSymbGradeTo)}=rGradesTo)))
					
					$b_escala_a_Porcentaje:=False:C215
					$l_modo:=Notas
					
					  //________________________________________
				: ((((iEvaluationMode=Puntos)\
					 | ((iEvaluationMode=Simbolos)\
					 & (iPrintMode=Puntos)))\
					 | ((viEVS_equMode=Puntos)\
					 & (iEvaluationMode=Simbolos)\
					 & (iPrintMode=Simbolos)\
					 & (iViewMode=Simbolos)))\
					 & ((aSymbPointsFrom{1}=rPointsFrom)\
					 & (aSymbPointsTo{Size of array:C274(aSymbPointsTo)}=rPointsTo)))
					
					$b_escala_a_Porcentaje:=False:C215
					$l_modo:=Puntos
					
					  //________________________________________
				: ((iEvaluationMode=Simbolos)\
					 & (iPrintMode=Simbolos)\
					 & (iViewMode=Simbolos))
					
					$b_escala_a_Porcentaje:=False:C215
					$l_modo:=Porcentaje
					
					  //________________________________________
				Else 
					
					$b_escala_a_Porcentaje:=True:C214
					
					Case of 
							
							  //----------------------------------------
						: ((iEvaluationMode=Notas)\
							 | (viEVS_EquMode=Notas))
							
							$l_modo:=Notas
							
							  //----------------------------------------
						: ((iEvaluationMode=Puntos)\
							 | (viEVS_EquMode=Puntos))
							
							$l_modo:=Puntos
							
							  //----------------------------------------
						Else 
							
							$l_modo:=Porcentaje
							
							  //----------------------------------------
					End case 
					
					  //________________________________________
			End case 
		End if 
		
		  // en v12 la conversión de símbolos a escala se define de acuerdo a la escala de referencia
		  // si todo es evaluado en simbolos se define de acuerdo la escala de 1 a 100
		$l_itemsEscala:=Size of array:C274(aSymbol)
		
		If ($l_itemsEscala>0)
			
			Case of 
					
					  //________________________________________
				: (($l_modo=Simbolos)\
					 | ($l_modo=Porcentaje))
					
					$y_simbolosDesde:=->aSymbPctFrom
					$y_simbolosHasta:=->aSymbPctTo
					$y_simbolosConversion:=->aSymbPctEqu
					$r_minimoEscala:=1
					$r_maximoEscala:=100
					$l_decimales:=1
					$r_minimoAprobatorio:=rAprobatorioPorcentaje
					
					  //________________________________________
				: ($l_modo=Notas)
					
					$y_simbolosDesde:=->aSymbGradeFrom
					$y_simbolosHasta:=->aSymbGradeTo
					$y_simbolosConversion:=->aSymbGradesEqu
					$r_minimoEscala:=rGradesFrom
					$r_maximoEscala:=rGradesTo
					$l_decimales:=MATH_Max (iGradesDec;iGradesPP;iGradesPF;iGradesNF;iGradesNO)
					$r_minimoAprobatorio:=rGradesMinimum
					
					  //________________________________________
				: ($l_modo=Puntos)
					
					$y_simbolosDesde:=->aSymbPointsFrom
					$y_simbolosHasta:=->aSymbPointsTo
					$y_simbolosConversion:=->aSymbPointsEqu
					$r_minimoEscala:=rPointsFrom
					$r_maximoEscala:=rPointsTo
					$l_decimales:=MATH_Max (iPointsDec;iPointsPP;iPointsPF;iPointsNF;iPointsNO)
					$r_minimoAprobatorio:=rPointsMinimum
					
					  //________________________________________
			End case 
			
			AT_RedimArrays (Size of array:C274(aSymbPctFrom);$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;->aSymbPctFrom;->aSymbPctTo;->aSymbPctEqu)
			$y_simbolosDesde->{1}:=$r_minimoEscala
			$y_simbolosHasta->{Size of array:C274($y_simbolosHasta->)}:=$r_maximoEscala
			
			For ($i;1;Size of array:C274(aSymbGradesEqu);1)
				
				$y_simbolosDesde->{$i}:=Trunc:C95($y_simbolosDesde->{$i};$l_decimales)
				$y_simbolosHasta->{$i}:=Trunc:C95($y_simbolosHasta->{$i};$l_decimales)
				$y_simbolosConversion->{$i}:=Trunc:C95($y_simbolosConversion->{$i};$l_decimales)
				
			End for 
			
			  //  // me aseguro que el primer valor de conversión al simbolo sea igual al mínimo de la escala y el último al máximo de la escala
			  //$y_simbolosDesde->{1}:=$r_minimoEscala
			  //$y_simbolosHasta->{$l_itemsEscala}:=$r_maximoEscala
			  //$y_simbolosDesdePct->{1}:=1
			  //$y_simbolosHastaPct->{$l_itemsEscala}:=100
			
			$r_minimoDiferencia:=1/(10^$l_decimales)
			
			For ($i;1;Size of array:C274($y_simbolosDesdePct->);1)
				
				If ($b_escala_a_Porcentaje)
					
					$y_simbolosDesde->{$i}:=Round:C94($r_maximoEscala*$y_simbolosDesdePct->{$i}/100;$l_decimales)
					$y_simbolosHasta->{$i}:=Round:C94($r_maximoEscala*$y_simbolosHastaPct->{$i}/100;$l_decimales)
					$y_simbolosConversion->{$i}:=Round:C94($r_maximoEscala*aSymbPctEqu{$i}/100;$l_decimales)
					
				Else 
					
					$y_simbolosDesdePct->{$i}:=Round:C94($y_simbolosDesde->{$i}/$r_maximoEscala*100;11)
					$y_simbolosHastaPct->{$i}:=Round:C94($y_simbolosHasta->{$i}/$r_maximoEscala*100;11)
					$y_simbolosDesde->{$i}:=Trunc:C95($r_maximoEscala*$y_simbolosDesdePct->{$i}/100;$l_decimales)
					$y_simbolosHasta->{$i}:=Trunc:C95($r_maximoEscala*$y_simbolosHastaPct->{$i}/100;$l_decimales)
					$y_simbolosConversion->{$i}:=Trunc:C95($r_maximoEscala*aSymbPctEqu{$i}/100;$l_decimales)
					
					  //$y_simbolosDesde->{$i}:=Trunc($r_maximoEscala*$y_simbolosDesdePct->{$i}/100;$l_decimales)
					  //$y_simbolosHasta->{$i}:=Trunc($r_maximoEscala*$y_simbolosHastaPct->{$i}/100;$l_decimales)
					  //$y_simbolosConversion->{$i}:=Trunc($r_maximoEscala*aSymbPctEqu{$i}/100;$l_decimales)
					If ($i>1)
						
						If ($y_simbolosHasta->{$i-1}>=$y_simbolosDesde->{$i})
							
							$y_simbolosDesde->{$i}:=$y_simbolosHasta->{$i-1}+$r_minimoDiferencia
							$y_simbolosDesdePct->{$i}:=Trunc:C95($y_simbolosDesde->{$i}/$r_maximoEscala*100;11)
							
						End if 
					End if 
				End if 
				
				  // si el valor de conversion esta fuera del rango lo establezco dentro del rango utilizando las preferencias existentes en los estilos de evaluación en v11
				If (($y_simbolosConversion->{$i}<$y_simbolosDesde->{$i})\
					 | ($y_simbolosConversion->{$i}>$y_simbolosHasta->{$i}))
					
					$r_valorMediano:=Round:C94($y_simbolosDesde->{$i}+($y_simbolosHasta->{$i}-$y_simbolosDesde->{$i}/2);$l_decimales)
					
					Case of 
							
							  //________________________________________
						: ((viEVS_EquMethod=3)\
							 & ($y_simbolosHasta->{$i}#$y_simbolosConversion->{$i}))  //valor superior del rango
							
							  // si el modo de equivalencia estaba fijado como el valor superior del rango y era diferente a él, lo reestablezco
							$y_simbolosConversion->{$i}:=$y_simbolosHasta->{$i}
							
							  //________________________________________
						: ((viEVS_EquMethod=2)\
							 & ($r_valorMediano#$y_simbolosConversion->{$i}))  // valor mediano del rango
							
							  // si el modo de equivalencia estaba fijado como el valor mediano del rango y era diferente a él, lo reestablezco
							$y_simbolosConversion->{$i}:=$r_valorMediano
							
							  //________________________________________
						: ((viEVS_EquMethod=1)\
							 & ($y_simbolosDesde->{$i}#$y_simbolosConversion->{$i}))  // valor inferior del rango
							
							  // si el modo de equivalencia estaba fijado como el valor mediano del rango y era diferente a él, lo reestablezco
							$y_simbolosConversion->{$i}:=$y_simbolosDesde->{$i}
							
							  //________________________________________
						: ((viEVS_EquMethod=4)\
							 & (($y_simbolosConversion->{$i}<$y_simbolosDesde->{$i})\
							 | ($y_simbolosConversion->{$i}>$y_simbolosHasta->{$i})))  // valor establecido manualmente
							
							  // si el valor establecido manualmente esta fuera del rango lo restablezco asignando el valor superior superior del rango (el mas favorable al alumno
							$y_simbolosConversion->{$i}:=$y_simbolosHasta->{$i}
							
							  //________________________________________
						: ($y_simbolosConversion->{$i}>$y_simbolosHasta->{$i})
							
							$y_simbolosConversion->{$i}:=$y_simbolosHasta->{$i}
							
							  //________________________________________
					End case 
				End if 
				
				If ($b_escala_a_Porcentaje)
					
					$y_simbolosDesdePct->{$i}:=Round:C94($y_simbolosDesde->{$i}/$r_maximoEscala*100;1)
					$y_simbolosHastaPct->{$i}:=Round:C94($y_simbolosHasta->{$i}/$r_maximoEscala*100;1)
					$y_simbolosDesde->{$i}:=$y_simbolosDesdePct->{$i}
					$y_simbolosHasta->{$i}:=$y_simbolosHastaPct->{$i}
					$y_simbolosConversion->{$i}:=aSymbPctEqu{$i}
					aSymbPctEqu{$i}:=Round:C94($y_simbolosConversion->{$i}/$r_maximoEscala*100;1)
					
				Else 
					
					$y_simbolosDesdePct->{$i}:=Round:C94($y_simbolosDesde->{$i}/$r_maximoEscala*100;11)
					$y_simbolosHastaPct->{$i}:=Round:C94($y_simbolosHasta->{$i}/$r_maximoEscala*100;11)
					  //MONO (Ticket 193805) Para reparación de estilos con conversión, creo que se da por un error de los rango que en v11 cuando un desde es menor que su siguiente hasta en los reales. mas adelante sólo consideramos desde el segundo elemento.
					If ($y_simbolosConversion->{$i}<$y_simbolosHasta->{$i})
						$y_simbolosConversion->{$i}:=$y_simbolosHasta->{$i}
					End if 
					aSymbPctEqu{$i}:=Round:C94($y_simbolosConversion->{$i}/$r_maximoEscala*100;11)
					
				End if 
			End for 
			
			  // me aseguro que el primer valor de conversión al simbolo sea igual al mínimo de la escala y el último al máximo de la escala
			$y_simbolosDesde->{1}:=$r_minimoEscala
			$y_simbolosHasta->{$l_itemsEscala}:=$r_maximoEscala
			
			  //$y_simbolosDesdePct->{1}:=1
			$y_simbolosDesdePct->{1}:=Round:C94($r_minimoEscala/$r_maximoEscala*100;11)
			$y_simbolosHastaPct->{$l_itemsEscala}:=100
			
			If ($b_escala_a_Porcentaje)
				
				$y_simbolosDesde:=->aSymbPctFrom
				$y_simbolosHasta:=->aSymbPctTo
				$y_simbolosConversion:=->aSymbPctEqu
				$r_minimoEscala:=1
				$r_maximoEscala:=100
				$l_decimales:=1
				$r_minimoAprobatorio:=rAprobatorioPorcentaje
				
			End if 
			
			  // elimino el rango desde 0% a 0% conversiones a simbolos en escalas con evaluación en % (el mínimo es 1, el máximo 500)
			For ($i;Size of array:C274($y_simbolosSimbolo->);1;-1)
				
				If (iEvaluationMode=Porcentaje)
					
					If (($y_simbolosDesdePct->{$i}<$r_minimoEscala)\
						 & ($y_simbolosHastaPct->{$i}<$r_minimoEscala))
						
						  //NOTIFICAR ELIMINACION DE RANGO en TABLA DE CONVERSION DE SIMBOLOS
						If ($b_estiloEnUso)
							
							APPEND TO ARRAY:C911($at_estilos;[xxSTR_EstilosEvaluacion:44]Name:2)
							APPEND TO ARRAY:C911($at_simbolos;$y_simbolosSimbolo->{$i})
							APPEND TO ARRAY:C911($at_Error;"Rango de 0% a 0%")
							APPEND TO ARRAY:C911($at_Correccion;"Símbolo eliminado")
							APPEND TO ARRAY:C911($at_EvalDesde;String:C10($y_simbolosDesde->{$i};"###0"+Choose:C955($l_decimales>0;<>tXS_RS_DecimalSeparator+("0"*$l_decimales);"")))
							APPEND TO ARRAY:C911($at_EvalHasta;String:C10($y_simbolosHasta->{$i};"###0"+Choose:C955($l_decimales>0;<>tXS_RS_DecimalSeparator+("0"*$l_decimales);"")))
							APPEND TO ARRAY:C911($at_PctDesde;String:C10($y_simbolosDesdePct->{$i};"##0"+<>tXS_RS_DecimalSeparator+("0"*11)))
							APPEND TO ARRAY:C911($at_PctHasta;String:C10($y_simbolosHastaPct->{$i};"##0"+<>tXS_RS_DecimalSeparator+("0"*11)))
							
						End if 
						
						AT_Delete ($i;1;$y_simbolosSimbolo;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosPctEqu)
						
					End if 
				End if 
			End for 
		End if 
		
		$l_ultimoElemento:=Size of array:C274($y_simbolosSimbolo->)
		
		If ($l_ultimoElemento>0)
			
			If ($y_simbolosHasta->{$l_ultimoElemento}<$r_maximoEscala)
				
				  // si la última fila de la tabla de conversión no incluye la evaluación máxinma en la escala agrego una fila a la escala
				  // y establezco el rango:
				  // - Desde = Hasta de la fila anterior + 1 intervalo
				  // - Hasta = máximo de la escala
				$l_ultimoElemento:=$l_ultimoElemento+1
				AT_RedimArrays ($l_ultimoElemento;$y_simbolosSimbolo;$y_simbolosDescripcion;$y_simbolosDesde;$y_simbolosHasta;$y_simbolosConversion;$y_simbolosDesdePct;$y_simbolosHastaPct;$y_simbolosPctEqu)
				$y_simbolosSimbolo->{$l_ultimoElemento}:="S"+String:C10($l_ultimoElemento;"000")
				$y_simbolosDescripcion->{$l_ultimoElemento}:="Símbolo #"+String:C10($l_ultimoElemento;"000")
				$y_simbolosDesde->{$l_ultimoElemento}:=$y_simbolosHasta->{$l_ultimoElemento-1}+(1/(10^iGradesDec))
				$y_simbolosHasta->{$l_ultimoElemento}:=rGradesTo
				$y_simbolosConversion->{$l_ultimoElemento}:=rGradesTo
				$y_simbolosDesdePct->{$l_ultimoElemento}:=Round:C94($y_simbolosDesde->{$l_ultimoElemento};11)
				$y_simbolosHastaPct->{$l_ultimoElemento}:=100
				$y_simbolosPctEqu->{$l_ultimoElemento}:=100
				
				  //NOTIFICAR ADICION DE RANGO A TABLA DE CONVERSION DE SIMBOLOS
				If ($b_estiloEnUso)
					
					APPEND TO ARRAY:C911($at_estilos;[xxSTR_EstilosEvaluacion:44]Name:2)
					APPEND TO ARRAY:C911($at_simbolos;$y_simbolosSimbolo->{$l_ultimoElemento})
					APPEND TO ARRAY:C911($at_Error;"Símbolo inexistente para un rango de equivalencias faltante")
					APPEND TO ARRAY:C911($at_Correccion;"Símbolo añadido")
					APPEND TO ARRAY:C911($at_EvalDesde;String:C10($y_simbolosDesde->{$l_ultimoElemento};"###0"+Choose:C955($l_decimales>0;<>tXS_RS_DecimalSeparator+("0"*$l_decimales);"")))
					APPEND TO ARRAY:C911($at_EvalHasta;String:C10($y_simbolosHasta->{$l_ultimoElemento};"###0"+Choose:C955($l_decimales>0;<>tXS_RS_DecimalSeparator+("0"*$l_decimales);"")))
					APPEND TO ARRAY:C911($at_PctDesde;String:C10($y_simbolosDesdePct->{$l_ultimoElemento};"##0"+<>tXS_RS_DecimalSeparator+("0"*11)))
					APPEND TO ARRAY:C911($at_PctHasta;String:C10($y_simbolosHastaPct->{$l_ultimoElemento};"##0"+<>tXS_RS_DecimalSeparator+("0"*11)))
					
				End if 
				
			Else 
				
			End if 
			
			  // me aseguro de que el primer elemento de la tabla de conversión comience con el mínimo de la escala de referencia
			Case of 
					
					  //________________________________________
				: ((iEvaluationMode=Notas)\
					 | ((iEvaluationMode=Simbolos)\
					 & (iPrintMode=Notas)))
					
					If ($y_simbolosDesde->{1}#rGradesFrom)
						
						$y_simbolosDesde->{1}:=rGradesFrom
						$y_simbolosDesdePct->{1}:=Round:C94($r_minimoEscala/rGradesTo*100;11)
						
					End if 
					
					  //________________________________________
				: ((iEvaluationMode=Puntos)\
					 | ((iEvaluationMode=Simbolos)\
					 & (iPrintMode=Puntos)))
					
					If ($y_simbolosDesde->{1}#rPointsFrom)
						
						$y_simbolosDesde->{1}:=rPointsFrom
						$y_simbolosDesdePct->{1}:=Round:C94($r_minimoEscala/rPointsTo*100;11)
						
					End if 
					
					  //________________________________________
				: ((iEvaluationMode=Porcentaje)\
					 | ((iEvaluationMode=Simbolos)\
					 & (iPrintMode=Simbolos)))
					
					$y_simbolosDesde->{1}:=1
					$y_simbolosDesdePct->{1}:=Round:C94($y_simbolosDesde->{1};11)
					
					  //________________________________________
			End case 
			
			$r_minimoDiferencia:=1/(10^$l_decimales)
			
			For ($i;1;Size of array:C274($y_simbolosSimbolo->)-1;1)
				
				$r_diferenciaDecimales:=$y_simbolosDesde->{$i+1}-$y_simbolosHasta->{$i}
				
				If ($r_diferenciaDecimales>$r_minimoDiferencia)
					
					$y_simbolosHasta->{$i}:=$y_simbolosDesde->{$i+1}-$r_minimoDiferencia
					$y_simbolosHastaPct->{$i}:=Round:C94($y_simbolosHasta->{$i}/$r_maximoEscala*100;11)
					$y_simbolosPctEqu->{$i}:=$y_simbolosHastaPct->{$i}
					
				End if 
			End for 
			
			AT_RedimArrays (0;->aSymbGradeFrom;->aSymbGradeTo;->aSymbGradesEqu;->aSymbPointsFrom;->aSymbPointsTo;->aSymbPointsEqu)
			AT_RedimArrays (Size of array:C274(aSymbPctFrom);->aSymbGradeFrom;->aSymbGradeTo;->aSymbGradesEqu;->aSymbPointsFrom;->aSymbPointsTo;->aSymbPointsEqu)
			$l_decimalesNotas:=MATH_Max (iGradesDec;iGradesPP;iGradesPF;iGradesNF;iGradesNO)
			$l_decimalesPuntos:=MATH_Max (iPointsDec;iPointsPP;iPointsPF;iPointsNF;iPointsNO)
			
			For ($i;1;Size of array:C274(aSymbPctFrom);1)
				
				aSymbGradeFrom{$i}:=Round:C94(rGradesTo*aSymbPctFrom{$i}/100;$l_decimalesNotas)
				aSymbGradeTo{$i}:=Round:C94(rGradesTo*aSymbPctTo{$i}/100;$l_decimalesNotas)
				aSymbGradesEqu{$i}:=Round:C94(rGradesTo*aSymbPctEqu{$i}/100;$l_decimalesNotas)
				aSymbPointsFrom{$i}:=Round:C94(rPointsTo*aSymbPctFrom{$i}/100;$l_decimalesNotas)
				aSymbPointsTo{$i}:=Round:C94(rPointsTo*aSymbPctTo{$i}/100;$l_decimalesNotas)
				aSymbPointsEqu{$i}:=Round:C94(rPointsTo*aSymbPctEqu{$i}/100;$l_decimalesNotas)
				
			End for 
			
			If (vi_SinReprobacion=1)
				
				If (Size of array:C274(aSymbPctFrom)>0)
					
					rPctMinimum:=aSymbPctFrom{1}
					rGradesMinimum:=Round:C94(aSymbGradeFrom{1};iGradesDec)
					rPointsMinimum:=Round:C94(aSymbGradeFrom{1};iPointsDec)
					
				Else 
					
					rPctMinimum:=0
					rGradesMinimum:=0
					rPointsMinimum:=0
					
				End if 
				
			Else 
				
				$l_index:=Find in array:C230(aSymbol;sSymbolMinimum)
				
				If ($l_index>0)
					
					rPctMinimum:=aSymbPctFrom{$l_index}
					rGradesMinimum:=Round:C94(aSymbGradeFrom{$l_index};iGradesDec)
					rPointsMinimum:=Round:C94(aSymbGradeFrom{$l_index};iPointsDec)
					
				End if 
			End if 
			
			EVS_WriteStyleData 
			
		End if 
	End if 
	
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"")
	
End for 

$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

If (Size of array:C274($at_error)>0)
	
	AT_AppendItems2TextArray (->$at_TitulosColumnas;"Error";"Estilo";"Simbolo";"Correccion";"Desde";"Hasta";"Desde%";"Hasta%")
	$t_encabezado:="Verificación símbolos en estilos de evaluación"
	$t_descripcion:="Durante la actualización se detectaron inconsistencias en la tabla de conversión a símbolos en algunos estilos de evaluación"
	$t_uuid:=NTC_CreaMensaje ("SchoolTrack";$t_Encabezado;$t_descripcion)
	NTC_Mensaje_Arreglos ($t_uuid;->$at_TitulosColumnas;->$at_error;->$at_estilos;->$at_simbolos;->$at_Correccion;->$at_EvalDesde;->$at_EvalHasta;->$at_PctDesde;->$at_PctHasta)
	
End if 

READ WRITE:C146([MPA_DefinicionCompetencias:187])

For ($i_registros;1;Size of array:C274($al_recNumCompetencias);1)
	
	GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNumCompetencias{$i_registros})
	EVS_ReadStyleData ([MPA_DefinicionCompetencias:187]EstiloEvaluacion:7)
	$r_real:=EV2_Simbolo_a_Real ($at_simboloAprobacion{$i_registros})
	
	If ($r_real#[MPA_DefinicionCompetencias:187]PctParaAprobacion:22)
		
		[MPA_DefinicionCompetencias:187]PctParaAprobacion:22:=$r_real
		SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		
	End if 
End for 