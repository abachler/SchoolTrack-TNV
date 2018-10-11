//%attributes = {}
  // Método: ACTac_RecalculaAvisos
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 10-03-10, 14:19:03
  // ---------------------------------------------
  // Descripción: 
  // metodo que calcula montos de avisos con saldo cuando se elimina un cargo y/o un aviso...
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($vt_accion;$1)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2)
C_LONGINT:C283($vlACT_idApdo;$vlACT_idTer)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

  // Código principal
Case of 
	: ($vt_accion="DeclaraVar")
		C_BOOLEAN:C305(vbACTac_AgregarElementos)
		
	: ($vt_accion="DeclaraVars")
		ARRAY LONGINT:C221(vlACTac_IdApdo;0)
		ARRAY LONGINT:C221(vlACTac_IdTercero;0)
		C_BOOLEAN:C305(vbACTac_CargoBorrado)
		ACTac_RecalculaAvisos ("DeclaraVar")
		
	: ($vt_accion="InitVars")
		vbACTac_CargoBorrado:=False:C215
		vbACTac_AgregarElementos:=True:C214
		AT_Initialize (->vlACTac_IdApdo;->vlACTac_IdTercero)
		
	: ($vt_accion="DeclaraInitVars")
		ACTac_RecalculaAvisos ("DeclaraVars")
		ACTac_RecalculaAvisos ("InitVars")
		
	: ($vt_accion="CapturaVars")
		ACTac_RecalculaAvisos ("DeclaraInitVars")
		ACTac_RecalculaAvisos ("AgregarElemento";$ptr1;$ptr2)
		
	: ($vt_accion="AgregarElemento")
		ACTac_RecalculaAvisos ("DeclaraVar")
		If (vbACTac_AgregarElementos)
			If (Not:C34(Is nil pointer:C315($ptr1)))
				$vlACT_idApdo:=$ptr1->
			End if 
			If (Not:C34(Is nil pointer:C315($ptr2)))
				$vlACT_idTer:=$ptr2->
			End if 
			If ($vlACT_idApdo#0)
				If (Find in array:C230(vlACTac_IdApdo;$vlACT_idApdo)=-1)
					APPEND TO ARRAY:C911(vlACTac_IdApdo;$vlACT_idApdo)
				End if 
			End if 
			If ($vlACT_idTer#0)
				If (Find in array:C230(vlACTac_IdTercero;$vlACT_idTer)=-1)
					APPEND TO ARRAY:C911(vlACTac_IdTercero;$vlACT_idTer)
				End if 
			End if 
		End if 
		
	: ($vt_accion="RecalculaAviso")
		ACTac_RecalculaAvisos ("DeclaraVar")
		If (vbACTac_AgregarElementos)
			$recNumAviso:=Record number:C243([ACT_Avisos_de_Cobranza:124])
			ACTac_RecalculaAvisos ("RecalculaArerglosApdo";->vlACTac_IdApdo)
			ACTac_RecalculaAvisos ("RecalculaArerglosTercero";->vlACTac_IdTercero)
			ACTac_RecalculaAvisos ("InitVars")
			vbACTac_AgregarElementos:=False:C215
			vbACTac_CargoBorrado:=False:C215
			KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$recNumAviso)
		End if 
		
	: ($vt_accion="RecalculaArerglos@")
		If (Size of array:C274($ptr1->)>0)
			ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
			If (cb_IncluirSaldosAnteriores=1)
				C_BLOB:C604(xBlob)
				C_DATE:C307(vd_fecha)
				
				vd_fecha:=Current date:C33(*)
				SET BLOB SIZE:C606(xBlob;0)
				
				  //20150605 RCH Se agregan ventana de información al usuario de avance de proceso...
				If (Size of array:C274($ptr1->)>15)
					$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Recalculando Saldos en Avisos de Cobranza..."))
				End if 
				
				For ($i;1;Size of array:C274($ptr1->))
					READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
					Case of 
						: ($vt_accion="RecalculaArerglosApdo")
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$ptr1->{$i};*)
							QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
							$vt_accion:="Apdo_"+String:C10($ptr1->{$i})
						: ($vt_accion="RecalculaArerglosTercero")
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=$ptr1->{$i};*)
							QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
							$vt_accion:="Tercero_"+String:C10($ptr1->{$i})
					End case 
					
					  //20170314 RCH
					  //ARRAY LONGINT(al_recNumsAvisos;0)
					  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];al_recNumsAvisos;"")
					  //$vb_calculaCtas:=True
					  //BLOB_Variables2Blob (->xBlob;0;->al_recNumsAvisos;->vd_fecha;->$vb_calculaCtas)
					$vb_calculaCtas:=True:C214
					ARRAY TEXT:C222($at_uuid;0)
					SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Auto_UUID:32;$at_uuid)
					BLOB_Variables2Blob (->xBlob;0;->$at_uuid;->vd_fecha;->$vb_calculaCtas)
					
					BM_CreateRequest ("ACT_RecalculaAvisosBash";$vt_accion;$vt_accion;xBlob)
					SET BLOB SIZE:C606(xBlob;0)
					ARRAY LONGINT:C221(al_recNumsAvisos;0)
					
					If (Size of array:C274($ptr1->)>15)
						$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($ptr1->))
					End if 
				End for 
				
				If (Size of array:C274($ptr1->)>15)
					$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
				End if 
				
			End if 
		End if 
		
	: ($vt_accion="CargoBorrado")
		ACTac_RecalculaAvisos ("DeclaraVar")
		If (vbACTac_AgregarElementos)
			vbACTac_CargoBorrado:=True:C214
		End if 
		
End case 