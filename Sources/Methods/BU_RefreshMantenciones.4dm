//%attributes = {}
  //BU_RefreshMantenciones

$line:=AL_GetLine (xalp_Buses)

If ($line>0)
	AT_Initialize (->alBU_Mantencion;->adBU_Fecha;->atBU_Responsable;->atBU_Tipo;->atBU_Patente;->arBU_Valor)
	QUERY:C277([BU_Buses_Mantencion:32];[BU_Buses_Mantencion:32]Patente_Bus:2;=;atBU_BUSPatente{$line})
	SELECTION TO ARRAY:C260([BU_Buses_Mantencion:32]Numero:1;alBU_Mantencion;[BU_Buses_Mantencion:32]Fecha:3;adBU_Fecha;[BU_Buses_Mantencion:32]Nombre_Responsable:4;atBU_Responsable;[BU_Buses_Mantencion:32]Tipo_Mantencion:5;atBU_Tipo;[BU_Buses_Mantencion:32]Patente_Bus:2;atBU_Patente;[BU_Buses_Mantencion:32]Valor:9;arBU_Valor)
End if 
