//%attributes = {"executedOnServer":true}
  // BM_CreateRequest(metodo/accion:T; parametrosTexto:T; llaveRegistro:T; obsoleto:T; parametrosBlob:X)
  //
  // version original de Alberto Bachler on 15/8/98
  // modificado por: Alberto Bachler Klein: 26-10-16, 18:55:43
  // Se ejecuta en el servidor
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_BLOB:C604($4)
C_TEXT:C284($5)

C_BLOB:C604($x_parametros)
C_LONGINT:C283($l_IdProceso;$l_recNum)
C_TEXT:C284($t_accion;$t_ejecutarEn;$t_llaveCompuesta;$t_parametros)

If (False:C215)
	C_LONGINT:C283(BM_CreateRequest ;$0)
	C_TEXT:C284(BM_CreateRequest ;$1)
	C_TEXT:C284(BM_CreateRequest ;$2)
	C_TEXT:C284(BM_CreateRequest ;$3)
	C_BLOB:C604(BM_CreateRequest ;$4)
	C_TEXT:C284(BM_CreateRequest ;$5)
End if 

C_BOOLEAN:C305(<>noBatchProcessor)
$t_accion:=$1
$t_parametros:=""


If (<>noBatchProcessor=False:C215)
	If (Count parameters:C259>0)
		Case of 
			: (Count parameters:C259=5)
				$t_parametros:=$2
				$t_llaveCompuesta:=$3
				$x_parametros:=$4
				$t_ejecutarEn:=$5
			: (Count parameters:C259=4)
				$t_parametros:=$2
				$t_llaveCompuesta:=$3
				$x_parametros:=$4
			: (Count parameters:C259=3)
				$t_parametros:=$2
				$t_llaveCompuesta:=$3
			: (Count parameters:C259=2)
				$t_parametros:=$2
		End case 
		
		Case of 
			: ($t_accion="")
				$t_key:=""  // si no hay acción solicitada en la llamada no hay actiona a ejecutar
				
			: ($t_llaveCompuesta="") & ($t_parametros="") & ($t_accion#"")
				$t_key:=$t_accion  // si solo se pasó la acción la llave ES la acción
				
			: ($t_llaveCompuesta="") & ($t_parametros#"")
				$t_Key:=$t_accion+"."+$t_parametros  // si se pasó la acción y parametros compongo la llave con la acción y los parametros
				
			: ($t_llaveCompuesta#"")
				$t_Key:=$t_accion+"="+$t_llaveCompuesta  // si se utiliza una llave compuesta compongo la llave con la acción y la llave compuesta
		End case 
		
		
		If ($t_Key#"")
			$l_recNum:=Find in field:C653([xShell_BatchRequests:48]Key:7;$t_key)  // verifico si la llave existe en la tabla
			$b_agregarTarea:=Choose:C955($l_recNum=No current record:K29:2;True:C214;False:C215)  // si no existe se agrega; si existe no es necesario agregarla
		Else 
			  // si la llave está vacía no hay tarea a ejecutar
			$b_agregarTarea:=False:C215
		End if 
		
		
		If ($b_agregarTarea)  // hay que agregar la tarea
			$t_llaveVacia:=""
			$l_recNumDisponible:=Find in field:C653([xShell_BatchRequests:48]Key:7;$t_llaveVacia)  // busco un registro no utilizado
			If ($l_recNumDisponible=No current record:K29:2)
				CREATE RECORD:C68([xShell_BatchRequests:48])  // si no hay ningún registro disponible agrego uno a la tabla
			Else 
				READ WRITE:C146([xShell_BatchRequests:48])
				GOTO RECORD:C242([xShell_BatchRequests:48];$l_recNumDisponible)  // si hay un registro lo reutilizo
			End if 
			[xShell_BatchRequests:48]Action:1:=$t_accion
			[xShell_BatchRequests:48]Msg:2:=$t_parametros
			[xShell_BatchRequests:48]Key:7:=$t_key
			[xShell_BatchRequests:48]DTS:10:=DTS_MakeFromDateTime +"."+String:C10(Milliseconds:C459)
			[xShell_BatchRequests:48]Parameters:8:=$x_parametros
			[xShell_BatchRequests:48]EjecutarEn:12:=$t_ejecutarEn
			SAVE RECORD:C53([xShell_BatchRequests:48])
			UNLOAD RECORD:C212([xShell_BatchRequests:48])
			READ ONLY:C145([xShell_BatchRequests:48])
		End if 
	End if 
	
	  // si el proceso de ejecución de tareas batch no existe por alguna razón se relanza
	$l_IdProceso:=Process number:C372("Batch Tasks Processor")
	If ($l_IdProceso=0)
		<>l_BatchProcessID:=New process:C317("BM_MainLoop";0;"Batch Tasks Processor";*)
	End if 
	
End if 

