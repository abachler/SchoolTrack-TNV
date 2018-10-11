//%attributes = {}
  //EV2_TransfiereEvalSubAsig 

C_BOOLEAN:C305($config_per_var)
C_TEXT:C284($refSubAsignatura)
C_LONGINT:C283($n;$i;$fia;$id_origen;$j;$id_destino;$id_alu)
C_OBJECT:C1216($o_data)

$id_origen:=$1
$id_destino:=$2
$id_alu:=$3


PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

For ($n;1;Size of array:C274(atSTR_Periodos_Nombre))
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id_origen)
	AS_PropEval_Lectura ("";$n)
	
	$config_per_var:=[Asignaturas:18]Consolidacion_PorPeriodo:58
	
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id_destino)
	
	If ($config_per_var=[Asignaturas:18]Consolidacion_PorPeriodo:58)
		
		ARRAY TEXT:C222($atAS_EvalPropSourceNameOri;0)  //destination name
		ARRAY TEXT:C222($atAS_EvalPropClassNameOri;0)  //destination class
		ARRAY LONGINT:C221($alAS_EvalPropSourceIDOri;0)  //id destination
		ARRAY LONGINT:C221($aiAS_EvalPropEnterableOri;0)  //method
		ARRAY REAL:C219($arAS_EvalPropPercentOri;0)  //grade weight
		ARRAY REAL:C219($arAS_EvalPropCoefficientOri;0)  //coefficient
		ARRAY BOOLEAN:C223($abAS_EvalPropPrintDetailOri;0)  //print on reports
		ARRAY TEXT:C222($atAS_EvalPropPrintNameOri;0)  //print as
		ARRAY TEXT:C222($atAS_EvalPropDescriptionOri;0)  //description
		ARRAY DATE:C224($adAS_EvalPropDueDateOri;0)  //due date 
		ARRAY REAL:C219($arAS_EvalPropCoefficientOri;0)  //coefficient  
		
		COPY ARRAY:C226(atAS_EvalPropSourceName;$atAS_EvalPropSourceNameOri)
		COPY ARRAY:C226(atAS_EvalPropClassName;$atAS_EvalPropClassNameOri)
		COPY ARRAY:C226(alAS_EvalPropSourceID;$alAS_EvalPropSourceIDOri)
		COPY ARRAY:C226(aiAS_EvalPropEnterable;$aiAS_EvalPropEnterableOri)
		COPY ARRAY:C226(arAS_EvalPropPercent;$arAS_EvalPropPercentOri)
		COPY ARRAY:C226(arAS_EvalPropCoefficient;$arAS_EvalPropCoefficientOri)
		COPY ARRAY:C226(abAS_EvalPropPrintDetail;$abAS_EvalPropPrintDetailOri)
		COPY ARRAY:C226(atAS_EvalPropPrintName;$atAS_EvalPropPrintNameOri)
		COPY ARRAY:C226(atAS_EvalPropDescription;$atAS_EvalPropDescriptionOri)
		COPY ARRAY:C226(adAS_EvalPropDueDate;$adAS_EvalPropDueDateOri)
		COPY ARRAY:C226(arAS_EvalPropCoefficient;$arAS_EvalPropCoefficientOri)
		
		AS_PropEval_Lectura ("";$n)
		
		For ($i;1;Size of array:C274(atAS_EvalPropSourceName))
			
			  //If (($alAS_EvalPropSourceIDOri{$i}<0) & (alAS_EvalPropSourceID{$i}<0))
			If ($alAS_EvalPropSourceIDOri{$i}<0)
				$fia:=Find in array:C230(atAS_EvalPropSourceName;$atAS_EvalPropSourceNameOri{$i})
				
				If ($fia>0)
					  //If (atAS_EvalPropSourceName{$i}=$atAS_EvalPropSourceNameOri{$i})
					ASsev_InitArrays 
					EV2_InitArrays 
					
					$refSubAsignatura:=String:C10($id_origen)+"."+String:C10($n)+"."+String:C10($i)
					
					READ ONLY:C145([xxSTR_Subasignaturas:83])
					QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$refSubAsignatura)
					
					If (Records in selection:C76([xxSTR_Subasignaturas:83])=1)
						  //ASsev_InitArrays 
						  //BLOB_ExpandBlob_byPointer (->[xxSTR_Subasignaturas]Data)
						  //$offset:=0
						  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalID;"aSubEvalID")
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStdNme;"aSubEvalStdNme")
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalCurso;"aSubEvalCurso")
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStatus;"aSubEvalStatus")
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalOrden;"aSubEvalOrden")
						
						For ($j;1;Size of array:C274(aRealSubEvalArrPtr))
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
						End for 
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalControles;"aRealSubEvalControles")
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
						OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
						
						  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
						  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
						  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentacion)
					End if 
					
					$fia:=Find in array:C230(aSubEvalID;$id_alu)
					
					If ($fia>0)
						C_LONGINT:C283($SubEvalID_temp)
						_O_C_INTEGER:C282($SubEvalOrden_temp)
						C_TEXT:C284($SubEvalStdNme_temp;$SubEvalCurso_temp;$SubEvalStatus_temp)
						C_REAL:C285($RealSubEvalP1_temp;$RealSubEvalControles_temp;$RealSubEvalPresentacion_temp)
						ARRAY REAL:C219($arealsubeval_temp;0)
						
						$SubEvalID_temp:=aSubEvalID{$fia}
						$SubEvalStdNme_temp:=aSubEvalStdNme{$fia}
						$SubEvalCurso_temp:=aSubEvalCurso{$fia}
						$SubEvalStatus_temp:=aSubEvalStatus{$fia}
						  //$SubEvalOrden_temp:=aSubEvalOrden{$fia}
						
						For ($j;1;Size of array:C274(aRealSubEvalArrPtr))
							APPEND TO ARRAY:C911($arealsubeval_temp;aRealSubEvalArrPtr{$j}->{$fia})
						End for 
						
						$RealSubEvalP1_temp:=aRealSubEvalP1{$fia}
						$RealSubEvalControles_temp:=aRealSubEvalControles{$fia}
						$RealSubEvalPresentacion_temp:=aRealSubEvalPresentacion{$fia}
						
						
						  //SUB ASIGNATURA DESTINO
						$refSubAsignatura:=String:C10($id_destino)+"."+String:C10($n)+"."+String:C10($i)
						  //SRal_NotasSubAsignaturas ($refSubAsignatura;$i;$id_alu)
						
						READ WRITE:C146([xxSTR_Subasignaturas:83])
						QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=$refSubAsignatura)
						
						If (Records in selection:C76([xxSTR_Subasignaturas:83])=1)
							ASsev_InitArrays 
							  //MONO TICKET 187315 
							  //BLOB_ExpandBlob_byPointer (->[xxSTR_Subasignaturas]Data)
							  //$offset:=0
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalID;"aSubEvalID")
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStdNme;"aSubEvalStdNme")
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalCurso;"aSubEvalCurso")
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalStatus;"aSubEvalStatus")
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalOrden;"aSubEvalOrden")
							For ($j;1;Size of array:C274(aRealSubEvalArrPtr))
								  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
								OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
							End for 
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
							  //$offset:=BLOB_Blob2Vars (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentacion)
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalP1;"aRealSubEvalP1")
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalControles;"aRealSubEvalControles")
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
							OB_GET ([xxSTR_Subasignaturas:83]o_Data:21;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
							
							$fia:=Find in array:C230(aSubEvalID;$SubEvalID_temp)
							  //APPEND TO ARRAY(aSubEvalID;$SubEvalID_temp)
							  //APPEND TO ARRAY(aSubEvalStdNme;$SubEvalStdNme_temp)
							  //APPEND TO ARRAY(aSubEvalCurso;$SubEvalCurso_temp)
							  //APPEND TO ARRAY(aSubEvalStatus;$SubEvalStatus_temp)
							  //APPEND TO ARRAY(aSubEvalOrden;$SubEvalOrden_temp)
							  //APPEND TO ARRAY(aSubEvalOrden;aSubEvalOrden{Size of array(aSubEvalOrden)}+1)
							
							If ($fia>0)
								
								For ($j;1;Size of array:C274(aRealSubEvalArrPtr))
									aRealSubEvalArrPtr{$j}->{$fia}:=$arealsubeval_temp{$j}
								End for 
								
								aRealSubEvalP1{$fia}:=$RealSubEvalP1_temp
								aRealSubEvalControles{$fia}:=$RealSubEvalControles_temp
								aRealSubEvalPresentacion{$fia}:=$RealSubEvalPresentacion_temp
								
								$o_data:=OB_Create   //MONO TICKET 187315
								OB_SET ($o_data;->aSubEvalID;"aSubEvalID")
								OB_SET ($o_data;->aSubEvalStdNme;"aSubEvalStdNme")
								OB_SET ($o_data;->aSubEvalCurso;"aSubEvalCurso")
								OB_SET ($o_data;->aSubEvalStatus;"aSubEvalStatus")
								OB_SET ($o_data;->aSubEvalOrden;"aSubEvalOrden")
								  //SET BLOB SIZE([xxSTR_Subasignaturas]Data;0)
								  //$offset:=0
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aSubEvalID;->aSubEvalStdNme;->aSubEvalCurso;->aSubEvalStatus;->aSubEvalOrden)
								
								For ($j;1;Size of array:C274(aRealSubEvalArrPtr))
									  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;aRealSubEvalArrPtr{$j})
									OB_SET ($o_data;aRealSubEvalArrPtr{$j};"aRealSubEval"+String:C10($j))
								End for 
								OB_SET ($o_data;->aRealSubEvalP1;"aRealSubEvalP1")
								OB_SET ($o_data;->aRealSubEvalControles;"aRealSubEvalControles")
								OB_SET ($o_data;->aRealSubEvalPresentacion;"aRealSubEvalPresentacion")
								OB_SET ($o_data;->aSubEvalNombreParciales;"aSubEvalNombreParciales")
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalP1)
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalControles)
								  //$offset:=BLOB_Variables2Blob (->[xxSTR_Subasignaturas]Data;$offset;->aRealSubEvalPresentación)
								  //COMPRESS BLOB([xxSTR_Subasignaturas]Data;1)
								[xxSTR_Subasignaturas:83]o_Data:21:=$o_data
								SAVE RECORD:C53([xxSTR_Subasignaturas:83])
								
							End if 
							
							KRL_ReloadAsReadOnly (->[xxSTR_Subasignaturas:83])
							
						End if 
						
					End if 
					
					  //End if 
					
				End if 
				
			End if 
			
		End for 
		
	Else 
		$msg:=""
		$msg:="La verificación de traspaso de evaluaciones de Sub-Asignaturas para "+[Asignaturas:18]denominacion_interna:16
		If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
			$config:="variable en el año "
		Else 
			$config:="fija para todo el año "
		End if 
		$msg:=$msg+" ha sido cancelada debido a que sus propiedades de evaluación son de configuració"+"n "+$config
		If ($config_per_var)
			$config:="variable en el año "
		Else 
			$config:="fija para todo el año "
		End if 
		$msg:=$msg+" y la configuración de proipiedades de evaluación de la asignatura origen es "+$config
		LOG_RegisterEvt ($msg)
		
	End if 
	
End for 
