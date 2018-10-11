//%attributes = {}
  // MPAcfg_ListaCompetencias()
  // 
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/07/12, 09:55:39
  // ---------------------------------------------





  // CÓDIGO
$l_tipoObjeto:=$1

C_BOOLEAN:C305($b_aplicaEnEtapa)
_O_C_INTEGER:C282($i_etapas)
C_LONGINT:C283($iCompetencias;$indexNivel;$iNiveles;$iRows;$l_fila;$l_IdArea;$l_numeroEtapas)
C_POINTER:C301($arrayPointer)
C_TEXT:C284($atMnemo)

ARRAY LONGINT:C221($al_BitsNiveles;0)
ARRAY LONGINT:C221($al_ColorFondo;0)
ARRAY LONGINT:C221($al_ColorTexto;0)
ARRAY LONGINT:C221($al_desdeGrado;0)
ARRAY LONGINT:C221($al_hastaGrado;0)
ARRAY LONGINT:C221($al_IdCompetencia;0)
ARRAY LONGINT:C221($al_recNumCompetencias;0)
ARRAY INTEGER:C220($ai_OrdenCompetencia;0)
ARRAY INTEGER:C220($ai_OrdenDimension;0)
ARRAY INTEGER:C220($ai_OrdenEje;0)
ARRAY TEXT:C222($at_EnunciadoCompetencia;0)





  // CÓDIGO
READ ONLY:C145([MPA_DefinicionAreas:186])
READ ONLY:C145([MPA_DefinicionCompetencias:187])
GOTO RECORD:C242([MPA_DefinicionAreas:186];vlMPA_recNumArea)
If (BLOB size:C605([MPA_DefinicionAreas:186]xEtapas:10)>0)
	BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
End if 


AT_Initialize (->atEVLG_Competencias_E1;->atEVLG_Competencias_E2;->atEVLG_Competencias_E3;->atEVLG_Competencias_E4;->atEVLG_Competencias_E5;->atEVLG_Competencias_E6;->atEVLG_Competencias_E7;->atEVLG_Competencias_E8;->atEVLG_Competencias_E9;->atEVLG_Competencias_E10;->atEVLG_Competencias_E11;->atEVLG_Competencias_E12;->atEVLG_Competencias_E13;->atEVLG_Competencias_E14;->atEVLG_Competencias_E15;->atEVLG_Competencias_E16;->atEVLG_Competencias_E17;->atEVLG_Competencias_E18;->atEVLG_Competencias_E19;->atEVLG_Competencias_E20;->atEVLG_Competencias_E21;->atEVLG_Competencias_E22;->atEVLG_Competencias_E23;->atEVLG_Competencias_E24)

$l_numeroEtapas:=Size of array:C274(atMPA_EtapasArea)
ARRAY LONGINT:C221(alEVLG_Competencias_RecNums;0;0)
ARRAY LONGINT:C221(alEVLG_Competencias_ColorsTexto;0;0)
ARRAY LONGINT:C221(alEVLG_Competencias_ColorsFondo;0;0)
$l_fila:=0


READ ONLY:C145([MPA_DefinicionCompetencias:187])
Case of 
	: ($l_tipoObjeto=0)  // area, todas las competencias del área seleccionada
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=vlEVLG_IDArea)
		If (vb_SoloEnunciadosNoAsociados)
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2;=;0;*)
			QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Dimension:23;=;0)
			vb_SoloEnunciadosNoAsociados:=False:C215
		End if 
		vtEVLG_labelCompetencias:="Competencias en: "+[MPA_DefinicionAreas:186]AreaAsignatura:4
		
		
	: ($l_tipoObjeto=Eje_Aprendizaje)  // todas las competencias del eje seleccionado
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=vlEVLG_IDEje)
		vtEVLG_labelCompetencias:="Competencias en: "+[MPA_DefinicionEjes:185]Nombre:3
		
		
		
	: ($l_tipoObjeto=Dimension_Aprendizaje)  // todas las competencias de la dimensión seleccionada
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=vlEVLG_IDDimension;*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Eje:2=vlEVLG_IDEje)
		vtEVLG_labelCompetencias:="Competencias en: "+[MPA_DefinicionDimensiones:188]Dimensión:4
		
		
End case 



SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNumCompetencias;[MPA_DefinicionCompetencias:187]DesdeGrado:5;$al_NivelDesde;[MPA_DefinicionCompetencias:187]HastaGrado:13;$al_NivelHasta;[MPA_DefinicionCompetencias:187]ID:1;$al_IdCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_EnunciadoCompetencia;[MPA_DefinicionCompetencias:187]Mnemo:26;$at_mnemo;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$ai_OrdenCompetencia;[MPA_DefinicionCompetencias:187]BitNiveles:28;$al_BitsNiveles;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$ai_OrdenDimension;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$ai_OrdenEje;[MPA_DefinicionDimensiones:188]ColorTexto:9;$al_ColorTexto;[MPA_DefinicionDimensiones:188]ColorFondo:10;$al_ColorFondo)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

AT_MultiLevelSort (">>>";->$ai_OrdenEje;->$ai_OrdenDimension;->$ai_OrdenCompetencia;->$at_EnunciadoCompetencia;->$al_recNumCompetencias;->$al_ColorTexto;->$al_ColorFondo;->$al_IdCompetencia;->$at_mnemo;->$al_NivelDesde;->$al_NivelHasta;->$al_BitsNiveles)


$l_fila:=0
  //recorro todas las etapas (columnas en el formulario)
For ($i_etapas;1;$l_numeroEtapas)
	For ($iCompetencias;1;Size of array:C274($al_recNumCompetencias))
		
		$b_aplicaEnEtapa:=False:C215
		If ($at_EnunciadoCompetencia{$iCompetencias}="")  // si la competencia no tiene enunciado la eliminamos (esto no debiera ocurrir nunca)
			KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$al_recNumCompetencias{$iCompetencias};True:C214)
			DELETE RECORD:C58([MPA_DefinicionCompetencias:187])
		Else 
			
			  // determino si la competencia actual (bucle competencias) tiene aplicación en la etapa actual (bucle etapas)
			$arrayPointer:=Get pointer:C304("atEVLG_Competencias_E"+String:C10($i_etapas))
			If (((alMPA_NivelDesde{$i_etapas}>=$al_NivelDesde{$iCompetencias}) & (alMPA_NivelHasta{$i_etapas}<=$al_NivelHasta{$iCompetencias})) | (($al_NivelDesde{$iCompetencias}=-100) & ($al_NivelHasta{$iCompetencias}=-100)))
				$b_aplicaEnEtapa:=True:C214
			Else 
				For ($iNiveles;alMPA_NivelDesde{$i_etapas};alMPA_NivelHasta{$i_etapas})
					$indexNivel:=Find in array:C230(<>aNivNo;$iNiveles)
					If ($al_BitsNiveles{$iCompetencias} ?? $indexNivel)
						$b_aplicaEnEtapa:=True:C214
					End if 
				End for 
			End if 
			
			If ($b_aplicaEnEtapa)
				  //si la competencia actual aplica en la etapa actual
				
				  // busco la primera celda libre en la columna para asignar la competencia
				$l_fila:=Find in array:C230($arrayPointer->;"")
				If ($l_fila<0)
					  // si no hay ninguna celda libre agrego una fila a todas las columnas correspondientes a etapas
					$l_fila:=Size of array:C274($arrayPointer->)+1
					AT_RedimArrays ($l_fila;->atEVLG_Competencias_E1;->atEVLG_Competencias_E2;->atEVLG_Competencias_E3;->atEVLG_Competencias_E4;->atEVLG_Competencias_E5;->atEVLG_Competencias_E6;->atEVLG_Competencias_E7;->atEVLG_Competencias_E8;->atEVLG_Competencias_E9;->atEVLG_Competencias_E10;->atEVLG_Competencias_E11;->atEVLG_Competencias_E12;->atEVLG_Competencias_E13;->atEVLG_Competencias_E14;->atEVLG_Competencias_E15;->atEVLG_Competencias_E16;->atEVLG_Competencias_E17;->atEVLG_Competencias_E18;->atEVLG_Competencias_E19;->atEVLG_Competencias_E20;->atEVLG_Competencias_E21;->atEVLG_Competencias_E22;->atEVLG_Competencias_E23;->atEVLG_Competencias_E24)
					ARRAY LONGINT:C221(alEVLG_Competencias_RecNums;$l_fila;$l_numeroEtapas)
					ARRAY LONGINT:C221(alEVLG_Competencias_ColorsTexto;$l_fila;$l_numeroEtapas)
					ARRAY LONGINT:C221(alEVLG_Competencias_ColorsFondo;$l_fila;$l_numeroEtapas)
				End if 
				  // asigno nombre, recNum de la competencia y colores a la celda
				If ($at_mnemo{$iCompetencias}#"")
					$arrayPointer->{$l_fila}:="["+$at_mnemo{$iCompetencias}+"]"+$at_EnunciadoCompetencia{$iCompetencias}
				Else 
					$arrayPointer->{$l_fila}:=$at_EnunciadoCompetencia{$iCompetencias}
				End if 
				alEVLG_Competencias_RecNums{$l_fila}{$i_etapas}:=$al_recNumCompetencias{$iCompetencias}
				alEVLG_Competencias_ColorsTexto{$l_fila}{$i_etapas}:=$al_ColorTexto{$iCompetencias}
				alEVLG_Competencias_ColorsFondo{$l_fila}{$i_etapas}:=$al_ColorFondo{$iCompetencias}
			End if 
		End if 
	End for 
End for 

  // me aseguro que todas las celdas libres (sin competencia asignada) tengan asignado -1 en el arreglo de dos dimensiones que almacena los recnums de comptencias correspondientes a las celdas
For ($i_Etapas;1;$l_numeroEtapas)
	$arrayPointer:=Get pointer:C304("atEVLG_Competencias_E"+String:C10($i_etapas))
	For ($i_filas;1;Size of array:C274(atEVLG_Competencias_E1))
		If ($arrayPointer->{$i_filas}="")
			alEVLG_Competencias_RecNums{$i_filas}{$i_etapas}:=-1
		End if 
	End for 
End for 