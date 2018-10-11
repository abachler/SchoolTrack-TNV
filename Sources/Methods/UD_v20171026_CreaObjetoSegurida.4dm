//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 26/10/17, 11:18:35
  // ----------------------------------------------------
  // Método: UD_v20171026_CreaObjetoSegurida
  // Descripción
  //Crear Objeto de Preferencia para Funcionalidad de contraseñas.
  //
  // Parámetros
  // ----------------------------------------------------

C_OBJECT:C1216($ob_temp)
C_OBJECT:C1216($ob_Parametros)
$ob_Parametros:=OB_Create 
OB_SET_Text ($ob_Parametros;"CreaObjeto";"accion")
$ob_temp:=STR_SegAvanzada (->$ob_Parametros)
PREF_SetObject (0;"PreferenciaContraseñas";$ob_temp)