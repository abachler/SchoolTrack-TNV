//%attributes = {}
  //ACTmnu_GenerarPagaresDesdeAC

C_LONGINT:C283($found)
  //$found:=BWR_SearchRecords 
  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Pagare=0)  // se quitan los avisos que ya tienen un pagare
  //If (Records in selection([ACT_Avisos_de_Cobranza])>0)
If (Size of array:C274(alBWR_recordNumber)>0)
	ARRAY LONGINT:C221($alACT_idsApdos;0)
	ARRAY LONGINT:C221($alACT_idsCtas;0)
	ARRAY LONGINT:C221($alACT_idsAvisos;0)
	ARRAY LONGINT:C221($alACT_idsAvisosPag;0)
	C_LONGINT:C283($i;$vl_records;$j;$vl_idApdo;$vl_resp;$vl_idTercero;$vl_idAlumno;$vl_proc;$vl_avisosProcesados)
	C_TEXT:C284($vt_curso;$vt_sede;$vt_totalAvisos)
	
	ACTcfg_OpcionesPagares ("LeeBlobs")
	
	If (cs_genPagare=1)
		  //$vl_resp:=CD_Dlog (0;__ ("Se generarán pagarés a partir de los avisos de cobranza seleccionados.")+<>cr+<>cr+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
		
		ACTpgr_OpcionesGeneracionDesdAC ("muestraForm")
		$vl_resp:=ok
		
		If ($vl_resp=1)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)
			
			$vt_totalAvisos:=String:C10(Records in selection:C76([ACT_Avisos_de_Cobranza:124]))
			$vl_proc:=IT_UThermometer (1;0;__ ("Emitiendo pagarés. Avisos procesados: ")+"0/"+$vt_totalAvisos)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisos")
			  //DISTINCT VALUES([ACT_Avisos_de_Cobranza]ID_Apoderado;$alACT_idsApdos)
			
			  //For ($i;1;Size of array($alACT_idsApdos))
			While (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
				USE SET:C118("setAvisos")
				ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;>;[ACT_Avisos_de_Cobranza:124]ID_Tercero:26;>;[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
				$vl_idApdo:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
				$vl_idTercero:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
				$vl_idCta:=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2
				
				$vb_continuar:=True:C214
				
				  //If ($vl_idCta#0)
				  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente=$vl_idCta)
				  //End if 
				
				Case of 
					: ($vl_idApdo#0)
						QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$vl_idApdo)
					: ($vl_idTercero#0)
						QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=$vl_idTercero)
						  //: ($vl_idCta#0)
						  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_CuentaCorrriente=$vl_idCta)
					Else 
						$vb_continuar:=False:C215
				End case 
				
				If ($vb_continuar)
					$vl_avisosProcesados:=$vl_avisosProcesados+Records in selection:C76([ACT_Avisos_de_Cobranza:124])
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisosApdo")
					DIFFERENCE:C122("setAvisos";"setAvisosApdo";"setAvisos")
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2#0)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					  //20120723 RCH Generacion por apoderado
					If (($vl_records>0) & (vl_generarPorApdo=0))
						ARRAY LONGINT:C221($alACT_idsCtas;0)
						DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2;$alACT_idsCtas)
						
						For ($j;1;Size of array:C274($alACT_idsCtas))
							USE SET:C118("setAvisosApdo")
							$vl_idCta:=$alACT_idsCtas{$j}
							QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=$vl_idCta)
							SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisosPag)
							$vl_idAlumno:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
							$vt_curso:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAlumno;->[Alumnos:2]curso:20)
							$vt_sede:=KRL_GetTextFieldData (->[Cursos:3]Curso:1;->$vt_curso;->[Cursos:3]Sede:19)
							ACTpgr_CreateRecord (->$alACT_idsAvisosPag;$vt_sede;Current date:C33(*);vtACTp_Periodo;$vl_idApdo;$vl_idCta;$vl_idTercero)
						End for 
					Else 
						SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisosPag)
						ACTpgr_CreateRecord (->$alACT_idsAvisosPag;"";Current date:C33(*);vtACTp_Periodo;$vl_idApdo;0;$vl_idTercero)
					End if 
				End if 
				IT_UThermometer (0;$vl_proc;__ ("Emitiendo pagarés. Avisos procesados: ")+String:C10($vl_avisosProcesados)+"/"+$vt_totalAvisos)
				USE SET:C118("setAvisos")
			End while 
			SET_ClearSets ("setAvisos";"setAvisosApdo")
			IT_UThermometer (-2;$vl_proc)
		End if 
	Else 
		CD_Dlog (0;__ ("La opción ")+ST_Qte (__ ("Generar pagaré"))+" "+__ ("no ha sido marcada en Archivo/Configuración/Generales, pestaña Pagarés."))
	End if 
Else 
	REDUCE SELECTION:C351(yBWR_CurrentTable->;0)
	CD_Dlog (0;__ ("Para utilizar esta opción usted debe tener registros no asociados a Pagarés en el explorador de Avisos de Cobranza."))
End if 