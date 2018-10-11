//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 175179
  // Fecha y hora: 09-05-17, 16:13:40
  // ----------------------------------------------------
  // Método: AS_BloqueaPropDeEvalAsignBWR
  // Descripción: El objetivo es bloquear o desbloquear el campo [Asignaturas]BloqueoPropDeEval para las asignaturas seleccionadas en el explorador.
  // 
  //
  // Parámetros: No requiere
  // ----------------------------------------------------

If (USR_GetMethodAcces ("AS_BloqueoPropiedadesEvaluacion"))
	BWR_SearchRecords 
	If (Records in selection:C76([Asignaturas:18])>0)
		
		CREATE SET:C116([Asignaturas:18];"$asigSeleccionadas")
		
		C_TEXT:C284($vt_msg)
		C_BOOLEAN:C305($vb_opc)
		C_LONGINT:C283($vl_resp;$vl_cantAsig;$z)
		
		$vb_opc:=False:C215
		$vl_cantAsig:=0
		$vl_resp:=0
		$vt_msg:=""
		
		$vt_msg:="Se dispone a Bloquear o Desbloquear las Propiedades de Evaluación para cada una de las asignaturas seleccionadas en el explorador."
		$vt_msg:=$vt_msg+"\n\n¿Desea Desbloquear o Bloquear?"
		$vl_resp:=CD_Dlog (0;$vt_msg;"";"Cancelar";"Bloquear";"Desbloquear")
		
		If ($vl_resp=1)
			CD_Dlog (0;"No se efectuaron cambios en las asignaturas seleccionadas.")
		Else 
			$vb_opc:=Not:C34($vl_resp=2)
			USE SET:C118("$asigSeleccionadas")
			QUERY SELECTION BY ATTRIBUTE:C1424([Asignaturas:18];[Asignaturas:18]Opciones:57;"BloqueoPropDeEval";=;$vb_opc)  //MONO Ticket 175179
			$vl_cantAsig:=Records in selection:C76([Asignaturas:18])
			
			If ($vl_cantAsig>0)
				
				$vl_resp:=0
				$vt_msg:="En la selección existen "+String:C10($vl_cantAsig)+" asignaturas "+Choose:C955($vb_opc;"bloquedas";"desbloqueadas")+" sobre las que se puede aplicar el cambio."
				$vt_msg:=$vt_msg+"\n\n¿Desea continuar?"
				$vl_resp:=CD_Dlog (0;$vt_msg;"";"Cancelar";"Continuar")
				
				If ($vl_resp=2)
					  //MONO Ticket 175179
					ARRAY LONGINT:C221($al_rnAsignatura;0)
					$vb_opc:=Not:C34($vb_opc)
					LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_rnAsignatura;"")
					AS_ObjOpc_BlockPropEval (->$al_rnAsignatura;$vb_opc;True:C214)
					CLEAR SET:C117("$asigSeleccionadas")
					KRL_UnloadReadOnly (->[Asignaturas:18])
				Else 
					CD_Dlog (0;"No se efectuaron cambios en las asignaturas seleccionadas.")
				End if 
			Else 
				CD_Dlog (0;"No existen asignaturas "+ST_Qte (Choose:C955($vb_opc;"Bloqueadas";"Desbloqueadas"))+" en la selección.")
			End if 
		End if 
	Else 
		CD_Dlog (0;"Debe existir una selección de asignaturas en el explorador para ejecutar esta opción.")
	End if 
Else 
	ok:=0
End if 