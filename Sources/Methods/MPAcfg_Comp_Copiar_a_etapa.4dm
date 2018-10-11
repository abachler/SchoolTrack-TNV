//%attributes = {}
  // MPAcfg_Comp_Copiar_a_etapa()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 20/07/12, 17:45:16
  // ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_desconectarDimension;$b_desconectarEje)
C_LONGINT:C283($l_limiteInferiorEtapa;$l_limiteSuperiorEtapa;$l_recNumCompetencia)

If (False:C215)
	C_LONGINT:C283(MPAcfg_Comp_Copiar_a_etapa ;$0)
	C_LONGINT:C283(MPAcfg_Comp_Copiar_a_etapa ;$1)
	C_LONGINT:C283(MPAcfg_Comp_Copiar_a_etapa ;$2)
	C_LONGINT:C283(MPAcfg_Comp_Copiar_a_etapa ;$3)
End if 




  // CÓDIGO
$l_recNumCompetencia:=$1
$l_limiteInferiorEtapa:=$2
$l_limiteSuperiorEtapa:=$3

KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia;False:C215)
If (OK=1)
	[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_limiteInferiorEtapa
	[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_limiteSuperiorEtapa
	For ($i;$l_limiteInferiorEtapa;$l_limiteSuperiorEtapa)
		$l_bitToSet:=Find in array:C230(<>aNivNo;$i)
		[MPA_DefinicionCompetencias:187]BitNiveles:28:=[MPA_DefinicionCompetencias:187]BitNiveles:28 ?+ $l_bitToSet
	End for 
	
	If (Not:C34(MPAcfg_Comp_EsUnica ))
		CD_Dlog (0;__ ("Existe una competencia con el mismo nombre en el mismo contenedor (Area, Eje o Dimensión) que aplica en las mismas etapas o niveles académicos.\r\rNo es posible copiar la competencia."))
		OK:=0
		
	Else 
		$b_desconectarDimension:=False:C215
		$b_desconectarEje:=False:C215
		If (OK=1)
			Case of 
				: ([MPA_DefinicionCompetencias:187]ID_Dimension:23>0)
					KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2)
					KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionDimensiones:188]ID:1;->[MPA_DefinicionCompetencias:187]ID_Dimension:23)
					Case of 
						: ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5=0)
							OK:=1
						: (($l_limiteInferiorEtapa>=[MPA_DefinicionDimensiones:188]DesdeGrado:6) & ($l_limiteSuperiorEtapa<=[MPA_DefinicionDimensiones:188]HastaGrado:7))
							OK:=1
						Else 
							Case of 
								: ((($l_limiteInferiorEtapa>=[MPA_DefinicionDimensiones:188]DesdeGrado:6) & ($l_limiteSuperiorEtapa<=[MPA_DefinicionDimensiones:188]HastaGrado:7)) | ([MPA_DefinicionDimensiones:188]Asignado_a_Etapa:5=0))
									OK:=CD_Dlog (0;__ ("Esta competencia está asociada a una Dimensión que no incluye la etapa a la que desea copiarla.\rPuede copiarla, pero desconectándola de la dimensión a la que está asociada, aunque manteniéndola asociada al mismo Eje.\r\r¿Que desea hacer?\r");__ ("");__ ("Desconectar y Copiar");__ ("No copiar"))
									If (OK=1)
										$b_desconectarDimension:=True:C214
									End if 
								Else 
									OK:=CD_Dlog (0;__ ("Esta Competencia esta asociada una Dimensión y un Eje que no incluyen la etapa a la que desea copiarla.\rPuede copiarla pero desconectándola de la Dimensión y del Eje de aprendizaje.\r\r¿Que desea hacer?");__ ("");__ ("Desconectar y Copiar");__ ("No copiar"))
									If (OK=1)
										$b_desconectarDimension:=True:C214
										$b_desconectarEje:=True:C214
									End if 
							End case 
					End case 
					
				: ([MPA_DefinicionCompetencias:187]ID_Eje:2>0)
					KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionEjes:185]ID:1;->[MPA_DefinicionCompetencias:187]ID_Eje:2)
					Case of 
						: ([MPA_DefinicionEjes:185]Asignado_a_Etapa:19=0)
							OK:=1
						: ($l_limiteInferiorEtapa>=[MPA_DefinicionEjes:185]DesdeGrado:4) & ($l_limiteSuperiorEtapa<=[MPA_DefinicionEjes:185]HastaGrado:5)
							OK:=1
						Else 
							OK:=CD_Dlog (0;__ ("Esta Competencia esta asociada un Eje de aprendizaje que no incluye la etapa a la que desea copiarla.\rPuede copiarla pero desconectándola del Eje de aprendizaje.\r\r¿Que desea hacer?");__ ("");__ ("Desconectar y Copiar");__ ("No copiar"))
							If (OK=1)
								$b_desconectarEje:=True:C214
							End if 
					End case 
				Else 
					OK:=1
			End case 
		End if 
		
		If (OK=1)
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNumCompetencia)
			DUPLICATE RECORD:C225([MPA_DefinicionCompetencias:187])
			[MPA_DefinicionCompetencias:187]ID:1:=SQ_SeqNumber (->[MPA_DefinicionCompetencias:187]ID:1)
			[MPA_DefinicionCompetencias:187]Auto_UUID:30:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
			If ([MPA_DefinicionCompetencias:187]Asignado_a_Etapa:4>0)
				[MPA_DefinicionCompetencias:187]DesdeGrado:5:=$l_limiteInferiorEtapa
				[MPA_DefinicionCompetencias:187]HastaGrado:13:=$l_limiteSuperiorEtapa
			End if 
			If ($b_desconectarDimension)
				[MPA_DefinicionCompetencias:187]ID_Dimension:23:=0
			End if 
			If ($b_desconectarEje)
				[MPA_DefinicionCompetencias:187]ID_Eje:2:=0
			End if 
			SAVE RECORD:C53([MPA_DefinicionCompetencias:187])
			$l_recNumCompetencia:=Record number:C243([MPA_DefinicionCompetencias:187])
			If (cb_AutoActualizaMatricesMPA=1)
				MPAcfg_ActualizaMatrices (vlMPA_recNumArea;Logro_Aprendizaje;[MPA_DefinicionCompetencias:187]DesdeGrado:5;[MPA_DefinicionCompetencias:187]HastaGrado:13;$l_recNumCompetencia)
			End if 
		End if 
	End if 
Else 
	$l_recNumCompetencia:=-1
End if 

$0:=$l_recNumCompetencia

