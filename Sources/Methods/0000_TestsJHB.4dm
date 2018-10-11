//%attributes = {}
C_POINTER:C301($ptr)

ARRAY TEXT:C222($personas;0)
ARRAY LONGINT:C221($rnPersonas;0)
ARRAY TEXT:C222($alumnos;0)
ARRAY TEXT:C222($profes;0)
ARRAY TEXT:C222($familias;0)

READ ONLY:C145([Personas:7])
$id:=17724
$rn:=Find in field:C653([Personas:7]No:1;$id)
APPEND TO ARRAY:C911($rnPersonas;$rn)

CONDOR_Export_Personas (->$personas;->$profes;->$alumnos;->$familias;->$rnPersonas)

CONDOR_Export_Familias (->$familias)