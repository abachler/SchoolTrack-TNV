//%attributes = {}
  //dbu_CountFamilyStudents

READ WRITE:C146([Familia:78])
ALL RECORDS:C47([Familia:78])
SELECTION TO ARRAY:C260([Familia:78];$aRecNums)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Contabilizando alumnos por familia..."))
C_LONGINT:C283($recs)
CREATE EMPTY SET:C140([Personas:7];"set")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Familia:78];$aRecNums{$i})
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1;*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"Retirado@";*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50#"Egresado";*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29>=<>al_NumeroNivelRegular{1};*)
	QUERY:C277([Alumnos:2]; & [Alumnos:2]nivel_numero:29<=<>al_NumeroNivelRegular{Size of array:C274(<>al_NumeroNivelRegular)})
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	[Familia:78]Numero_de_Alumnos:2:=$recs
	[Familia:78]Inactiva:31:=($recs=0)
	SAVE RECORD:C53([Familia:78])
	If ([Familia:78]Inactiva:31)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
		KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
		CREATE SET:C116([Personas:7];"set2")
		UNION:C120("set";"set2";"set")
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[Familia:78])

USE SET:C118("set")
SET_ClearSets ("set2";"set")

ARRAY LONGINT:C221($long;0)
LONGINT ARRAY FROM SELECTION:C647([Personas:7];$long;"")
READ WRITE:C146([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando estado de relaciones familiares..."))
For ($y;1;Size of array:C274($long))
	GOTO RECORD:C242([Personas:7];$long{$y})
	RF_VerificaEstado 
	SAVE RECORD:C53([Personas:7])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274($long))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
KRL_UnloadReadOnly (->[Personas:7])
  //  `dbu_CountFamilyStudents
  //
  //READ WRITE([Familia])
  //
  //ALL RECORDS([Familia])
  //
  //SELECTION TO ARRAY([Familia];$aRecNums)
  //
  //$msg:=RP_GetIdxString (21112;26)
  //
  //CD_THERMOMETREXSEC (1;0;$msg)
  //
  //For ($i;1;Size of array($aRecNums))
  //GOTO RECORD([Familia];$aRecNums{$i})
  //QUERY([Alumnos];[Alumnos]Familia_Número=[Familia]Numero;*)
  //QUERY([Alumnos]; & [Alumnos]Status#"Retirado@";*)
  //QUERY([Alumnos]; & [Alumnos]Status#"Egresado";*)
  //QUERY([Alumnos]; & [Alumnos]Nivel_Número>=◊al_NumeroNivelRegular{1};*)
  //QUERY([Alumnos]; & [Alumnos]Nivel_Número<=◊al_NumeroNivelRegular{Size of array(◊al_NumeroNivelRegular)})
  //
  //[Familia]Numero_de_Alumnos:=Records in selection([Alumnos])
  //
  //If ([Familia]Numero_de_Alumnos=0)
  //[Familia]Inactiva:=True
  //QUERY([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Familia=[Familia]Numero)
  //KRL_RelateSelection (->[Personas]No;->[Familia_RelacionesFamiliares]ID_Persona;"")
  //ARRAY LONGINT($aRecNumsParents;0)
  //LONGINT ARRAY FROM SELECTION([Personas];$aRecNumsParents;"")
  //For ($iParents;1;Size of array($aRecNumsParents))
  //READ WRITE([Personas])
  //GOTO RECORD([Personas];$aRecNumsParents{$iParents})
  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID_Apoderado;=;[Personas]No)
  //$sum:=Sum([ACT_CuentasCorrientes]Total_Saldos)
  //If ($sum=0)
  //[Personas]Inactivo:=True
  //[Personas]Es_Apoderado_Academico:=False
  //[Personas]ES_Apoderado_de_Cuentas:=False
  //SAVE RECORD([Personas])
  //Else 
  //[Personas]Inactivo:=False
  //SAVE RECORD([Personas])
  //End if 
  //KRL_ReloadAsReadOnly (->[Personas])
  //End for 
  //Else 
  //[Familia]Inactiva:=False
  //QUERY([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Familia=[Familia]Numero)
  //KRL_RelateSelection (->[Personas]No;->[Familia_RelacionesFamiliares]ID_Persona;"")
  //ARRAY LONGINT($aRecNumsParents;0)
  //LONGINT ARRAY FROM SELECTION([Personas];$aRecNumsParents;"")
  //For ($iParents;1;Size of array($aRecNumsParents))
  //READ WRITE([Personas])
  //GOTO RECORD([Personas];$aRecNumsParents{$iParents})
  //[Personas]Inactivo:=False
  //SAVE RECORD([Personas])
  //KRL_ReloadAsReadOnly (->[Personas])
  //End for 
  //End if 
  //SAVE RECORD([Familia])
  //CD_THERMOMETREXSEC (0;$i/Size of array($aRecNums)*100;$msg)
  //End for 
  //CD_THERMOMETREXSEC (-1)
  //UNLOAD RECORD([Familia])
  //READ ONLY([Familia])