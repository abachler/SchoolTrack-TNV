//%attributes = {}
  //ACTcfg_OpcionesListaMatrices

C_TEXT:C284($t_accion;$1;$t_retorno;$0)
C_POINTER:C301($y_puntero1;$y_puntero2)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_puntero1:=$2
End if 
If (Count parameters:C259>=3)
	$y_puntero2:=$3
End if 

Case of 
	: ($t_accion="onLoadConf")
		  //ACTcfg_OpcionesListaMatrices ("onLoadConf")
		
		  //declara arreglos
		ARRAY TEXT:C222(atACT_ReglasMatricesNombre;0)
		ARRAY TEXT:C222(atACT_ReglasMatricesMatriz;0)
		ARRAY LONGINT:C221(alACT_ReglasMatricesMatriz;0)
		ARRAY LONGINT:C221(alACT_ReglasMatricesAlumnos;0)
		ARRAY BOOLEAN:C223(abACT_ReglasMatricesInactivo;0)
		ARRAY LONGINT:C221(alACT_ReglasMatricesID;0)
		
		  //ARRAY LONGINT(alACT_ReglasMatricesConsulta;0)
		  //ARRAY TEXT(atACT_ReglasMatricesConsulta;0)
		
		  //Lee tabla
		C_LONGINT:C283($l_indice)
		READ ONLY:C145([ACT_MatricesAsignacionAut:289])
		ALL RECORDS:C47([ACT_MatricesAsignacionAut:289])
		
		ORDER BY:C49([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]Inactiva:5;>;[ACT_MatricesAsignacionAut:289]orden:6;>)
		
		SELECTION TO ARRAY:C260([ACT_MatricesAsignacionAut:289]ID:1;alACT_ReglasMatricesID;[ACT_MatricesAsignacionAut:289]id_matriz:4;alACT_ReglasMatricesMatriz;[ACT_MatricesAsignacionAut:289]Inactiva:5;abACT_ReglasMatricesInactivo;[ACT_MatricesAsignacionAut:289]nombre:3;atACT_ReglasMatricesNombre)
		  //[ACT_MatricesAsignacionAut]id_consulta;alACT_ReglasMatricesConsulta)
		
		
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([ACT_Matrices:177])
		
		AT_RedimArrays (Size of array:C274(alACT_ReglasMatricesID);->atACT_ReglasMatricesNombre;->alACT_ReglasMatricesAlumnos;->atACT_ReglasMatricesMatriz)
		For ($l_indice;1;Size of array:C274(alACT_ReglasMatricesID))
			ACTcfg_OpcionesListaMatrices ("ObtieneDatos";->alACT_ReglasMatricesID{$l_indice})
		End for 
		
		  //ops
		ACTcfg_OpcionesListaMatrices ("LeeDia")
		
	: ($t_accion="EditaLinea")
		READ WRITE:C146([ACT_MatricesAsignacionAut:289])
		QUERY:C277([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]ID:1=$y_puntero1->)
		If (Not:C34(Locked:C147([ACT_MatricesAsignacionAut:289])))
			C_TEXT:C284($title)
			$title:=__ ("Asignación de matrices")
			WDW_OpenFormWindow (->[ACT_MatricesAsignacionAut:289];"Regla";-1;4;$title)
			FORM SET INPUT:C55([ACT_MatricesAsignacionAut:289];"Regla")
			MODIFY RECORD:C57([ACT_MatricesAsignacionAut:289];*)
			CLOSE WINDOW:C154
			If (ok=1)
				ACTcfg_OpcionesListaMatrices ("ObtieneDatos";->[ACT_MatricesAsignacionAut:289]ID:1)
			End if 
		Else 
			CD_Dlog (0;"El registro no puede ser editado en este momento.")
		End if 
		
		KRL_UnloadReadOnly (->[ACT_MatricesAsignacionAut:289])
		
	: ($t_accion="AgregaLinea")
		C_TEXT:C284($title)
		$title:=__ ("Asignación de matrices")
		WDW_OpenFormWindow (->[ACT_MatricesAsignacionAut:289];"Regla";-1;4;$title)
		FORM SET INPUT:C55([ACT_MatricesAsignacionAut:289];"Regla")
		ADD RECORD:C56([ACT_MatricesAsignacionAut:289];*)
		CLOSE WINDOW:C154
		
		  //actualiza alumnos
		If (ok=1)
			ACTcfg_OpcionesListaMatrices ("ActualizaContador";->[ACT_MatricesAsignacionAut:289]ID:1)
		End if 
		KRL_UnloadReadOnly (->[ACT_MatricesAsignacionAut:289])
		
	: ($t_accion="ActualizaContador")
		C_LONGINT:C283($l_pos)
		$l_pos:=Find in array:C230(alACT_ReglasMatricesID;$y_puntero1->)
		If ($l_pos>0)
			C_LONGINT:C283($l_Recs)
			If (Not:C34(KRL_GetBooleanFieldData (->[ACT_MatricesAsignacionAut:289]ID:1;->alACT_ReglasMatricesID{$l_pos};->[ACT_MatricesAsignacionAut:289]Inactiva:5)))
				$l_Recs:=Num:C11(ACTcfg_OpcionesListaMatrices ("BuscaCuentas";$y_puntero1))
			Else 
				$l_Recs:=0
			End if 
			alACT_ReglasMatricesAlumnos{$l_pos}:=$l_Recs
		End if 
		
	: ($t_accion="ObtieneDatos")
		C_LONGINT:C283($l_pos)
		$l_pos:=Find in array:C230(alACT_ReglasMatricesID;$y_puntero1->)
		If ($l_pos>0)
			KRL_FindAndLoadRecordByIndex (->[ACT_MatricesAsignacionAut:289]ID:1;->alACT_ReglasMatricesID{$l_pos})
			
			atACT_ReglasMatricesNombre{$l_pos}:=[ACT_MatricesAsignacionAut:289]nombre:3
			
			If (alACT_ReglasMatricesMatriz{$l_pos}>0)
				atACT_ReglasMatricesMatriz{$l_pos}:=KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->alACT_ReglasMatricesMatriz{$l_pos};->[ACT_Matrices:177]Nombre_matriz:2)
			Else 
				atACT_ReglasMatricesMatriz{$l_pos}:="Ninguna"
			End if 
			ACTcfg_OpcionesListaMatrices ("ActualizaContador";->alACT_ReglasMatricesID{$l_pos})
			
			abACT_ReglasMatricesInactivo{$l_pos}:=KRL_GetBooleanFieldData (->[ACT_MatricesAsignacionAut:289]ID:1;->alACT_ReglasMatricesID{$l_pos};->[ACT_MatricesAsignacionAut:289]Inactiva:5)
			
		End if 
		
	: ($t_accion="EliminaLinea")
		READ WRITE:C146([ACT_MatricesAsignacionAut:289])
		QUERY:C277([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]ID:1=$y_puntero1->)
		If (Not:C34(End selection:C36([ACT_MatricesAsignacionAut:289])))
			LOG_RegisterEvt ("Eliminación de regla de asignación automática de matriz de cargo. Regla eliminada: "+[ACT_MatricesAsignacionAut:289]nombre:3+", id: "+String:C10([ACT_MatricesAsignacionAut:289]ID:1)+".")
			DELETE RECORD:C58([ACT_MatricesAsignacionAut:289])
			$t_retorno:="1"
		Else 
			$t_retorno:="0"
		End if 
		KRL_UnloadReadOnly (->[ACT_MatricesAsignacionAut:289])
		
	: ($t_accion="Guardar")
		READ WRITE:C146([ACT_MatricesAsignacionAut:289])
		C_LONGINT:C283($l_indiceActivos)
		$l_indiceActivos:=0
		For ($l_indice;1;Size of array:C274(alACT_ReglasMatricesMatriz))
			QUERY:C277([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]ID:1=alACT_ReglasMatricesID{$l_indice})
			[ACT_MatricesAsignacionAut:289]id_matriz:4:=alACT_ReglasMatricesMatriz{$l_indice}
			[ACT_MatricesAsignacionAut:289]Inactiva:5:=abACT_ReglasMatricesInactivo{$l_indice}
			If (Not:C34([ACT_MatricesAsignacionAut:289]Inactiva:5))
				$l_indiceActivos:=$l_indiceActivos+1
				If ([ACT_MatricesAsignacionAut:289]orden:6#$l_indiceActivos)
					LOG_RegisterEvt ("Cambio en orden de regla de asignación automática de matrices de cargo para regla: "+ST_Qte ([ACT_MatricesAsignacionAut:289]nombre:3)+", id: "+String:C10([ACT_MatricesAsignacionAut:289]ID:1)+". Cambió de "+String:C10([ACT_MatricesAsignacionAut:289]orden:6)+" a "+String:C10($l_indiceActivos)+".")
					[ACT_MatricesAsignacionAut:289]orden:6:=$l_indiceActivos
				End if 
			End if 
			SAVE RECORD:C53([ACT_MatricesAsignacionAut:289])
		End for 
		KRL_UnloadReadOnly (->[ACT_MatricesAsignacionAut:289])
		
		C_BLOB:C604($xBlob)
		BLOB_Variables2Blob (->$xBlob;0;->lACT_ReglasMatricesDia;->lACT_QuitaMatriz)
		PREF_SetBlob (0;"ACT_Conf_Asign_Matrices";$xBlob)
		
	: ($t_accion="LeeDia")
		C_BLOB:C604($xBlob)
		C_LONGINT:C283(lACT_ReglasMatricesDia;lACT_QuitaMatriz)
		lACT_ReglasMatricesDia:=0
		lACT_QuitaMatriz:=1
		
		BLOB_Variables2Blob (->$xBlob;0;->lACT_ReglasMatricesDia;->lACT_QuitaMatriz)
		$xBlob:=PREF_fGetBlob (0;"ACT_Conf_Asign_Matrices";$xBlob)
		BLOB_Blob2Vars (->$xBlob;0;->lACT_ReglasMatricesDia;->lACT_QuitaMatriz)
		
		
	: ($t_accion="BuscaCuentas")
		REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
		KRL_FindAndLoadRecordByIndex (->[ACT_MatricesAsignacionAut:289]ID:1;$y_puntero1)
		$t_retorno:=String:C10(QRY_ExecuteQuery_Blob (vyQRY_TablePointer;[ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7))
		
	: ($t_accion="AplicaMatrices")
		C_BOOLEAN:C305($b_asignarMatriz)
		$b_asignarMatriz:=True:C214
		
		If (Not:C34(Is nil pointer:C315($y_puntero1)))
			$b_asignarMatriz:=$y_puntero1->
		End if 
		
		ARRAY LONGINT:C221($al_idsNumsMatr;0)
		ARRAY LONGINT:C221($al_idsMatriz;0)
		
		READ ONLY:C145([ACT_MatricesAsignacionAut:289])
		QUERY:C277([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]Inactiva:5=False:C215)
		ORDER BY:C49([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]orden:6;>)
		SELECTION TO ARRAY:C260([ACT_MatricesAsignacionAut:289]ID:1;$al_idsNumsMatr;[ACT_MatricesAsignacionAut:289]id_matriz:4;$al_idsMatriz)
		
		CREATE EMPTY SET:C140([ACT_CuentasCorrientes:175];"CuentasProcesadas")
		For ($l_indice;1;Size of array:C274($al_idsNumsMatr))
			ACTcfg_OpcionesListaMatrices ("BuscaCuentas";->$al_idsNumsMatr{$l_indice})
			CREATE SET:C116([ACT_CuentasCorrientes:175];"setEncontradas")
			DIFFERENCE:C122("setEncontradas";"CuentasProcesadas";"2Asignar")
			UNION:C120("CuentasProcesadas";"2Asignar";"CuentasProcesadas")
			If ($b_asignarMatriz)
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				USE SET:C118("2Asignar")
				ACTmatrices_AsignaNuevasMatrice (Choose:C955($al_idsMatriz{$l_indice}=-1;0;$al_idsMatriz{$l_indice}))
			End if 
		End for 
		USE SET:C118("CuentasProcesadas")
		
		  //limpia matrices de cuentas activas que no fueron procesadas
		If ($b_asignarMatriz)
			If (lACT_QuitaMatriz=1)
				ARRAY LONGINT:C221($al_idCta;0)
				ARRAY LONGINT:C221($al_idMatriz;0)
				READ WRITE:C146([ACT_CuentasCorrientes:175])
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214;*)
				QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]ID_Matriz:7>0)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"activas")
				
				DIFFERENCE:C122("activas";"CuentasProcesadas";"2limpiar")
				USE SET:C118("2limpiar")
				ACTmatrices_AsignaNuevasMatrice (0)
				
				KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
			End if 
		End if 
		
		SET_ClearSets ("CuentasProcesadas";"setEncontradas";"2Asignar";"activas";"2limpiar")
		
	: ($t_accion="VerAlumnos")
		ACTcfg_OpcionesListaMatrices ("BuscaCuentas";$y_puntero1)
		ACTcfg_OpcionesListaMatrices ("MuestraAlumnos";$y_puntero2)
		
		
	: ($t_accion="MuestraAlumnos")
		READ ONLY:C145([Alumnos:2])
		CREATE SET:C116([ACT_CuentasCorrientes:175];"amostrar")
		USE SET:C118($y_puntero1->)
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		ARRAY LONGINT:C221($alACT_idsAlumnos1;0)
		SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID_Alumno:3;$alACT_idsAlumnos1)
		
		ALL RECORDS:C47([ACT_CuentasCorrientes:175])
		ARRAY LONGINT:C221($alACT_idsAlumnos3;0)
		ARRAY LONGINT:C221($alACT_alumnosMatrices;0)
		SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID_Alumno:3;$alACT_idsAlumnos3;[ACT_CuentasCorrientes:175]ID_Matriz:7;$alACT_alumnosMatrices)
		
		USE SET:C118("amostrar")
		SET_ClearSets ("amostrar")
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		
		ARRAY TEXT:C222(atACT_alumnosNombres;0)
		ARRAY TEXT:C222(atACT_alumnosCurso;0)
		ARRAY LONGINT:C221(alACT_colores;0)  //COLORES
		ARRAY LONGINT:C221($alACT_idsAlumnos2;0)
		ARRAY TEXT:C222(atACT_alumnosMatrices;0)
		
		
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;atACT_alumnosNombres;[Alumnos:2]curso:20;atACT_alumnosCurso;[Alumnos:2]numero:1;$alACT_idsAlumnos2)
		
		C_REAL:C285($r_rgbRojo;$r_rgbVerde)
		$r_rgbRojo:=16711680  //ROJO
		$r_rgbVerde:=34816  //VERDE
		For ($l_indice;1;Size of array:C274(atACT_alumnosNombres))
			If (Find in array:C230($alACT_idsAlumnos1;$alACT_idsAlumnos2{$l_indice})>0)
				APPEND TO ARRAY:C911(alACT_colores;$r_rgbRojo)
			Else 
				APPEND TO ARRAY:C911(alACT_colores;$r_rgbVerde)
			End if 
			
			$l_pos:=Find in array:C230($alACT_idsAlumnos3;$alACT_idsAlumnos2{$l_indice})
			If ($l_pos>0)
				If ($alACT_alumnosMatrices{$l_pos}>0)
					APPEND TO ARRAY:C911(atACT_alumnosMatrices;KRL_GetTextFieldData (->[ACT_Matrices:177]ID:1;->$alACT_alumnosMatrices{$l_pos};->[ACT_Matrices:177]Nombre_matriz:2))
				Else 
					APPEND TO ARRAY:C911(atACT_alumnosMatrices;"")
				End if 
			Else 
				APPEND TO ARRAY:C911(atACT_alumnosMatrices;"")
			End if 
			
		End for 
		
		WDW_OpenFormWindow (->[Alumnos:2];"ListaAlumnos";0;-Palette form window:K39:9;__ ("Alumnos"))
		DIALOG:C40([Alumnos:2];"ListaAlumnos")
		CLOSE WINDOW:C154
		
End case 

$0:=$t_retorno