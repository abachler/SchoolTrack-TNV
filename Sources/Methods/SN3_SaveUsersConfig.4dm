//%attributes = {}
  //SN3_SaveUsersConfig

C_BLOB:C604($usersBlob)

$OT_Object:=OT New 
OT PutLong ($OT_Object;"loginType";SN3_LoginTypeSel)
OT PutLong ($OT_Object;"passwordType";SN3_PasswordTypeSel)
OT PutLong ($OT_Object;"whatUsers";SN3_WhatUsersSel)

OT PutLong ($OT_Object;"useOtherChar";cb_UsarOtroChar)
OT PutText ($OT_Object;"char";SN3_Separador)
OT PutLong ($OT_Object;"sendMail";cb_SendByMail)

OT PutLong ($OT_Object;"usr_schooltrack";<>lUSR_CurrentUserID)

OT PutLong ($OT_Object;"recibirTodos";h1_Todos)
OT PutLong ($OT_Object;"recibirNuevos";h2_SoloNuevos)

OT PutLong ($OT_Object;"cursoMenor";r1_AgruparCursoMenor)
OT PutLong ($OT_Object;"cursoMayor";r2_AgruparCursoMayor)

OT PutLong ($OT_Object;"porMail";g1_Mail)
OT PutText ($OT_Object;"email";SN3_MailAddress)

OT PutLong ($OT_Object;"directo";g2_Directo)

OT PutLong ($OT_Object;"excel";cb_FormatoXLS)
OT PutLong ($OT_Object;"pdf";cb_FormatoPDF)

OT PutText ($OT_Object;"ultimaSolicitud";SN3_LastListDTS)

$usersBlob:=OT ObjectToNewBLOB ($OT_Object)
OT Clear ($OT_Object)

PREF_SetBlob (0;"SN3UsersSettings";$usersBlob)

