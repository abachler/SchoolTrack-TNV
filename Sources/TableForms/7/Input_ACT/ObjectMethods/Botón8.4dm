[Personas:7]ACT_Apellido_Materno_Cta:75:=[Personas:7]Apellido_materno:4
[Personas:7]ACT_Apellido_Paterno_Cta:74:=[Personas:7]Apellido_paterno:3
[Personas:7]ACT_Nombres_Cta:76:=[Personas:7]Nombres:2
[Personas:7]ACT_Titular_Cta:49:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
[Personas:7]ACT_RUTTitutal_Cta:50:=[Personas:7]RUT:6