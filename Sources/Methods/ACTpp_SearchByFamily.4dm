//%attributes = {}
  //ACTpp_SearchByFamily

READ ONLY:C145([Familia_RelacionesFamiliares:77])
READ ONLY:C145([Personas:7])
$set:="$RecordSet_Table"+String:C10(Table:C252(->[Personas:7]))

USE SET:C118($set)
CREATE SET:C116([Personas:7];"Selection")
KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1)
KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3)