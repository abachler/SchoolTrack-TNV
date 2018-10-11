//%attributes = {}
  // NTC_Mensaje_Leido(UUID:T)
  //
  // Marca un mensaje como leído
  // - UUID: uuid del mensaje
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/12, 16:35:31
  // ---------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($t_registroLectura;$t_uuid)


  // CÓDIGO
$t_uuid:=$1
KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_uuid;True:C214)
$t_registroLectura:=String:C10(Current date:C33(*);System date short:K1:1)+", "+String:C10(Current time:C178(*);HH MM SS:K7:1)+"."+String:C10(USR_GetUserID )+"."+USR_GetUserName (USR_GetUserID )
[NTC_Notificaciones:190]Leido:10:=True:C214
[NTC_Notificaciones:190]Lectores:11:=$t_registroLectura+Char:C90(Carriage return:K15:38)+[NTC_Notificaciones:190]Lectores:11
SAVE RECORD:C53([NTC_Notificaciones:190])
KRL_ReloadAsReadOnly (->[NTC_Notificaciones:190])
