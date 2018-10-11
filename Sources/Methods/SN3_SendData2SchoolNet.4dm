//%attributes = {}
  //SN3_SendData2SchoolNet

  //`======
vb_CambiarConstantes:=True:C214
  //`======


C_BOOLEAN:C305($queEnviar;$1;$2;$dummy)
ARRAY LONGINT:C221(SN3_Docs2Send;0)  //Para envio de adjuntos a planes
ARRAY TEXT:C222(SN3_extensions;0)  //Para envio de adjuntos a planes
ARRAY TEXT:C222(SN3_DocsNames;0)  //Para envio de adjuntos a planes
ARRAY BOOLEAN:C223(SN3_AdjuntoMD;0)  //Para envio de adjuntos a planes JVP 20160603
ARRAY TEXT:C222(SN3_FileReferenceKey;0)  //MONO

ARRAY LONGINT:C221(aNivelesCalificaciones;0)  //Para marcas de ultimo envio de calificaciones
_O_ARRAY STRING:C218(14;aDTSCalificaciones;0)  //Para marcas de ultimo envio de calificaciones

While (Semaphore:C143("SN3_DataSend"))
	DELAY PROCESS:C323(Current process:C322;30)
End while 

EVS_LoadStyles 
PERIODOS_Init 
NIV_LoadArrays 

SN3_VerificadorObsoletos 

SN3_RegisterLogEntry (SN3_Log_Info;"Generación de archivos iniciada.")
vb_ModoEnvio:=$1  //Usada por SN3_BuildFileHeader para saber si los archivos se generaron en forma manual o automatica
$queEnviar:=$2
$go:=True:C214
If (Count parameters:C259=3)
	C_BLOB:C604($3;xBlob)
	xBlob:=$3
	ARRAY LONGINT:C221(SN3_ParameterDataArr;0)  //Data Refs
	ARRAY LONGINT:C221(SN3_ParameterLevelArr;0)  //Niveles
	ARRAY BOOLEAN:C223(SN3_ParameterWhichDataArr;0)  //Cuales (todos o solo mods)
	BLOB_Blob2Vars (->xBlob;0;->SN3_ParameterDataArr;->SN3_ParameterLevelArr;->SN3_ParameterWhichDataArr)
	
	COPY ARRAY:C226(SN3_ParameterDataArr;SN3_ParameterDataArrCpy)
	
	AT_DistinctsArrayValues (->SN3_ParameterDataArrCpy)
	For ($i;1;Size of array:C274(SN3_ParameterDataArrCpy))
		SN3_ParameterDataArr{0}:=SN3_ParameterDataArrCpy{$i}
		ARRAY LONGINT:C221(SN3_MasterLevels;0)
		ARRAY BOOLEAN:C223(SN3_MasterTipoEnvio;0)
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray (->SN3_ParameterDataArr;"=";->$DA_Return)
		For ($j;1;Size of array:C274($DA_Return))
			If (SN3_ParameterLevelArr{$DA_Return{$j}}=SN3_TodosLosNiveles)  //Todos los niveles
				COPY ARRAY:C226(<>al_NumeroNivelesSchoolNet;SN3_MasterLevels)
				AT_RedimArrays (Size of array:C274(SN3_MasterLevels);->SN3_MasterTipoEnvio)
				$dummy:=SN3_ParameterWhichDataArr{$DA_Return{$j}}
				AT_Populate (->SN3_MasterTipoEnvio;->$dummy)
				$j:=Size of array:C274($DA_Return)+1
			Else 
				If (SN3_ParameterLevelArr{$DA_Return{$j}}=0)
					$queEnviar:=SN3_ParameterWhichDataArr{$DA_Return{$j}}
					Case of 
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Alumnos)
							SN3_SendAlumnosXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Profesores)
							SN3_SendProfesoresXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Cursos)
							SN3_SendCursosXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Asignaturas)
							SN3_SendAsignaturasXML ($queEnviar)
							SN3_SendguiasXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Familias)
							SN3_SendFamiliesXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_RelacionesFamiliares)
							SN3_SendRelacionesXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_DatosGenerales)
							SN3_SendColegioXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_ActividadesExtraCurr)
							SN3_SendActividadesXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_MatricesAprendizaje)
							SN3_SendMapasDefinicionesXML ($queEnviar)
						: (SN3_ParameterDataArrCpy{$i}=100022)
							SN3_SendSesionesXML ($queEnviar)
					End case 
				Else 
					APPEND TO ARRAY:C911(SN3_MasterLevels;SN3_ParameterLevelArr{$DA_Return{$j}})
					APPEND TO ARRAY:C911(SN3_MasterTipoEnvio;SN3_ParameterWhichDataArr{$DA_Return{$j}})
				End if 
			End if 
		End for 
		Case of 
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_EventosAgenda)
				SN3_SendEventosAgendaXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Calificaciones)
				SN3_SendCalificacionesXML ($queEnviar;True:C214)
				If (Not:C34($queEnviar))
					SN3_SendAsignaturasXML ($queEnviar;True:C214)  //Para actualizar estadisticas cuando envien solo calificaciones...
					SN3_SendAlumnosXML ($queEnviar;True:C214)  //Para actualizar promedio de alumnos cuando envien solo calificaciones...
				End if 
				SN3_SendSubAsignaturasXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Conducta)
				CREATE EMPTY SET:C140([Alumnos:2];"headers")
				SN3_SendAnotacionesXML ($queEnviar;True:C214)
				SN3_SendAtrasosXML ($queEnviar;True:C214)
				SN3_SendCastigosXML ($queEnviar;True:C214)
				SN3_SendInasistenciasXML ($queEnviar;True:C214)
				SN3_SendInasistHoraAcumXML ($queEnviar;True:C214)
				SN3_SendInasistHoraDetalleXML ($queEnviar;True:C214)
				SN3_SendSuspensionesXML ($queEnviar;True:C214)
				SN3_SendCondicionalidadXML ($queEnviar;True:C214)
				SN3_SendFaltasxAtrasosXML ($queEnviar;True:C214)  //MONO TICKET 209421
				CLEAR SET:C117("headers")
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Companeros)
				  //Compañeros... no mandamos nada...
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Horarios)
				SN3_SendHorariosXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Observaciones)
				SN3_SendObsAsignaturasXML ($queEnviar;True:C214)
				SN3_SendObsPJefeXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Salud)
				SN3_SendEnfermeriaXML ($queEnviar;True:C214)
				SN3_SendControlesMedicosXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_PlanesClase)
				SN3_SendPlanesXML ($queEnviar;True:C214)
				SN3_SendDocRefsXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_CalificacionesMPA)
				SN3_SendAprendizajesXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_CalificacionesExtraCurr)
				SN3_SendActividadesNotasXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_AvisosCobranza)
				SN3_SendAvisosXML ($queEnviar;True:C214)
				SN3_SendAvisosPDF 
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Pagos)
				SN3_SendPagosXML ($queEnviar;True:C214)
				
				  // Modificado por: Saúl Ponce (05/10/2017) Ticket 166954, envío de documentos tributarios
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_DTrib)
				SN3_SendDocTributariosXML ($queEnviar;True:C214)
				
			: (SN3_ParameterDataArrCpy{$i}=SN3_DTi_Prestamos)
				SN3_SendPrestamosXML ($queEnviar;True:C214)
			: (SN3_ParameterDataArrCpy{$i}=100022)
				SN3_SendSesionesXML ($queEnviar;True:C214)  //MONO 22-05-14: pub sesiones
				
				  //Se envia el enviar todo asignaturas
				  //: (SN3_ParameterDataArrCpy{$i}=10013)  // ASM para publicar los adjuntos de asugnaturas
				  //SN3_SendguiasXML ($queEnviar;True)
				  //SN3_SendDocRefsXML_Adjuntos ($queEnviar;True)
		End case 
	End for 
	AT_Initialize (->SN3_ParameterDataArr;->SN3_ParameterLevelArr;->SN3_ParameterWhichDataArr)
Else 
	If ($queEnviar)
		$allowed:=SN3_IsAllowed2Send 
		If ($allowed#1)
			$go:=False:C215
		End if 
	End if 
	
	If ($go)
		SN3_SendColegioXML ($queEnviar)
		
		SN3_SendAlumnosXML ($queEnviar)
		SN3_SendRelacionesXML ($queEnviar)
		SN3_SendFamiliesXML ($queEnviar)
		SN3_SendProfesoresXML ($queEnviar)
		SN3_SendCursosXML ($queEnviar)
		SN3_SendAsignaturasXML ($queEnviar)
		SN3_SendEventosAgendaXML ($queEnviar)
		SN3_SendActividadesXML ($queEnviar)
		SN3_SendMapasDefinicionesXML ($queEnviar)
		
		SN3_SendActividadesNotasXML ($queEnviar)
		
		CREATE EMPTY SET:C140([Alumnos:2];"headers")
		SN3_SendAnotacionesXML ($queEnviar)
		SN3_SendAtrasosXML ($queEnviar)
		SN3_SendCastigosXML ($queEnviar)
		SN3_SendInasistenciasXML ($queEnviar)
		SN3_SendInasistHoraAcumXML ($queEnviar)
		SN3_SendInasistHoraDetalleXML ($queEnviar)
		SN3_SendSuspensionesXML ($queEnviar)
		SN3_SendCondicionalidadXML ($queEnviar)
		CLEAR SET:C117("headers")
		
		SN3_SendAprendizajesXML ($queEnviar)
		
		SN3_SendCalificacionesXML ($queEnviar)
		SN3_SendSubAsignaturasXML ($queEnviar)
		
		SN3_SendEnfermeriaXML ($queEnviar)
		SN3_SendControlesMedicosXML ($queEnviar)
		
		SN3_SendPlanesXML ($queEnviar)
		SN3_SendDocRefsXML ($queEnviar)
		
		SN3_SendHorariosXML ($queEnviar)
		
		SN3_SendObsAsignaturasXML ($queEnviar)
		SN3_SendObsPJefeXML ($queEnviar)
		
		SN3_SendAvisosXML ($queEnviar)
		SN3_SendPagosXML ($queEnviar)
		
		  // Modificado por: Saúl Ponce (05/10/2017) Ticket 166954, envío de documentos tributarios
		SN3_SendDocTributariosXML ($queEnviar)
		
		SN3_SendPrestamosXML ($queEnviar)
		
		If (LICENCIA_esModuloAutorizado (1;AccountTrack))
			SN3_SendAvisosPDF 
		End if 
		
		SN3_SendSesionesXML ($queEnviar)  //MONO 22-05-14: pub sesiones
		SN3_SendguiasXML ($queEnviar)
		  //SN3_SendDocRefsXML_Adjuntos ($queEnviar)
		SN3_SendFaltasxAtrasosXML ($queEnviar)  //MONO 209421
		
	End if 
End if 
If ($go)
	SN3_SendAttachments 
	SN3_SendAttachments (True:C214)
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24#0)
	SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
	QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
	SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	CREATE SET:C116([Alumnos:2];"headers")
	SN3_SendHeadersConductaXML ($queEnviar)
	CLEAR SET:C117("headers")
	SN3_SendObsoletosXML ($queEnviar)
	SN3_RegisterLogEntry (SN3_Log_Info;"Generación de archivos concluída.")
	SN3_SendPubConfigs (1)
	SN3_FTP_SendFiles 
End if 
If (Not:C34($go))
	SN3_RegisterLogEntry (SN3_Log_Info;"Generación de archivos y envío no realizado. SchoolNet está procesando un envío a"+"nterior.")
End if 
AT_Initialize (->SN3_Docs2Send;->SN3_extensions;->SN3_DocsNames;->SN3_AdjuntoMD)
AT_Initialize (->aNivelesCalificaciones;->aDTSCalificaciones)

CLEAR SEMAPHORE:C144("SN3_DataSend")