  // SeleccionValor.seleccionar()
  // Por: Alberto Bachler K.: 12-02-15, 12:40:36
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------



USE SET:C118("$seleccionCampo")
vt_textoBuscado:=vy_campoSeleccion->
$l_largoTextoEditado:=(OBJECT Get pointer:C1124(Object named:K67:5;"largoTextoEditado"))->
HIGHLIGHT TEXT:C210(vt_textoBuscado;$l_largoTextoEditado;32000)


