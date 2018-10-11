//%attributes = {}
  // Método: CURL_Callback
  //
  // 
  // creado por Alberto Bachler Klein
  // el 09/08/18, 12:55:50
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––


C_LONGINT:C283($1;$2;$3;$4;$5)
C_BOOLEAN:C305($0)

$l_progress:=$1

  //download info
$l_bytesToDownload:=$2
$l_bytesDownloaded:=$3

  //upload info
$l_bytesToUpload:=$4
$l_bytesUploaded:=$5

DELAY PROCESS:C323(Current process:C322;60)

If (Progress Stopped ($l_progress))
	
	$0:=True:C214
	
Else 
	
	$r_progress:=Choose:C955($l_bytesToUpload#0;$l_bytesToUpload/$l_bytesToUpload;-1)
	$t_message:=Choose:C955($r_progress#-1;String:C10($l_bytesUploaded)+"/"+String:C10($l_bytesToUpload)+__ (" bytes transferidos");__ ("conectando..."))
	
	Progress SET PROGRESS ($l_progress;$r_progress;$t_message)
	
End if 



