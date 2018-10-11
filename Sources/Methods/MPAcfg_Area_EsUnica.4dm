//%attributes = {}
  // MPAcfg_Area_EsUnica
  // Determina si el nombre del área es único en la tabla [MPA_DefinicionAreas]
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 05/07/12, 11:05:49
  // ---------------------------------------------
C_BOOLEAN:C305($0)

C_LONGINT:C283($l_Duplicados;$l_IdArea)
C_TEXT:C284($t_Enunciado)

If (False:C215)
	C_BOOLEAN:C305(MPAcfg_Area_EsUnica ;$0)
End if 

  // CÓDIGO

$l_IdArea:=[MPA_DefinicionAreas:186]ID:1
$t_Enunciado:=[MPA_DefinicionAreas:186]AreaAsignatura:4
$0:=True:C214

SET QUERY DESTINATION:C396(Into variable:K19:4;$l_Duplicados)
QUERY:C277([MPA_DefinicionAreas:186];[MPA_DefinicionAreas:186]ID:1#$l_IdArea;*)
QUERY:C277([MPA_DefinicionAreas:186]; & ;[MPA_DefinicionAreas:186]AreaAsignatura:4=$t_Enunciado)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

If ($l_Duplicados>0)
	$0:=False:C215
End if 
