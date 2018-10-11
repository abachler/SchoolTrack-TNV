//%attributes = {}
  //SYS_ModulesTableBelongTo

If (False:C215)
	  //Este metodo toma un puntero sobre una tabla como parámetro y devuelve en un arreglo de texto
	  //llamado aModDisp, todos los modulos donde la tabla es utilizada y el aModRefs los reference de los modulos.
End if 

C_POINTER:C301($1;$TablePtr)
C_BLOB:C604($blob)

$TablePtr:=$1
ARRAY TEXT:C222(aModDisp;0)
ARRAY TEXT:C222(aModTables;0)
ARRAY LONGINT:C221(aModRefs;0)
hl_ModuleTables:=New list:C375
LIST TO ARRAY:C288("XS_Modules";<>aModules;$aModRefs)
For ($i;1;Size of array:C274(<>aModules))
	HL_ClearList (hl_ModuleTables)
	$ModuleRef:=$i
	$PrefReference:="XS_CFG_Tables_Module#"+String:C10($ModuleRef)
	$blob:=PREF_fGetBlob (0;$PrefReference)
	If (BLOB size:C605($blob)>0)
		hl_moduleTables:=BLOB to list:C557($blob)
		SORT LIST:C391(hl_ModuleTables;>)
		_O_REDRAW LIST:C382(hl_ModuleTables)
		ARRAY TEXT:C222(aModTables;0)
		HL_CopyReferencedListToArray (hl_ModuleTables;->aModTables)
	End if 
	$esta:=Find in array:C230(aModTables;Table name:C256($TablePtr))
	If ($esta#-1)
		INSERT IN ARRAY:C227(aModDisp;Size of array:C274(aModDisp)+1;1)
		INSERT IN ARRAY:C227(aModRefs;Size of array:C274(aModRefs)+1;1)
		aModDisp{Size of array:C274(aModDisp)}:=<>aModules{$i}
		aModRefs{Size of array:C274(aModRefs)}:=$aModRefs{$i}
	End if 
End for 