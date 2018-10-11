//%attributes = {}
  //SN3_InitConsultaUsuarios

C_LONGINT:C283(bPreviewUsuario)

ARRAY TEXT:C222(SN3_TipoUsuario;0)
ARRAY TEXT:C222(SN3_TipoCodeUsuario;0)
ARRAY TEXT:C222(SN3_AyNUsuarios;0)
ARRAY TEXT:C222(SN3_LoginUsuarios;0)
ARRAY TEXT:C222(SN3_PasswordUsuarios;0)
ARRAY TEXT:C222(SN3_CodeUsuarios;0)
ARRAY LONGINT:C221(SN3_InactivoUsuarios;0)
ARRAY LONGINT:C221(SN3_ColorsUsuarios;0)
ARRAY LONGINT:C221(SN3_StylesUsuarios;0)
ARRAY LONGINT:C221(SN3_BacksUsuarios;0)
ARRAY LONGINT:C221(SN3_ModificadoWebUsuarios;0)
ARRAY TEXT:C222(SN3_CursosUsuarios;0)
ARRAY TEXT:C222(SN3_eMailsUsuarios;0)
ARRAY TEXT:C222(SN3_ultimo_ingreso;0)  //mono 02/07/13 ultimo acceso

ARRAY TEXT:C222(SN3_TipoUsuarioCpy;0)
ARRAY TEXT:C222(SN3_TipoCodeUsuarioCpy;0)
ARRAY TEXT:C222(SN3_AyNUsuariosCpy;0)
ARRAY TEXT:C222(SN3_LoginUsuariosCpy;0)
ARRAY TEXT:C222(SN3_PasswordUsuariosCpy;0)
ARRAY TEXT:C222(SN3_CodeUsuariosCpy;0)
ARRAY LONGINT:C221(SN3_InactivoUsuariosCpy;0)
ARRAY LONGINT:C221(SN3_ColorsUsuariosCpy;0)
ARRAY LONGINT:C221(SN3_ModificadoWebUsuariosCpy;0)
ARRAY TEXT:C222(SN3_CursosUsuariosCpy;0)
ARRAY TEXT:C222(SN3_eMailsUsuariosCpy;0)
ARRAY TEXT:C222(SN3_ultimo_ingresoCpy;0)  //mono 02/07/13 ultimo acceso

ARRAY TEXT:C222(SN3_ConsultaUsuarios;0)  //receptor de consulta web service

IT_SetButtonState (False:C215;->bPrintUsuarios;->bSaveUsuarios;->bPreviewUsuario)
g_Todos:=1
g_Alumnos:=0
g_relaciones:=0
r_Todos:=1
r_Activos:=0
r_Inactivos:=0
h_Todos:=1
h_NoModificados:=0
h_Modificados:=0
cb_SendMailInactivar:=0
SN3_SearchString:=""
_O_DISABLE BUTTON:C193(bSearch)
_O_DISABLE BUTTON:C193(*;"opcionesLista@")

SN3_ListMessage:="Mostrando 0 usuarios de 0 recibidos."

GOTO OBJECT:C206(SN3_Searchstring)

titulo1:=0
titulo2:=0
titulo3:=0
titulo4:=0
titulo5:=0