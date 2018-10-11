//%attributes = {}
  //ACTmatrices_AsignaNuevaMatriz

C_LONGINT:C283($l_idMatriz;$1;$2;$l_resp;$l_prevMatrixID)
C_BOOLEAN:C305($b_muestraMensaje;$3;$b_ros)
C_LONGINT:C283($0;$t_matriz)
C_POINTER:C301($y_puntero)

$l_idCta:=$1
$l_idMatriz:=$2
$b_muestraMensaje:=$3
If (Count parameters:C259>=4)
	$y_puntero:=$4
End if 

If ($b_muestraMensaje)
	If ($l_idMatriz>0)
		$l_resp:=CD_Dlog (0;__ ("El cambio de matriz implica que los cargos proyectados serán eliminados. Esta operación no se puede deshacer.\r¿Desea continuar?");__ ("");__ ("No");__ ("Sí"))
	Else 
		$l_resp:=CD_Dlog (0;__ ("Dejar una cuenta sin matriz implica que los cargos proyectados para la matriz anterior serán eliminados. Esta operación no se puede deshacer.\r¿Desea continuar?");__ ("");__ ("No");__ ("Sí"))
	End if 
Else 
	$l_resp:=2
End if 

$b_ros:=Read only state:C362([ACT_CuentasCorrientes:175])
KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$l_idCta;True:C214)
$l_prevMatrixID:=[ACT_CuentasCorrientes:175]ID_Matriz:7

  //If (([ACT_CuentasCorrientes]Estado) | (([Alumnos]Nivel_Número=Nivel_AdmisionDirecta) & (viACT_AsignarMatAdmision=1)))
If (([ACT_CuentasCorrientes:175]Estado:4) | (([Alumnos:2]nivel_numero:29<=Nivel_AdmisionDirecta) & (viACT_AsignarMatAdmision=1)))  //20170801 RCH
	If ($l_resp=2)
		KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$l_idCta;True:C214)
		If (ok=1)
			If ($l_idMatriz#$l_prevMatrixID)
				If ($l_idMatriz>=0)
					[ACT_CuentasCorrientes:175]ID_Matriz:7:=$l_idMatriz
				End if 
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
				If ($l_prevMatrixID>0)
					READ WRITE:C146([ACT_Cargos:173])
					READ WRITE:C146([ACT_Documentos_de_Cargo:174])
					QUERY:C277([xxACT_ItemsMatriz:180];[xxACT_ItemsMatriz:180]ID_Matriz:1=$l_prevMatrixID)
					KRL_RelateSelection (->[ACT_Cargos:173]Ref_Item:16;->[xxACT_ItemsMatriz:180]ID_Item:2;"")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
					
					ARRAY LONGINT:C221($al_idsApoderados;0)
					ARRAY LONGINT:C221($al_idsTerceros;0)
					CREATE SET:C116([ACT_Cargos:173];"setProyectados")
					
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54>0)
					DISTINCT VALUES:C339([ACT_Cargos:173]ID_Apoderado:18;$al_idsTerceros)
					For ($l_indice;1;Size of array:C274($al_idsTerceros))
						USE SET:C118("setProyectados")
						SET QUERY LIMIT:C395(1)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=$al_idsTerceros{$l_indice})
						SET QUERY LIMIT:C395(0)
						ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)  //por si hay mas de un apdo
					End for 
					
					USE SET:C118("setProyectados")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18>0)
					DISTINCT VALUES:C339([ACT_Cargos:173]ID_Apoderado:18;$al_idsApoderados)
					For ($l_indice;1;Size of array:C274($al_idsApoderados))
						USE SET:C118("setProyectados")
						SET QUERY LIMIT:C395(1)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$al_idsApoderados{$l_indice})
						SET QUERY LIMIT:C395(0)
						ACTcc_OpcionesCalculoCtaCte ("AgregarElemento";->[ACT_Cargos:173]ID_Apoderado:18)  //por si hay mas de un apdo
					End for 
					USE SET:C118("setProyectados")
					SET_ClearSets ("setProyectados")
					
					  //elimina cargos
					ACTcc_EliminaCargosLoop 
					
					KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
				End if 
			Else 
				$l_idMatriz:=$l_prevMatrixID
			End if 
		Else 
			If (Not:C34(Is nil pointer:C315($y_puntero)))
				$y_puntero->:=$y_puntero->+1
			End if 
			$l_idMatriz:=$l_prevMatrixID
		End if 
	Else 
		$l_idMatriz:=$l_prevMatrixID
	End if 
Else 
	$l_idMatriz:=$l_prevMatrixID
End if 
KRL_ResetPreviousRWMode (->[ACT_CuentasCorrientes:175];$b_ros)

$0:=$l_idMatriz