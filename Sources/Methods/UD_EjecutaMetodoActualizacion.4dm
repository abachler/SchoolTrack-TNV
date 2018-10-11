//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 25/04/13, 19:16:32
  // ----------------------------------------------------
  // Método: UD_EjecutaMetodoActualizacion
  // Descripción
  // Este método fue creado para que, por defecto, los métodos de actualización se ejecuten solo una vez por base de datos.
  // Si se necesita ejecutar un método por segunda vez, se puede pasar un True como segundo parametro.
  // Para ejecutar el método, se valida que el método exista.
  // Parámetros
  // $1 método a ejecutar
  // {$2} True para ejecutar siempre. Vacío o False para no ejecutar si ya se ejecutó en la base
  // ----------------------------------------------------

C_TEXT:C284($t_metodo;$1)
C_BOOLEAN:C305($b_forzarEjecucion;$b_ejecutar)
C_LONGINT:C283($l_idRegistro;$l_metodoEjecutado)

$b_ejecutar:=False:C215
$t_metodo:=$1
If (Count parameters:C259>=2)
	$b_forzarEjecucion:=$2
End if 

If ($b_forzarEjecucion)
	$b_ejecutar:=True:C214
Else 
	  //20160517 RCH Se verifica que el metodo efectivamente haya escrito la propiedad de fin.
	  //$l_metodoEjecutado:=Find in field([xShell_MetodoActualizacion]NombreMetodo;$t_metodo)
	  //If ($l_metodoEjecutado=-1)  //el método no ha sido ejecutado en la base de datos.
	  //$b_ejecutar:=True
	  //End if 
	C_LONGINT:C283($l_recs)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recs)
	QUERY:C277([xShell_MetodoActualizacion:252];[xShell_MetodoActualizacion:252]NombreMetodo:2=$t_metodo;*)
	QUERY:C277([xShell_MetodoActualizacion:252]; & ;[xShell_MetodoActualizacion:252]DTS_ejecucionFin_GMT:4#"")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($l_recs=0)  //el método no ha sido ejecutado en la base de datos.
		$b_ejecutar:=True:C214
	End if 
End if 

  //si el metodo no existe no se ejecuta
If ($b_ejecutar)
	If (API Does Method Exist ($t_metodo)=0)
		$b_ejecutar:=False:C215
		ALERT:C41("Método "+ST_Qte ($t_metodo)+", no existe.")
	End if 
End if 

If ($b_ejecutar)
	CREATE RECORD:C68([xShell_MetodoActualizacion:252])
	$l_idRegistro:=SQ_SeqNumber (->[xShell_MetodoActualizacion:252]id:1)
	While (Find in field:C653([xShell_MetodoActualizacion:252]id:1;$l_idRegistro)#-1)
		$l_idRegistro:=SQ_SeqNumber (->[xShell_MetodoActualizacion:252]id:1)
	End while 
	
	[xShell_MetodoActualizacion:252]id:1:=$l_idRegistro
	[xShell_MetodoActualizacion:252]NombreMetodo:2:=$t_metodo
	[xShell_MetodoActualizacion:252]DTS_ejecucionInicio_GMT:3:=DTS_Get_GMT_TimeStamp 
	SAVE RECORD:C53([xShell_MetodoActualizacion:252])
	KRL_UnloadReadOnly (->[xShell_MetodoActualizacion:252])
	
	  //ejecuta método
	EXECUTE FORMULA:C63($t_metodo)
	
	  //guarda DTS cuando se termina
	KRL_FindAndLoadRecordByIndex (->[xShell_MetodoActualizacion:252]id:1;->$l_idRegistro;True:C214)
	[xShell_MetodoActualizacion:252]DTS_ejecucionFin_GMT:4:=DTS_Get_GMT_TimeStamp 
	SAVE RECORD:C53([xShell_MetodoActualizacion:252])
	KRL_UnloadReadOnly (->[xShell_MetodoActualizacion:252])
End if 