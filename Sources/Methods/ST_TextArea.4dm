//%attributes = {}
  //ST_TextArea - MONO
  // abre un un formulario que contiene un input de texto que se le aplica Spell_CheckSpelling
  // $1 texto
  // $2 titulo para la ventana
  // $0 contenido final del texto

C_TEXT:C284($1;$2;$0;vt_textooriginal;vt_textomodificado;$titulo_ventana)

vt_textooriginal:=$1
$titulo_ventana:=$2

vt_textomodificado:=vt_textooriginal
WDW_OpenFormWindow (->[xxSTR_Constants:1];"ST_AreadeTexto";0;8;$titulo_ventana)
DIALOG:C40([xxSTR_Constants:1];"ST_AreadeTexto")
CLOSE WINDOW:C154

$0:=vt_textomodificado