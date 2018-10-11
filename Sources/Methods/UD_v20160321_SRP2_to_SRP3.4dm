//%attributes = {}
  // UD_v20160321_SRP2_to_SRP3()
  //
  //
  // creado por: Alberto Bachler Klein: 23-03-16, 11:23:13
  // -----------------------------------------------------------
C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_guardarScript)
C_LONGINT:C283($i_expresion;$i_lineasCodigo;$i_registros;$i_scripts;$l_areaRef;$l_elementos;$l_error;$l_idObjeto;$l_posicion;$l_posicion2)
C_LONGINT:C283($l_progress)
C_TIME:C306($h_ref)
C_TEXT:C284($t_codigo;$t_codigoActual;$t_debugLog;$t_json;$t_nombreArreglo;$t_nombreVariable;$t_parametros;$t_ruta;$t_tipoObjeto;$t_xml)
C_OBJECT:C1216($ob_cambio;$ob_informe;$ob_log)

ARRAY LONGINT:C221($al_idObjeto;0)
ARRAY LONGINT:C221($al_recNum;0)
ARRAY TEXT:C222($at_expresionActual;0)
ARRAY TEXT:C222($at_expresionReemplazo;0)
ARRAY TEXT:C222($at_lineas;0)
ARRAY TEXT:C222($at_scripts;0)
ARRAY TEXT:C222($at_tipoObjeto;0)
ARRAY OBJECT:C1221($ao_Cambios;0)
ARRAY OBJECT:C1221($ao_informes;0)

APPEND TO ARRAY:C911($at_expresionActual;"[Asignaturas]AsgConsol_ID")
APPEND TO ARRAY:C911($at_expresionReemplazo;"[Asignaturas]Consolidacion_Madre_Id")
APPEND TO ARRAY:C911($at_expresionActual;"[Asignaturas]Consolida_en")
APPEND TO ARRAY:C911($at_expresionReemplazo;"[Asignaturas]Consolidacion_Madre_Nombre")
APPEND TO ARRAY:C911($at_expresionActual;"[Asignaturas]Es_Consolidante")
APPEND TO ARRAY:C911($at_expresionReemplazo;"[Asignaturas]Consolidacion_EsConsolidante")
APPEND TO ARRAY:C911($at_expresionActual;"[Asignaturas]ConsDec")
APPEND TO ARRAY:C911($at_expresionReemplazo;"[Asignaturas]Consolidacion_Metodo")
APPEND TO ARRAY:C911($at_expresionActual;"[MPA_AsignaturasMatrices]CFG_Final_VariableSegunPeriodo")
APPEND TO ARRAY:C911($at_expresionReemplazo;"[MPA_AsignaturasMatrices]CFG_Comp_VariableSegunPeriodo")
APPEND TO ARRAY:C911($at_expresionActual;"[Alumnos_Observaciones]")
APPEND TO ARRAY:C911($at_expresionReemplazo;"[Alumnos_ObsOrientacion]")
APPEND TO ARRAY:C911($at_expresionActual;"AS_ReadEvalProperties")
APPEND TO ARRAY:C911($at_expresionReemplazo;"AS_PropEval_Lectura")
APPEND TO ARRAY:C911($at_expresionActual;"DELETE ELEMENT")
APPEND TO ARRAY:C911($at_expresionReemplazo;"DELETE FROM ARRAY")
APPEND TO ARRAY:C911($at_expresionActual;"INSERT ELEMENT")
APPEND TO ARRAY:C911($at_expresionReemplazo;"INSERT IN ARRAY")
APPEND TO ARRAY:C911($at_expresionActual;"4D Client")
APPEND TO ARRAY:C911($at_expresionReemplazo;"4D Remote Mode")
APPEND TO ARRAY:C911($at_expresionActual;"Find index key")
APPEND TO ARRAY:C911($at_expresionReemplazo;"Find in field")
APPEND TO ARRAY:C911($at_expresionActual;"SET TEXT TO CLIPBOARD")
APPEND TO ARRAY:C911($at_expresionReemplazo;"SET TEXT TO PASTEBOARD")
APPEND TO ARRAY:C911($at_expresionActual;"Ascii")
APPEND TO ARRAY:C911($at_expresionReemplazo;"Character code")
APPEND TO ARRAY:C911($at_expresionActual;"SET WEB SERVICE PARAMETER")
APPEND TO ARRAY:C911($at_expresionReemplazo;"WEB SERVICE SET PARAMETER")
APPEND TO ARRAY:C911($at_expresionActual;"GET WEB SERVICE RESULT")
APPEND TO ARRAY:C911($at_expresionReemplazo;"WEB SERVICE GET RESULT")

READ WRITE:C146([xShell_Reports:54])
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=False:C215)
APPLY TO SELECTION:C70([xShell_Reports:54];[xShell_Reports:54]xReportData_:29:=[xShell_Reports:54]xReportData_:29)

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=False:C215)
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportName:26="")
KRL_DeleteSelection (->[xShell_Reports:54])

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=False:C215)
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="")
KRL_DeleteSelection (->[xShell_Reports:54])

QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=False:C215)
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="gSR2")
QUERY SELECTION BY FORMULA:C207([xShell_Reports:54];BLOB size:C605([xShell_Reports:54]xReportData_:29)=0)
KRL_DeleteSelection (->[xShell_Reports:54])

CIM_CuentaRegistros ("GuardaArchivo")

C_PICTURE:C286($p_vacia)
QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=False:C215)
QUERY SELECTION BY FORMULA:C207([xShell_Reports:54];Picture size:C356([xShell_Reports:54]pSuperReportData:12)>0)
APPLY TO SELECTION:C70([xShell_Reports:54];[xShell_Reports:54]pSuperReportData:12:=$p_vacia)


QUERY:C277([xShell_Reports:54];[xShell_Reports:54]EnRepositorio:48=False:C215)
QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="gSR2")
ORDER BY:C49([xShell_Reports:54];[xShell_Reports:54]ReportName:26;>;[xShell_Reports:54]ID:7;>)


$t_debugLog:=Get 4D folder:C485(Logs folder:K5:19)+Replace string:C233(SYS_GetServerProperty (XS_DataFileName);".4dd";"")+"-ConversionInformes_SRP3.txt"
If (Test path name:C476($t_debugLog)=Is a document:K24:1)
	DELETE DOCUMENT:C159($t_debugLog)
End if 
$h_ref:=Create document:C266($t_debugLog)
SEND PACKET:C103($h_ref;"Informe\tTabla\tCargado\tScripts leidos\tProcesable\tFinalizado\tPurgado\r")
LONGINT ARRAY FROM SELECTION:C647([xShell_Reports:54];$al_recNum)


$l_ProgressProcID:=IT_Progress (1;0;0;"")
For ($i_registros;1;Size of array:C274($al_recNum))
	KRL_GotoRecord (->[xShell_Reports:54];$al_recNum{$i_registros};True:C214)
	
	If ((OK=1) & (BLOB size:C605([xShell_Reports:54]xReportData_:29)>0) & (Is table number valid:C999(Abs:C99([xShell_Reports:54]MainTable:3))))
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i_registros/Size of array:C274($al_recNum);"Actualizando scripts informes…\r"+[xShell_Reports:54]ReportName:26)
		SEND PACKET:C103($h_ref;[xShell_Reports:54]ReportName:26+"\t"+Table name:C256(Abs:C99([xShell_Reports:54]MainTable:3))+"\t")
		$x_blob:=[xShell_Reports:54]xReportData_:29
		$l_error:=SR_ConvertReportToXML ($x_blob;$t_xml;"informe";"")
		If ($l_error=0)
			$l_error:=SR_NewReport ($l_areaRef;$t_xml;0)
		Else 
			$l_error:=SR_NewReportBLOB ($l_areaRef;$x_blob)
		End if 
		
		If ($l_error=0)
			SEND PACKET:C103($h_ref;"SI\t")
			SR_GetAllScripts ($l_areaRef;->$at_scripts;->$al_idObjeto;->$at_tipoObjeto)
			SEND PACKET:C103($h_ref;"SI\t")
			
			
			$b_guardarScript:=False:C215
			For ($i_scripts;1;Size of array:C274($at_scripts))
				
				If ($at_scripts{$i_scripts}#"")
					$l_idObjeto:=$al_idObjeto{$i_scripts}
					$t_tipoObjeto:=$at_tipoObjeto{$i_scripts}
					AT_Text2Array (->$at_lineas;$at_scripts{$i_scripts};"\r")
					For ($i_lineasCodigo;1;Size of array:C274($at_lineas))
						  // substitucion de ARRAY STRING (obsoleto) por ARRAY TEXT
						$l_posicion:=Position:C15("ARRAY STRING(";$at_lineas{$i_lineasCodigo})
						If ($l_posicion>0)
							$t_codigoActual:=$at_lineas{$i_lineasCodigo}
							$t_codigo:=ST_ClearSpaces ($at_lineas{$i_lineasCodigo})
							$t_parametros:=Substring:C12($t_codigo;Position:C15("(";$t_codigo)+1)
							$t_nombreArreglo:=ST_GetWord ($t_parametros;2;";")
							$l_elementos:=Num:C11(ST_GetWord ($t_parametros;3;";"))
							$at_lineas{$i_lineasCodigo}:="ARRAY TEXT("+$t_nombreArreglo+";"+String:C10($l_elementos)+")"
							$b_guardarScript:=True:C214
						End if 
						
						
						  // substitucion de C_STRING (obsoleto) por C_TEXT
						$l_posicion:=Position:C15("C_STRING(";$at_lineas{$i_lineasCodigo})
						If ($l_posicion>0)
							$t_codigoActual:=$at_lineas{$i_lineasCodigo}
							$t_codigo:=ST_ClearSpaces ($at_lineas{$i_lineasCodigo})
							$t_parametros:=Replace string:C233(Substring:C12($t_codigo;Position:C15("(";$t_codigo)+1);")";"")
							$t_nombreVariable:=ST_GetWord ($t_parametros;2;";")
							$at_lineas{$i_lineasCodigo}:="C_TEXT("+$t_nombreVariable+")"
							$b_guardarScript:=True:C214
						End if 
						
						  // reemplazo de AUTOMATIC RELATIONS por SET AUTOMATIC RELATIONS (cambio de nombre de comando)
						$l_posicion2:=Position:C15("SET AUTOMATIC RELATIONS";$at_lineas{$i_lineasCodigo})
						$l_posicion:=Position:C15("AUTOMATIC RELATIONS";$at_lineas{$i_lineasCodigo})
						If (($l_posicion>0) & ($l_posicion2=0))
							$t_codigoActual:=$at_lineas{$i_lineasCodigo}
							$at_lineas{$i_lineasCodigo}:=Replace string:C233($at_lineas{$i_lineasCodigo};"AUTOMATIC RELATIONS";"SET AUTOMATIC RELATIONS")
							$b_guardarScript:=True:C214
						End if 
						
						
						$l_posicion:=Position:C15("SET SET AUTOMATIC RELATIONS";$at_lineas{$i_lineasCodigo})
						If ($l_posicion>0)
							$t_codigoActual:=$at_lineas{$i_lineasCodigo}
							$at_lineas{$i_lineasCodigo}:=Replace string:C233($at_lineas{$i_lineasCodigo};"SET SET AUTOMATIC RELATIONS";"SET AUTOMATIC RELATIONS")
							$b_guardarScript:=True:C214
						End if 
						
						For ($i_expresion;1;Size of array:C274($at_expresionActual))
							If (Position:C15($at_expresionActual{$i_expresion};$at_lineas{$i_lineasCodigo})>0)
								$t_codigoActual:=$at_lineas{$i_lineasCodigo}
								$at_lineas{$i_lineasCodigo}:=Replace string:C233($at_lineas{$i_lineasCodigo};$at_expresionActual{$i_expresion};$at_expresionReemplazo{$i_expresion})
								$b_guardarScript:=True:C214
							End if 
						End for 
					End for 
					
					If ($b_guardarScript)
						$at_scripts{$i_scripts}:=AT_array2text (->$at_lineas;"\r")
					End if 
				End if 
			End for 
			
			If ($b_guardarScript)
				SEND PACKET:C103($h_ref;"SI\t")
				SR_SetScripts ($l_areaRef;->$at_scripts;->$al_idObjeto;->$at_tipoObjeto)
				SEND PACKET:C103($h_ref;"OK\t")
			Else 
				SAVE RECORD:C53([xShell_Reports:54])
				SEND PACKET:C103($h_ref;"NO\tOK\t")
			End if 
			
			SR_DeleteReport ($l_areaRef)
			SEND PACKET:C103($h_ref;"SI\r")
		End if 
		
	Else 
		
	End if 
	SYS_LogUsoMemoriaEjecucion 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLOSE DOCUMENT:C267($h_ref)



