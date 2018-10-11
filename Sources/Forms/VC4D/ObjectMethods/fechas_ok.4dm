  // VC4D_Config.in_ok()
  //
  //
  // creado por: Alberto Bachler Klein: 05-02-16, 18:26:32
  // -----------------------------------------------------------

$y_Universo:=OBJECT Get pointer:C1124(Object named:K67:5;"universo")

OBJECT SET VISIBLE:C603(*;"fechas@";False:C215)
OBJECT SET VISIBLE:C603(*;"universo";True:C214)

  //$t_opcion:=OBJECT Get title(*;"fechasTitulo")
  //$l_elemento:=Find in array($y_Universo->;$t_opcion)
  //If ($l_elemento>0)
  //$y_Universo->:=$l_elemento
  //End if 
POST KEY:C465(F5 key:K12:5)

OBJECT SET VISIBLE:C603(*;"fechas@";False:C215)