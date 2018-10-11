//%attributes = {}
  //SRACTpgs_OrdenEnMovimientos

C_LONGINT:C283($1)

If (Count parameters:C259>0)
	
	Case of 
		: ($1=1)
			  //Para Movimientos por Forma de Pago Cta Cte
			ARRAY TEXT:C222(atFormasPagos;0)
			ARRAY LONGINT:C221(alRegNums;0)
			ARRAY TEXT:C222(atNombresCtas;0)
			ARRAY TEXT:C222(atCursoCtas;0)
			SELECTION TO ARRAY:C260([ACT_Pagos:172];alRegNums;[ACT_Pagos:172]forma_de_pago_new:31;atFormasPagos;[Alumnos:2]apellidos_y_nombres:40;atNombresCtas;[Alumnos:2]curso:20;atCursoCtas)
			AT_MultiLevelSort (">>> ";->atFormasPagos;->atCursoCtas;->atNombresCtas;->alRegNums)
			CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];alRegNums)
		: ($1=2)
			  //Para Movimientos por Lugar de Pago Cta Cte
			ARRAY TEXT:C222(atLugaresPagos;0)
			ARRAY LONGINT:C221(alRegNums;0)
			ARRAY TEXT:C222(atNombresCtas;0)
			ARRAY TEXT:C222(atCursoCtas;0)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([ACT_Pagos:172];alRegNums;[ACT_Pagos:172]forma_de_pago_new:31;atLugaresPagos;[Alumnos:2]apellidos_y_nombres:40;atNombresCtas;[Alumnos:2]curso:20;atCursoCtas)
			AT_MultiLevelSort (">>> ";->atLugaresPagos;->atCursoCtas;->atNombresCtas;->alRegNums)
			CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];alRegNums)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			
		: ($1=3)
			  //Para Movimientos por Forma de Pago Apoderado
			ARRAY TEXT:C222(atFormasPagos;0)
			ARRAY LONGINT:C221(alRegNums;0)
			ARRAY TEXT:C222(atNombresApds;0)
			ARRAY DATE:C224(adFechasPagos;0)
			SELECTION TO ARRAY:C260([ACT_Pagos:172];alRegNums;[ACT_Pagos:172]forma_de_pago_new:31;atFormasPagos;[ACT_Pagos:172]Fecha:2;adFechasPagos;[Personas:7]Apellidos_y_nombres:30;atNombresApds)
			AT_MultiLevelSort (">>> ";->atFormasPagos;->atNombresApds;->adFechasPagos;->alRegNums)
			CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];alRegNums)
			
		: ($1=4)
			  //Para Movimientos por Lugar de Pago Apoderado
			ARRAY TEXT:C222(atLugaresPagos;0)
			ARRAY LONGINT:C221(alRegNums;0)
			ARRAY TEXT:C222(atNombresApds;0)
			ARRAY DATE:C224(adFechasPagos;0)
			SELECTION TO ARRAY:C260([ACT_Pagos:172];alRegNums;[ACT_Pagos:172]Lugar_de_Pago:18;atLugaresPagos;[ACT_Pagos:172]Fecha:2;adFechasPagos;[Personas:7]Apellidos_y_nombres:30;atNombresApds)
			AT_MultiLevelSort (">>> ";->atLugaresPagos;->atNombresApds;->adFechasPagos;->alRegNums)
			CREATE SELECTION FROM ARRAY:C640([ACT_Pagos:172];alRegNums)
			
	End case 
End if 
