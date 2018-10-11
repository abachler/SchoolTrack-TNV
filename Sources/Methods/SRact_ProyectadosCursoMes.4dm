//%attributes = {}
  //SRact_ProyectadosCursoMes

SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_CuentaCorriente:2;->[ACT_CuentasCorrientes:175]ID:1;"")

For ($i;1;12)
	
	vMesPtr:=Get pointer:C304("vMes"+String:C10($i))
	vMesPtr->:=0
	
End for 

If (Records in selection:C76([ACT_Cargos:173])>0)
	
	CREATE SET:C116([ACT_Cargos:173];"Seleccion")
	
	For ($i;1;12)
		
		USE SET:C118("Seleccion")
		
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22=!00-00-00!;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=$i)
		
		vMesPtr:=Get pointer:C304("vMes"+String:C10($i))
		vMesPtr->:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
		
	End for 
	
	CLEAR SET:C117("Seleccion")
	
End if 