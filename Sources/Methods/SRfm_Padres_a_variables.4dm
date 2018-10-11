//%attributes = {}
  //SRfm_Padres_a_variables

C_BOOLEAN:C305(vPadre_Es_ExAlumno)
C_DATE:C307(vPadre_Fecha_de_Modificacion;vPadre_Fecha_de_nacimiento;vPadre_Fecha_de_Creación)
C_REAL:C285(vPadre_No)
C_TEXT:C284(vPadre_Región_o_Estado;vPadre_Apellidos_y_nombres;vPadre_Observaciones;vPadre_Direccion;vPadre_Nombres;vPadre_eMail;vPadre_Codigo;vPadre_Fax;vPadre_RUT;vPadre_Direccion_Profesional;vPadre_Nacionalidad;vPadre_Telefono_domicilio;vPadre_Celular;vPadre_Profesión;vPadre_Sexo;vPadre_Cargo;vPadre_Apellido_materno;vPadre_Apellido_paterno;vPadre_Modificado_por;vPadre_Ciudad;vPadre_Estado_civil;vPadre_Código_postal;vPadre_Comuna;vPadre_Religión;vPadre_Empresa;vPadre_Fax_empresa;vPadre_Nivel_de_estudios;vPadre_Telefono_profesional)
C_BOOLEAN:C305(vMadre_Es_ExAlumno)
C_DATE:C307(vMadre_Fecha_de_Modificacion;vMadre_Fecha_de_nacimiento;vMadre_Fecha_de_Creación)
C_REAL:C285(vMadre_No)
C_TEXT:C284(vMadre_Región_o_Estado;vMadre_Apellidos_y_nombres;vMadre_Observaciones;vMadre_Direccion;vMadre_Nombres;vMadre_eMail;vMadre_Codigo;vMadre_Fax;vMadre_RUT;vMadre_Direccion_Profesional;vMadre_Nacionalidad;vMadre_Telefono_domicilio;vMadre_Celular;vMadre_Profesión;vMadre_Sexo;vMadre_Cargo;vMadre_Apellido_materno;vMadre_Apellido_paterno;vMadre_Modificado_por;vMadre_Ciudad;vMadre_Estado_civil;vMadre_Código_postal;vMadre_Comuna;vMadre_Religión;vMadre_Empresa;vMadre_Fax_empresa;vMadre_Nivel_de_estudios;vMadre_Telefono_profesional)

  //$familyID:=$1

QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
vMadre_Región_o_Estado:=[Personas:7]Region_o_Estado:18
vMadre_No:=[Personas:7]No:1
vMadre_Apellidos_y_nombres:=[Personas:7]Apellidos_y_nombres:30
vMadre_Fecha_de_Modificacion:=[Personas:7]Fecha_de_Modificacion:27
vMadre_Observaciones:=[Personas:7]Observaciones:32
vMadre_Direccion:=[Personas:7]Direccion:14
vMadre_Nombres:=[Personas:7]Nombres:2
vMadre_eMail:=[Personas:7]eMail:34
vMadre_Es_ExAlumno:=[Personas:7]Es_ExAlumno:12
vMadre_Codigo:=[Personas:7]Codigo_interno:22
vMadre_Codigo_Interno:=[Personas:7]Codigo_interno:22
vMadre_Fax:=[Personas:7]Fax:35
If (Num:C11([Personas:7]RUT:6)#0)
	vMadre_RUT:=SR_FormatoRUT2 ([Personas:7]RUT:6)  //20171005 RCH
Else 
	vMadre_RUT:=""
End if 
vMadre_Fecha_de_nacimiento:=[Personas:7]Fecha_de_nacimiento:5
vMadre_Direccion_Profesional:=[Personas:7]Direccion_Profesional:23
vMadre_Nacionalidad:=[Personas:7]Nacionalidad:7
vMadre_Telefono_domicilio:=[Personas:7]Telefono_domicilio:19
vMadre_Celular:=[Personas:7]Celular:24
vMadre_Profesión:=[Personas:7]Profesion:13
vMadre_Sexo:=[Personas:7]Sexo:8
vMadre_Cargo:=[Personas:7]Cargo:21
vMadre_Apellido_materno:=[Personas:7]Apellido_materno:4
vMadre_Apellido_paterno:=[Personas:7]Apellido_paterno:3
vMadre_Modificado_por:=[Personas:7]Modificado_por:28
vMadre_Ciudad:=[Personas:7]Ciudad:17
vMadre_Estado_civil:=[Personas:7]Estado_civil:10
vMadre_Fecha_de_Creación:=[Personas:7]Fecha_de_Creacion:26
vMadre_Código_postal:=[Personas:7]Codigo_postal:15
vMadre_Comuna:=[Personas:7]Comuna:16
vMadre_Religión:=[Personas:7]Religión:9
vMadre_Empresa:=[Personas:7]Empresa:20
vMadre_Fax_empresa:=[Personas:7]Fax_empresa:25
vMadre_Nivel_de_estudios:=[Personas:7]Nivel_de_estudios:11
vMadre_Telefono_profesional:=[Personas:7]Telefono_profesional:29


QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
vPadre_Región_o_Estado:=[Personas:7]Region_o_Estado:18
vPadre_No:=[Personas:7]No:1
vPadre_Apellidos_y_nombres:=[Personas:7]Apellidos_y_nombres:30
vPadre_Fecha_de_Modificacion:=[Personas:7]Fecha_de_Modificacion:27
vPadre_Observaciones:=[Personas:7]Observaciones:32
vPadre_Direccion:=[Personas:7]Direccion:14
vPadre_Nombres:=[Personas:7]Nombres:2
vPadre_eMail:=[Personas:7]eMail:34
vPadre_Es_ExAlumno:=[Personas:7]Es_ExAlumno:12
vPadre_Codigo:=[Personas:7]Codigo_interno:22
vPadre_Codigo_Interno:=[Personas:7]Codigo_interno:22
vPadre_Fax:=[Personas:7]Fax:35
If (Num:C11([Personas:7]RUT:6)#0)
	vPadre_RUT:=SR_FormatoRUT2 ([Personas:7]RUT:6)  //20171005 RCH
Else 
	vPadre_RUT:=""
End if 
vPadre_Fecha_de_nacimiento:=[Personas:7]Fecha_de_nacimiento:5
vPadre_Direccion_Profesional:=[Personas:7]Direccion_Profesional:23
vPadre_Nacionalidad:=[Personas:7]Nacionalidad:7
vPadre_Telefono_domicilio:=[Personas:7]Telefono_domicilio:19
vPadre_Celular:=[Personas:7]Celular:24
vPadre_Profesión:=[Personas:7]Profesion:13
vPadre_Sexo:=[Personas:7]Sexo:8
vPadre_Cargo:=[Personas:7]Cargo:21
vPadre_Apellido_materno:=[Personas:7]Apellido_materno:4
vPadre_Apellido_paterno:=[Personas:7]Apellido_paterno:3
vPadre_Modificado_por:=[Personas:7]Modificado_por:28
vPadre_Ciudad:=[Personas:7]Ciudad:17
vPadre_Estado_civil:=[Personas:7]Estado_civil:10
vPadre_Fecha_de_Creación:=[Personas:7]Fecha_de_Creacion:26
vPadre_Código_postal:=[Personas:7]Codigo_postal:15
vPadre_Comuna:=[Personas:7]Comuna:16
vPadre_Religión:=[Personas:7]Religión:9
vPadre_Empresa:=[Personas:7]Empresa:20
vPadre_Fax_empresa:=[Personas:7]Fax_empresa:25
vPadre_Nivel_de_estudios:=[Personas:7]Nivel_de_estudios:11
vPadre_Telefono_profesional:=[Personas:7]Telefono_profesional:29

