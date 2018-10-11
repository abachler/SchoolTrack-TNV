//%attributes = {}
  // MPAcfg_ListaEjes()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/07/12, 09:33:14
  // ---------------------------------------------
C_LONGINT:C283($i)

ARRAY INTEGER:C220($ai_NivelDesde;0)
ARRAY INTEGER:C220($ai_NivelHasta;0)

  // CÓDIGO
AL_UpdateArrays (xALP_Ejes;0)
READ ONLY:C145([MPA_DefinicionEjes:185])
QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=vlEVLG_IDArea)
ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]Asignado_a_Etapa:19;>;[MPA_DefinicionEjes:185]DesdeGrado:4;>;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>)
SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185];alEVLG_Ejes_RecNums;[MPA_DefinicionEjes:185]Nombre:3;atEVLG_Ejes_Nombres;[MPA_DefinicionEjes:185]DesdeGrado:4;$ai_NivelDesde;[MPA_DefinicionEjes:185]HastaGrado:5;$ai_NivelHasta;[MPA_DefinicionEjes:185]ID:1;alEVLG_Ejes_Ids)
ARRAY TEXT:C222(atEVLG_Ejes_Etapas;Size of array:C274(alEVLG_Ejes_RecNums))
For ($i;1;Size of array:C274(alEVLG_Ejes_RecNums))
	Case of 
		: ($ai_NivelDesde{$i}=999)
			atEVLG_Ejes_Etapas{$i}:="Por nivel"
			
		: ($ai_NivelDesde{$i}>-100)
			atEVLG_Ejes_Etapas{$i}:=String:C10($ai_NivelDesde{$i})+" - "+String:C10($ai_NivelHasta{$i})
			
		Else 
			atEVLG_Ejes_Etapas{$i}:="Todos"
	End case 
End for 
AL_UpdateArrays (xALP_Ejes;-2)
AL_SetLine (xALP_Ejes;0)
