//%attributes = {"executedOnServer":true}
  // KRL_GetFileFromServer()
  // Por: Alberto Bachler K.: 02-11-14, 09:34:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BLOB:C604($0)
C_TEXT:C284($1)
C_BOOLEAN:C305($2)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_esRutaAbsoluta)
C_TEXT:C284($t_rutaDocumento)
C_TEXT:C284($t_rutaEnServidor)
C_TEXT:C284($t_rutaEstructura)
C_TEXT:C284($t_VolumenEnRuta)
C_TEXT:C284($t_VolumenEstructura)
ARRAY TEXT:C222($at_volumenes;0)

If (False:C215)
	C_BLOB:C604(KRL_GetFileFromServer ;$0)
	C_TEXT:C284(KRL_GetFileFromServer ;$1)
	C_BOOLEAN:C305(KRL_GetFileFromServer ;$2)
End if 

$t_rutaDocumento:=$1
$b_esRutaAbsoluta:=True:C214
If (Count parameters:C259=2)
	$b_esRutaAbsoluta:=$2
End if 

$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)


$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;":";Folder separator:K24:12)
$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;"\\";Folder separator:K24:12)
If (SYS_IsWindows )
	$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;"\\\\";":\\")
	If (Position:C15(":\\";$t_rutaDocumento)=2)
		$t_VolumenEnRuta:=Substring:C12($t_rutaDocumento;1;Position:C15(":\\";$t_rutaDocumento)-1)+":\\"
	End if 
Else 
	$t_VolumenEnRuta:=ST_GetWord ($t_rutaDocumento;1;":")
	$t_VolumenEstructura:=ST_GetWord ($t_rutaEstructura;1;":")
End if 
VOLUME LIST:C471($at_volumenes)
$b_esRutaAbsoluta:=(Find in array:C230($at_volumenes;$t_VolumenEnRuta)>0)

If (Not:C34($b_esRutaAbsoluta))
	$t_rutaEnServidor:=$t_rutaEstructura+$t_rutaDocumento
Else 
	$t_rutaEnServidor:=$t_rutaDocumento
End if 
If (Test path name:C476($t_rutaEnServidor)=1)
	DOCUMENT TO BLOB:C525($t_rutaEnServidor;$x_blob)
End if 
$0:=$x_blob
