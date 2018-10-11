//%attributes = {}
  //ACTinit_CalcNoCargasYOrdenaCtas

ACTcfgdes_OpcionesGenerales ("AperturaModulo")
ACTcc_OrderCtasCtes 
READ ONLY:C145([Personas:7])
ALL RECORDS:C47([Personas:7])
ARRAY LONGINT:C221($al_idApdos;0)
SELECTION TO ARRAY:C260([Personas:7]No:1;$al_idApdos)
REDUCE SELECTION:C351([Personas:7];0)
For ($i;1;Size of array:C274($al_idApdos))
	ACTpp_CalculaNoCargas ($al_idApdos{$i})
End for 

  //se fuerza ejecución de trigger para todas las personas
READ ONLY:C145([Personas:7])
ALL RECORDS:C47([Personas:7])
ARRAY LONGINT:C221($al_recNumPersonas;0)
LONGINT ARRAY FROM SELECTION:C647([Personas:7];$al_recNumPersonas;"")
For ($i;1;Size of array:C274($al_recNumPersonas))
	KRL_GotoRecord (->[Personas:7];$al_recNumPersonas{$i};True:C214)
	[Personas:7]No:1:=[Personas:7]No:1
	SAVE RECORD:C53([Personas:7])
	KRL_UnloadReadOnly (->[Personas:7])
End for 
REDUCE SELECTION:C351([Personas:7];0)