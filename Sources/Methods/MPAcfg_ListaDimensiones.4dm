//%attributes = {}
  // MPAcfg_ListaDimensiones()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/07/12, 10:13:39
  // ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($i;$l_tipoObjeto)

ARRAY LONGINT:C221($al_ColorFondo;0)
ARRAY LONGINT:C221($al_ColorTexto;0)
ARRAY INTEGER:C220($ai_NivelDesde;0)
ARRAY INTEGER:C220($ai_NivelHasta;0)
ARRAY INTEGER:C220($ai_OrdenDimension;0)
ARRAY INTEGER:C220($ai_OrdenEje;0)
If (False:C215)
	C_LONGINT:C283(MPAcfg_ListaDimensiones ;$1)
End if 

  // CÓDIGO
$l_tipoObjeto:=$1

AL_UpdateArrays (xALP_Dimensiones;0)
ARRAY LONGINT:C221(alEVLG_Dimensiones_RecNums;0)
ARRAY TEXT:C222(atEVLG_Dimensiones_Nombres;0)
ARRAY TEXT:C222(atEVLG_Dimensiones_Etapas;0)

READ ONLY:C145([MPA_DefinicionDimensiones:188])

Case of 
	: ($l_tipoObjeto=0)  // area, todas las dimensiones del área
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Area:2=vlEVLG_IDArea)
		
	: ($l_tipoObjeto=Eje_Aprendizaje)  // eje, todas las dimensiones del eje
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=vlEVLG_IDEje)
End case 

If (Records in selection:C76([MPA_DefinicionDimensiones:188])>0)
	SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188];alEVLG_Dimensiones_RecNums;[MPA_DefinicionDimensiones:188]Dimensión:4;atEVLG_Dimensiones_Nombres;[MPA_DefinicionDimensiones:188]DesdeGrado:6;$ai_NivelDesde;[MPA_DefinicionDimensiones:188]HastaGrado:7;$ai_NivelHasta;[MPA_DefinicionDimensiones:188]ColorTexto:9;$al_ColorTexto;[MPA_DefinicionDimensiones:188]ColorFondo:10;$al_ColorFondo;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$ai_OrdenDimension;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$ai_OrdenEje)
	AT_MultiLevelSort (">>";->$ai_OrdenEje;->$ai_OrdenDimension;->atEVLG_Dimensiones_Nombres;->$ai_NivelDesde;->$ai_NivelHasta;->alEVLG_Dimensiones_RecNums;->$al_ColorTexto;->$al_ColorFondo)
	ARRAY TEXT:C222(atEVLG_Dimensiones_Etapas;0)
	ARRAY TEXT:C222(atEVLG_Dimensiones_Etapas;Size of array:C274(alEVLG_Dimensiones_RecNums))
	For ($i;1;Size of array:C274(atEVLG_Dimensiones_Etapas))
		Case of 
			: ($ai_NivelDesde{$i}=999)
				atEVLG_Dimensiones_Etapas{$i}:="Por nivel"
				
			: ($ai_NivelDesde{$i}>-100)
				atEVLG_Dimensiones_Etapas{$i}:=String:C10($ai_NivelDesde{$i})+" - "+String:C10($ai_NivelHasta{$i})
			Else 
				atEVLG_Dimensiones_Etapas{$i}:="Todos"
		End case 
	End for 
	
End if 
AL_UpdateArrays (xALP_Dimensiones;-2)
For ($I;1;Size of array:C274(atEVLG_Dimensiones_Etapas))
	AL_SetRowColor (xALP_Dimensiones;$i;"";$al_ColorTexto{$i};"";$al_ColorFondo{$i})
End for 
AL_SetLine (xALP_Dimensiones;0)
