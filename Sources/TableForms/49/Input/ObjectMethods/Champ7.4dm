Self:C308->:=ST_Format (Self:C308)

If (<>viSTR_UD_NombresComun_Oficial=1)
	AL_ProcesaNombres 
End if 

If (<>vlSTR_UsarSoloUnApellido=1)
	[Alumnos:2]Familia_Número:24:=AL_RelateToFamily 
	READ ONLY:C145([Familia:78])
	QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
	If (Records in selection:C76([Familia:78])=1)
		vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
		  //SAVE RECORD([ADT_Candidatos])
	Else 
		  //vlPST_LinkedFamilyRec:=0 20111808 AS.  causaba conflicto para la Tabla [Familia] con Record Number cero.
		vlPST_LinkedFamilyRec:=-1
	End if 
	PST_GetFamilyRelations 
	PST_SetConnexions 
	If (vlPST_LinkedFamilyRec>=0)
		KRL_ReloadInReadWriteMode (->[Familia:78])
		OBJECT SET ENTERABLE:C238(*;"Family@";True:C214)
	End if 
	KRL_ReloadInReadWriteMode (->[Alumnos:2])
	
	If (Self:C308->#"")
		OBJECT SET ENTERABLE:C238(*;"Champ8";True:C214)
	Else 
		OBJECT SET ENTERABLE:C238(*;"Champ8";False:C215)
	End if 
	SAVE RECORD:C53([Alumnos:2])
End if 
