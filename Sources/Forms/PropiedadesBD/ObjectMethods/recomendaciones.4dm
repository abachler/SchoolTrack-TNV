  // PropiedadesBD.recomendaciones()
  // Por: Alberto Bachler K.: 24-09-15, 14:20:25
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$y_propiedadesModificadas:=OBJECT Get pointer:C1124(Object named:K67:5;"propiedadesModificadas")

(OBJECT Get pointer:C1124(Object named:K67:5;"memReserved"))->:=Num:C11(OBJECT Get title:C1068(*;"memReserved_R"))
(OBJECT Get pointer:C1124(Object named:K67:5;"memPercentCache"))->:=Num:C11(OBJECT Get title:C1068(*;"memPercentCache_R"))
(OBJECT Get pointer:C1124(Object named:K67:5;"memMinimum"))->:=Num:C11(OBJECT Get title:C1068(*;"memMinimumCache_R"))
(OBJECT Get pointer:C1124(Object named:K67:5;"memMaximum"))->:=Num:C11(OBJECT Get title:C1068(*;"memMaximumCache_R"))
(OBJECT Get pointer:C1124(Object named:K67:5;"memFlushDelay"))->:=Num:C11(OBJECT Get title:C1068(*;"memFlushDelay_R"))

OBJECT SET ENABLED:C1123(*;"btnGuardar";True:C214)
$y_propiedadesModificadas->:=1