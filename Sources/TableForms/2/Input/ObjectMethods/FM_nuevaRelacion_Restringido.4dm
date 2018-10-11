If (USR_checkRights ("M";->[Familia:78]))
	
	aStdFmID:=0
	vApID:=0
	aPersId:=0
	<>aParentesco:=0
	SAVE RECORD:C53([Familia:78])
	READ WRITE:C146([Familia:78])
	$familyRecNum:=Record number:C243([Familia:78])
	$currentRecNum:=Record number:C243([Alumnos:2])  //conservamos el recnum del registro para volver a el al final
	$state:=Read only state:C362([Alumnos:2])
	AL_UpdateArrays (xALP_Familia;0)
	AL_UpdateArrays (xALP_FamUFields;0)
	
	ARRAY LONGINT:C221(al_IdPersona;0)
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24)
	SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;al_IdPersona)
	
	WDW_OpenFormWindow (->[Familia_RelacionesFamiliares:77];"Input";-1;4;__ ("Relaciones familiares"))
	FORM SET INPUT:C55([Familia_RelacionesFamiliares:77];"Input")
	ADD RECORD:C56([Familia_RelacionesFamiliares:77];*)
	CLOSE WINDOW:C154
	KRL_GotoRecord (->[Alumnos:2];$currentRecNum;Not:C34($state))
	AL_UpdateArrays (xALP_FamUFields;0)
	AL_LoadFamRels 
	AL_UpdateArrays (xALP_Familia;-2)
	AL_SetLine (xALP_Familia;0)
	UFLD_LoadFileTplt (->[Familia:78])
	UFLD_LoadFields (->[Familia:78];->[Familia:78]Userfields:13;->[Familia]Userfields'Value;->xALP_FamUFields)
	AT_Initialize (->al_IdPersona)
	AL_OnActivate 
	GOTO RECORD:C242([Familia:78];$familyRecNum)
Else 
	$ignore:=CD_Dlog (0;__ ("Usted no dispone de los privilegios suficientes para realizar esta operación."))
End if 


