//%attributes = {}
  //BU_xALP_CB_EX_Inscritos

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)

AL_GetCurrCell (xalp_Inscritos;$col;$row)
$lineRec:=AL_GetLine (xalp_ListaRec)
If ($row>0)
	If ($col>0)
		READ WRITE:C146([BU_Rutas_Inscripciones:35])
		QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=alBU_IdRecorrido{$lineRec};*)
		QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2=alBU_ALID{$row})
		If (Records in selection:C76([BU_Rutas_Inscripciones:35])=1)
			[BU_Rutas_Inscripciones:35]Tipo_Servicio:6:=atBU_ALTipoServ{$row}
			[BU_Rutas_Inscripciones:35]solo_o_acompañado:5:=atBU_ALDesciende{$row}
			If (atBU_ALDesciende{$row}=False:C215)
				[BU_Rutas_Inscripciones:35]Acompañado_por:7:=""
				atBU_ALAcompañado{$row}:=""
			Else 
				[BU_Rutas_Inscripciones:35]Acompañado_por:7:=atBU_ALAcompañado{$row}
			End if 
			SAVE RECORD:C53([BU_Rutas_Inscripciones:35])
			KRL_UnloadReadOnly (->[BU_Rutas_Inscripciones:35])
		End if 
	End if 
End if 