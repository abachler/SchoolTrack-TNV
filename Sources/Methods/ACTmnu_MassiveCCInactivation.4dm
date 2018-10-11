//%attributes = {}
  //ACTmnu_MassiveCCInactivation

C_BOOLEAN:C305($1;$2;$display)
$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_CuentasCorrientes:175]))
COPY SET:C600($set;"tempctas")
If (Count parameters:C259=0)
	BWR_SearchRecords (->[ACT_CuentasCorrientes:175])
Else 
	$set:="$RecordSet_Table"+String:C10(Table:C252(->[ACT_CuentasCorrientes:175]))
	USE SET:C118($set)
End if 
If (Count parameters:C259=2)
	$display:=$2
Else 
	$display:=True:C214
End if 
If (Records in selection:C76([ACT_CuentasCorrientes:175])=0)
	CD_Dlog (0;__ ("Por favor seleccione las cuentas a inactivar."))
	COPY SET:C600("tempctas";$set)
Else 
	$r:=CD_Dlog (0;__ ("Se dispone a inactivar todas las Cuentas Corrientes seleccionadas.\r¿Está usted seguro de querer proseguir?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Inactivando cuentas corrientes..."))
		ARRAY LONGINT:C221($aRNCtas;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$aRNCtas;"")
		For ($i;1;Size of array:C274($aRNCtas))
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$aRNCtas{$i})
			If ([ACT_CuentasCorrientes:175]Estado:4=True:C214)
				[ACT_CuentasCorrientes:175]Estado:4:=False:C215
				$PrevMatrixID:=[ACT_CuentasCorrientes:175]ID_Matriz:7
				[ACT_CuentasCorrientes:175]ID_Matriz:7:=0
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
				  //If ($PrevMatrixID#0)
				READ WRITE:C146([ACT_Cargos:173])
				READ WRITE:C146([ACT_Documentos_de_Cargo:174])
				  //QUERY([xxACT_ItemsMatriz];[xxACT_ItemsMatriz]ID_Matriz=$PrevMatrixID)
				  //KRL_RelateSelection (->[ACT_Cargos]Ref_Item;->[xxACT_ItemsMatriz]ID_Item;"")
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
				ACTcc_EliminaCargosLoop 
				ACTcc_CalculaMontos ([ACT_CuentasCorrientes:175]ID:1)
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
				  //End if 
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRNCtas);__ ("Inactivando cuentas corrientes..."))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		COPY SET:C600("tempctas";$set)
		FLUSH CACHE:C297
		LOG_RegisterEvt ("Inactivación masiva de cuentas corrientes.")
	End if 
End if 

