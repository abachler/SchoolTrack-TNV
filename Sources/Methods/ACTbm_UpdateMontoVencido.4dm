//%attributes = {}
  //ACTbm_UpdateMontoVencido

ARRAY LONGINT:C221($al_recNumCargos;0)
ARRAY LONGINT:C221($al_difference;0)
C_LONGINT:C283($i)

  //Actualiza monto vencido en cargos
READ ONLY:C145([ACT_Cargos:173])
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*);*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)

QUERY SELECTION BY FORMULA:C207([ACT_Cargos:173];Abs:C99([ACT_Cargos:173]Monto_Vencido:30)#Abs:C99([ACT_Cargos:173]Saldo:23))

LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando montos vencidos de cargos..."))
For ($i;1;Size of array:C274($al_recNumCargos))
	KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCargos{$i};True:C214)
	[ACT_Cargos:173]Año:14:=[ACT_Cargos:173]Año:14
	  //ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos]ID_Apoderado)
	SAVE RECORD:C53([ACT_Cargos:173])
	
	ACTeod_EjecutaTareas ("AgregaElemento";->[ACT_Cargos:173]ID_Apoderado:18;->[ACT_Cargos:173]ID_Tercero:54)
	
	KRL_UnloadReadOnly (->[ACT_Cargos:173])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumCargos);__ ("Actualizando montos vencidos de cargos..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

  //20130705 RCH
  //AT_Difference (->alACTtid_IdsApdos2Recalc2;->alACTpp_idsPersonas;->$al_difference)
  //COPY ARRAY($al_difference;alACTtid_IdsApdos2Recalc2)