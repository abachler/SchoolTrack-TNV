//%attributes = {}
  //AL_pgPsy



vage:=DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7)
QUERY:C277([Alumnos_ObsOrientacion:127];[Alumnos_ObsOrientacion:127]Alumno_Numero:1=[Alumnos:2]numero:1)
AL_UpdateFields (xALP_PsyObs;2)
AL_SetSort (xALP_PsyObs;-1)
ALP_SetDefaultAppareance (xALP_PsyObs)
ALP_SetAlternateLigneColor (xALP_PsyObs;Records in selection:C76([Alumnos_ObsOrientacion:127]))
AL_SetLine (xALP_PsyObs;0)

QUERY:C277([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]Alumno_Numero:1=[Alumnos:2]numero:1)
AL_UpdateFields (xALP_PsyEvents;2)
AL_SetSort (xALP_PsyEvents;-1)
ALP_SetDefaultAppareance (xALP_PsyEvents)
ALP_SetAlternateLigneColor (xALP_PsyEvents;Records in selection:C76([Alumnos_EventosOrientacion:21]))
AL_SetLine (xALP_PsyEvents;0)
AL_SetLine (xALP_PsyEvents;0)

OBJECT SET VISIBLE:C603(*;"Observaciones";False:C215)
KRL_ReloadAsReadOnly (->[Alumnos_EventosOrientacion:21])
KRL_ReloadAsReadOnly (->[Alumnos_Orientacion:15])
KRL_ReloadAsReadOnly (->[Alumnos_ObsOrientacion:127])


IT_SetButtonState (USR_checkRights ("M";->[Alumnos_Orientacion:15]);->bBWR_SaveRecord)
MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_Orientacion:15]);1;5)
$0:=1

If (USR_checkRights ("A";->[Alumnos_Orientacion:15]))
	_O_ENABLE BUTTON:C192(*;"buttonOrientacion@")
Else 
	_O_DISABLE BUTTON:C193(*;"buttonOrientacion@")
End if 
