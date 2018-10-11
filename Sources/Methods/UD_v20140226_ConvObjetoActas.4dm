//%attributes = {}
  //   UD_v20140226_ConvObjetoActas
  // Por: Alberto Bachler K.: 26-02-14, 09:01:56
  //  ---------------------------------------------
  // Fix 19-12-2017 MONO: cambio los if que confirman la lectura del objeto y si son exitosos guardo el acta para que pueda ser leída y validada con OB_BlobToObject
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$i_registros;$l_error;$l_idCurso;$l_idTermometro;$l_recNum)
C_OBJECT:C1216($oo_ObjetoActa)

ARRAY LONGINT:C221($al_RecNums;0)

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=0)
KRL_DeleteSelection (->[Alumnos_SintesisAnual:210])


  //Elimino registros inválidos en [xxSTR_HistoricoNiveles]
QUERY:C277([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]Año:2;>=;<>gYear;*)
QUERY:C277([xxSTR_HistoricoNiveles:191]; | ;[xxSTR_HistoricoNiveles:191]Año:2;=;0;*)
QUERY:C277([xxSTR_HistoricoNiveles:191]; | ;[xxSTR_HistoricoNiveles:191]NumeroNivel:3=0)
KRL_DeleteSelection (->[xxSTR_HistoricoNiveles:191])

  //Elimino registros inválidos en [Cursos_SintesisAnual]
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2;>;<>gYear;*)
QUERY:C277([Cursos_SintesisAnual:63]; | ;[Cursos_SintesisAnual:63]Año:2;=;0;*)
QUERY:C277([Cursos_SintesisAnual:63]; | ;[Cursos_SintesisAnual:63]NumeroNivel:3=0)
KRL_DeleteSelection (->[Cursos_SintesisAnual:63])

CIM_CuentaRegistros ("GuardaArchivo")


  // obtengo y asigno el numero de curso
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]ID_Curso:52;=;0;*)
QUERY:C277([Cursos_SintesisAnual:63]; & [Cursos_SintesisAnual:63]Curso:5;#;"")
LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Cursos_SintesisAnual:63])
	GOTO RECORD:C242([Cursos_SintesisAnual:63];$al_RecNums{$i})
	
	$l_recNum:=No current record:K29:2
	If ([Cursos_SintesisAnual:63]ID_Curso:52#0)
		$l_idCurso:=Abs:C99([Cursos_SintesisAnual:63]ID_Curso:52)
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Cursos:3]Numero_del_curso:6;->$l_idCurso)
	End if 
	If ($l_recNum=No current record:K29:2)
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Cursos:3]Curso:1;->[Cursos_SintesisAnual:63]Curso:5)
	End if 
	If ($l_recNum=No current record:K29:2)
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Cursos:3]Curso:1;->[Cursos_SintesisAnual:63]NombreOficialCurso:7)
	End if 
	If ($l_recNum=No current record:K29:2)
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Cursos:3]Nombre_Oficial_Curso:15;->[Cursos_SintesisAnual:63]NombreOficialCurso:7)
	End if 
	If ($l_recNum=No current record:K29:2)
		$l_recNum:=KRL_FindAndLoadRecordByIndex (->[Cursos:3]Nombre_Oficial_Curso:15;->[Cursos_SintesisAnual:63]Curso:5)
	End if 
	If ($l_recNum>No current record:K29:2)
		[Cursos_SintesisAnual:63]ID_Curso:52:=[Cursos:3]Numero_del_curso:6
		[Cursos_SintesisAnual:63]Curso:5:=[Cursos:3]Curso:1
		[Cursos_SintesisAnual:63]NombreOficialCurso:7:=[Cursos:3]Nombre_Oficial_Curso:15
	End if 
	SAVE RECORD:C53([Cursos_SintesisAnual:63])
End for 
KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])


vl_actionOnObjetToolsError:=0  // para manejar el despliegue de advertencia de error de ObjectTools (método OT_errorHandler)

ALL RECORDS:C47([xxSTR_Niveles:6])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Convirtiendo objeto actas en niveles...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([xxSTR_Niveles:6])
	GOTO RECORD:C242([xxSTR_Niveles:6];$al_RecNums{$i_registros})
	If (BLOB size:C605([xxSTR_Niveles:6]Actas_y_Certificados:43)>0)
		$l_error:=UD_v20140226_LeeOT_actas (->[xxSTR_Niveles:6]Actas_y_Certificados:43)
		If ($l_error=-1)
			ACTAS_ConfiguracionPorDefecto ([xxSTR_Niveles:6]NoNivel:5)
			ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
			ACTAS_ActualizaListaAsignaturas ([xxSTR_Niveles:6]NoNivel:5)
		Else 
			ACTAS_GuardaConfiguracion ([xxSTR_Niveles:6]NoNivel:5)
			OB_BlobToObject (->[xxSTR_Niveles:6]Actas_y_Certificados:43;->$oo_ObjetoActa)
			If (Not:C34(OB Is defined:C1231($oo_ObjetoActa)) | (OB Is empty:C1297($oo_ObjetoActa)))
				SET BLOB SIZE:C606([xxSTR_Niveles:6]Actas_y_Certificados:43;0)
				SAVE RECORD:C53([xxSTR_Niveles:6])
			End if 
		End if 
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[xxSTR_Niveles:6])



ALL RECORDS:C47([Cursos:3])
LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Convirtiendo objetos actas en cursos...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Cursos:3])
	GOTO RECORD:C242([Cursos:3];$al_RecNums{$i_registros})
	If ([Cursos:3]ActaEspecificaAlCurso:35 & (BLOB size:C605([Cursos:3]Acta:34)>0))
		$l_error:=UD_v20140226_LeeOT_actas (->[Cursos:3]Acta:34)
		If ($l_error=-1)
			ACTAS_ConfiguracionPorDefecto ([Cursos:3]Nivel_Numero:7)
			ACTAS_GuardaConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
			ACTAS_ActualizaListaAsignaturas ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
		Else 
			ACTAS_GuardaConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
			OB_BlobToObject (->[Cursos:3]Acta:34;->$oo_ObjetoActa)
			If (Not:C34(OB Is defined:C1231($oo_ObjetoActa)) | (OB Is empty:C1297($oo_ObjetoActa)))
				SET BLOB SIZE:C606([Cursos:3]Acta:34;0)
				SAVE RECORD:C53([Cursos:3])
			End if 
		End if 
	Else 
		SET BLOB SIZE:C606([Cursos:3]Acta:34;0)
		SAVE RECORD:C53([Cursos:3])
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Cursos:3])


ALL RECORDS:C47([xxSTR_HistoricoNiveles:191])
LONGINT ARRAY FROM SELECTION:C647([xxSTR_HistoricoNiveles:191];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Convirtiendo objetos actas en registros históricos de niveles ...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([xxSTR_HistoricoNiveles:191])
	GOTO RECORD:C242([xxSTR_HistoricoNiveles:191];$al_RecNums{$i_registros})
	If (BLOB size:C605([xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10)>0)
		$l_error:=UD_v20140226_LeeOT_actas (->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10)
		If ($l_error=-1)
			ACTAS_ConfiguracionPorDefecto ([xxSTR_HistoricoNiveles:191]NumeroNivel:3)
			ACTAS_GuardaConfiguracion ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;"";[xxSTR_HistoricoNiveles:191]Año:2)
			ACTAS_ActualizaListaAsignaturas ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;"";[xxSTR_HistoricoNiveles:191]Año:2)
		Else 
			ACTAS_GuardaConfiguracion ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;"";[xxSTR_HistoricoNiveles:191]Año:2)
			OB_BlobToObject (->[xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10;->$oo_ObjetoActa)
			If (Not:C34(OB Is defined:C1231($oo_ObjetoActa)) | (OB Is empty:C1297($oo_ObjetoActa)))
				SET BLOB SIZE:C606([xxSTR_HistoricoNiveles:191]xActas_y_Certificados:10;0)
				SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			End if 
		End if 
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])


ALL RECORDS:C47([Cursos_SintesisAnual:63])
LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"Convirtiendo objetos actas en cursos de años anteriores...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Cursos_SintesisAnual:63])
	GOTO RECORD:C242([Cursos_SintesisAnual:63];$al_RecNums{$i_registros})
	If (BLOB size:C605([Cursos_SintesisAnual:63]Actas_y_Certificados:11)>0)
		$l_error:=UD_v20140226_LeeOT_actas (->[Cursos_SintesisAnual:63]Actas_y_Certificados:11)
		If ($l_error=-1)
			ACTAS_ConfiguracionPorDefecto ([Cursos_SintesisAnual:63]NumeroNivel:3)
			ACTAS_GuardaConfiguracion ([Cursos_SintesisAnual:63]NumeroNivel:3;[Cursos_SintesisAnual:63]Curso:5;[Cursos_SintesisAnual:63]Año:2)
			ACTAS_ActualizaListaAsignaturas ([Cursos_SintesisAnual:63]NumeroNivel:3;[Cursos_SintesisAnual:63]Curso:5;[Cursos_SintesisAnual:63]Año:2)
		Else 
			ACTAS_GuardaConfiguracion ([Cursos_SintesisAnual:63]NumeroNivel:3;[Cursos_SintesisAnual:63]Curso:5;[Cursos_SintesisAnual:63]Año:2)
			OB_BlobToObject (->[Cursos_SintesisAnual:63]Actas_y_Certificados:11;->$oo_ObjetoActa)
			If (Not:C34(OB Is defined:C1231($oo_ObjetoActa)) | (OB Is empty:C1297($oo_ObjetoActa)))
				SET BLOB SIZE:C606([Cursos_SintesisAnual:63]Actas_y_Certificados:11;0)
				SAVE RECORD:C53([Cursos_SintesisAnual:63])
			End if 
		End if 
	Else 
		SET BLOB SIZE:C606([Cursos_SintesisAnual:63]Actas_y_Certificados:11;0)
		SAVE RECORD:C53([Cursos_SintesisAnual:63])
	End if 
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Cursos:3])

