  // [Asignaturas].Input.lb_observaciones()
  // 
  //
  // creado por: Alberto Bachler Klein: 24-12-15, 11:51:20
  // -----------------------------------------------------------

$t_objeto:=OBJECT Get name:C1087(Object current:K67:2)
Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		AS_EditaObservaciones 
		AS_PageObs 
End case 
