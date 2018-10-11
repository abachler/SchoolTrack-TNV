//%attributes = {}
  // AL_MarcaCampoHijoFuncionario()
  // Por: Alberto Bachler K.: 05-09-14, 11:59:35
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_esHijoDeFuncionario;$b_tareaEjecutada)
C_LONGINT:C283($l_IdPersona;$l_recNumFamilia)



If (False:C215)
	C_LONGINT:C283(AL_MarcaCampoHijoFuncionario ;$1)
	C_LONGINT:C283(AL_MarcaCampoHijoFuncionario ;$2)
End if 

READ WRITE:C146([Alumnos:2])

$l_IdPersona:=$1

$l_recNumFamilia:=No current record:K29:2
If (Count parameters:C259=2)
	$l_recNumFamilia:=$2
End if 

PROCESS PROPERTIES:C336(Current process:C322;$t_nombreProceso;$l_estadoProceso;$l_tiempo)
$b_esTareaBatch:=($t_nombreProceso="Batch Tasks Processor")

  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->$l_IdPersona;False)
  //KRL_FindAndLoadRecordByIndex (->[Profesores]ID_Persona;->$l_IdPersona;False)
KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_IdPersona;True:C214)  //20171121 RCH
KRL_FindAndLoadRecordByIndex (->[Profesores:4]ID_Persona:65;->$l_IdPersona;True:C214)  //20171121 RCH
If (Not:C34((Locked:C147([Personas:7]))) & (Not:C34(Locked:C147([Profesores:4]))))
	READ ONLY:C145([Familia_RelacionesFamiliares:77])
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=$l_IdPersona)
	If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
		KRL_RelateSelection (->[Alumnos:2]Familia_Número:24;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
		If (Records in selection:C76([Alumnos:2])>0)
			$b_esHijoDeFuncionario:=(([Personas:7]ID_Profesor:78#0) & (Not:C34([Profesores:4]Inactivo:62)) & (Not:C34([Personas:7]Inactivo:46)))
			APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Hijo_funcionario:67:=$b_esHijoDeFuncionario)
			$b_tareaEjecutada:=(Records in set:C195("LockedSet")=0)
			If ((Not:C34($b_tareaEjecutada)) & (Not:C34($b_esTareaBatch)))
				BM_CreateRequest ("AL_MarcaCampoHijoFuncionario";String:C10([Personas:7]No:1);String:C10([Personas:7]No:1))
			End if 
		Else 
			$b_tareaEjecutada:=True:C214  //20150805 RCH no se encuentra al alumno
		End if 
	Else 
		$b_tareaEjecutada:=True:C214  //20150805 RCH no existe la relacion familiar
	End if 
	
	If ($l_recNumFamilia>No current record:K29:2)
		GOTO RECORD:C242([Familia:78];$l_recNumFamilia)
	End if 
	
	KRL_UnloadReadOnly (->[Alumnos:2])
End if 
KRL_UnloadReadOnly (->[Personas:7])
KRL_UnloadReadOnly (->[Profesores:4])
$0:=$b_tareaEjecutada

