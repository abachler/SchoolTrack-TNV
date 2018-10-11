//%attributes = {}
  //SN3_SetPubInterfaceObjects

C_LONGINT:C283(bExtrasAtrasos;bExtrasAnotaciones;bExtrasCastigos;bExtrasSuspensiones)

IT_SetButtonState (((cb_PublicarAtrasos=1) & (cb_PublicarDato=1));->bExtrasAtrasos)
IT_SetButtonState (((cb_PublicarAnotaciones=1) & (cb_PublicarDato=1));->bExtrasAnotaciones)
IT_SetButtonState (((cb_PublicarCastigos=1) & (cb_PublicarDato=1));->bExtrasCastigos)
IT_SetButtonState (((cb_PublicarSuspensiones=1) & (cb_PublicarDato=1));->bExtrasSuspensiones)
IT_SetButtonState (((cb_PublicarAnotaciones=1) & (cb_PublicarDato=1));->cb_PublicarAnotacionesPositivas;->cb_PublicarAnotacionesNegativas;->cb_PublicarAnotacionesNeutras)
If (cb_PublicarAtrasos=1)
	OBJECT SET FONT STYLE:C166(cb_PublicarAtrasos;Bold:K14:2+Underline:K14:4)
Else 
	OBJECT SET FONT STYLE:C166(cb_PublicarAtrasos;Plain:K14:1)
End if 
If (cb_PublicarAnotaciones=1)
	OBJECT SET FONT STYLE:C166(cb_PublicarAnotaciones;Bold:K14:2+Underline:K14:4)
Else 
	OBJECT SET FONT STYLE:C166(cb_PublicarAnotaciones;Plain:K14:1)
End if 
If (cb_PublicarCastigos=1)
	OBJECT SET FONT STYLE:C166(cb_PublicarCastigos;Bold:K14:2+Underline:K14:4)
Else 
	OBJECT SET FONT STYLE:C166(cb_PublicarCastigos;Plain:K14:1)
End if 
If (cb_PublicarSuspensiones=1)
	OBJECT SET FONT STYLE:C166(cb_PublicarSuspensiones;Bold:K14:2+Underline:K14:4)
Else 
	OBJECT SET FONT STYLE:C166(cb_PublicarSuspensiones;Plain:K14:1)
End if 

IT_SetButtonState (((cb_PublicarResGralAsignatura=1) & (cb_PublicarDato=1));->cb_PublicarResGralMinimo;->cb_PublicarResGralMedia;->cb_PublicarResGralMaximo)
IT_SetButtonState (((cb_MostrarDetalle=1) & (cb_PublicarDato=1));->cb_OcultaParcialesMadre)

IT_SetButtonState (((cb_PublicarVisitas=1) & (cb_PublicarDato=1));->cb_PublicarVisitasViejas)

If (cb_PublicarDato=1)
	IT_SetButtonState ((cb_PublicarCompColegio=0);->cb_PublicarCompNivel)
	IT_SetButtonState ((cb_PublicarCompNivel=0);->cb_PublicarCompColegio)
	OBJECT SET ENTERABLE:C238(vl_DiasAlertaPrestamos;(cb_AlertarAtrasos=1))
Else 
	IT_SetButtonState (False:C215;->cb_PublicarCompNivel)
	IT_SetButtonState (False:C215;->cb_PublicarCompColegio)
	OBJECT SET ENTERABLE:C238(vl_DiasAlertaPrestamos;False:C215)
End if 

If (cb_PublicarAdjuntosPlanes=1)
	OBJECT SET ENABLED:C1123(cb_PC_Notasalalumno;False:C215)
	OBJECT SET ENABLED:C1123(cb_PC_Objetivos;False:C215)
	OBJECT SET ENABLED:C1123(cb_PC_Contenidos;False:C215)
	OBJECT SET ENABLED:C1123(cb_PC_Actividades;False:C215)
	OBJECT SET ENABLED:C1123(cb_PC_Tareas;False:C215)
	OBJECT SET ENABLED:C1123(cb_PC_Evaluacion;False:C215)
	
Else 
	OBJECT SET ENABLED:C1123(cb_PC_Notasalalumno;True:C214)
	OBJECT SET ENABLED:C1123(cb_PC_Objetivos;True:C214)
	OBJECT SET ENABLED:C1123(cb_PC_Contenidos;True:C214)
	OBJECT SET ENABLED:C1123(cb_PC_Actividades;True:C214)
	OBJECT SET ENABLED:C1123(cb_PC_Tareas;True:C214)
	OBJECT SET ENABLED:C1123(cb_PC_Evaluacion;True:C214)
End if 