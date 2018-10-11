//%attributes = {}
  // Método: BLOB_equals (blob1:Y ; blob2:Y)
  // retorna TRUE si los blobs son iguales, FALSE si son distintos
  //
  // por Alberto Bachler Klein
  // creación 28/06/17, 11:45:03
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)

C_POINTER:C301($y_blob1;$y_blob2)
C_TEXT:C284($t_digest1;$t_digest2)



If (False:C215)
	C_BOOLEAN:C305(BLOB_equals ;$0)
End if 

$y_blob1:=$1
$y_blob2:=$2

$0:=True:C214
If (BLOB size:C605($y_blob1->)#BLOB size:C605($y_blob2->))
	$0:=False:C215
Else 
	  // Saúl Ponce O, Ticket Nº 185552 - Cambié al valor contenido en el blob
	  //$t_digest1:=Generate digest($y_blob1;SHA1 digest)
	  //$t_digest2:=Generate digest($y_blob2;SHA1 digest)
	$t_digest1:=Generate digest:C1147($y_blob1->;SHA1 digest:K66:2)
	$t_digest2:=Generate digest:C1147($y_blob2->;SHA1 digest:K66:2)
	$0:=($t_digest1=$t_digest2)
End if 



