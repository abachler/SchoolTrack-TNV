//%attributes = {}
  //Método: CAE_CreaArchivosHistoricos


MESSAGES OFF:C175
C_LONGINT:C283($0)
C_LONGINT:C283($i;$j;$n)
C_BLOB:C604($blob)


$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
If ($step<5)
	Case of 
		: (<>vtXS_CountryCode="cl")
			CAE_ArchivaModelosActaCurso 
			  //CAE_ArchivaActas segun lo indicado por alberto esto ya no lo vamos a archivar
	End case 
	PREF_Set (0;"Cierre del año escolar";"5:Archivaje Actas Terminado")
	LOG_RegisterEvt ("Cierre de año escolar: Archivaje de actas")
End if 

$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
If ($step<6)
	CAE_CreaHistoricoAlumnos 
	CAE_ArchivaAprendizajes 
	PREF_Set (0;"Cierre del año escolar";"6:Archivaje Alumnos Terminado")
	LOG_RegisterEvt ("Cierre de año escolar: Archivaje de información de alumnos para el año "+String:C10(vl_UltimoAño))
	FLUSH CACHE:C297
End if 

$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
If ($step<7)
	CAE_CreaHistoricoAsignaturas 
	PREF_Set (0;"Cierre del año escolar";"7:Archivaje de Asignaturas Terminado")
	LOG_RegisterEvt ("Cierre de año escolar: Archivaje de información de asignaturas y evaluaciones par"+"a el año "+String:C10(vl_UltimoAño))
	FLUSH CACHE:C297
End if 


$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
If ($step<8)
	If (bEliminarSubasignaturas=1)
		READ WRITE:C146([xxSTR_Subasignaturas:83])
		ALL RECORDS:C47([xxSTR_Subasignaturas:83])
		KRL_DeleteSelection (->[xxSTR_Subasignaturas:83];False:C215)
	Else 
		SET BLOB SIZE:C606($blob;0)
		READ WRITE:C146([xxSTR_Subasignaturas:83])
		MESSAGES ON:C181
		ALL RECORDS:C47([xxSTR_Subasignaturas:83])
		APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Data:4:=$blob)
		  //MONO TICKET 187315 
		APPLY TO SELECTION:C70([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]o_Data:21:=OB_Create )
		MESSAGES OFF:C175
	End if 
	PREF_Set (0;"Cierre del año escolar";"8: Inicialización de subasignaturas")
	LOG_RegisterEvt ("Cierre de año escolar: Inicialización de subasignaturas según preferencias")
	FLUSH CACHE:C297
End if 