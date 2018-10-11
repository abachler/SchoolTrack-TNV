//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 02/10/15, 16:29:22
  // ----------------------------------------------------
  // Método: STWA2_OWC_eliminaevento
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$uuid)
C_POINTER:C301($2;$3;$y_ParameterNames;$y_ParameterValues)
C_OBJECT:C1216($ob_raiz)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3

$ob_raiz:=OB_Create 
$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)  //ASM
$idevento:=Num:C11(NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"idevent"))
  //20150824 ASM Ticket 149033  Realizo validaciones
KRL_FindAndLoadRecordByIndex (->[Asignaturas_Eventos:170]ID_Event:11;->$idevento;False:C215)
KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Eventos:170]ID_asignatura:1;False:C215)
$permisoEliminar:=(USR_checkRights ("M";->[Asignaturas:18];$userID)) | ([Asignaturas:18]profesor_numero:4=$profID) | ([Asignaturas:18]profesor_firmante_numero:33=$profID)
If ($permisoEliminar)
	If (KRL_FindAndLoadRecordByIndex (->[Asignaturas_Eventos:170]ID_Event:11;->$idevento;True:C214)>=0)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Eventos:170]ID_asignatura:1;False:C215)
		If (KRL_DeleteRecord (->[Asignaturas_Eventos:170])=0)
			OB_SET_Text ($ob_raiz;"0";"resultado")
		Else 
			OB_SET_Text ($ob_raiz;"1";"resultado")
			Log_RegisterEvtSTW ("Se elimina evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";$userID)
		End if 
	Else 
		OB_SET_Text ($ob_raiz;"0";"resultado")
	End if 
Else 
	OB_SET_Text ($ob_raiz;"notiene";"permiso")
End if 
$json:=OB_Object2Json ($ob_raiz)
$0:=$json
