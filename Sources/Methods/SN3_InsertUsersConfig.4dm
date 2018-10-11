//%attributes = {}
  //SN3_InsertUsersConfig

C_TIME:C306($1;$refXML)

$refXML:=$1

SN3_LoadUsersSettings 
SAX_CreateNode ($refXML;"configusuarios")
SAX_CreateNode ($refXML;"tipologin";True:C214;String:C10(SN3_LoginTypeSel))
SAX_CreateNode ($refXML;"tipoclave";True:C214;String:C10(SN3_PasswordTypeSel))
SAX_CreateNode ($refXML;"quienes";True:C214;String:C10(SN3_WhatUsersSel))
SAX_CreateNode ($refXML;"usaotrochar";True:C214;String:C10(cb_UsarOtroChar))
SAX_CreateNode ($refXML;"caracter";True:C214;SN3_Separador)
SAX_CreateNode ($refXML;"enviarmail";True:C214;String:C10(cb_SendByMail))
SAX_CreateNode ($refXML;"usr_schooltrack";True:C214;String:C10(SN3_LastChanger))
SAX CLOSE XML ELEMENT:C854($refXML)

