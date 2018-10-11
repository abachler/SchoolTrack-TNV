//%attributes = {}
  //ACTit_MoveElementALP

C_LONGINT:C283($1;$vl_alp;$line;$0)
C_BOOLEAN:C305($vb_arriba)
C_POINTER:C301(${3})
ARRAY POINTER:C280($ap_arrays;0)
$vl_alp:=$1
$vb_arriba:=($2=1)
For ($i;3;Count parameters:C259)
	APPEND TO ARRAY:C911($ap_arrays;${$i})
End for 

$line:=AL_GetLine ($vl_alp)
If ($line>0)
	AL_UpdateArrays ($vl_alp;0)
	If ($vb_arriba)
		$vl_pos:=$line-1
	Else 
		$vl_pos:=$line+1
	End if 
	For ($i;1;Size of array:C274($ap_arrays))
		APPEND TO ARRAY:C911($ap_arrays{$i}->;$ap_arrays{$i}->{$line})
	End for 
	For ($i;1;Size of array:C274($ap_arrays))
		$ap_arrays{$i}->{$line}:=$ap_arrays{$i}->{$vl_pos}
	End for 
	For ($i;1;Size of array:C274($ap_arrays))
		$ap_arrays{$i}->{$vl_pos}:=$ap_arrays{$i}->{Size of array:C274($ap_arrays{$i}->)}
	End for 
	  //elimino el último elemento utilizado como elemento temporal
	For ($i;1;Size of array:C274($ap_arrays))
		AT_Delete (Size of array:C274($ap_arrays{$i}->);1;$ap_arrays{$i})
	End for 
	AL_UpdateArrays ($vl_alp;-2)
End if 
$0:=$line