AL_ExitCell (xALP_CsdList2)

  //DECLARATIONS
C_BOOLEAN:C305($cancelTrans)
C_LONGINT:C283($i;$r)

  //INITIALIZATION
$cancelTrans:=False:C215
$l_RecordNumber:=Record number:C243([Asignaturas:18])
$b_especificaPorPeriodo:=(r2=1)

  //MAIN CODE
Case of 
	: ((vb_CsdVariable=False:C215) & (r2=1))
		$r:=CD_Dlog (0;__ ("Si selecciona esta opción podrá configurar cada período independientemente.\r¿Desea copiar las opciones ya definidas como configuración por defecto para cada uno de los períodos?");__ ("");__ ("Sí");__ ("No");__ ("Cancelar"))
		Case of 
			: ($r=1)  //la respuesta es sí, se copia la consolidación a cada periodo   
				vbRecalcPromedios:=True:C214
				vb_CsdVariable:=True:C214
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
				QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12#vlSTR_PeriodoSeleccionado)
				If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
					$opcion:=1
				Else 
					  //$msg:="Hay sub-asignaturas asociadas a esta asignatura.\rPuede optar por eliminarlas de"+"finitivamente o conservarlas para usarlas posteriormente.\r\r¿Que desea usted hacer"+"?"
					$opcion:=CD_Dlog (0;__ ("Hay sub-asignaturas asociadas a esta asignatura.\rPuede optar por eliminarlas definitivamente o conservarlas para usarlas posteriormente.\r\r¿Que desea usted hacer?");__ ("");__ ("Eliminar");__ ("Conservar");__ ("Cancelar"))
				End if 
				
				Case of 
					: ($opcion=1)  //eliminar subasignaturas
						  //MONO TICKET 214516 En AScsd_DesconectaHijas_TODAS perdemos los valores de las variables de proceso que tienen las configuración anual de cálculo, ponderación, decimales, etc.
						$l_CalcMethod:=vlAS_CalcMethod
						$l_DecimalesPonderacion:=vi_DecimalesPonderacion
						$l_PonderacionTruncada:=vi_PonderacionTruncada
						$l_ConsolidaExamenFinal:=vi_ConsolidaExamenFinal
						$l_ConsolidaNotasFinales:=vi_ConsolidaNotasFinales
						$cancelTrans:=AScsd_DesconectaHijas_TODAS (lConsID;True:C214)
						vlAS_CalcMethod:=$l_CalcMethod
						vi_DecimalesPonderacion:=$l_DecimalesPonderacion
						vi_PonderacionTruncada:=$l_PonderacionTruncada
						vi_ConsolidaExamenFinal:=$l_ConsolidaExamenFinal
						vi_ConsolidaNotasFinales:=$l_ConsolidaNotasFinales
						If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción
							vb_CsdVariable:=True:C214
							POST KEY:C465(27;0)
						End if 
						
					: ($opcion=2)  //conservar subasignaturas
						  //$cancelTrans:=AScsd_ClrSources (False)
						If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción
							vb_CsdVariable:=True:C214
							POST KEY:C465(27;0)
						End if 
						
					: ($opcion=3)
						$cancelTrans:=True:C214
						
				End case 
				
				If (Not:C34($cancelTrans))
					$cancelTrans:=AScsd_CopiaPropiedadesPeriodos (lConsID;sConsName)
				End if 
				
				GOTO RECORD:C242([Asignaturas:18];$l_RecordNumber)
				
				If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción          
					POST KEY:C465(27;0)
				Else 
					  //MONO CAMBIO AS_PropEval_Escritura
					
					AS_PropEval_Escritura (1;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (2;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (3;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (4;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (5;True:C214;$b_especificaPorPeriodo)
					
					AL_RemoveArrays (xALP_CsdList2;1;8)
					AS_PropEval_MenuAsignaturas 
					GOTO RECORD:C242([Asignaturas:18];$l_RecordNumber)
					xALSet_AS_PropiedadesEvaluacion 
					OBJECT SET VISIBLE:C603(*;"periodos";True:C214)
				End if 
				
			: ($r=2)  //la respuesta es no, se inicializa todo
				vbRecalcPromedios:=True:C214
				vb_CsdVariable:=True:C214
				  //se inicializan los parametros de configuración
				AScsd_InicializaPropiedades (lConsID)
				OBJECT SET VISIBLE:C603(*;"ponderacion@";False:C215)  //ASM ticket 216399
				
				  //Configuración de las asignaturas consolidables y subasignaturas (fuentes)
				vbRecalcPromedios:=True:C214
				vb_CsdVariable:=True:C214
				QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=lConsID;*)
				QUERY:C277([xxSTR_Subasignaturas:83]; & [xxSTR_Subasignaturas:83]Periodo:12#vlSTR_PeriodoSeleccionado)
				If (Records in selection:C76([xxSTR_Subasignaturas:83])=0)
					$opcion:=1
				Else 
					  //$msg:="Hay sub-asignaturas asociadas a esta asignatura.\rPuede optar por eliminarlas de"+"finitivamente o conservarlas para usarlas posteriormente.\r\r¿Que desea usted hacer"+"?"
					$opcion:=CD_Dlog (0;__ ("Hay sub-asignaturas asociadas a esta asignatura.\rPuede optar por eliminarlas definitivamente o conservarlas para usarlas posteriormente.\r\r¿Que desea usted hacer?");__ ("");__ ("Eliminar");__ ("Conservar");__ ("Cancelar"))
				End if 
				Case of 
					: ($opcion=1)  //eliminar subasignaturas
						$cancelTrans:=AScsd_DesconectaHijas_TODAS (lConsID;True:C214)
						If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción
							vb_CsdVariable:=True:C214
							POST KEY:C465(27;0)
						End if 
						
					: ($opcion=2)  //conservar subasignaturas
						$cancelTrans:=AScsd_DesconectaHijas_TODAS (lConsID;False:C215)
						If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción
							vb_CsdVariable:=True:C214
							POST KEY:C465(27;0)
						End if 
						
					: ($opcion=3)
						$cancelTrans:=True:C214
						
				End case 
				
				
				
				  //If (Not($cancelTrans))
				If (Not:C34($cancelTrans) & ($r=1))  //ASM ticket 216399
					$cancelTrans:=AScsd_CopiaPropiedadesPeriodos (lConsID;sConsName)
				End if 
				
				If ($cancelTrans)  //si algún registro estaba bloqueado se cancela la transacción
					vb_CsdVariable:=False:C215
					POST KEY:C465(27;0)
				Else 
					vb_CsdVariable:=True:C214
					$l_RecordNumber:=Record number:C243([Asignaturas:18])
					  //configuración de la asignatura consolidante (destino)
					  //MONO CAMBIO AS_PropEval_Escritura
					
					AS_PropEval_Escritura (1;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (2;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (3;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (4;True:C214;$b_especificaPorPeriodo)
					AS_PropEval_Escritura (5;True:C214;$b_especificaPorPeriodo)
					
					
					AL_RemoveArrays (xALP_CsdList2;1;8)
					AS_PropEval_MenuAsignaturas 
					GOTO RECORD:C242([Asignaturas:18];$l_RecordNumber)
					xALSet_AS_PropiedadesEvaluacion 
					OBJECT SET VISIBLE:C603(*;"periodos@";True:C214)
					
				End if 
			: ($r=3)
				r1:=1
				r2:=0
		End case 
End case 


If (Not:C34($cancelTrans))
	vt_textMsg:=__ ("Usted modificó las propiedades de evaluación. Los resultados de los alumnos en esta asignatura seran calculados en otro proceso una vez que usted la libere.")
	APPEND TO ARRAY:C911(atSTR_EventLog;"Atributo \"Específica a cada período \" activado")
End if 
