//%attributes = {}
  // MPAcfg_Dim_NivelesAplicacion()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 01/08/12, 09:57:28
  // ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($i;$iCompetencias;$iDimensiones;$iNiveles;$l_indexNivel;$l_nivelNumero;$l_nivelSeleccionado;$l_numeroNivelEnLista;$l_objetos;$l_resultado)
C_LONGINT:C283($l_transaccionOK)

ARRAY LONGINT:C221($al_recNumObjetos;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_Dim_NivelesAplicacion ;$0)
End if 

  // CÓDIGO
$l_numeroNivelEnLista:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{<>al_NumeroNivelesActivos})

If (vl_AplicaEnNiveles ?? $l_numeroNivelEnLista)  // (la variable vl_AplicaEnNiveles tiene asignado el valor del campo [MPA_DefinicionDimensiones]BitsNiveles)
	  // La dimensión aplica actualmente en el nivel seleccionado...
	
	  // busco los enunciados (dimensiones y competencias asociadas) utilizados en matrices y los pongo en un conjunto
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=[MPA_DefinicionDimensiones:188]ID:1)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=<>al_NumeroNivelesActivos{<>al_NumeroNivelesActivos})
	CREATE SET:C116([MPA_ObjetosMatriz:204];"$Objetos")
	$l_objetos:=Records in set:C195("$Objetos")
	
	
	  // busco las competencias asociadas a la dimensión que aplican en el nivel y las pongo en un conjunto
	QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=[MPA_DefinicionDimensiones:188]ID:1)
	QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_numeroNivelEnLista)
	CREATE SET:C116([MPA_DefinicionCompetencias:187];"$Competencias")
	
	  // busco los registros de evaluación de aprendizajes (dimensiones y competencias asociadas) correspondientes a la dimensión
	  // y los pongo en un conjunto
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=[MPA_DefinicionDimensiones:188]ID:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos:2]nivel_numero:29=<>al_NumeroNivelesActivos{<>al_NumeroNivelesActivos})
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"$Aprendizajes")
	QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
	  // determino si hay registros evaluados
	  // la variable vl_RegistrosEvaluados es utilizada en el diálogo de confirmación ([MPA_DefinicionAreas];"OpcionesNiveles")
	vl_RegistrosEvaluados:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	
	
	  // conservo en un conjunto las matrices que resultarán modificadas y que podrían requerir recalculo
	USE SET:C118("$Objetos")
	KRL_RelateSelection (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[MPA_ObjetosMatriz:204]ID_Matriz:1)
	CREATE SET:C116([MPA_AsignaturasMatrices:189];"$matricesModificadas")
	
	$l_resultado:=1
	vt_RetiroNivel:="Inhabilitar Dimensión de aprendizaje en "+<>at_NombreNivelesActivos{<>al_NumeroNivelesActivos}
	
	$l_transaccionOK:=1
	If ($l_objetos>0)
		  // si hay enunciados asociados a la dimensión utilizados en matrices de evaluación
		  // muestro el diálogo de confirmación al usuario
		  // el usuario puede optar por eliminar los enunciados asociados ala dimensión en las matrices
		  //  o desvincular las competencias del eje (dejándolas asociadas directamente al área);
		  // Si opta por desvincular las dimensiones son eliminadas en las matrices (no pueden no estar asociadas a un Eje)
		WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"OpcionesNiveles";7;32)
		DIALOG:C40([MPA_DefinicionAreas:186];"OpcionesNiveles")
		CLOSE WINDOW:C154
		
		If ((bDelete=0) & (bDesvincular=0))
			  //el usuario cancela la operación
			$l_transaccionOK:=0
			CANCEL:C270
			
		Else 
			
			START TRANSACTION:C239
			  // apago el bit en la variable (copia del campo [MPA_DefinicionEjes]BitsNiveles)
			vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?- $l_numeroNivelEnLista
			Case of 
				: (bDelete=1)
					  //elimino los registros de aprendizajes que corresponden al eje inhabilitado y sus dependencias
					USE SET:C118("$Aprendizajes")
					$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
					  //elimino los objetos de las matrices que corresponden al eje inhabilitado
					If ($l_transaccionOK=1)
						USE SET:C118("$Objetos")
						$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
					End if 
					
				: (bDesvincular=1)
					  //desvinculos los aprendizajes del eje inhabilitado
					USE SET:C118("$Aprendizajes")
					ARRAY LONGINT:C221($aZero;Records in set:C195("$Aprendizajes"))
					$l_transaccionOK:=KRL_Array2Selection (->$aZero;->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
					If ($l_transaccionOK=1)
						$l_transaccionOK:=KRL_Array2Selection (->$aZero;->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
					End if 
					
					  //elimino en las matrices las dimensiones asociadas al eje en el nivel inhabilitado
					If ($l_transaccionOK=1)
						USE SET:C118("$Objetos")
						QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
						CREATE SET:C116([MPA_ObjetosMatriz:204];"$dimensionesMatrices")
						DIFFERENCE:C122("$Objetos";"$dimensionesMatrices";"$Objetos")
						USE SET:C118("$dimensionesMatrices")
						$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
					End if 
					
					  //desvinculo las competencias de las matrices del eje inhabilitado
					If ($l_transaccionOK=1)
						USE SET:C118("$Objetos")
						ARRAY LONGINT:C221($aZero;Records in set:C195("$Objetos"))
						$l_transaccionOK:=KRL_Array2Selection (->$aZero;->[MPA_ObjetosMatriz:204]ID_Eje:3;->$aZero;->[MPA_ObjetosMatriz:204]ID_Dimension:4)
					End if 
			End case 
		End if 
	Else 
		  // no hay dimensiones ni competencias asociadas asignadas a matrices de evaluación
		START TRANSACTION:C239
		  // apago el bit en la variable (copia del campo [MPA_DefinicionEjes]BitsNiveles)
		vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?- $l_numeroNivelEnLista
		
	End if 
	
	
	
	If ($l_transaccionOK=1)
		vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?- $l_numeroNivelEnLista
		USE SET:C118("$competencias")
		LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$al_recNumObjetos;"")
		For ($iCompetencias;1;Size of array:C274($al_recNumObjetos))
			READ WRITE:C146([MPA_DefinicionCompetencias:187])
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$al_recNumObjetos{$iCompetencias};True:C214)
			If (OK=1)
				  // apago en las competencias los bits que no están encendidos en en la dimensión de la que depende
				For ($iNiveles;1;24)
					If (([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $iNiveles) & (Not:C34(vl_AplicaEnNiveles ?? $iNiveles)))
						[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?- $iNiveles
					End if 
				End for 
				
				  // si la competencia estaba habilitada en una etapa que incluía el nivel que se inhabilita
				  // desasigno la etapa y especifico que la competencia está asociada a niveles, no a una etapa
				For ($i;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13)
					$l_indexNivel:=Find in array:C230(<>aNivNo;$i)
					If (Not:C34([MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel))
						[MPA_DefinicionCompetencias:187]DesdeGrado:5:=999
						[MPA_DefinicionCompetencias:187]HastaGrado:13:=999
						[MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4:=0
					End if 
				End for 
				SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
				
			Else 
				$iCompetencias:=Size of array:C274($al_recNumObjetos)
				$l_transaccionOK:=0
			End if 
		End for 
	End if 
	
	If ($l_transaccionOK=1)
		[MPA_DefinicionDimensiones:188]BitsNiveles:21:=vl_AplicaEnNiveles
		If (Not:C34(Is new record:C668([MPA_DefinicionDimensiones:188])))
			SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
		End if 
		VALIDATE TRANSACTION:C240
		UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
	Else 
		vl_AplicaEnNiveles:=[MPA_DefinicionDimensiones:188]BitsNiveles:21  // reestablezco el valor de [MPA_DefinicionDimensiones]BitsNiveles en la variable
		CANCEL TRANSACTION:C241
	End if 
	
Else 
	  // El Eje NO aplica actualmente en el nivel seleccionado...
	  //   enciendo el bit que indica aplicación en ese nivel
	If ([MPA_DefinicionDimensiones:188]ID_Eje:3#0)
		$l_bitsNivelesEje:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionDimensiones:188]ID_Eje:3;->[MPA_DefinicionEjes:185]BitsNiveles:20)
		If ($l_bitsNivelesEje ?? $l_numeroNivelEnLista)
			vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?+ $l_numeroNivelEnLista
			[MPA_DefinicionDimensiones:188]BitsNiveles:21:=vl_AplicaEnNiveles
			If (Not:C34(Is new record:C668([MPA_DefinicionDimensiones:188])))
				SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
			End if 
		Else 
			$t_mensaje:=__ ("El eje de aprendizaje del que depende esta dimensión no está habilitado para ^0.\r\rNo es posible habilitar la Dimensión de aprendizaje en este nivel.")
			CD_Dlog (0;Replace string:C233($t_mensaje;"^0";<>at_NombreNivelesActivos{<>al_NumeroNivelesActivos}))
		End if 
	Else 
		$l_EtapaNivel:=0
		For ($i;1;Size of array:C274(alMPA_NivelDesde))
			If ((<>al_NumeroNivelesActivos{<>al_NumeroNivelesActivos}>=alMPA_NivelDesde{$i}) & (<>al_NumeroNivelesActivos{<>al_NumeroNivelesActivos}<=alMPA_NivelHasta{$i}))
				$l_EtapaNivel:=$i
				$i:=Size of array:C274(alMPA_NivelDesde)
			End if 
		End for 
		If ($l_EtapaNivel<=0)
			$t_mensaje:=__ ("El área no esta configurada para ser utilizada en ^0.\r\rNo es posible habilitar la Dimensión de aprendizaje en este nivel.")
			CD_Dlog (0;Replace string:C233($t_mensaje;"^0";<>at_NombreNivelesActivos{<>al_NumeroNivelesActivos}))
		Else 
			vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?+ $l_numeroNivelEnLista
			[MPA_DefinicionDimensiones:188]BitsNiveles:21:=vl_AplicaEnNiveles
			If (Not:C34(Is new record:C668([MPA_DefinicionDimensiones:188])))
				SAVE RECORD:C53([MPA_DefinicionDimensiones:188])
			End if 
		End if 
	End if 
End if 

$0:=$l_transaccionOK
