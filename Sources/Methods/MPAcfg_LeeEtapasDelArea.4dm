//%attributes = {}
  // MPAcfg_LeeEtapasDelArea(recNum)
  // recNum: Longint: record number del área desde la cual se leen las etapas
  // Lee los arreglos de definición de etapa almacenados en el blob [MPA_DefinicionAreas]xEtapas
  // del registro de definición del área cuyo recNum se paso en argumento
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 23/07/12, 10:29:10
  // ---------------------------------------------
C_LONGINT:C283($1)

C_LONGINT:C283($l_recNumArea)

If (False:C215)
	C_LONGINT:C283(MPAcfg_LeeEtapasDelArea ;$1)
End if 

  // CÓDIGO
$l_recNumArea:=$1
READ ONLY:C145([MPA_DefinicionAreas:186])
KRL_GotoRecord (->[MPA_DefinicionAreas:186];$l_recNumArea)
BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
SORT ARRAY:C229(alMPA_NivelDesde;alMPA_NivelHasta;atMPA_EtapasArea)
