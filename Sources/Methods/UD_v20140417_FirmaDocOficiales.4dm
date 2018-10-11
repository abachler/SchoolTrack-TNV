//%attributes = {}
  // UD_v20140417_FirmaDocOficiales()
  // Por: Alberto Bachler K.: 17-04-14, 18:16:40
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i)

ARRAY LONGINT:C221($al_RecNums;0)

If (<>gCountryCode="cl")
	QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesOficiales)
	LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_RecNums;"")
	For ($i;1;Size of array:C274($al_RecNums))
		READ WRITE:C146([xxSTR_Niveles:6])
		GOTO RECORD:C242([xxSTR_Niveles:6];$al_RecNums{$i})
		ACTAS_LeeConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
		If ((vi_FirmaDirectorNivel+vi_FirmaDirectorColegio)=0)
			vi_FirmaDirectorNivel:=0
			vi_FirmaDirectorColegio:=1
		End if 
		ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
		SAVE RECORD:C53([xxSTR_Niveles:6])
	End for 
	KRL_UnloadReadOnly (->[xxSTR_Niveles:6])
End if 

READ WRITE:C146([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
If (Records in selection:C76([Colegio:31])=1)
	QUERY SELECTION BY FORMULA:C207([Profesores:4];ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)=[Colegio:31]Director_NombreCompleto:13)
	If (Records in selection:C76([Profesores:4])=1)
		[Colegio:31]Director_ApellidoPaterno:18:=[Profesores:4]Apellido_paterno:3
		[Colegio:31]Director_ApellidoMaterno:19:=[Profesores:4]Apellido_materno:4
		[Colegio:31]Director_Nombres:20:=[Profesores:4]Nombres:2
		[Colegio:31]Director_IdFuncionario:61:=[Profesores:4]Numero:1
		SAVE RECORD:C53([Colegio:31])
	Else 
		QUERY SELECTION BY FORMULA:C207([Profesores:4];ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3)=[Colegio:31]Director_NombreCompleto:13)
		If (Records in selection:C76([Profesores:4])=1)
			[Colegio:31]Director_ApellidoPaterno:18:=[Profesores:4]Apellido_paterno:3
			[Colegio:31]Director_ApellidoMaterno:19:=[Profesores:4]Apellido_materno:4
			[Colegio:31]Director_Nombres:20:=[Profesores:4]Nombres:2
			[Colegio:31]Director_IdFuncionario:61:=[Profesores:4]Numero:1
			SAVE RECORD:C53([Colegio:31])
		End if 
	End if 
End if 
KRL_UnloadReadOnly (->[Colegio:31])

QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]Director:13#"";*)
QUERY:C277([xxSTR_Niveles:6]; & ;[xxSTR_Niveles:6]ID_DirectorNivel:52=0)
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([xxSTR_Niveles:6])
	GOTO RECORD:C242([xxSTR_Niveles:6];$al_RecNums{$i})
	QUERY SELECTION BY FORMULA:C207([Profesores:4];ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4)=[xxSTR_Niveles:6]Director:13)
	If (Records in selection:C76([Profesores:4])>0)
		[xxSTR_Niveles:6]ID_DirectorNivel:52:=[Profesores:4]Numero:1
	Else 
		QUERY SELECTION BY FORMULA:C207([Profesores:4];ST_ClearSpaces ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3)=[xxSTR_Niveles:6]Director:13)
		If (Records in selection:C76([Profesores:4])>0)
			[xxSTR_Niveles:6]ID_DirectorNivel:52:=[Profesores:4]Numero:1
		Else 
			QUERY:C277([Profesores:4];[Profesores:4]Nombre_comun:21=[xxSTR_Niveles:6]Director:13)
			If (Records in selection:C76([Profesores:4])>0)
				[xxSTR_Niveles:6]ID_DirectorNivel:52:=[Profesores:4]Numero:1
			End if 
		End if 
	End if 
	SAVE RECORD:C53([xxSTR_Niveles:6])
End for 
KRL_UnloadReadOnly (->[xxSTR_Niveles:6])

