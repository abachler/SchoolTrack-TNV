//%attributes = {"executedOnServer":true}
  // KRL_GetLockedRecordsInfo()
  //
  //
  // creado por: Alberto Bachler Klein: 18-11-16, 08:19:43
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_POINTER:C301($1)
C_POINTER:C301($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)
C_POINTER:C301($7)

C_BOOLEAN:C305($b_esRemoto)
C_LONGINT:C283($i;$l_numeroProceso)
C_POINTER:C301($y_esTareaRemota;$y_idProceso;$y_nombreMaquina;$y_nombreProceso;$y_nombreUsuario;$y_objeto;$y_tabla)
C_TEXT:C284($t_maquina;$t_nombreProceso;$t_usuarioSistema)
C_OBJECT:C1216($ob_atributosContexto;$ob_Resultado)

ARRAY OBJECT:C1221($ao_registrosBloqueados;0)



If (False:C215)
	C_LONGINT:C283(KRL_GetLockedRecordsInfo ;$0)
	C_POINTER:C301(KRL_GetLockedRecordsInfo ;$1)
	C_POINTER:C301(KRL_GetLockedRecordsInfo ;$2)
	C_POINTER:C301(KRL_GetLockedRecordsInfo ;$3)
	C_POINTER:C301(KRL_GetLockedRecordsInfo ;$4)
	C_POINTER:C301(KRL_GetLockedRecordsInfo ;$5)
	C_POINTER:C301(KRL_GetLockedRecordsInfo ;$6)
	C_POINTER:C301(KRL_GetLockedRecordsInfo ;$7)
End if 

$y_tabla:=$1

Case of 
	: (Count parameters:C259=7)
		$y_objeto:=$7
		$y_idProceso:=$6
		$y_nombreProceso:=$5
		$y_nombreMaquina:=$4
		$y_esTareaRemota:=$3
		$y_nombreUsuario:=$2
		
	: (Count parameters:C259=6)
		$y_idProceso:=$6
		$y_nombreProceso:=$5
		$y_nombreMaquina:=$4
		$y_esTareaRemota:=$3
		$y_nombreUsuario:=$2
		
	: (Count parameters:C259=5)
		$y_nombreProceso:=$5
		$y_nombreMaquina:=$4
		$y_esTareaRemota:=$3
		$y_nombreUsuario:=$2
		
	: (Count parameters:C259=4)
		$y_nombreMaquina:=$4
		$y_esTareaRemota:=$3
		$y_nombreUsuario:=$2
		
	: (Count parameters:C259=3)
		$y_esTareaRemota:=$3
		$y_nombreUsuario:=$2
		
	: (Count parameters:C259=2)
		$y_nombreUsuario:=$2
End case 


$ob_Resultado:=Get locked records info:C1316($y_tabla->)
OB GET ARRAY:C1229($ob_Resultado;"records";$ao_registrosBloqueados)


For ($i;1;Size of array:C274($ao_registrosBloqueados))
	OB_GET ($ao_registrosBloqueados{$i};->$ob_atributosContexto;"contextAttributes")
	OB_GET ($ob_atributosContexto;->$b_esRemoto;"is_remote_context")
	OB_GET ($ob_atributosContexto;->$t_usuarioSistema;"user_name")
	OB_GET ($ob_atributosContexto;->$t_maquina;"host_name")
	OB_GET ($ob_atributosContexto;->$t_nombreProceso;"task_name")
	OB_GET ($ob_atributosContexto;->$l_numeroProceso;"task_id")
	
	If (Not:C34(Is nil pointer:C315($y_nombreUsuario)))
		APPEND TO ARRAY:C911($y_nombreUsuario->;$t_usuarioSistema)
	End if 
	
	If (Not:C34(Is nil pointer:C315($y_esTareaRemota)))
		APPEND TO ARRAY:C911($y_esTareaRemota->;$b_esRemoto)
	End if 
	
	If (Not:C34(Is nil pointer:C315($y_nombreMaquina)))
		APPEND TO ARRAY:C911($y_nombreMaquina->;$t_maquina)
	End if 
	
	If (Not:C34(Is nil pointer:C315($y_nombreProceso)))
		APPEND TO ARRAY:C911($y_nombreProceso->;$t_nombreProceso)
	End if 
	
	If (Not:C34(Is nil pointer:C315($y_idProceso)))
		APPEND TO ARRAY:C911($y_idProceso->;$l_numeroProceso)
	End if 
End for 


$0:=Size of array:C274($ao_registrosBloqueados)




