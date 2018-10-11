
  // ----------------------------------------------------
  // Usuario (SO): Saul Ponce Ticket Nº 187484
  // Fecha y hora: 02-10-18, 09:27:01
  // ----------------------------------------------------
  // Método: [xxSTR_Constants].ACTwiz_AsignaIDGlosaParaTramos
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


Case of 
	: (Form event:C388=On Load:K2:1)
		
		  //$l_tiempo:=IT_StartTimer 
		
		XS_SetInterface 
		C_POINTER:C301($y_control)
		C_LONGINT:C283($l_cuantosItems)
		
		KRL_UnloadReadOnly (->[xxACT_Items:179])
		ACTwiz_AsignaIDGlosaTramosMas ("InicializaInterfaz")
		$l_cuantosItems:=Num:C11(ACTcfgit_OpcionesGenerales ("BuscaItemsADesplegar"))
		If ($l_cuantosItems>0)
			ACTwiz_AsignaIDGlosaTramosMas ("PreparaArraysLB")
			  //ACTwiz_AsignaIDGlosaTramosMas ("PreparaControlesInterfazLB") // Modificado por: Saul Ponce (07-10-2018)
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"lbl_nroPagina")
			$y_control->:=1
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"chk_todos")
			$y_control->:=0
			$y_control:=OBJECT Get pointer:C1124(Object named:K67:5;"bProxima")
			OBJECT SET ENABLED:C1123($y_control->;False:C215)
			ACTwiz_AsignaIDGlosaTramosMas ("actualizaContadores")
			
			  //ACTwiz_AsignaIDGlosaTramosMas ("PreparaCBPeriodos") // Modificado por: Saul Ponce (07-10-2018)
		Else 
			ACTwiz_AsignaIDGlosaTramosMas ("MsgSinItemsParaSeleccion")
		End if 
		
		  //IT_StopTimer ($l_tiempo)
End case 