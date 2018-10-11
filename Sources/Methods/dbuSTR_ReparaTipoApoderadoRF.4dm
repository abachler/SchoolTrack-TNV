//%attributes = {}
  // Método: dbuSTR_ReparaTipoApoderadoRF
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 06-08-10, 17:34:12
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal



  //dbuSTR_ReparaTipoApoderadoRF

C_LONGINT:C283($i;$vl_recordsAcademico;$vl_recordsCuentas;$vl_idFamilia;$vl_idApdo)
ARRAY LONGINT:C221($aQR_Longint1;0)


READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Alumnos:2])

ALL RECORDS:C47([Familia_RelacionesFamiliares:77])

LONGINT ARRAY FROM SELECTION:C647([Familia_RelacionesFamiliares:77];$aQR_Longint1;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Actualizando campo en Relaciones Familiares..."))
For ($i;1;Size of array:C274($aQR_Longint1))
	READ WRITE:C146([Familia_RelacionesFamiliares:77])
	GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$aQR_Longint1{$i})
	
	$vl_idFamilia:=[Familia_RelacionesFamiliares:77]ID_Familia:2
	$vl_idApdo:=[Familia_RelacionesFamiliares:77]ID_Persona:3
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_recordsAcademico)
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24=$vl_idFamilia;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Apoderado_académico_Número:27=$vl_idApdo)
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_recordsCuentas)
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24=$vl_idFamilia;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Apoderado_Cuentas_Número:28=$vl_idApdo)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	Case of 
		: (($vl_recordsAcademico=0) & ($vl_recordsCuentas=0))
			[Familia_RelacionesFamiliares:77]Apoderado:5:=0
		: (($vl_recordsAcademico>0) & ($vl_recordsCuentas=0))
			[Familia_RelacionesFamiliares:77]Apoderado:5:=1
		: (($vl_recordsAcademico=0) & ($vl_recordsCuentas>0))
			[Familia_RelacionesFamiliares:77]Apoderado:5:=2
		: (($vl_recordsAcademico>0) & ($vl_recordsCuentas>0))
			[Familia_RelacionesFamiliares:77]Apoderado:5:=3
	End case 
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
	KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aQR_Longint1);__ ("Actualizando campo en Relaciones Familiares..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)