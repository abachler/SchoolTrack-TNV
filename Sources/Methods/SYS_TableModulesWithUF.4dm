//%attributes = {}
  // SYS_TableModulesWithUF()
  // Por: Alberto Bachler: 25/02/13, 15:19:21
  //  ---------------------------------------------
  // Busca las tablas con campos propios definidos y llena arreglos con los nombres y Ids de esas tablas
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_BLOB:C604($x_blob)
C_LONGINT:C283($i;$l_referenciaModulo)
C_TEXT:C284($t_referenciaPrefs)

If (False:C215)
	C_LONGINT:C283(SYS_TableModulesWithUF ;$1)
End if 

If (Count parameters:C259=1)
	$l_referenciaModulo:=$1
Else 
	$l_referenciaModulo:=vlBWR_CurrentModuleRef
End if 
HL_ClearList (hl_ModuleTables)
$t_referenciaPrefs:=XS_GetBlobName ("tables";$l_referenciaModulo)
$x_blob:=PREF_fGetBlob (0;$t_referenciaPrefs)
If (BLOB size:C605($x_blob)>0)
	hl_moduleTables:=BLOB to list:C557($x_blob)
	SORT LIST:C391(hl_ModuleTables;>)
	_O_REDRAW LIST:C382(hl_ModuleTables)
	ARRAY TEXT:C222(aModTables;0)
	HL_CopyReferencedListToArray (hl_ModuleTables;->aModTables)
End if 
QUERY WITH ARRAY:C644([xShell_Tables:51]NombreDeTabla:1;aModTables)
QUERY SELECTION:C341([xShell_Tables:51];[xShell_Tables:51]TieneCamposPropios:33=True:C214)
SELECTION TO ARRAY:C260([xShell_Tables:51]NumeroDeTabla:5;<>aUFFileNo)
ARRAY TEXT:C222(<>aUFFileNm;Size of array:C274(<>aUFFileNo))
For ($i;1;Size of array:C274(<>aUFFileNo))
	<>aUFFileNm{$i}:=XSvs_nombreTablaLocal_Numero (<>aUFFileNo{$i};<>vtXS_CountryCode;<>vtXS_Langage)
End for 