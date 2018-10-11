//%attributes = {}
  //SN3_LoadUsersSettings

C_BLOB:C604($usersBlob)

  //==========  CREAMOS UNA CONFIGURACION GENERICA PARA LA PRIMERA VEZ  ==========

SN3_InitUsersSettings 

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

  //==========  FIN CONFIG. GENERICA  ==========

$usersBlob:=PREF_fGetBlob (0;"SN3UsersSettings";$usersBlob)

$OT_Object:=OT BLOBToObject ($usersBlob)

SN3_LoginTypeSel:=OT GetLong ($OT_Object;"loginType")
SN3_PasswordTypeSel:=OT GetLong ($OT_Object;"passwordType")
SN3_WhatUsersSel:=OT GetLong ($OT_Object;"whatUsers")

cb_UsarOtroChar:=OT GetLong ($OT_Object;"useOtherChar")
SN3_Separador:=OT GetText ($OT_Object;"char")
cb_SendByMail:=OT GetLong ($OT_Object;"sendMail")

SN3_LastChanger:=OT GetLong ($OT_Object;"usr_schooltrack")

h1_Todos:=OT GetLong ($OT_Object;"recibirTodos")
h2_SoloNuevos:=OT GetLong ($OT_Object;"recibirNuevos")

r1_AgruparCursoMenor:=OT GetLong ($OT_Object;"cursoMenor")
r2_AgruparCursoMayor:=OT GetLong ($OT_Object;"cursoMayor")

g1_Mail:=OT GetLong ($OT_Object;"porMail")
SN3_MailAddress:=OT GetText ($OT_Object;"email")

g2_Directo:=OT GetLong ($OT_Object;"directo")

cb_FormatoXLS:=OT GetLong ($OT_Object;"excel")
cb_FormatoPDF:=OT GetLong ($OT_Object;"pdf")

OT Clear ($OT_Object)

