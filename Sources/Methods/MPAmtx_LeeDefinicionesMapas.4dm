//%attributes = {}
  // // MPAmtx_LeeDefinicionesMapas()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 30/07/12, 09:23:50
  // ---------------------------------------------

  // CÓDIGO
C_LONGINT:C283($1;$l_IdArea)
C_LONGINT:C283($2;$l_IdMateria;$l_nivelNumero;$3;$l_nivelNumero)
C_POINTER:C301($4;$y_arregloTipoObjeto;$5;$y_arregloIdObjeto;$6;$y_arregloNombreObjeto;$7;$y_arregloRefIconos)

$l_IdArea:=$1
$l_IdMateria:=$2
$l_nivelNumero:=$3

$y_arregloTipoObjeto:=$4
$y_arregloIdObjeto:=$5
$y_arregloNombreObjeto:=$6
$y_arregloRefIconos:=$7


$l_indexNivel:=Find in array:C230(<>aNivNo;$l_nivelNumero)
$l_recNumArea:=Find in field:C653([MPA_DefinicionAreas:186]ID:1;$l_IdArea)
KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNumArea)
If (OK=1)
	BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	$l_indexEtapa:=0
	For ($i;1;Size of array:C274(alMPA_NivelDesde))
		If (($l_nivelNumero>=alMPA_NivelDesde{$i}) & ($l_nivelNumero<=alMPA_NivelHasta{$i}))
			$l_indexEtapa:=$i
			$i:=Size of array:C274(alMPA_NivelDesde)
		End if 
	End for 
	
	If ($l_indexEtapa>0)
		  //LECTURA DE COMPETENCIAS NO ASOCIADOS A EJES O DIMENSIONES
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Eje:2=0)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0;*)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; | ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria)
		QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
		
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNums;[MPA_DefinicionCompetencias:187]Competencia:6;$y_arregloNombreObjeto->;[MPA_DefinicionCompetencias:187]ID:1;$y_arregloIdObjeto->;[MPA_DefinicionCompetencias:187]Mnemo:26;$at_mnemoVariante)
		AT_RedimArrays (Size of array:C274($y_arregloIdObjeto->);$y_arregloRefIconos;$y_arregloTipoObjeto)
		For ($i;1;Size of array:C274($y_arregloIdObjeto->))
			If ($at_mnemoVariante{$i}#"")
				$y_arregloNombreObjeto->{$i}:=Char:C90(Space:K15:42)*4+"["+$at_mnemoVariante{$i}+"]"+$y_arregloNombreObjeto->{$i}
			Else 
				$y_arregloNombreObjeto->{$i}:=Char:C90(Space:K15:42)*4+$y_arregloNombreObjeto->{$i}
			End if 
			$y_arregloTipoObjeto->{$i}:=(Logro_Aprendizaje*1)
		End for 
		
		
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0;*)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; | ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria)
		QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
		
		If (Records in selection:C76([MPA_DefinicionCompetencias:187])>0)
			QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_IdArea)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
			CREATE SET:C116([MPA_DefinicionDimensiones:188];"dimensiones")
			
			QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]BitsNiveles:20 ?? $l_indexNivel)
			
			
			If (Records in selection:C76([MPA_DefinicionEjes:185])>0)
				$l_ejes:=Records in selection:C76([MPA_DefinicionEjes:185])
				ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>)
				SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185];$al_recNums;[MPA_DefinicionEjes:185]ID:1;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEjes)
				$appendAt:=Size of array:C274($y_arregloIdObjeto->)
				AT_Insert ($appendAt+1;$l_ejes;$y_arregloNombreObjeto;$y_arregloRefIconos;$y_arregloTipoObjeto;$y_arregloIdObjeto)
				For ($i;1;Size of array:C274($al_IdEje))
					$y_arregloIdObjeto->{$i+$appendAt}:=$al_IdEje{$i}
					$y_arregloNombreObjeto->{$i+$appendAt}:=$at_nombreEjes{$i}
					$y_arregloRefIconos->{$i+$appendAt}:=""
					$y_arregloTipoObjeto->{$i+$appendAt}:=Eje_Aprendizaje
				End for 
				For ($i;Size of array:C274($y_arregloIdObjeto->);1;-1)
					If ($y_arregloTipoObjeto->{$i}=Eje_Aprendizaje)
						$l_recNumEje:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;$y_arregloIdObjeto->{$i})
						GOTO RECORD:C242([MPA_DefinicionEjes:185];$l_recNumEje)
						USE SET:C118("dimensiones")
						
						QUERY SELECTION:C341([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3;=;$y_arregloIdObjeto->{$i})
						QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
						SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
						ORDER BY:C49([MPA_DefinicionDimensiones:188];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
						SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188]ID:1;$al_IdDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionDimensiones:188]ColorFondo:10;$al_ColorFondo;[MPA_DefinicionDimensiones:188]ColorTexto:9;$al_ColorTexto)
						$l_dimensiones:=Records in selection:C76([MPA_DefinicionDimensiones:188])
						If ($l_dimensiones>0)
							$y_arregloRefIconos->{$i}:="^9002"
							AT_Insert ($i+1;$l_dimensiones;$y_arregloNombreObjeto;$y_arregloRefIconos;$y_arregloTipoObjeto;$y_arregloIdObjeto)
							For ($i_Dimensiones;1;Size of array:C274($at_NombreDimension))
								$y_arregloIdObjeto->{$i+$i_Dimensiones}:=$al_IdDimension{$i_Dimensiones}
								$y_arregloNombreObjeto->{$i+$i_Dimensiones}:=<>nbSpace+$at_NombreDimension{$i_Dimensiones}
								$y_arregloRefIconos->{$i+$i_Dimensiones}:=""
								$y_arregloTipoObjeto->{$i+$i_Dimensiones}:=Dimension_Aprendizaje
							End for 
						End if 
					End if 
				End for 
				
				For ($i;Size of array:C274($y_arregloIdObjeto->);1;-1)
					Case of 
						: ($y_arregloTipoObjeto->{$i}=Eje_Aprendizaje)
							QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$y_arregloIdObjeto->{$i};*)
							QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Dimension:23=0)
							QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0;*)
							QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; | ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria)
							QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
						: ($y_arregloTipoObjeto->{$i}=(Dimension_Aprendizaje*1))
							QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$y_arregloIdObjeto->{$i})
							QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0;*)
							QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; | ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria)
							QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
						Else 
							REDUCE SELECTION:C351([MPA_DefinicionCompetencias:187];0)
					End case 
					
					$l_logros:=Records in selection:C76([MPA_DefinicionCompetencias:187])
					If ($l_logros>0)
						SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
						ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
						SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
						Case of 
							: ($y_arregloTipoObjeto->{$i}=Eje_Aprendizaje)
								$y_arregloRefIconos->{$i}:="^9002"
							: ($y_arregloTipoObjeto->{$i}=Dimension_Aprendizaje)
								$y_arregloRefIconos->{$i}:=Char:C90(Space:K15:42)*2+"^9002"
						End case 
						
						AT_Insert ($i+1;$l_logros;$y_arregloNombreObjeto;$y_arregloRefIconos;$y_arregloTipoObjeto;$y_arregloIdObjeto)
						SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187]ID:1;$idLogros;[MPA_DefinicionCompetencias:187]Competencia:6;$aCompetenciasLogros;[MPA_DefinicionCompetencias:187]Mnemo:26;$at_mnemoVariante)
						For ($i_Logros;1;Size of array:C274($aCompetenciasLogros))
							$y_arregloIdObjeto->{$i+$i_Logros}:=$idLogros{$i_Logros}
							$y_arregloNombreObjeto->{$i+$i_Logros}:=Char:C90(Space:K15:42)*4+$aCompetenciasLogros{$i_Logros}
							If ($at_mnemoVariante{$i_Logros}#"")
								$y_arregloNombreObjeto->{$i+$i_Logros}:=Char:C90(Space:K15:42)*4+"["+$at_mnemoVariante{$i_Logros}+"]"+$aCompetenciasLogros{$i_Logros}
							Else 
								$y_arregloNombreObjeto->{$i+$i_Logros}:=Char:C90(Space:K15:42)*4+$aCompetenciasLogros{$i_Logros}
							End if 
							
							$y_arregloRefIconos->{$i+$i_Logros}:=""
							$y_arregloTipoObjeto->{$i+$i_Logros}:=Logro_Aprendizaje
						End for 
					End if 
				End for 
				
			End if 
			
		Else 
			
			QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=$l_IdArea)
			QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
			CREATE SET:C116([MPA_DefinicionDimensiones:188];"dimensiones")
			
			If (Records in selection:C76([MPA_DefinicionDimensiones:188])>0)
				KRL_RelateSelection (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionDimensiones:188]ID_Eje:3;"")
				If (Records in selection:C76([MPA_DefinicionEjes:185])>0)
					$l_ejes:=Records in selection:C76([MPA_DefinicionEjes:185])
					ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>)
					SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185];$al_recNums;[MPA_DefinicionEjes:185]ID:1;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEjes)
					$appendAt:=Size of array:C274($y_arregloIdObjeto->)
					AT_Insert ($appendAt+1;$l_ejes;$y_arregloNombreObjeto;$y_arregloRefIconos;$y_arregloTipoObjeto;$y_arregloIdObjeto)
					For ($i;1;Size of array:C274($al_IdEje))
						$y_arregloIdObjeto->{$i+$appendAt}:=$al_IdEje{$i}
						$y_arregloNombreObjeto->{$i+$appendAt}:=$at_nombreEjes{$i}
						$y_arregloRefIconos->{$i+$appendAt}:=""
						$y_arregloTipoObjeto->{$i+$appendAt}:=Eje_Aprendizaje
					End for 
					For ($i;Size of array:C274($y_arregloIdObjeto->);1;-1)
						If ($y_arregloTipoObjeto->{$i}=Eje_Aprendizaje)
							$l_recNumEje:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;$y_arregloIdObjeto->{$i})
							GOTO RECORD:C242([MPA_DefinicionEjes:185];$l_recNumEje)
							USE SET:C118("dimensiones")
							
							QUERY SELECTION:C341([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3;=;$y_arregloIdObjeto->{$i})
							QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
							SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
							ORDER BY:C49([MPA_DefinicionDimensiones:188];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>)
							SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
							SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188]ID:1;$al_IdDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_NombreDimension;[MPA_DefinicionDimensiones:188]ColorFondo:10;$al_ColorFondo;[MPA_DefinicionDimensiones:188]ColorTexto:9;$al_ColorTexto)
							$l_dimensiones:=Records in selection:C76([MPA_DefinicionDimensiones:188])
							If ($l_dimensiones>0)
								$y_arregloRefIconos->{$i}:="^9002"
								AT_Insert ($i+1;$l_dimensiones;$y_arregloNombreObjeto;$y_arregloRefIconos;$y_arregloTipoObjeto;$y_arregloIdObjeto)
								For ($i_Dimensiones;1;Size of array:C274($at_NombreDimension))
									$y_arregloIdObjeto->{$i+$i_Dimensiones}:=$al_IdDimension{$i_Dimensiones}
									$y_arregloNombreObjeto->{$i+$i_Dimensiones}:=<>nbSpace+$at_NombreDimension{$i_Dimensiones}
									$y_arregloRefIconos->{$i+$i_Dimensiones}:=""
									$y_arregloTipoObjeto->{$i+$i_Dimensiones}:=Dimension_Aprendizaje
								End for 
							End if 
						End if 
					End for 
					
				Else 
					
					
				End if 
			Else 
				QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea)
				QUERY SELECTION BY FORMULA:C207([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]BitsNiveles:20 ?? $l_indexNivel)
				If (Records in selection:C76([MPA_DefinicionEjes:185])>0)
					$l_ejes:=Records in selection:C76([MPA_DefinicionEjes:185])
					ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>)
					SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185];$al_recNums;[MPA_DefinicionEjes:185]ID:1;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_nombreEjes)
					For ($i;1;Size of array:C274($al_IdEje))
						APPEND TO ARRAY:C911($y_arregloIdObjeto->;$al_IdEje{$i})
						APPEND TO ARRAY:C911($y_arregloNombreObjeto->;$at_nombreEjes{$i})
						APPEND TO ARRAY:C911($y_arregloRefIconos->;"")
						APPEND TO ARRAY:C911($y_arregloTipoObjeto->;Eje_Aprendizaje)
					End for 
				End if 
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Seleccione el Eje o la Dimensión de aprendizaje al que desea asociar esta Competencia"))
End if 


SET_ClearSets ("Dimensiones")