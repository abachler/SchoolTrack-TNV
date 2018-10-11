//%attributes = {}
C_OBJECT:C1216($ob_objeto)
C_LONGINT:C283($l_idEvento;$l_idUsuario;$l_idProfesor)
C_BOOLEAN:C305($b_desdeSTWA)
C_TEXT:C284($t_evento_text)
C_BOOLEAN:C305($b_editable)

$ob_objeto:=$1
$l_idEvento:=$2
$l_idUsuario:=$3
$l_idProfesor:=$4
$b_desdeSTWA:=$5

KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Eventos:170]ID_asignatura:1;False:C215)
If ([Asignaturas_Eventos:170]Evento:3#"")
	$t_evento_text:="["+[Asignaturas:18]Curso:5+"]"+"["+[Asignaturas:18]Abreviación:26+"]"+[Asignaturas_Eventos:170]Evento:3
Else 
	$t_evento_text:="["+[Asignaturas:18]Curso:5+"]"+"["+[Asignaturas:18]Abreviación:26+"]"+[Asignaturas_Eventos:170]Tipo Evento:7
End if 
$b_editable:=(($l_idUsuario<0) | (USR_IsGroupMember_by_GrpID (-15001;$l_idUsuario)) | ([Asignaturas:18]profesor_numero:4=$l_idProfesor) | ([Asignaturas:18]profesor_firmante_numero:33=$l_idProfesor) | ([Asignaturas_Eventos:170]UserID:10=$l_idUsuario))

OB_SET ($ob_objeto;->[Asignaturas_Eventos:170]ID_Event:11;"id")
OB_SET ($ob_objeto;->[Asignaturas_Eventos:170]Auto_UUID:18;"uuid")
OB_SET ($ob_objeto;->$t_evento_text;"title")
If ($b_desdeSTWA)
	OB_SET_Text ($ob_objeto;String:C10([Asignaturas_Eventos:170]Fecha:2;ISO date:K1:8);"start")
Else 
	OB_SET_Text ($ob_objeto;SN3_MakeDateInmune2LocalFormat2 ([Asignaturas_Eventos:170]Fecha:2);"start")
End if 
OB_SET ($ob_objeto;->[Asignaturas_Eventos:170]Descripción:4;"desc")
OB_SET ($ob_objeto;->[Asignaturas_Eventos:170]Tipo Evento:7;"tipo")
OB_SET ($ob_objeto;->[Asignaturas_Eventos:170]Evento:3;"evento")
OB_SET ($ob_objeto;->[Asignaturas:18]auto_uuid:12;"uuidasignatura")
OB_SET ($ob_objeto;->[Asignaturas:18]Curso:5;"curso")
OB_SET ($ob_objeto;->[Asignaturas:18]denominacion_interna:16;"asignatura")
OB_SET ($ob_objeto;->[Asignaturas:18]Abreviación:26;"abrev")
OB_SET ($ob_objeto;->[Asignaturas:18]profesor_nombre:13;"profesor")
OB_SET ($ob_objeto;->[Asignaturas_Eventos:170]Privado:9;"privado")
OB_SET ($ob_objeto;->[Asignaturas_Eventos:170]Publicar:5;"publicar")
OB_SET ($ob_objeto;->$b_editable;"editable")
OB_SET_Text ($ob_objeto;String:C10([Asignaturas_Eventos:170]Hora_Inicio:13);"horadesde")
OB_SET_Text ($ob_objeto;String:C10([Asignaturas_Eventos:170]Hora_Termino:14);"horahasta")
