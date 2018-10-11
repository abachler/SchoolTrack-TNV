//%attributes = {}
  // MÉTODO: MPAcfg_Area_CambiaLimitesEtapa
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 10/01/12, 17:01:13
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Este metodo es llamado desde el formulario de definición del area
  // cuando se modifica el nivel en que inicia o termina la etapa en edición entre las etapas del area
  //
  // PARÁMETROS
  // MPAcfg_Area_CambiaLimitesEtapa()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)

C_LONGINT:C283($i;$l_aprendizajesEvaluados;$l_bitNiveles;$l_cambiaA_desdeNivel;$l_cambiaA_hastaNivel;$l_idArea;$l_indexNivel;$l_numeroCompetencias;$l_numeroDimensiones;$l_numeroEjes)
C_LONGINT:C283($l_numeroNivel;$l_objetosEnMatriz;$l_recNumAreaAprendizaje;$l_respuestaUsuario;$l_transaccionOK;$l_Uno)
C_TEXT:C284($t_textoEventoLog)

ARRAY LONGINT:C221($al_IDAsignaturas;0)
ARRAY LONGINT:C221($al_recNumAsignaturas;0)
ARRAY LONGINT:C221($al_recNumObjetos;0)
ARRAY LONGINT:C221($l_actual_DesdeNivel;0)
ARRAY LONGINT:C221($l_actual_HastaNivel;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_Area_CambiaLimitesEtapa ;$0)
	C_LONGINT:C283(MPAcfg_Area_CambiaLimitesEtapa ;$1)
	C_LONGINT:C283(MPAcfg_Area_CambiaLimitesEtapa ;$2)
	C_LONGINT:C283(MPAcfg_Area_CambiaLimitesEtapa ;$3)
	C_LONGINT:C283(MPAcfg_Area_CambiaLimitesEtapa ;$4)
	C_LONGINT:C283(MPAcfg_Area_CambiaLimitesEtapa ;$5)
End if 

  // CODIGO PRINCIPAL
$l_idArea:=$1
$l_actual_DesdeNivel:=$2
$l_actual_HastaNivel:=$3
$l_cambiaA_desdeNivel:=$4
$l_cambiaA_hastaNivel:=$5

  // busco las matrices de evaluaciones existentes en el rango de niveles definidos para la etapa actualmente (antes del cambio)
QUERY:C277([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]ID_Area:22=$l_idArea;*)
QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4>=$l_actual_DesdeNivel;*)
QUERY:C277([MPA_AsignaturasMatrices:189]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4<=$l_actual_hastaNivel)
CREATE SET:C116([MPA_AsignaturasMatrices:189];"$MatricesActuales")

  // busco las matrices de evaluaciones existentes en niveles que quedarán fuera del rango de niveles de aplicación después del cambio de limites de la etapa
SET_UseSet ("$MatricesActuales")
SELECTION TO ARRAY:C260([MPA_AsignaturasMatrices:189]NumeroNivel:4;$al_Niveles;[MPA_AsignaturasMatrices:189]NombreMatriz:2;$at_nombres)
QUERY SELECTION:C341([MPA_AsignaturasMatrices:189];[MPA_AsignaturasMatrices:189]NumeroNivel:4;<;$l_cambiaA_desdeNivel;*)
QUERY SELECTION:C341([MPA_AsignaturasMatrices:189]; | ;[MPA_AsignaturasMatrices:189]NumeroNivel:4;>;$l_cambiaA_hastaNivel)
CREATE SET:C116([MPA_AsignaturasMatrices:189];"$MatricesFueraRango")

  // creo un conjunto con las asignaciones de Ejes Dimensiones y competencias de matrices que quedarán fuera del rango de niveles de aplicación después del cambio de limites de la etapa
SET_UseSet ("$MatricesFueraRango")
KRL_RelateSelection (->[MPA_ObjetosMatriz:204]ID_Matriz:1;->[MPA_AsignaturasMatrices:189]ID_Matriz:1)
CREATE SET:C116([MPA_ObjetosMatriz:204];"$Objetos_MatricesFueraRango")
$l_objetosEnMatriz:=Records in set:C195("$Objetos_MatricesFueraRango")  // asigno el número de objetos a una variable

  // creo un conjunto con los registros de evaluación de Ejes Dimensiones y competencias de matrices que quedarán fuera del rango de niveles de aplicación después del cambio de limites de la etapa
SET_UseSet ("$MatricesFueraRango")
KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2;->[MPA_AsignaturasMatrices:189]ID_Matriz:1;"")
CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$evaluaciones")

  // creo un conjunto con los registros de Definicion de Ejes de aprendizaje que quedarán fuera del rango niveles de aplicación después del cambio de limites de la etapa
QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_idArea;*)
QUERY:C277([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]DesdeGrado:4>=$l_actual_DesdeNivel;*)
QUERY:C277([MPA_DefinicionEjes:185]; & [MPA_DefinicionEjes:185]HastaGrado:5<=$l_actual_HastaNivel)
CREATE SET:C116([MPA_DefinicionEjes:185];"$Ejes")

  // creo un conjunto con los registros de Definicion de Dimensiones de aprendizaje que quedarán fuera del rango niveles de aplicación después del cambio de limites de la etapa
QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_idArea;*)
QUERY:C277([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]DesdeGrado:6>=$l_actual_DesdeNivel;*)
QUERY:C277([MPA_DefinicionDimensiones:188]; & [MPA_DefinicionDimensiones:188]HastaGrado:7<=$l_actual_HastaNivel)
CREATE SET:C116([MPA_DefinicionDimensiones:188];"$Dimensiones")

  // creo un conjunto con los registros de Definicion de Competencias que quedarán fuera del rango niveles de aplicación después del cambio de limites de la etapa
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_idArea;*)
QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]DesdeGrado:5>=$l_actual_DesdeNivel;*)
QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]HastaGrado:13<=$l_actual_HastaNivel)
CREATE SET:C116([MPA_DefinicionCompetencias:187];"$Competencias")

$l_numeroEjes:=Records in set:C195("$Ejes")
$l_numeroDimensiones:=Records in set:C195("$Dimensiones")
$l_numeroCompetencias:=Records in set:C195("$Competencias")

  // busco los registros de evaluación de aprendizajes efectivamente evaluados y almaceno el número de registros en una variable
SET_UseSet ("$evaluaciones")
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_aprendizajesEvaluados)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0;*)
QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Año:77=<>gYear)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If (($l_actual_DesdeNivel<$l_cambiaA_desdeNivel) | ($l_actual_HastaNivel>$l_cambiaA_hastaNivel))
	  // si el cambio de los limites de la etapa excluye uno o más niveles, es decir
	  // - si el limite inferior de la etapa es más alto que el límite actual
	  // - si el limite superior es mas bajo que el límite actual
	
	Case of 
			  // Si hay registros de evaluación de aprendizajes efectivamente evaluados advertimos al usuario que los aprendizajes evaluados y las as¡gnaciones a matrices
			  // en los niveles que quedan excluidos de la etapa en esos niveles serán eliminados
		: ($l_aprendizajesEvaluados>0)
			$l_respuestaUsuario:=CD_Dlog (0;Replace string:C233(__ ("Se han registrado ^0 evaluaciones en Ejes, Dimensiones y Competencias en los niveles o grados académicos que usted desea excluir de la etapa seleccionada.\r");__ ("^0");String:C10($l_aprendizajesEvaluados))+__ ("\rPuede eliminar las evaluaciones registradas o bien asignar los Ejes, Dimensiones y Competencias de esta etapa a todas las etapas.\r\r")+__ ("¿Que desea hacer?");"";__ ("Cancelar");__ ("Asignar a todas las etapas");__ ("Eliminar evaluaciones"))
			
		: ($l_objetosEnMatriz>0)
			  // Si NO hay registros de evaluación de aprendizajes efectivamente evaluados advertimos al usuario que las as¡gnaciones a de ejes, dimensiones y competencias a matrices
			  // en los niveles que quedan excluidos de la etapa en esos niveles serán eliminados
			$l_respuestaUsuario:=CD_Dlog (0;Replace string:C233(__ ("^0 Ejes, Dimensiones y Competencias afectados por el cambio de etapa son utilizados en algunas matrices de  matrices de evaluación de las asignaturas del área.\r");__ ("^0");String:C10($l_objetosEnMatriz))+__ ("\rPuede retirar los Ejes, Dimensiones y Competencias de las matrices que los utilizan en los niveles que desea excluir de la etapa o bien asignarlos a todas las etapas.\r\r")+__ ("¿Que desea hacer?");"";__ ("Cancelar");__ ("Asignar a todas las etapas");__ ("Retirar de matrices"))
			
		Else 
			$l_respuestaUsuario:=3
	End case 
	
	
Else 
	  // los limites de la etapa se amplían
	  // no es necesario advertir al usuario, no hay eliminación de ningún registro
	  // si la opción de actualización automática de las matrices está activada necesitamos que la variable $l_transaccionOK tome valor 1 para 
	  // que la actualización se ejecute al final de este método
	$l_transaccionOK:=1
	$l_objetosEnMatriz:=0
	$l_aprendizajesEvaluados:=0
	$l_respuestaUsuario:=3
End if 




If ($l_respuestaUsuario>1)
	START TRANSACTION:C239
	Case of 
			
		: ($l_respuestaUsuario=2)
			  //el usuario respondió que se ampliara la aplicación de los ejes, dimensiones y competencias del rango de niveles de la etapa a actual a todos los niveles en que se imparten las asignaturas del area
			  // esto no afecta las evaluaciones registradas ni las asignaciones a matrices de evaluacion
			
			  //enciendo en un entero largo los bits correspondientes a todos los niveles
			$l_bitNiveles:=0
			For ($i;1;24)
				$l_indexNivel:=$i
				$l_bitNiveles:=$l_bitNiveles ?+ $l_indexNivel
			End for 
			
			  // ampliamos el rango de aplicación de los ejes definidos en la etapa actual a a todos los niveles en que se imparten las asignaturas del area
			SET_UseSet ("$Ejes")
			ARRAY LONGINT:C221($al_Zero;$l_numeroEjes)
			ARRAY LONGINT:C221($al_Cien;$l_numeroEjes)
			ARRAY LONGINT:C221($al_BitNiveles;$l_numeroEjes)
			$l_numeroNivel:=-100
			AT_Populate (->$al_Cien;->$l_numeroNivel)
			AT_Populate (->$al_BitNiveles;->$l_bitNiveles)
			$l_transaccionOK:=KRL_Array2Selection (->$al_Cien;->[MPA_DefinicionEjes:185]DesdeGrado:4;->$al_Cien;->[MPA_DefinicionEjes:185]HastaGrado:5;->$al_Zero;->[MPA_DefinicionEjes:185]Asignado_a_Etapa:19;->$al_BitNiveles;->[MPA_DefinicionEjes:185]BitsNiveles:20)
			
			If ($l_transaccionOK=1)
				  // ampliamos el rango de aplicación de las dimensiones definidas en la etapa actual a a todos los niveles en que se imparten las asignaturas del area
				SET_UseSet ("$Dimensiones")
				ARRAY LONGINT:C221($al_Zero;$l_numeroDimensiones)
				ARRAY LONGINT:C221($al_Cien;$l_numeroDimensiones)
				ARRAY LONGINT:C221($al_BitNiveles;$l_numeroDimensiones)
				$l_numeroNivel:=-100
				AT_Populate (->$al_Cien;->$l_numeroNivel)
				$l_transaccionOK:=KRL_Array2Selection (->$al_Cien;->[MPA_DefinicionDimensiones:188]DesdeGrado:6;->$al_Cien;->[MPA_DefinicionDimensiones:188]HastaGrado:7;->$al_Zero;->[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5;->$al_BitNiveles;->[MPA_DefinicionDimensiones:188]BitsNiveles:21)
			End if 
			
			If ($l_transaccionOK=1)
				  // ampliamos el rango de aplicación de las competencias definidas en la etapa actual a todas a todos los niveles en que se imparten las asignaturas del area
				SET_UseSet ("$Competencias")
				ARRAY LONGINT:C221($al_Zero;$l_numeroCompetencias)
				ARRAY LONGINT:C221($al_Cien;$l_numeroCompetencias)
				ARRAY LONGINT:C221($al_BitNiveles;$l_numeroCompetencias)
				$l_numeroNivel:=-100
				AT_Populate (->$al_Cien;->$l_numeroNivel)
				AT_Populate (->$al_BitNiveles;->$l_bitNiveles)
				$l_transaccionOK:=KRL_Array2Selection (->$al_Cien;->[MPA_DefinicionCompetencias:187]DesdeGrado:5;->$al_Cien;->[MPA_DefinicionCompetencias:187]HastaGrado:13;->$al_Zero;->[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4;->$al_BitNiveles;->[MPA_DefinicionCompetencias:187]BitNiveles:28)
			End if 
			
			If ($l_transaccionOK=1)
				$t_textoEventoLog:=__ ("Los Ejes, Dimensiones y Competencias del área ^0 fueron retirados de las matrices que los utilizaban bajo el nivel ^1 y sobre el nivel ^2. ")
				$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^0";[MPA_DefinicionAreas:186]AreaAsignatura:4)
				$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^1";String:C10($l_cambiaA_desdeNivel))
				$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^2";String:C10($l_cambiaA_hastaNivel))
				LOG_RegisterEvt ($t_textoEventoLog)
				OK:=1
			End if 
			
		: ($l_respuestaUsuario=3)
			  // el rango de niveles de de aplicación de los ejes, dimensiones y aprendizaje es modificado respetando el rango definido en la etapa
			  // Las eventuales evaluaciones o asignaciones a matrices en niveles que quedan fuera del rango definido serán eliminadas de acuerdo a lo solicitado por el usuario
			
			  //enciendo en un entero largo los bits correspondientes a los niveles de aplicación definidos en la etapa
			$l_bitNiveles:=0
			For ($i;$l_cambiaA_desdeNivel;$l_cambiaA_hastaNivel)
				$l_indexNivel:=Find in array:C230(<>aNivNo;$i)
				$l_bitNiveles:=$l_bitNiveles ?+ $l_indexNivel
			End for 
			
			  // eliminamos los objetos en las matrices de los niveles que quedan fueran del rango definido en la etapa
			SET_UseSet ("$Objetos_MatricesFueraRango")
			$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
			
			  // eliminamos las evaluaciones de los ejes, dimensiones y competencias que quedan fuera de los niveles que quedan fueran del rango definido en la etapa
			If ($l_transaccionOK=1)
				SET_UseSet ("$Evaluaciones")
				DISTINCT VALUES:C339([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;$al_IDAsignaturas)
				$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
			End if 
			
			If ($l_transaccionOK=1)
				SET_UseSet ("$Ejes")
				ARRAY LONGINT:C221($al_Desde;$l_numeroEjes)
				ARRAY LONGINT:C221($al_Hasta;$l_numeroEjes)
				ARRAY LONGINT:C221($al_Uno;$l_numeroEjes)
				ARRAY LONGINT:C221($al_BitNiveles;$l_numeroEjes)
				$l_Uno:=1
				AT_Populate (->$al_Desde;->$l_cambiaA_desdeNivel)
				AT_Populate (->$al_Hasta;->$l_cambiaA_hastaNivel)
				AT_Populate (->$al_Uno;->$l_Uno)
				AT_Populate (->$al_BitNiveles;->$l_bitNiveles)
				$l_transaccionOK:=KRL_Array2Selection (->$al_Desde;->[MPA_DefinicionEjes:185]DesdeGrado:4;->$al_Hasta;->[MPA_DefinicionEjes:185]HastaGrado:5;->$al_Uno;->[MPA_DefinicionEjes:185]Asignado_a_Etapa:19;->$al_BitNiveles;->[MPA_DefinicionEjes:185]BitsNiveles:20)
			End if 
			
			If (OK=1)
				SET_UseSet ("$Dimensiones")
				ARRAY LONGINT:C221($al_Desde;$l_numeroDimensiones)
				ARRAY LONGINT:C221($al_Hasta;$l_numeroDimensiones)
				ARRAY LONGINT:C221($al_Uno;$l_numeroDimensiones)
				ARRAY LONGINT:C221($al_BitNiveles;$l_numeroDimensiones)
				AT_Populate (->$al_Desde;->$l_cambiaA_desdeNivel)
				AT_Populate (->$al_Hasta;->$l_cambiaA_hastaNivel)
				AT_Populate (->$al_Uno;->$l_Uno)
				AT_Populate (->$al_BitNiveles;->$l_bitNiveles)
				$l_transaccionOK:=KRL_Array2Selection (->$al_Desde;->[MPA_DefinicionDimensiones:188]DesdeGrado:6;->$al_Hasta;->[MPA_DefinicionDimensiones:188]HastaGrado:7;->$al_Uno;->[MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5;->$al_BitNiveles;->[MPA_DefinicionDimensiones:188]BitsNiveles:21)
			End if 
			
			If ($l_transaccionOK=1)
				SET_UseSet ("$Competencias")
				ARRAY LONGINT:C221($al_Desde;$l_numeroCompetencias)
				ARRAY LONGINT:C221($al_Hasta;$l_numeroCompetencias)
				ARRAY LONGINT:C221($al_Uno;$l_numeroCompetencias)
				ARRAY LONGINT:C221($al_BitNiveles;$l_numeroCompetencias)
				$l_Uno:=1
				AT_Populate (->$al_Desde;->$l_cambiaA_desdeNivel)
				AT_Populate (->$al_Hasta;->$l_cambiaA_hastaNivel)
				AT_Populate (->$al_Uno;->$l_Uno)
				AT_Populate (->$al_BitNiveles;->$l_bitNiveles)
				$l_transaccionOK:=KRL_Array2Selection (->$al_Desde;->[MPA_DefinicionCompetencias:187]DesdeGrado:5;->$al_Hasta;->[MPA_DefinicionCompetencias:187]HastaGrado:13;->$al_Uno;->[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4;->$al_BitNiveles;->[MPA_DefinicionCompetencias:187]BitNiveles:28)
			End if 
			
			If (OK=1)
				$t_textoEventoLog:=__ ("Los Ejes, Dimensiones y Competencias del área ^0 fueron retirados de las matrices que los utilizaban bajo el nivel ^1 y sobre el nivel ^2. ")
				$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^0";[MPA_DefinicionAreas:186]AreaAsignatura:4)
				$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^1";String:C10($l_cambiaA_desdeNivel))
				$t_textoEventoLog:=Replace string:C233($t_textoEventoLog;"^2";String:C10($l_cambiaA_hastaNivel))
				
				$t_textoEventoLog:=$t_textoEventoLog+__ ("Las evaluaciones registradas en esos niveles en esos ítems fueron eliminadas previa confirmación del usuario.")
				LOG_RegisterEvt ($t_textoEventoLog)
			End if 
	End case 
	
	If ($l_transaccionOK=1)
		  // combino el conjunto de matrices modificadas por la eliminación del objeto
		  // con el conjunto "$matrices_a_recalcular" declarado en MPAcfg_Configuracion
		MPAcfg_Area_AlGuardar 
		SAVE RECORD:C53([MPA_DefinicionAreas:186])
		UNION:C120("$matrices_a_recalcular";"$MatricesFueraRango";"$matrices_a_recalcular")
		VALIDATE TRANSACTION:C240
		
	Else 
		
		$t_mensaje:=__ ("No fue posible completar la modificación en los límites de la etapa")
		$t_mensaje:=$t_mensaje+"\r\r"+__ ("Registros asociados que debían ser modificados o eliminados se encuentran en uso en otros procesos.")
		$t_mensaje:=$t_mensaje+"\r\r"+__ ("Por favor intente nuevamente mas tarde.")
		CANCEL TRANSACTION:C241
		
	End if 
End if 

If (($l_transaccionOK=1) & (cb_AutoActualizaMatricesMPA=1))
	$l_recNumAreaAprendizaje:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;$l_idArea)
	If ($l_recNumAreaAprendizaje>=0)
		QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_idArea)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$al_recNumObjetos;"")
		For ($i;1;Size of array:C274($al_recNumObjetos))
			GOTO RECORD:C242([MPA_DefinicionEjes:185];$al_recNumObjetos{$i})
			MPAcfg_ActualizaMatrices ($l_recNumAreaAprendizaje;Eje_Aprendizaje;$l_cambiaA_desdeNivel;$l_cambiaA_hastaNivel;$al_recNumObjetos{$i};False:C215)
		End for 
		
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_idArea)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$al_recNumObjetos;"")
		For ($i;1;Size of array:C274($al_recNumObjetos))
			GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNumObjetos{$i})
			MPAcfg_ActualizaMatrices ($l_recNumAreaAprendizaje;Dimension_Aprendizaje;$l_cambiaA_desdeNivel;$l_cambiaA_hastaNivel;$al_recNumObjetos{$i};False:C215)
		End for 
		
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_idArea)
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNumObjetos;"")
		For ($i;1;Size of array:C274($al_recNumObjetos))
			GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNumObjetos{$i})
			MPAcfg_ActualizaMatrices ($l_recNumAreaAprendizaje;Logro_Aprendizaje;$l_cambiaA_desdeNivel;$l_cambiaA_hastaNivel;$al_recNumObjetos{$i};False:C215)
		End for 
	End if 
End if 

$0:=$l_transaccionOK
SET_ClearSets ("$ejes";"$Dimensiones";"$Competencias";"$Objetos_MatricesFueraRango";"$Evaluaciones";"$MatricesActuales";"$MatricesBajoRangoEtapa";"$MatricesSobreRangoEtapa";"$MatricesFueraRango")

