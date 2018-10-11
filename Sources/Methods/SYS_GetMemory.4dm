//%attributes = {}
  // SYS_GetMemory()
  // Por: Alberto Bachler K.: 16-02-14, 15:01:35
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($x_blob)
C_LONGINT:C283($l_posicion)
C_REAL:C285($r_cacheSize;$r_freeMemory;$r_freeStackMemory;$r_Physical;$r_stackMemory;$r_usedCacheSize;$r_usedPhysicalMemory;$r_usedVirtualMemory)

ARRAY REAL:C219($ar_InfoValor;0)
ARRAY REAL:C219($ar_numeroObjeto;0)
ARRAY TEXT:C222($at_nombresValor;0)

C_LONGINT:C283(<>lTotalMemory;<>lPhysicalMemory;<>lFreeMemory;vlTotalMemory;vlPhysicalMemory;vlFreeMemory)
C_BOOLEAN:C305(<>bgettingMemory)


<>bgettingMemory:=True:C214
If (Application type:C494=4D Remote mode:K5:5)
	$x_blob:=SYS_GetServerMemory 
	BLOB_Blob2Vars (->$x_blob;0;-><>vl_MemoriaUtilizada;-><>lPhysicalMemory;-><>lFreeMemory;-><>vl_Cache;-><>vl_CacheUtilizada)
End if 

GET MEMORY STATISTICS:C1118(1;$at_nombresValor;$ar_InfoValor;$ar_numeroObjeto)
$l_posicion:=Find in array:C230($at_nombresValor;"Physical Memory Size")
If ($l_posicion>0)
	$r_Physical:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"cacheSize")
If ($l_posicion>0)
	$r_cacheSize:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"usedCacheSize")
If ($l_posicion>0)
	$r_usedCacheSize:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"Free Memory")
If ($l_posicion>0)
	$r_freeMemory:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"Used Physical Memory")
If ($l_posicion>0)
	$r_usedPhysicalMemory:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"Used virtual Memory")
If ($l_posicion>0)
	$r_usedVirtualMemory:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"Used virtual Memory")
If ($l_posicion>0)
	$r_usedVirtualMemory:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"Stack Memory")
If ($l_posicion>0)
	$r_stackMemory:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 

$l_posicion:=Find in array:C230($at_nombresValor;"Free stack Memory")
If ($l_posicion>0)
	$r_freeStackMemory:=Round:C94($ar_InfoValor{$l_posicion}/1024/1024;2)
End if 


vl_MemoriaUtilizada:=Round:C94($r_usedPhysicalMemory;0)
vlPhysicalMemory:=Round:C94($r_Physical;0)
vlFreeMemory:=Round:C94($r_freeMemory;0)
vl_Cache:=Round:C94($r_cacheSize;0)
vl_CacheUtilizada:=Round:C94($r_usedCacheSize;0)