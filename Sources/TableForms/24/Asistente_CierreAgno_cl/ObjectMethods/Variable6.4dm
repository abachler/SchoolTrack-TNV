  // [xxSTR_DatosDeCierre].Asistente_CierreAgno_cl.Variable6()
  // Por: Alberto Bachler K.: 04-10-14, 17:56:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_resultado)
C_REAL:C285($r_libreVolumen;$r_tamañoBD;$r_tamañoVolumen;$r_usadoEnVolumen)
C_TEXT:C284($t_error;$t_rutaRespaldos;$t_separador)

vi_PageNumber:=FORM Get current page:C276
Case of 
	: (FORM Get current page:C276=1)
		vt_errorStatus:="Presione Flecha Derecha para continuar"
		_O_DISABLE BUTTON:C193(bPrev)
		
	: (FORM Get current page:C276=2)
		vt_ResultadoDiagnostico:=""
		OBJECT SET VISIBLE:C603(bDiagnostico;True:C214)
		_O_DISABLE BUTTON:C193(bPrev)
		_O_DISABLE BUTTON:C193(bNext)
		
	: (FORM Get current page:C276=3)
		If (Not:C34(vb_SituacionFinalOK))
			QUERY WITH ARRAY:C644([Alumnos:2]nivel_numero:29;<>al_NumeroNivelesActivos)
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]curso:20#"@ADT")
			CREATE SET:C116([Alumnos:2];"Alumnos")
			vi_TotalAlumnos:=Records in selection:C76([Alumnos:2])
			USE SET:C118("Alumnos")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="P")
			vi_alumnosPromovidos:=Records in selection:C76([Alumnos:2])
			USE SET:C118("Alumnos")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="R")
			vi_alumnosReprobados:=Records in selection:C76([Alumnos:2])
			USE SET:C118("Alumnos")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="Y")
			vi_alumnosRetirados:=Records in selection:C76([Alumnos:2])
			USE SET:C118("Alumnos")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="X")
			vi_alumnosEspeciales:=Records in selection:C76([Alumnos:2])
			USE SET:C118("Alumnos")
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Situacion_final:33="";*)
			QUERY SELECTION:C341([Alumnos:2]; | [Alumnos:2]Situacion_final:33="??")
			vi_alumnosPendientes:=Records in selection:C76([Alumnos:2])
		End if 
		_O_ENABLE BUTTON:C192(bPrev)
		If (vi_AlumnosPendientes>0)
			_O_DISABLE BUTTON:C193(bNext)
			OBJECT SET VISIBLE:C603(*;"problemas2@";True:C214)
			OBJECT SET VISIBLE:C603(*;"texto5";False:C215)
		Else 
			OBJECT SET VISIBLE:C603(*;"problemas2@";False:C215)
			OBJECT SET VISIBLE:C603(*;"texto5";True:C214)
			_O_ENABLE BUTTON:C192(bNext)
		End if 
		
	: (FORM Get current page:C276=4)
		If (((Macintosh option down:C545) | (Windows Alt down:C563)) & (<>lUSR_RelatedTableUserID=-1))
			vb_PromediosOK:=True:C214
		End if 
		If (Not:C34(vb_PromediosOK))
			OBJECT SET VISIBLE:C603(*;"Verificando";True:C214)
			OBJECT SET VISIBLE:C603(*;"Problemas3";False:C215)
			OBJECT SET VISIBLE:C603(*;"PromediosOK";False:C215)
			$l_resultado:=CAE_VerificaDatos 
			vb_PromediosOK:=($l_resultado=1)
		End if 
		If (vb_PromediosOK)
			_O_ENABLE BUTTON:C192(bNext)
			OBJECT SET VISIBLE:C603(*;"problemas3@";False:C215)
			OBJECT SET VISIBLE:C603(*;"Verificando";False:C215)
			OBJECT SET VISIBLE:C603(*;"PromediosOK";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"problemas3@";True:C214)
			OBJECT SET VISIBLE:C603(*;"Verificando";False:C215)
			OBJECT SET VISIBLE:C603(*;"PromediosOK";False:C215)
		End if 
		
	: (FORM Get current page:C276=5)
		$t_rutaRespaldos:=SYS_GetDataPath 
		If (Position:C15(":\\";$t_rutaRespaldos)>0)
			$t_separador:="\\"
		Else 
			$t_separador:=":"
		End if 
		If (Application type:C494=4D Remote mode:K5:5)
			$t_rutaRespaldos:=Replace string:C233($t_rutaRespaldos;Data file:C490;"")
		Else 
			$t_rutaRespaldos:=SYS_GetParentNme ($t_rutaRespaldos)
		End if 
		$t_rutaRespaldos:=$t_rutaRespaldos+"Respaldo_"+<>gRolBD+" antes cierre "+String:C10(<>gYear)
		vt_Backup:=$t_rutaRespaldos
		vt_BackupFolder:=vt_Backup
		
		SYS_TamañoBD_y_Disco (->$r_tamañoBD;->$r_tamañoVolumen;->$r_usadoEnVolumen;->$r_libreVolumen)
		If ($r_tamañoVolumen<($r_tamañoBD*4))
			$t_error:="Espacio en disco insuficiente: "+String:C10($r_tamañoBD)+"Mb requeridos, "+String:C10($r_libreVolumen)+"Mb disponibles.\r\rNo es posible continuar con el cierre del año escolar."
			CD_Dlog (0;$t_error)
			CANCEL:C270
		End if 
End case 

