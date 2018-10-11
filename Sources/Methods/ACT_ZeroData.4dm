//%attributes = {"executedOnServer":true}
  // ACT_ZeroData()
  //
  //
  // creado por: Alberto Bachler Klein: 17-11-16, 17:42:39
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_BOOLEAN:C305($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_falso;$b_preservarConfig;$b_tablaExcluida)
C_LONGINT:C283($i;$l_registros;$l_zero;$ms)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_clienteRegistrado;$t_mensaje;$t_nombreTabla;$t_vacio)

ARRAY BOOLEAN:C223($ab_falso;0)
ARRAY LONGINT:C221($al_tablasExcluidas;0)
ARRAY LONGINT:C221($al_zero;0)
ARRAY REAL:C219($ar_zero;0)
ARRAY TEXT:C222($at_vacio;0)



If (False:C215)
	C_LONGINT:C283(ACT_ZeroData ;$0)
	C_BOOLEAN:C305(ACT_ZeroData ;$1)
	C_TEXT:C284(ACT_ZeroData ;$2)
End if 

$ms:=Milliseconds:C459


$b_preservarConfig:=$1
If (Count parameters:C259=2)
	$t_clienteRegistrado:=$2
End if 

USR_SetModuleSemaphore (AccountTrack)

  // excluyo las siguientes tablas
If ($b_preservarConfig)
	  // excluyo las tablas de configuración de ACT
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[ACT_CuentasCorrientes:175]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_Items:179]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_ItemsMatriz:180]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[ACT_Matrices:177]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_ItemsCategorias:98]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_ItemsTramos:291]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_MonedaParidad:147]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_Monedas:146]))
	
	  // Modificado por: Saúl Ponce (07-06-2018) Ticket Nº 206230, añado tablas de configuración ACT.
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[ACT_CFG_DctosIndividuales:229]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_ItemsTramos:291]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[ACT_Formas_de_Pago:287]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[ACT_EstadosFormasdePago:201]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_Bancos:129]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[xxACT_ArchivosBancarios:118]))
	APPEND TO ARRAY:C911($al_tablasExcluidas;Table:C252(->[ACT_RazonesSociales:279]))
	
Else 
	  // elimino todas las preferncias de AccountTrack
End if 


OK:=1
For ($i;1;Get last table number:C254)
	If (Is table number valid:C999($i))
		$t_nombreTabla:=Table name:C256($i)
		$y_tabla:=Table:C252($i)
		$b_tablaExcluida:=(Find in array:C230($al_tablasExcluidas;$i)>0)
		If (((Table name:C256($i)="ACT_@") | (Table name:C256($i)="xxACT_@")) & (Not:C34($b_tablaExcluida)))
			READ WRITE:C146($y_tabla->)
			TRUNCATE TABLE:C1051($y_tabla->)  // truncate table no puede operar al interior de una transacción
			If (OK=0)
				$i:=MAXLONG:K35:2
			End if 
		End if 
	End if 
End for 

  // Modificado por: Saul Ponce (18-05-2018) Ticket 206230, preservar las configuraciones.
If (Not:C34($b_preservarConfig))
	If (OK=1)
		START TRANSACTION:C239
		READ WRITE:C146([xShell_Prefs:46])
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1="ACT_@")
		DELETE SELECTION:C66([xShell_Prefs:46])
		OK:=Choose:C955(Records in set:C195("lockedset")=0;1;0)
	End if 
End if 


If (OK=1)
	READ WRITE:C146([Personas:7])
	ALL RECORDS:C47([Personas:7])
	$l_registros:=Records in selection:C76([Personas:7])
	AT_Initialize (->$ar_zero;->$ab_falso;->$at_vacio;->$al_zero)
	AT_RedimArrays ($l_registros;->$ar_zero;->$ab_falso;->$at_vacio;->$al_zero)
	ARRAY TO SELECTION:C261($ar_zero;[Personas:7]ACT_mon_prot_no_reemp:96;$ar_zero;[Personas:7]MontosEmitidos_Ejercicio:82;$ar_zero;[Personas:7]MontosPagados_Ejercicio:84;\
		$ar_zero;[Personas:7]ACT_monto_a_fecha:97;$ar_zero;[Personas:7]MontosProyectados_Ejercicio:81;$ar_zero;[Personas:7]DeudaVencida_Ejercicio:83;$ar_zero;[Personas:7]Saldo_Ejercicio:85;\
		$ab_falso;[Personas:7]ACT_AfectoIntereses:64;$at_vacio;[Personas:7]ACT_Modo_de_pago:39;$at_vacio;[Personas:7]ACT_modo_de_pago_new:95;$al_zero;[Personas:7]ACT_id_modo_de_pago:94)
	OK:=Choose:C955(Records in set:C195("lockedset")=0;1;0)
End if 

If (OK=1)
	If ($b_preservarConfig)
		READ WRITE:C146([ACT_CuentasCorrientes:175])
		ALL RECORDS:C47([ACT_CuentasCorrientes:175])
		$l_registros:=Records in selection:C76([ACT_CuentasCorrientes:175])
		AT_Initialize (->$ar_zero)
		AT_RedimArrays ($l_registros;->$ar_zero)
		ARRAY TO SELECTION:C261($ar_zero;[ACT_CuentasCorrientes:175]Proyectado_Futuro:24\
			;$ar_zero;[ACT_CuentasCorrientes:175]Saldo_Ejercicio:21\
			;$ar_zero;[ACT_CuentasCorrientes:175]Total_DeudaVencida:22\
			;$ar_zero;[ACT_CuentasCorrientes:175]Total_emitidos:5\
			;$ar_zero;[ACT_CuentasCorrientes:175]Total_pagados:6\
			;$ar_zero;[ACT_CuentasCorrientes:175]Total_Saldos:8\
			;$ar_zero;[ACT_CuentasCorrientes:175]Total_Vencida:20\
			;$ar_zero;[ACT_CuentasCorrientes:175]MontosEmitidos_Ejercicio:16\
			;$ar_zero;[ACT_CuentasCorrientes:175]MontosPagados_Ejercicio:17\
			;$ar_zero;[ACT_CuentasCorrientes:175]MontosProyectados_Ejercicio:14\
			;$ar_zero;[ACT_CuentasCorrientes:175]MontosVencidos_Ejercicio:15\
			;$ar_zero;[ACT_CuentasCorrientes:175]Emitido_Futuro:25\
			;$ar_zero;[ACT_CuentasCorrientes:175]DeudaVencida_Ejercicio:18)
		OK:=Choose:C955(Records in set:C195("lockedset")=0;1;0)
	End if 
End if 

If (OK=1)
	VALIDATE TRANSACTION:C240
	If ($b_preservarConfig)
		$t_mensaje:=__ ("AccountTrack fue inicializado preservando la configuración existente.")
		LOG_RegisterEvt ($t_mensaje)
	Else 
		$t_mensaje:=__ ("AccountTrack fue inicializado incluyendo la configuración existente.")
		LOG_RegisterEvt ($t_mensaje)
	End if 
	USR_ClearModuleSemaphore (AccountTrack)
	
Else 
	$t_mensaje:=__ ("No fue posible teminar la inicialización de AccountTrack. Deberá intentarlo nuevamente")
	LOG_RegisterEvt ($t_mensaje)
	CANCEL TRANSACTION:C241
End if 

$ms:=Milliseconds:C459-$ms
$0:=OK

If ($t_clienteRegistrado#"")
	EXECUTE ON CLIENT:C651($t_clienteRegistrado;"Notificacion_Mostrar";__ ("Inicializacion de AccountTrack");$t_mensaje)
Else 
	Notificacion_Mostrar (__ ("Inicializacion de AccountTrack");$t_mensaje)
End if 









