  // [xxSTR_Constants].SR_BuscaScript.lb_metodos1()
  // Por: Alberto Bachler K.: 18-08-15, 19:40:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

  //$y_script:=OBJECT Get pointer(Object named;"script")
$y_scriptsObjetos:=OBJECT Get pointer:C1124(Object named:K67:5;"scriptObjeto")

  //$y_script->:=$y_scriptsObjetos->{$y_scriptsObjetos->}

$t_codigoHTML:=CODE_Get_html ($y_scriptsObjetos->{$y_scriptsObjetos->})

EXE_StyleCodeText (->$t_codigoHTML)
WA SET PAGE CONTENT:C1037(*;"scriptHTML";$t_codigoHTML;"")

