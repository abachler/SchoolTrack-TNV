//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 11-05-17, 14:48:01 
  // ----------------------------------------------------
  // Método: ST_StatusAlumnoPrefSet
  // Descripción: Crea un objeto con dentro de XshellPrefs para contener los status de los alumnos. 
  //Antes inicializados y contenido de esta forma por el método STR_CargaArreglosInterproceso:
  //<>aStatus{1}:="Activo"
  //<>aStatus{2}:="Retirado temporalmente"
  //<>aStatus{3}:="Retirado"
  //<>aStatus{4}:="Promovido anticipadamente"
  //<>aStatus{5}:="Oyente"
  //<>aStatus{6}:="En trámite"
  //<>aStatus{7}:="-"
  //<>aStatus{8}:="Egresado"
  // Esto entrega la posibilidad de Personalizar la lista de Status del Alumno
  // Ticket 174967
  // Cada status tendrá:
  // - uuid: En blanco por ahora, quizas en un futuro Condor unifique estos status y les de un uuid comun para todos los colegios.
  // - alias: Forma de visualizar el status dentro de la aplicación.
  // - visible: opción para tener o no disponible el status dentro de la aplicación.
  //Parámetros:
  //$1 = Array con los Alias
  //$2 = Array status visible 
  // ----------------------------------------------------

C_POINTER:C301($1;$2)
C_OBJECT:C1216($ob_status)
C_TEXT:C284($t_nodo;$t_alias;$t_uuid)
C_BOOLEAN:C305($b_visible)
C_LONGINT:C283($i)
ARRAY TEXT:C222($aStatus;0)
ARRAY TEXT:C222($aStatus;7)
$aStatus{1}:="Activo"
$aStatus{2}:="Retirado temporalmente"
$aStatus{3}:="Retirado"
$aStatus{4}:="Promovido anticipadamente"
$aStatus{5}:="Oyente"
$aStatus{6}:="En trámite"
$aStatus{7}:="Egresado"
ARRAY TEXT:C222($aAlias;0)
ARRAY BOOLEAN:C223($aVisible;0)
ARRAY BOOLEAN:C223($aVisible;7)

If (Count parameters:C259=0)  //Inicializar
	COPY ARRAY:C226($aStatus;$aAlias)
	$b_visible:=True:C214
	AT_Populate (->$aVisible;->$b_visible)
End if 

If (Count parameters:C259>=1)  //Editar Alias
	COPY ARRAY:C226($1->;$aAlias)
	ARRAY TEXT:C222($aAlias;7)
End if 

If (Count parameters:C259=2)
	COPY ARRAY:C226($2->;$aVisible)
End if 

$ob_status:=OB_Create 
$ob_status:=PREF_fGetObject (0;"PrefObj_StatusAlumno";$ob_status)
If (OB_GetSize ($ob_status)=0)
	$ob_status:=OB_Create 
End if 
For ($i;1;Size of array:C274($aStatus))
	$t_nodo:=$aStatus{$i}
	If (Not:C34(OB Is defined:C1231($ob_status;$t_nodo)))
		$t_alias:=$t_nodo
		OB_AppendNode ($ob_status;$t_nodo)
	End if 
	$t_alias:=$aAlias{$i}
	$b_visible:=$aVisible{$i}
	OB_SET ($ob_status;->$t_uuid;$t_nodo+".uuid")
	OB_SET ($ob_status;->$t_alias;$t_nodo+".alias")
	OB_SET ($ob_status;->$b_visible;$t_nodo+".visible")
End for 

PREF_SetObject (0;"PrefObj_StatusAlumno";$ob_status)
KRL_ExecuteEverywhere ("STR_CargaArreglosInterproceso")  //ASM Ticket 217696