//%attributes = {}
  // STWA_SetBrowserOrder()
  // Por: Alberto Bachler Klein: 18-11-15, 15:32:38
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_POINTER:C301($1;$3)
C_LONGINT:C283($2)

yBWR_currentTable:=$1
vlBWR_CurrentModuleRef:=$2
$ay_Campos:=$3

BWR_InitArrays 
BWR_SetDataPointers 
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
$l_numeroCriterios:=ST_CountWords (vtBWR_sortOrder;1;",")
For ($i;1;$l_numeroCriterios)
	$l_columnaOrden:=Num:C11(ST_GetWord (vtBWR_sortOrder;$i;","))
	$y_campo:=$ay_Campos->{Abs:C99($i)}
	If ($l_columnaOrden<0)
		ORDER BY:C49(yBWR_currentTable->;$y_campo->;<;*)
	Else 
		ORDER BY:C49(yBWR_currentTable->;$y_campo->;>;*)
	End if 
End for 
ORDER BY:C49(yBWR_currentTable->)