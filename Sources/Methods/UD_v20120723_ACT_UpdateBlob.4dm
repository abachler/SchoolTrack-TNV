//%attributes = {}
  //UD_v20120723_ACT_UpdateBlob
If (ACT_AccountTrackInicializado )
	  //20120723 RCH Para manejar nuevo campo matriculado el
	C_BLOB:C604($xBlob)
	ACTcfg_ItemsMatricula ("InicializaArreglos")
	ACTcfg_ItemsMatricula ("Variables2Blob";->$xBlob)
	$xBlob:=PREF_fGetBlob (0;"ParametrosMatriculadoAuto";$xBlob)
	BLOB_Blob2Vars (->$xBlob;0;->alACTcfg_IdItemMatricula;->cs_MatriculadoAuto;->btn_Proyectado;->btn_Emitido;->btn_pagoParcial;->btn_pagoCompleto;->vdACTcfg_Fecha;->btn_noEmiteMatriculado;->btn_noEmiteAluXEgresar)
	
	ACTcfg_ItemsMatricula ("Variables2Blob";->$xBlob)
	PREF_SetBlob (0;"ParametrosMatriculadoAuto";$xBlob)
	ACTcfg_ItemsMatricula ("InicializaArreglos")
	SET BLOB SIZE:C606($xBlob;0)
End if 