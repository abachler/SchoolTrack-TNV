//%attributes = {}
  //ACTcar_EsCargoEspecial

C_LONGINT:C283($vl_idCargo;$1)
C_BOOLEAN:C305($0)

$vl_idCargo:=$1

ARRAY LONGINT:C221($alACT_idsCargosEspeciales;0)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-1)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-10)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-101)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-102)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-103)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-127)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-128)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-129)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-130)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-131)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-132)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-133)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-134)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-135)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-136)
APPEND TO ARRAY:C911($alACT_idsCargosEspeciales;-137)

$0:=(Find in array:C230($alACT_idsCargosEspeciales;$vl_idCargo)>0)