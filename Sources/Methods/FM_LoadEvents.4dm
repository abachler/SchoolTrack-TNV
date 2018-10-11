//%attributes = {}
  //FM_LoadEvents

ARRAY TEXT:C222(at_Text1;0)
ARRAY TEXT:C222(at_Text2;0)
ARRAY TEXT:C222(at_Text3;0)
ARRAY DATE:C224(ad_Date1;0)
ARRAY LONGINT:C221(al_Long1;0)

AL_UpdateArrays (xALP_EventosFamiliares;0)

QUERY:C277([Familia_RegistroEventos:140];[Familia_RegistroEventos:140]ID_Familia:1=[Familia:78]Numero:1;*)
QUERY:C277([Familia_RegistroEventos:140]; & ;[Familia_RegistroEventos:140]ModuloRef:6=vlBWR_CurrentModuleRef)
SELECTION TO ARRAY:C260([Familia_RegistroEventos:140]ID_Autor:9;$idautor;[Familia_RegistroEventos:140]Privada:8;$ab_Privada;[Familia_RegistroEventos:140]Fecha_Evento:2;ad_Date1;[Familia_RegistroEventos:140]Tipo_Evento:3;at_Text1;[Familia_RegistroEventos:140]Observaciones:4;at_Text2;[Familia_RegistroEventos:140]Registrado_por:5;at_Text3;[Familia_RegistroEventos:140];al_Long1)
SORT ARRAY:C229(ad_Date1;at_Text1;at_Text2;at_Text3;al_Long1;$idautor;>)
AL_UpdateArrays (xALP_EventosFamiliares;-2)
For ($i;1;Size of array:C274(al_Long1))
	If (($ab_Privada{$i}) & ($idautor{$i}#<>lUSR_RelatedTableUserID))
		at_Text2{$i}:="Privada ("+at_Text3{$i}+")"
		AL_SetRowStyle (xALP_EventosFamiliares;$i;2)
	End if 
End for 
AL_SetSort (xALP_EventosFamiliares;-1;2)


