//%attributes = {}
  // EVLG_AgregaObjeto_a_Matriz()
  //
If (False:C215)
	  // Alberto Bachler: 09/01/13, 22:00:28
	  // Declaración de variables, normalización, documentación
	  // Omisión de los parametros relacionados con los límites de la etapa,
	  // se utiliza el campo bitNiveles en las definiciones para determinar si el enunciado 
	  // aplica en el nivel
	  // ---------------------------------------------
End if 
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($b_AsignarSoloArrastrados)
C_LONGINT:C283($i;$idLogro;$indexNivel;$l_IdDimension;$l_idEje;$l_IdMatriz;$l_IdObjeto;$l_indexNivel;$l_numeroNivel;$l_NumeroPeriodo)
C_LONGINT:C283($l_recNumObjetoMatriz;$l_respuestaUsuario;$l_tipoObjeto)
C_TEXT:C284($t_llaveObjetoMatriz)

ARRAY LONGINT:C221($al_recNums;0)
If (False:C215)
	C_LONGINT:C283(EVLG_AgregaObjeto_a_Matriz ;$1)
	C_LONGINT:C283(EVLG_AgregaObjeto_a_Matriz ;$2)
	C_LONGINT:C283(EVLG_AgregaObjeto_a_Matriz ;$3)
	C_LONGINT:C283(EVLG_AgregaObjeto_a_Matriz ;$4)
End if 




$l_IdMatriz:=$1
$l_tipoObjeto:=$2
$l_IdObjeto:=$3
$l_NumeroPeriodo:=$4

  // CÓDIGO
If (Count parameters:C259=5)
	$b_AsignarSoloArrastrados:=$5
End if 

CREATE EMPTY SET:C140([MPA_ObjetosMatriz:204];"objetos")
KRL_FindAndLoadRecordByIndex (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->$l_IdMatriz)
$l_numeroNivel:=[MPA_AsignaturasMatrices:189]NumeroNivel:4
$l_indexNivel:=Find in array:C230(<>aNivNo;$l_numeroNivel)
$t_nombreMateria:=KRL_GetTextFieldData (->[Asignaturas:18]EVAPR_IdMatriz:91;->$l_IdMatriz;->[Asignaturas:18]Asignatura:3)
$l_idMateria:=[xxSTR_Materias:20]ID_Materia:16

Case of 
	: ($l_tipoObjeto=Eje_Aprendizaje)
		If (Not:C34($b_AsignarSoloArrastrados))
			$l_respuestaUsuario:=CD_Dlog (0;__ ("¿Desea copiar todos los aprendizajes esperados del eje a la configuracion seleccionada?");__ ("");__ ("Si");__ ("No"))
		Else 
			$l_respuestaUsuario:=1
		End if 
		If ($l_respuestaUsuario=1)
			QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=$l_IdObjeto)
			  // verificamos que la existencia del eje en la Matriz de Evaluación seleccionada
			$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10([MPA_DefinicionEjes:185]ID:1)+"."+String:C10(0)+"."+String:C10(0)
			$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
			If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
				  // si no existe lo creamos en la Matriz de Evaluación seleccionada
				CREATE RECORD:C68([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
				[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionEjes:185]ID:1
				[MPA_ObjetosMatriz:204]Periodos:7:=0
				[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			Else 
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			End if 
			ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
			
			If (Not:C34($b_AsignarSoloArrastrados))
				  //buscamos las dimensiones esperadas correspondientes al eje en la matriz por defecto
				QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$l_IdObjeto)
				  // restricción a solo los registros de dimensiones dependientes del eje que aplican en el nivel de la matriz de evaluación
				QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
				SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188];$al_recNums)  // los cargamos en un arreglo
				For ($i;1;Size of array:C274($al_recNums))  // recorremos las dimensiones  del eje en la matriz por defecto
					GOTO RECORD:C242([MPA_DefinicionDimensiones:188];$al_recNums{$i})
					
					  // verificamos que la existencia de la dimensiones  en la Matriz de Evaluación seleccionada
					$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10([MPA_DefinicionDimensiones:188]ID_Eje:3)+"."+String:C10([MPA_DefinicionDimensiones:188]ID:1)+"."+String:C10(0)
					$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
					If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
						  // si no existe la creamos en la configuración seleccionada
						CREATE RECORD:C68([MPA_ObjetosMatriz:204])
						[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
						[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionDimensiones:188]ID_Eje:3
						[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionDimensiones:188]ID:1
						[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
						[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					End if 
					ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
				End for 
				
				  //buscamos las competencias correspondientes al eje en la matriz por defecto
				QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$l_IdObjeto)
				  // restricción a solo los registros de competencias dependientes del eje que aplican en el nivel de la matriz de evaluación
				QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
				SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNums)  // los cargamos en un arreglo
				For ($i;1;Size of array:C274($al_recNums))  // recorremos los aprendizajes esperados del eje en la matriz por defecto
					GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNums{$i})
					$idLogro:=[MPA_DefinicionCompetencias:187]ID:1
					  // verificamos que la existencia del enunciado en la Matriz de evaluación seleccionada
					READ WRITE:C146([MPA_ObjetosMatriz:204])
					$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23)+"."+String:C10([MPA_DefinicionCompetencias:187]ID:1)
					$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
					$b_crearObjetoEnMatriz:=([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0) | ([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_idMateria)
					$b_crearObjetoEnMatriz:=($b_crearObjetoEnMatriz) & (($l_recNumObjetoMatriz=No current record:K29:2) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Logro_Aprendizaje))
					If ($b_crearObjetoEnMatriz)
						  // si no existe lo creamos en la Matriz de evaluación seleccionada
						CREATE RECORD:C68([MPA_ObjetosMatriz:204])
						[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
						[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
						[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
						[MPA_ObjetosMatriz:204]ID_Competencia:5:=[MPA_DefinicionCompetencias:187]ID:1
						[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Logro_Aprendizaje
						[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					Else 
						[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
						SAVE RECORD:C53([MPA_ObjetosMatriz:204])
					End if 
					ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
				End for 
			End if 
		End if 
		
	: ($l_tipoObjeto=Dimension_Aprendizaje)
		  // drag and drop de una dimensión
		READ WRITE:C146([MPA_ObjetosMatriz:204])
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1=$l_IdObjeto)
		$l_IdObjeto:=[MPA_DefinicionDimensiones:188]ID:1
		  // verificamos que la existencia de la dimensión en la Matriz de Evaluación seleccionada
		$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10([MPA_DefinicionDimensiones:188]ID_Eje:3)+"."+String:C10([MPA_DefinicionDimensiones:188]ID:1)+"."+String:C10(0)
		$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
		If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
			  // si no existe la creamos en la Matriz de Evaluación seleccionada
			CREATE RECORD:C68([MPA_ObjetosMatriz:204])
			[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
			[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionDimensiones:188]ID_Eje:3
			[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionDimensiones:188]ID:1
			[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
			[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
			SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		Else 
			[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
			SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		End if 
		ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
		$l_idEje:=[MPA_ObjetosMatriz:204]ID_Eje:3
		
		If ($l_idEje>0)
			$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10($l_idEje)+"."+String:C10(0)+"."+String:C10(0)
			$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
			If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
				  // si no existe lo creamos en la Matriz de Evaluación seleccionada
				QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=$l_idEje)
				CREATE RECORD:C68([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
				[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_idEje
				[MPA_ObjetosMatriz:204]Periodos:7:=0
				[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			Else 
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			End if 
			ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
		End if 
		
		  //buscamos las Competencias correspondientes a la Dimensión en la matriz por defecto
		If (Not:C34($b_AsignarSoloArrastrados))
			QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$l_IdObjeto)
			  // restricción a solo los registros de comepetencias dependientes de la dimensión que aplican en el nivel de la matriz de evaluación
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
			SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNums)  // los cargamos en un arreglo
			For ($i;1;Size of array:C274($al_recNums))  // recorremos los aprendizajes esperados del eje en la matriz por defecto
				GOTO RECORD:C242([MPA_DefinicionCompetencias:187];$al_recNums{$i})
				  // verificamos que la existencia de la Competencia en la Matriz de Evaluación seleccionada
				$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23)+"."+String:C10([MPA_DefinicionCompetencias:187]ID:1)
				$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
				$b_crearObjetoEnMatriz:=([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0) | ([MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_idMateria)
				$b_crearObjetoEnMatriz:=($b_crearObjetoEnMatriz) & (($l_recNumObjetoMatriz=No current record:K29:2) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Logro_Aprendizaje))
				If ($b_crearObjetoEnMatriz)
					  // si no existe lo creamos en la Matriz de Evaluación seleccionada
					CREATE RECORD:C68([MPA_ObjetosMatriz:204])
					[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
					[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
					[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
					[MPA_ObjetosMatriz:204]ID_Competencia:5:=[MPA_DefinicionCompetencias:187]ID:1
					[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Logro_Aprendizaje
					[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				Else 
					[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
					SAVE RECORD:C53([MPA_ObjetosMatriz:204])
				End if 
				ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
			End for 
		End if 
		
	: ($l_tipoObjeto=Logro_Aprendizaje)
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID:1=$l_IdObjeto)
		  // drag and drop de un aprendizaje esperado
		$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2)+"."+String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23)+"."+String:C10([MPA_DefinicionCompetencias:187]ID:1)
		$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
		If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Logro_Aprendizaje))
			CREATE RECORD:C68([MPA_ObjetosMatriz:204])
			[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
			[MPA_ObjetosMatriz:204]ID_Eje:3:=[MPA_DefinicionCompetencias:187]ID_Eje:2
			[MPA_ObjetosMatriz:204]ID_Dimension:4:=[MPA_DefinicionCompetencias:187]ID_Dimension:23
			[MPA_ObjetosMatriz:204]ID_Competencia:5:=[MPA_DefinicionCompetencias:187]ID:1
			[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Logro_Aprendizaje
			[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
			SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		Else 
			[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
			SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		End if 
		ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
		$l_idEje:=[MPA_ObjetosMatriz:204]ID_Eje:3
		$l_IdDimension:=[MPA_ObjetosMatriz:204]ID_Dimension:4
		
		If ($l_idEje>0)
			$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10($l_idEje)+"."+String:C10(0)+"."+String:C10(0)
			$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
			If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Eje_Aprendizaje))
				  // si no existe lo creamos en la Matriz de Evaluación seleccionada
				QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID:1=$l_idEje)
				CREATE RECORD:C68([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
				[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_idEje
				[MPA_ObjetosMatriz:204]Periodos:7:=0
				[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Eje_Aprendizaje
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			Else 
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			End if 
			ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
		End if 
		
		If ($l_IdDimension>0)
			$t_llaveObjetoMatriz:=String:C10(<>gInstitucion)+"."+String:C10($l_IdMatriz)+"."+String:C10($l_idEje)+"."+String:C10($l_IdDimension)+"."+String:C10(0)
			$l_recNumObjetoMatriz:=KRL_FindAndLoadRecordByIndex (->[MPA_ObjetosMatriz:204]Llave_unica:27;->$t_llaveObjetoMatriz;True:C214)
			If (($l_recNumObjetoMatriz<0) | ([MPA_ObjetosMatriz:204]Tipo_Objeto:2#Dimension_Aprendizaje))
				  // si no existe lo creamos en la Matriz de Evaluación seleccionada
				QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID:1=$l_IdDimension)
				CREATE RECORD:C68([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$l_IdMatriz
				[MPA_ObjetosMatriz:204]ID_Eje:3:=$l_idEje
				[MPA_ObjetosMatriz:204]ID_Dimension:4:=$l_IdDimension
				[MPA_ObjetosMatriz:204]Periodos:7:=0
				[MPA_ObjetosMatriz:204]Tipo_Objeto:2:=Dimension_Aprendizaje
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			Else 
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $l_NumeroPeriodo  // marcamos el objeto como evaluable en el período seleccionado (o en todos los períodos)
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			End if 
			ADD TO SET:C119([MPA_ObjetosMatriz:204];"objetos")
		End if 
		
End case 

USE SET:C118("objetos")
LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$al_recNums;"")
For (i;1;Size of array:C274($al_recNums))
	READ WRITE:C146([MPA_ObjetosMatriz:204])
	GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_recNums{i})
	Case of 
		: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5=[MPA_ObjetosMatriz:204]ID_Eje:3;*)
		: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6=[MPA_ObjetosMatriz:204]ID_Dimension:4;*)
		: ([MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7=[MPA_ObjetosMatriz:204]ID_Competencia:5;*)
	End case 
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=[MPA_ObjetosMatriz:204]Tipo_Objeto:2)
	ARRAY LONGINT:C221($aLongint;Records in selection:C76([Alumnos_EvaluacionAprendizajes:203]))
	AT_Populate (->$aLongint;->[MPA_ObjetosMatriz:204]Periodos:7)
	KRL_Array2Selection (->$aLongint;->[Alumnos_EvaluacionAprendizajes:203]BIT_Periodo:10)
End for 

