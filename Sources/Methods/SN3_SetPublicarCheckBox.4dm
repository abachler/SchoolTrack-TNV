//%attributes = {}
  //SN3_SetPublicarCheckBox

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======

If (vlSN3_CurrDataType>=10000)
	Case of 
		: (vlSN3_CurrDataType=SN3_DTi_EventosAgenda)
			cb_PublicarDato:=cb_PublicarAgenda
		: (vlSN3_CurrDataType=SN3_DTi_Calificaciones)
			cb_PublicarDato:=cb_PublicarEvaluaciones
			
		: (vlSN3_CurrDataType=SN3_DTi_Conducta)  //MONO TICKET 209421
			cb_PublicarDato:=cb_PublicarConducta
			If (cb_PublicarDato=1)
				$cond:=((cb_PublicarAnotaciones=0) & (cb_PublicarCastigos=0) & (cb_PublicarSuspensiones=0) & (cb_PublicarCondicionalidad=0))
				If ($cond)
					cb_PublicarAnotaciones:=1
					cb_PublicarCastigos:=1
					cb_PublicarSuspensiones:=1
					cb_PublicarCondicionalidad:=1
				End if 
				$cond:=((cb_PublicarAnotacionesPositivas=0) & (cb_PublicarAnotacionesNegativas=0) & (cb_PublicarAnotacionesNeutras=0) & (cb_PublicarAnotaciones=1))
				If ($cond)
					cb_PublicarAnotacionesPositivas:=1
					cb_PublicarAnotacionesNegativas:=1
					cb_PublicarAnotacionesNeutras:=1
				End if 
			End if 
			
		: (vlSN3_CurrDataType=10011)  //MONO TICKET 209421 - Asistencia
			cb_PublicarDato:=cb_PublicarAsistencia
			If (cb_PublicarDato=1)
				$cond:=((cb_PublicarInasistencias=0) & (cb_PublicarAtrasos=0) & (cb_PublicarPctAsistencia=0))
				If ($cond)
					cb_PublicarInasistencias:=1
					cb_PublicarAtrasos:=1
					cb_PublicarPctAsistencia:=1
				End if 
			End if 
			
			
		: (vlSN3_CurrDataType=SN3_DTi_Companeros)
			cb_PublicarDato:=cb_PublicarCompaneros
		: (vlSN3_CurrDataType=SN3_DTi_Horarios)
			cb_PublicarDato:=cb_PublicarHorario
		: (vlSN3_CurrDataType=SN3_DTi_Observaciones)
			cb_PublicarDato:=cb_PublicarObservaciones
			If (cb_PublicarDato=1)
				$cond:=((cb_PublicarObsPJ=0) & (cb_PublicarObsAsignaturas=0))
				If ($cond)
					cb_PublicarObsPJ:=1
					cb_PublicarObsAsignaturas:=1
				End if 
			End if 
		: (vlSN3_CurrDataType=SN3_DTi_Salud)
			cb_PublicarDato:=cb_PublicarEnfermeria
			If (cb_PublicarDato=1)
				$cond:=((cb_PublicarVisitas=0) & (cb_PublicarCM=0))
				If ($cond)
					cb_PublicarVisitas:=1
					cb_PublicarCM:=1
				End if 
			End if 
		: (vlSN3_CurrDataType=SN3_DTi_PlanesClase)
			cb_PublicarDato:=cb_PublicarPlanes
		: (vlSN3_CurrDataType=SN3_DTi_CalificacionesMPA)
			cb_PublicarDato:=cb_PublicarAE
		: (vlSN3_CurrDataType=SN3_DTi_CalificacionesExtraCurr)
			cb_PublicarDato:=cb_PublicarAct
		: (vlSN3_CurrDataType=SN3_DTi_AvisosCobranza)
			cb_PublicarDato:=cb_PublicarAvisos
		: (vlSN3_CurrDataType=SN3_DTi_Pagos)
			cb_PublicarDato:=cb_PublicarPagos
		: (vlSN3_CurrDataType=SN3_DTi_DTrib)
			cb_PublicarDato:=cb_PublicarBoletas
		: (vlSN3_CurrDataType=SN3_DTi_Prestamos)
			cb_PublicarDato:=cb_PublicarPrestamos
		: (vlSN3_CurrDataType=40000)
			cb_PublicarDato:=cb_PublicarFotografias
			If (cb_PublicarDato=1)
				$cond:=((cb_PublicarFotosAlumno=0) & (cb_PublicarFotoPJ=0) & (cb_PublicarFotoProfesores=0) & (cb_PublicarFotoCompaneros=0))
				If ($cond)
					cb_PublicarFotosAlumno:=1
					cb_PublicarFotoPJ:=1
					cb_PublicarFotoProfesores:=1
					cb_PublicarFotoCompaneros:=1
				End if 
			End if 
		: (vlSN3_CurrDataType=45000)  //comunicaciones
			If (Not:C34(vb_ct_lincenciado))
				cb_PublicarComunicaciones:=0
			End if 
			cb_PublicarDato:=cb_PublicarComunicaciones
		: (vlSN3_CurrDataType=SN3_DTi_Profesores)  //MONO 06-11-13: pub profesores
			cb_PublicarDato:=cb_PublicarProfesores
		: (vlSN3_CurrDataType=46000)  //MONO 06-11-13: pub informes
			cb_PublicarDato:=cb_PublicarInformes
			
		: (vlSN3_CurrDataType=10012)  //MONO 22-05-14: pub sesiones
			cb_PublicarDato:=cb_PublicarSesiones
			
		: (vlSN3_CurrDataType=10013)  //ASM 20160406
			cb_PublicarDato:=cb_PublicarMaterial
			
		: (vlSN3_CurrDataType=45501)  // HOME NOTICIAS TICKET 198851
			cb_PublicarDato:=cb_PublicarHome
			
	End case 
End if 

