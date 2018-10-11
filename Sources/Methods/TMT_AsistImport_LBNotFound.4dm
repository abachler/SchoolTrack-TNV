//%attributes = {}
  //TMT_AsistImport_LBNotFound
  //MONO: Carga el listbox con los valores del objeto

C_OBJECT:C1216($o_notFound;$1)
C_LONGINT:C283($i;$a;$l_idTermometro)
ARRAY TEXT:C222($at_childName;0)
ARRAY OBJECT:C1221($ao_childObj;0)
ARRAY TEXT:C222($at_AsigKey;0)
ARRAY OBJECT:C1221($ao_AsigObj;0)

  //array listbox
ARRAY TEXT:C222(at_lbNFCurso;0)
ARRAY TEXT:C222(at_lbNFLlave;0)

$o_notFound:=$1

$l_idTermometro:=IT_Progress (1;0;0;"Cargando Bloques No Encontrados...")

$l_nodos:=OB_GetChildNodes ($o_notFound;->$at_childName;->$ao_childObj)

For ($i;1;Size of array:C274($at_childName))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($at_childName))
	
	If (Not:C34(OB Is empty:C1297($ao_childObj{$i})))
		$l_nodos:=OB_GetChildNodes ($ao_childObj{$i};->$at_AsigKey;->$ao_AsigObj)
		
		For ($a;1;Size of array:C274($at_AsigKey))
			APPEND TO ARRAY:C911(at_lbNFCurso;$at_childName{$i})
			APPEND TO ARRAY:C911(at_lbNFLlave;$at_AsigKey{$a})
		End for 
	Else 
		OB REMOVE:C1226($o_notFound;$at_childName{$i})
	End if 
	
End for 

SORT ARRAY:C229(at_lbNFLlave;at_lbNFCurso;>)
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)