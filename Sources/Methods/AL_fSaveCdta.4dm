//%attributes = {}
  //AL_fSaveCdta

C_BOOLEAN:C305($condicionalidadActivada)
C_DATE:C307($condicionalidadHasta)
C_TEXT:C284($condicionalidadMotivo)
$0:=0

If ((USR_checkRights ("M";->[Alumnos_Conducta:8])) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
	
	$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
	AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57;->$condicionalidadActivada)
	AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58;->$condicionalidadHasta)
	AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Motivo:59;->$condicionalidadMotivo)
	
	If ((Num:C11($condicionalidadActivada)#(bCondicional)) | (vd_fechaCondicionalidad#$condicionalidadHasta) | ($condicionalidadMotivo#vt_motivoCondicionalidad))
		
		$condicionalidadActivada:=(bCondicional=1)
		$condicionalidadHasta:=vd_fechaCondicionalidad
		$condicionalidadMotivo:=vt_motivoCondicionalidad
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Activada:57;->$condicionalidadActivada;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Hasta:58;->$condicionalidadHasta;False:C215)
		AL_EscribeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Condicionalidad_Motivo:59;->$condicionalidadMotivo;True:C214)
		bCondicional:=0
		vd_fechaCondicionalidad:=!00-00-00!
		vt_motivoCondicionalidad:=""
		
		$0:=1
	Else 
		$0:=0
	End if 
	$0:=0
End if 
