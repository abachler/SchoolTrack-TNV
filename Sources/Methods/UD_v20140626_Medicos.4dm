//%attributes = {}
  // UD_v20140626_Medicos()
  // Por: Alberto Bachler K.: 26-06-14, 15:43:43
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_idTermometro;$l_posicion)

ARRAY LONGINT:C221($al_IdMedico;0)
ARRAY LONGINT:C221($al_RecNums;0)

QUERY:C277([XShell_FatObjects:86];[XShell_FatObjects:86]FatObjectName:1="medicos.ALU.@")
QUERY SELECTION BY FORMULA:C207([XShell_FatObjects:86];BLOB size:C605([XShell_FatObjects:86]BlobObject:2)>0)

LONGINT ARRAY FROM SELECTION:C647([XShell_FatObjects:86];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Estableciendo relación entre alumno y médico...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	GOTO RECORD:C242([XShell_FatObjects:86];$al_RecNums{$i_registros})
	$l_posicion:=BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->$al_IdMedico)
	If (Size of array:C274($al_IdMedico)>0)
		$l_idAlumno:=Num:C11([XShell_FatObjects:86]FatObjectName:1)
		$t_uuidAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlumno;->[Alumnos:2]auto_uuid:72)
		For ($i_medico;1;Size of array:C274($al_IdMedico))
			$l_idMedico:=$al_IdMedico{$i_medico}
			KRL_FindAndLoadRecordByIndex (->[STR_Medicos:89]ID:3;->$l_idMedico;True:C214)
			If (Not:C34(Util_isValidUUID ([STR_Medicos:89]Auto_UUID:6)))
				[STR_Medicos:89]Auto_UUID:6:=Generate UUID:C1066
			End if 
			SAVE RECORD:C53([STR_Medicos:89])
			$t_uuidMedico:=[STR_Medicos:89]Auto_UUID:6
			
			QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=$t_uuidAlumno;*)
			QUERY:C277([xxSTR_Link_AlumnosMedicos:237]; & ;[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3=$t_uuidMedico)
			
			If (Records in selection:C76([xxSTR_Link_AlumnosMedicos:237])=0)
				CREATE RECORD:C68([xxSTR_Link_AlumnosMedicos:237])
				[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2:=$t_uuidAlumno
				[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3:=$t_uuidMedico
				SAVE RECORD:C53([xxSTR_Link_AlumnosMedicos:237])
			End if 
			
		End for 
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[XShell_FatObjects:86])
KRL_UnloadReadOnly (->[STR_Medicos:89])
KRL_UnloadReadOnly (->[xxSTR_Link_AlumnosMedicos:237])
