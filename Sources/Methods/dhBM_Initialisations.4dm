//%attributes = {}
  //dhBM_Initialisations

If ("Instrucciones"="")
	  // utilizar para las inicializaciones que serán requeridas durante los procesos batch
End if 

  //schooltrack
vb_asignaSituacionFinal:=False:C215
STR_LeeConfiguracion 
BBL_LeeConfiguracion 

If (ACT_AccountTrackInicializado )
	ACTinit_LoadPrefs 
End if 