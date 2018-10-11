//%attributes = {}
  //ACTinit_CreateInstitutionPrefs

  //Preferencias Institución
READ WRITE:C146([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
[Colegio:31]RazonSocial:38:=<>gCustom
[Colegio:31]RepresentanteLegal_Nombre:39:=[Colegio:31]Director_NombreCompleto:13
[Colegio:31]RepresentanteLegal_RUN:40:=[Colegio:31]Director_RUN:28
[Colegio:31]Administracion_Direccion:41:=[Colegio:31]Dirección:3
[Colegio:31]Administracion_Comuna:42:=[Colegio:31]Comuna:4
[Colegio:31]Administracion_Ciudad:43:=[Colegio:31]Ciudad:6
[Colegio:31]Administracion_CPostal:44:=[Colegio:31]CodigoPostal:24
[Colegio:31]Administracion_Telefono:45:=[Colegio:31]Telefono1:7
[Colegio:31]Administracion_Fax:46:=[Colegio:31]Fax:8
[Colegio:31]Administracion_EMail:47:=[Colegio:31]eMail:25
[Colegio:31]Moneda:49:=ACT_DivisaPais 
SAVE RECORD:C53([Colegio:31])
<>vsACT_Direccion:=[Colegio:31]Administracion_Direccion:41
<>vsACT_Comuna:=[Colegio:31]Administracion_Comuna:42
<>vsACT_Ciudad:=[Colegio:31]Administracion_Ciudad:43
<>vsACT_CPostal:=[Colegio:31]Administracion_CPostal:44
<>vsACT_Telefono:=[Colegio:31]Administracion_Telefono:45
<>vsACT_Fax:=[Colegio:31]Administracion_Fax:46
<>vsACT_Email:=[Colegio:31]Administracion_EMail:47
<>vsACT_RepLegal:=[Colegio:31]RepresentanteLegal_Nombre:39
<>vsACT_RUTRepLegal:=[Colegio:31]RepresentanteLegal_RUN:40
<>vsACT_RazonSocial:=[Colegio:31]RazonSocial:38
<>vsACT_RUT:=[Colegio:31]RUT:2
UNLOAD RECORD:C212([Colegio:31])
READ ONLY:C145([Colegio:31])