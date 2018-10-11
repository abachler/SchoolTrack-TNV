//%attributes = {}
  //BU_ValidaCupo

C_LONGINT:C283($1)
C_LONGINT:C283($2)
If (Count parameters:C259=2)
	Case of 
		: ($1=0)
			  //Para validar desde ingreso de buses escolares
			$vl_NuevoCupo:=$2
			ARRAY LONGINT:C221(al_RutasID;0)
			READ ONLY:C145([BU_Rutas:26])
			QUERY:C277([BU_Rutas:26];[BU_Rutas:26]Patente_Bus:11;=;[Buses_escolares:57]Patente:1)
			SELECTION TO ARRAY:C260([BU_Rutas:26]ID:12;al_RutasID)
			READ ONLY:C145([BU_Rutas_Recorridos:33])
			QRY_QueryWithArray (->[BU_Rutas_Recorridos:33]ID_Ruta:2;->al_RutasID)
			If (Records in selection:C76([BU_Rutas_Recorridos:33])>0)
				FIRST RECORD:C50([BU_Rutas_Recorridos:33])
				For ($i;1;Records in selection:C76([BU_Rutas_Recorridos:33]))
					$vl_TotalxRec:=[BU_Rutas_Recorridos:33]Total_Alumnos:10+[BU_Rutas_Recorridos:33]Total_Profesores:11
					If ($vl_TotalxRec>$vl_NuevoCupo)
						$0:=-1
						$i:=Records in selection:C76([BU_Rutas_Recorridos:33])+1
					Else 
						$0:=0
					End if 
					NEXT RECORD:C51([BU_Rutas_Recorridos:33])
				End for 
			Else 
				$0:=0
			End if 
			
		: ($1#0)
			  //Para Validar desde la ficha de la ruta
			$vl_NuevoCupo:=$2
			READ ONLY:C145([BU_Rutas_Recorridos:33])
			QUERY:C277([BU_Rutas_Recorridos:33];[BU_Rutas_Recorridos:33]ID_Ruta:2;=;$1)
			If (Records in selection:C76([BU_Rutas_Recorridos:33])>0)
				
				FIRST RECORD:C50([BU_Rutas_Recorridos:33])
				For ($i;1;Records in selection:C76([BU_Rutas_Recorridos:33]))
					$vl_TotalxRec:=[BU_Rutas_Recorridos:33]Total_Alumnos:10+[BU_Rutas_Recorridos:33]Total_Profesores:11
					If ($vl_TotalxRec>$vl_NuevoCupo)
						$0:=-1
						$i:=Records in selection:C76([BU_Rutas_Recorridos:33])+1
					Else 
						$0:=0
					End if 
					NEXT RECORD:C51([BU_Rutas_Recorridos:33])
				End for 
				
			Else 
				$0:=0
			End if 
			
	End case 
End if 