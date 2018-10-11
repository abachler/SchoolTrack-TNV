  // [TMT_Horario].Horario.lbsalas()
  // 
  //
  // creado por: Alberto Bachler Klein: 19-07-16, 18:29:48
  // -----------------------------------------------------------

$y_salas:=OBJECT Get pointer:C1124(Object named:K67:5;"lbSalas")
$y_asignaturas:=OBJECT Get pointer:C1124(Object named:K67:5;"lbasignaturas")
$y_horario:=OBJECT Get pointer:C1124(Object named:K67:5;"lbHorario")

Case of 
	: (Form event:C388=On Begin Drag Over:K2:44)
		$0:=0
		
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($y_origen;$l_elementoArrastre;$l_proceso)
		RESOLVE POINTER:C394($y_origen;$t_variable;$l_tabla;$l_campo)
		If ($y_origen=$y_horario)
			$0:=0
		Else 
			$0:=-1
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
		OBJECT SET VISIBLE:C603(*;"resalte@";False:C215)
		
	: (Form event:C388=On Drop:K2:12)
		TMT_ManejaArrastrarSoltar 
		
		
End case 