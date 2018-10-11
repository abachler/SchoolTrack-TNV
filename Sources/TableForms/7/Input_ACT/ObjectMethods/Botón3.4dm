[Personas:7]ACT_Apellido_Materno_TC:72:=[Personas:7]Apellido_materno:4
[Personas:7]ACT_Apellido_Paterno_TC:71:=[Personas:7]Apellido_paterno:3
[Personas:7]ACT_Nombres_TC:73:=[Personas:7]Nombres:2
[Personas:7]ACT_Titular_TC:55:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
[Personas:7]ACT_RUTTitular_TC:56:=[Personas:7]RUT:6