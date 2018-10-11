  // [TMT_Horario].InfoAsignacionAsignatura.lb_alumnos()
  // Por: Alberto Bachler: 02/06/13, 17:20:39
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (vl_ColumnaAlumnos=1)
		LISTBOX SORT COLUMNS:C916(lb_alumnos;5;>)
	: (vl_ColumnaAlumnos=2)
		LISTBOX SORT COLUMNS:C916(lb_alumnos;5;<)
End case 

vl_ColumnaAlumnos:=vl_ColumnaOrden
