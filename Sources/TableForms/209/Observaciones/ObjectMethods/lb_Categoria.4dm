  // [Alumnos_ObservacionesEvaluacion].Observaciones.lb_Categoria()
  //
  //
  // creado por: Alberto Bachler Klein: 18-12-15, 12:23:00
  // -----------------------------------------------------------
C_LONGINT:C283($i)
C_POINTER:C301($y_listaCategorias;$y_Objeto;$y_objetoCategoria;$y_observaciones)
C_TEXT:C284($t_observacion)

ARRAY OBJECT:C1221($ao_Observaciones;0)

$y_Objeto:=OBJECT Get pointer:C1124(Object named:K67:5;"objetoObservaciones")
$y_listaCategorias:=OBJECT Get pointer:C1124(Object named:K67:5;"listaCategorias")
$y_objetoCategoria:=OBJECT Get pointer:C1124(Object named:K67:5;"objetoCategoria")
$y_observaciones:=OBJECT Get pointer:C1124(Object named:K67:5;"observacion")

AT_Initialize ($y_observaciones)
Case of 
	: (Form event:C388=On Selection Change:K2:29)
		OB_GET ($y_objetoCategoria->{$y_objetoCategoria->};->$ao_Observaciones;"children")
		For ($i;1;Size of array:C274($ao_Observaciones))
			OB_GET ($ao_Observaciones{$i};->$t_observacion;"title")
			APPEND TO ARRAY:C911($y_observaciones->;$t_observacion)
		End for 
End case 


