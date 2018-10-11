//%attributes = {}
  //SN3_GetPublicarCheckBox

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======

If (vlSN3_CurrDataType>=10000)
	Case of 
		: (vlSN3_CurrDataType=SN3_DTi_EventosAgenda)
			cb_PublicarAgenda:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Calificaciones)
			cb_PublicarEvaluaciones:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Conducta)
			cb_PublicarConducta:=cb_PublicarDato  //MONO TICKET 209421
		: (vlSN3_CurrDataType=10011)  //MONO TICKET 209421
			cb_PublicarAsistencia:=cb_PublicarDato  //MONO TICKET 209421
		: (vlSN3_CurrDataType=SN3_DTi_Companeros)
			cb_PublicarCompaneros:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Horarios)
			cb_PublicarHorario:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Observaciones)
			cb_PublicarObservaciones:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Salud)
			cb_PublicarEnfermeria:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_PlanesClase)
			cb_PublicarPlanes:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_CalificacionesMPA)
			cb_PublicarAE:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_CalificacionesExtraCurr)
			cb_PublicarAct:=cb_PublicarDato
			  //cb_PublicarAct:=0  // agrego siempre cero, por solicitud de Ariel
		: (vlSN3_CurrDataType=SN3_DTi_AvisosCobranza)
			cb_PublicarAvisos:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Pagos)
			cb_PublicarPagos:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_DTrib)
			cb_PublicarBoletas:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Prestamos)
			cb_PublicarPrestamos:=cb_PublicarDato
		: (vlSN3_CurrDataType=40000)
			cb_PublicarFotografias:=cb_PublicarDato
		: (vlSN3_CurrDataType=45000)
			cb_PublicarComunicaciones:=cb_PublicarDato
		: (vlSN3_CurrDataType=SN3_DTi_Profesores)  //MONO 06-11-13: pub profesores
			cb_PublicarProfesores:=cb_PublicarDato
		: (vlSN3_CurrDataType=46000)  //MONO 06-11-13: pub informes
			cb_PublicarInformes:=cb_PublicarDato
		: (vlSN3_CurrDataType=10012)  //MONO 22-05-14: pub sesiones
			cb_PublicarSesiones:=cb_PublicarDato
		: (vlSN3_CurrDataType=10013)  //ASM 20160406
			cb_PublicarMaterial:=cb_PublicarDato
		: (vlSN3_CurrDataType=45501)  // HOME NOTICIAS TICKET 198851
			cb_PublicarHome:=cb_PublicarDato
	End case 
End if 