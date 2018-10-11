//%attributes = {}
  //ACTpp_CalculaNoCargas

C_BOOLEAN:C305(<>ACT_CalculandoCargas;$execServer)
C_BOOLEAN:C305($0)

$execServer:=(Count parameters:C259=0)

If ((Application type:C494=4D Remote mode:K5:5) & ($execServer))
	$ServerProc:=Execute on server:C373(Current method name:C684;Pila_256K;"Calculando número de cargas por apoderado")
	vb_Ordenando:=True:C214
	<>ACT_CalculandoCargas:=True:C214
	GET PROCESS VARIABLE:C371(-1;<>ACT_CalculandoCargas;vb_Ordenando)
	$ther:=IT_UThermometer (1;0;__ ("Calculando número de cargas por apoderado..."))
	While (vb_Ordenando)
		GET PROCESS VARIABLE:C371(-1;<>ACT_CalculandoCargas;vb_Ordenando)
	End while 
	IT_UThermometer (-2;$ther)
Else 
	C_LONGINT:C283($vl_tomados;$vl_cargas)
	ACTcfgdes_OpcionesGenerales ("LeeBlob")
	$vl_tomados:=0
	$0:=True:C214
	<>ACT_CalculandoCargas:=True:C214
	READ WRITE:C146([Personas:7])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([Alumnos:2])
	If (Count parameters:C259=1)
		$idApdo:=$1
		QUERY:C277([Personas:7];[Personas:7]No:1=$idApdo)
	Else 
		$idApdo:=0
		QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Calculando número de cargas por apoderado..."))
	End if 
	ARRAY LONGINT:C221($al_recNumPersonas;0)
	LONGINT ARRAY FROM SELECTION:C647([Personas:7];$al_recNumPersonas;"")
	For ($i;1;Size of array:C274($al_recNumPersonas))
		KRL_GotoRecord (->[Personas:7];$al_recNumPersonas{$i};True:C214)
		If (ok=1)
			$vl_cargas:=0
			ARRAY LONGINT:C221($al_recNumCtas;0)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1;*)
			QUERY:C277([ACT_CuentasCorrientes:175]; & ;[ACT_CuentasCorrientes:175]Estado:4=True:C214)
			LONGINT ARRAY FROM SELECTION:C647([ACT_CuentasCorrientes:175];$al_recNumCtas;"")
			For ($j;1;Size of array:C274($al_recNumCtas))
				KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$al_recNumCtas{$j})
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
				If (Find in array:C230(ai_nivelesConsideradoNoCarga;[Alumnos:2]nivel_numero:29)#-1)
					$vl_cargas:=$vl_cargas+1
				End if 
			End for 
			[Personas:7]ACT_NumCargas:65:=$vl_cargas
			SAVE RECORD:C53([Personas:7])
			If ($idApdo=0)
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumPersonas);__ ("Calculando número de cargas por apoderado..."))
			End if 
		Else 
			$vl_tomados:=1
		End if 
		KRL_UnloadReadOnly (->[Personas:7])
	End for 
	If ($idApdo=0)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		$0:=($vl_tomados=0)
	End if 
	<>ACT_CalculandoCargas:=False:C215
	ACTcfgdes_OpcionesGenerales ("DeclaraArraysPref")
End if 