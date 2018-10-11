If (USR_IsGroupMember_by_GrpID (-15001;USR_GetUserID ))
	
	$yearName:=CD_Request (__ ("¿Que año desea agregar?");__ ("Agregar");__ ("Cancelar"))
	$year:=Num:C11($yearName)
	If (($yearName#"") & ($year>0) & (<>gyear>$year))
		If (HL_FindElement (hl_añosNiveles;$yearName)=-1)
			QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1;=;$year)
			If (Records in selection:C76([xxSTR_DatosDeCierre:24])>0)
				$yearName:=[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5
			Else 
				CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
				[xxSTR_DatosDeCierre:24]Year:1:=$year
				[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=$yearName
				SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
			End if 
			CREATE RECORD:C68([xxSTR_HistoricoNiveles:191])
			[xxSTR_HistoricoNiveles:191]Año:2:=[xxSTR_DatosDeCierre:24]Year:1
			[xxSTR_HistoricoNiveles:191]NumeroNivel:3:=[xxSTR_Niveles:6]NoNivel:5
			[xxSTR_HistoricoNiveles:191]NombreDeCiclo:14:=[xxSTR_Niveles:6]Sección:9
			[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Interna:12:=[xxSTR_Niveles:6]Abreviatura:19
			[xxSTR_HistoricoNiveles:191]AbreviacionNivel_Oficial:13:=[xxSTR_Niveles:6]Abreviatura_Oficial:35
			[xxSTR_HistoricoNiveles:191]DirectorResponsable:15:=[xxSTR_Niveles:6]Director:13
			[xxSTR_HistoricoNiveles:191]Id_EstiloEvaluacionOficial:9:=EVS_EstiloHistoricoPorDefecto ([xxSTR_HistoricoNiveles:191]Año:2)
			[xxSTR_HistoricoNiveles:191]ID_EstiloEvaluacionInterno:8:=EVS_EstiloHistoricoPorDefecto ([xxSTR_HistoricoNiveles:191]Año:2)
			[xxSTR_HistoricoNiveles:191]ID_Institucion:1:=<>gInstitucion
			[xxSTR_HistoricoNiveles:191]NombreInterno:5:=[xxSTR_Niveles:6]Nombre_Oficial_NIvel:21
			[xxSTR_HistoricoNiveles:191]NombreOficial:6:=[xxSTR_Niveles:6]Nivel:1
			[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=2
			  //20121031 ASM se agrega nuevo campo
			[xxSTR_HistoricoNiveles:191]ModoRegistroAsistencia:23:=[xxSTR_Niveles:6]AttendanceMode:3
			SAVE RECORD:C53([xxSTR_HistoricoNiveles:191])
			ARRAY INTEGER:C220(aiSTR_Periodos_Numero;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
			ARRAY TEXT:C222(atSTR_Periodos_Nombre;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
			ARRAY DATE:C224(adSTR_Periodos_Desde;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
			ARRAY DATE:C224(adSTR_Periodos_Hasta;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
			ARRAY DATE:C224(adSTR_Periodos_Cierre;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
			ARRAY INTEGER:C220(aiSTR_Periodos_Dias;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
			
			For ($i;1;[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
				If (atSTR_Periodos_Nombre{$i}="")
					atSTR_Periodos_Nombre{$i}:="Período "+String:C10($i)
				End if 
			End for 
			
			PERIODOS_GuardaDatosHistoricos ([xxSTR_HistoricoNiveles:191]NumeroNivel:3;[xxSTR_HistoricoNiveles:191]Año:2)
			
			APPEND TO LIST:C376(hl_añosNiveles;$yearName;Record number:C243([xxSTR_HistoricoNiveles:191]))
			SORT LIST:C391(hl_añosNiveles;<)
			SELECT LIST ITEMS BY REFERENCE:C630(hl_añosNiveles;Record number:C243([xxSTR_HistoricoNiveles:191]))
			_O_REDRAW LIST:C382(hl_añosNiveles)
			
			OBJECT SET VISIBLE:C603(*;"hl_estilosEvaluacion@";True:C214)
			OBJECT SET VISIBLE:C603(*;"Texto2";True:C214)
			OBJECT SET ENTERABLE:C238(*;"editables@";True:C214)
			OBJECT SET VISIBLE:C603(*;"seccion@";True:C214)
			
			OBJECT SET ENTERABLE:C238(*;"editablesPeriodo@";True:C214)
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Usted no está autorizado para realizar esta acción."))
End if 