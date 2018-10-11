//%attributes = {}
  //AS_OnCloseInputForm

C_BOOLEAN:C305(modSubEvals;modNotas;modObservaciones)

Case of 
	: (modSubEvals)
		$r:=CD_Dlog (0;__ ("Usted introdujo modificaciones en las sub-evaluaciones. Si cancela pueden producirse una inconsistencia entre el promedio de las sub-evaluaciones y la nota afichada en la columna correspondiente.\r¿Desea continuar corriendo este riesgo?");__ ("");__ ("No");__ ("Sí"))
		If ($r=2)
			bClose:=1
			BWR_DispatchButtonActions 
		End if 
		  //: ((modNotas) | (modObservaciones))
		  //  //$r:=CD_Dlog (0;__ ("¿Desea guardar las modificaciones que introdujo antes de cerrar esta ventana?");__ ("");__ ("Sí");__ ("Cancelar");__ ("No"))
		  //  //Case of 
		  //  //: ($r=1)
		  //bBWR_Cancel:=0
		  //bBWR_SaveRecord:=1
		  //BWR_DispatchButtonActions 
		  //: ($r=3)
		  //bBWR_Cancel:=1
		  //bBWR_SaveRecord:=0
		  //BWR_DispatchButtonActions 
		  //Else 
		  //bBWR_Cancel:=0
		  //bBWR_SaveRecord:=0
		  //bClose:=0
		  //End case 
	Else 
		bClose:=1
		BWR_DispatchButtonActions 
End case 