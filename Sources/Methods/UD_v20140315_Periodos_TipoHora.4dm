//%attributes = {}
  // UD_v20140315_Periodos_TipoHora()
  // Por: Alberto Bachler K.: 15-03-14, 12:44:06
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------





C_BLOB:C604($x_blob)
C_LONGINT:C283($i;$l_refObjetoOT)

ARRAY LONGINT:C221($al_RecNums;0)

vlSTR_Horario_TipoCiclos:=1
vlSTR_Horario_NoCiclos:=1
vlSTR_Horario_DiasCiclo:=5
vlSTR_Horario_DiaInicioCiclo:=2
vlSTR_Horario_SabadoLabor:=0
ARRAY INTEGER:C220(aiSTR_Horario_HoraNo;0)
ARRAY LONGINT:C221(alSTR_Horario_Desde;0)
ARRAY LONGINT:C221(alSTR_Horario_Hasta;0)
ARRAY LONGINT:C221(alSTR_Horario_Duracion;0)
ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)
ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;0)

ALL RECORDS:C47([xxSTR_Periodos:100])

LONGINT ARRAY FROM SELECTION:C647([xxSTR_Periodos:100];$al_RecNums;"")
For ($i;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([xxSTR_Periodos:100])
	GOTO RECORD:C242([xxSTR_Periodos:100];$al_RecNums{$i})
	
	$l_refObjetoOT:=OT BLOBToObject ([xxSTR_Periodos:100]Horarios:8)
	OT GetArray ($l_refObjetoOT;"aiSTR_Horario_HoraNo";aiSTR_Horario_HoraNo)
	OT GetArray ($l_refObjetoOT;"alSTR_Horario_Desde";alSTR_Horario_Desde)
	OT GetArray ($l_refObjetoOT;"alSTR_Horario_Hasta";alSTR_Horario_Hasta)
	OT GetArray ($l_refObjetoOT;"alSTR_Horario_Duracion";alSTR_Horario_Duracion)
	vlSTR_Horario_TipoCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_TipoCiclos")
	vlSTR_Horario_NoCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_NoCiclos")
	vlSTR_Horario_DiasCiclo:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_DiasCiclo")
	vlSTR_Horario_DiaInicioCiclo:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_DiaInicioCiclo")
	vlSTR_Horario_SabadoLabor:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_SabadoLabor")
	vlSTR_Horario_ResetCiclos:=OT GetLong ($l_refObjetoOT;"vlSTR_Horario_ResetCiclos")
	OT GetArray ($l_refObjetoOT;"adSTR_Periodos_InicioCiclos";adSTR_Periodos_InicioCiclos)
	OT GetArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
	
	ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;Size of array:C274(aiSTR_Horario_HoraNo))
	OT PutArray ($l_refObjetoOT;"alSTR_Horario_RefTipoHora";alSTR_Horario_RefTipoHora)
	$x_blob:=OT ObjectToNewBLOB ($l_refObjetoOT)
	[xxSTR_Periodos:100]Horarios:8:=$x_blob
	OT Clear ($l_refObjetoOT)
	
	SAVE RECORD:C53([xxSTR_Periodos:100])
End for 
KRL_UnloadReadOnly (->[xxSTR_Periodos:100])

