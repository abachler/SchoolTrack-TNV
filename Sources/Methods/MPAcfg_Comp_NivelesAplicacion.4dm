//%attributes = {}
  // MPAcfg_Comp_NivelesAplicacion()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 01/08/12, 10:01:35
  // ---------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($i;$iCompetencias;$iDimensiones;$iNiveles;$l_indexNivel;$l_nivelNumero;$l_nivelSeleccionado;$l_numeroNivelEnLista;$l_objetos;$l_resultado)
C_LONGINT:C283($l_transaccionOK)

ARRAY LONGINT:C221($al_recNumObjetos;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_Comp_NivelesAplicacion ;$0)
End if 

  // CÓDIGO
$l_numeroNivelEnLista:=Find in array:C230(<>aNivNo;<>al_NumeroNivelesActivos{<>al_NumeroNivelesActivos})

If (vl_AplicaEnNiveles ?? $l_numeroNivelEnLista)  // (la variable vl_AplicaEnNiveles tiene asignado el valor del campo [MPA_DefinicionCompetencias]BitsNiveles)
	  // La competencia aplica actualmente en el nivel seleccionado...
	
	  // busco los enunciados (competencias) utilizados en matrices y los pongo en un conjunto
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_DefinicionCompetencias:187]ID:1;*)
	QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_AsignaturasMatrices:189]NumeroNivel:4=<>al_NumeroNivelesActivos{<>al_NumeroNivelesActivos})
	CREATE SET:C116([MPA_ObjetosMatriz:204];"$Objetos")
	$l_objetos:=Records in set:C195("$Objetos")
	
	
	  // busco los registros de evaluación de aprendizajes (competencias) correspondientes a la competencia
	  // y los pongo en un conjunto
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_DefinicionCompetencias:187]ID:1;*)
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
	vt_RetiroNivel:="Inhabilitar Competencia en "+<>at_NombreNivelesActivos{<>al_NumeroNivelesActivos}
	
	$l_transaccionOK:=1
	If ($l_objetos>0)
		  // si hay enunciados asociados al eje utilizados en matrices de evaluación
		  // muestro el diálogo de confirmación al usuario
		  // el usuario puede optar por eliminar los enunciados asociados al eje en las matrices
		  //  o desvincular las competencias del eje (dejándolas asociadas directamente al área);
		  // Si opta por desvincular las dimensiones son eliminadas en las matrices (no pueden no estar asociadas a un Eje)
		
		WDW_OpenFormWindow (->[MPA_DefinicionAreas:186];"OpcionesNiveles";7;Movable form dialog box:K39:8)
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
			If (bDelete=1)
				  //elimino los registros de aprendizajes que corresponden al eje inhabilitado y sus dependencias
				USE SET:C118("$Aprendizajes")
				$l_transaccionOK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203])
				  //elimino los objetos de las matrices que corresponden al eje inhabilitado
				If ($l_transaccionOK=1)
					USE SET:C118("$Objetos")
					$l_transaccionOK:=KRL_DeleteSelection (->[MPA_ObjetosMatriz:204])
				End if 
				
			End if 
		End if 
	Else 
		  // la competencia no está asignada a ninguna matriz de evaluación
		START TRANSACTION:C239
		  // apago el bit en la variable (copia del campo [MPA_DefinicionEjes]BitsNiveles)
		vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?- $l_numeroNivelEnLista
		
	End if 
	
	
	
	If ($l_transaccionOK=1)
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
		If (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187])))
			SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		End if 
	End if 
	
	
	If ($l_transaccionOK=1)
		[MPA_DefinicionCompetencias:187]BitNiveles:28:=vl_AplicaEnNiveles
		If (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187])))
			SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
		End if 
		VALIDATE TRANSACTION:C240
		UNION:C120("$matrices_a_recalcular";"$matricesModificadas";"$matrices_a_recalcular")
	Else 
		vl_AplicaEnNiveles:=[MPA_DefinicionCompetencias:187]BitNiveles:28  // reestablezco el valor de [MPA_DefinicionDimensiones]BitsNiveles en la variable
		CANCEL TRANSACTION:C241
	End if 
	
Else 
	
	  // La competencia NO aplica actualmente en el nivel seleccionado...
	  //   determino si la dimensión, el eje, o el área al que están asociados está configurado para aplicar en el nivel seleccionado
	  //   si es así enciendo el bit que indica aplicación en ese nivel para la competencia
	Case of 
		: ([MPA_DefinicionCompetencias:187]ID_Dimension:23#0)
			$l_bitsNivelesDimension:=KRL_GetNumericFieldData (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23;->[MPA_DefinicionDimensiones:188]BitsNiveles:21)
			If ($l_bitsNivelesDimension ?? $l_numeroNivelEnLista)
				vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?+ $l_numeroNivelEnLista
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=vl_AplicaEnNiveles
				If (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187])))
					SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
				End if 
			Else 
				$t_mensaje:=__ ("La dimensión de aprendizaje de la que depende esta competencia no está habilitado para ^0.\r\rNo es posible habilitar la Competencia en este nivel.")
				CD_Dlog (0;Replace string:C233($t_mensaje;"^0";<>at_NombreNivelesActivos{<>al_NumeroNivelesActivos}))
			End if 
		: ([MPA_DefinicionCompetencias:187]ID_Eje:2#0)
			$l_bitsNivelesEje:=KRL_GetNumericFieldData (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2;->[MPA_DefinicionEjes:185]BitsNiveles:20)
			If ($l_bitsNivelesEje ?? $l_numeroNivelEnLista)
				vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?+ $l_numeroNivelEnLista
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=vl_AplicaEnNiveles
				If (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187])))
					SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
				End if 
			Else 
				$t_mensaje:=__ ("El eje de aprendizaje del que depende esta competencia no está habilitado para ^0.\r\rNo es posible habilitar la Competencia en este nivel.")
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
			If ($l_EtapaNivel=0)
				$t_mensaje:=__ ("El área no esta configurada para ser utilizada en ^0.\r\rNo es posible habilitar la Competencia en este nivel.")
				CD_Dlog (0;Replace string:C233($t_mensaje;"^0";<>at_NombreNivelesActivos{<>al_NumeroNivelesActivos}))
			Else 
				vl_AplicaEnNiveles:=vl_AplicaEnNiveles ?+ $l_numeroNivelEnLista
				[MPA_DefinicionCompetencias:187]BitNiveles:28:=vl_AplicaEnNiveles
				If (Not:C34(Is new record:C668([MPA_DefinicionCompetencias:187])))
					SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
				End if 
			End if 
	End case 
End if 

$0:=$l_transaccionOK