//%attributes = {}
  //SN3_ActuaDatosSendIDActualizado
  //MONO 

C_TEXT:C284($vt_FileName;$xmlRef)
C_OBJECT:C1216($1;$ob)
ARRAY LONGINT:C221($al_id_personas_actualizadas;0)
$ob:=$1
OB_GET ($ob;->$al_id_personas_actualizadas;"id_actualizados")
$vt_FileName:=SN3_CreateFile2Send ("crear";"";40001;"dom";->$xmlRef)
$xmlRef:=DOM Create XML Ref:C861("colegium")
DOM SET XML DECLARATION:C859($xmlRef;"UTF-8")
For ($i;1;Size of array:C274($al_id_personas_actualizadas))
	DOM_SetElementValueAndAttr ($xmlRef;"id";String:C10($al_id_personas_actualizadas{$i});True:C214)
End for 
SN3_CloseXMLCompress ($xmlRef;$vt_FileName;"dom")
SN3_FTP_SendFiles 