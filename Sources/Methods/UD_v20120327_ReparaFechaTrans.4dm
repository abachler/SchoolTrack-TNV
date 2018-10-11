//%attributes = {}
  //UD_v20120327_ReparaFechaTrans

START TRANSACTION:C239
ARRAY LONGINT:C221($al_RecNumCargos;0)
ARRAY LONGINT:C221($al_RecNumTransacciones;0)
C_LONGINT:C283($vl_go;$x;$i)
C_BOOLEAN:C305($go)
READ WRITE:C146([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Pagos:172])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5=!00-00-00!)
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_RecNumCargos)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando Fechas...")
For ($i;1;Size of array:C274($al_RecNumCargos))
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_RecNumCargos))
	GOTO RECORD:C242([ACT_Cargos:173];$al_RecNumCargos{$i})
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5=!00-00-00!)
	SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_RecNumTransacciones)
	For ($x;1;Size of array:C274($al_RecNumTransacciones))
		GOTO RECORD:C242([ACT_Transacciones:178];$al_RecNumTransacciones{$x})
		$go:=Locked:C147([ACT_Transacciones:178])
		If (Not:C34($go))
			If ([ACT_Transacciones:178]ID_Pago:4=0)
				If ([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
					[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]FechaEmision:22
				Else 
					[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]Fecha_de_generacion:4
				End if 
			Else 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=[ACT_Transacciones:178]ID_Pago:4)
				[ACT_Transacciones:178]Fecha:5:=[ACT_Pagos:172]Fecha:2
			End if 
			SAVE RECORD:C53([ACT_Transacciones:178])
		Else 
			$x:=Size of array:C274($al_RecNumTransacciones)
			$i:=Size of array:C274($al_RecNumTransacciones)
			CD_Dlog (0;"Existen registros en uso. El script no se ha ejecutado.")
			CANCEL TRANSACTION:C241
		End if 
	End for 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
If (Not:C34($go))
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]Fecha:5=!00-00-00!)
	$vl_go:=KRL_DeleteSelection (->[ACT_Transacciones:178])
	If ($vl_go=1)
		VALIDATE TRANSACTION:C240
	Else 
		CANCEL TRANSACTION:C241
	End if 
Else 
	CANCEL TRANSACTION:C241
End if 

KRL_UnloadReadOnly (->[ACT_Transacciones:178])