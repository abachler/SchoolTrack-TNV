//%attributes = {}
  //ACTpgs_LoadIdentificadoresNac

LOC_LoadIdenNacionales 
ARRAY TEXT:C222(at_IDNacional_NamesApdos;0)
COPY ARRAY:C226(<>at_IDNacional_Names;at_IDNacional_NamesApdos)
AT_Insert (1;2;->at_IDNacional_NamesApdos)
at_IDNacional_NamesApdos{1}:="Todos"
at_IDNacional_NamesApdos{2}:="(-"
  //AT_Insert (0;3;->at_IDNacional_NamesApdos)
AT_Insert (0;4;->at_IDNacional_NamesApdos)
at_IDNacional_NamesApdos{Size of array:C274(at_IDNacional_NamesApdos)-3}:="(-"
at_IDNacional_NamesApdos{Size of array:C274(at_IDNacional_NamesApdos)-2}:="N° Pasaporte"
at_IDNacional_NamesApdos{Size of array:C274(at_IDNacional_NamesApdos)-1}:="Código Interno"
at_IDNacional_NamesApdos{Size of array:C274(at_IDNacional_NamesApdos)}:="Código de Familia"
vlACT_IdentificadorApdo:=1
vs_Identificador:="Todos"
ARRAY POINTER:C280(aPtrsApdos;0)
ARRAY POINTER:C280(aPtrsApdos;Size of array:C274(at_IDNacional_NamesApdos))
aPtrsApdos{3}:=->[Personas:7]RUT:6
aPtrsApdos{4}:=->[Personas:7]IDNacional_2:37
aPtrsApdos{5}:=->[Personas:7]IDNacional_3:38
aPtrsApdos{7}:=->[Personas:7]Pasaporte:59
aPtrsApdos{8}:=->[Personas:7]Codigo_interno:22
aPtrsApdos{9}:=->[Familia:78]Codigo_interno:14


ARRAY TEXT:C222(at_IDNacional_NamesCtas;0)
COPY ARRAY:C226(<>at_IDNacional_Names;at_IDNacional_NamesCtas)
AT_Insert (1;2;->at_IDNacional_NamesCtas)
at_IDNacional_NamesCtas{1}:="Todos"
at_IDNacional_NamesCtas{2}:="(-"
AT_Insert (0;3;->at_IDNacional_NamesCtas)
  //AT_Insert (0;4;->at_IDNacional_NamesCtas)
at_IDNacional_NamesCtas{Size of array:C274(at_IDNacional_NamesCtas)-2}:="(-"
at_IDNacional_NamesCtas{Size of array:C274(at_IDNacional_NamesCtas)-1}:="N° Pasaporte"
at_IDNacional_NamesCtas{Size of array:C274(at_IDNacional_NamesCtas)}:="Código Cuenta"
  //at_IDNacional_NamesCtas{Size of array(at_IDNacional_NamesCtas)}:="Código de Familia"
vlACT_IdentificadorCta:=1
vs_IdentificadorCta:="Todos"
ARRAY POINTER:C280(aPtrsCtas;0)
ARRAY POINTER:C280(aPtrsCtas;Size of array:C274(at_IDNacional_NamesCtas))
aPtrsCtas{3}:=->[Alumnos:2]RUT:5
aPtrsCtas{4}:=->[Alumnos:2]IDNacional_2:71
aPtrsCtas{5}:=->[Alumnos:2]IDNacional_3:70
aPtrsCtas{7}:=->[Alumnos:2]NoPasaporte:87
aPtrsCtas{8}:=->[ACT_CuentasCorrientes:175]Codigo:19
  //aPtrsCtas{9}:=->[Familia]Codigo_interno


ARRAY TEXT:C222(at_IDNacional_NamesTerceros;0)
COPY ARRAY:C226(<>at_IDNacional_Names;at_IDNacional_NamesTerceros)
AT_Insert (1;2;->at_IDNacional_NamesTerceros)
at_IDNacional_NamesTerceros{1}:="Todos"
at_IDNacional_NamesTerceros{2}:="(-"
AT_Insert (0;3;->at_IDNacional_NamesTerceros)
at_IDNacional_NamesTerceros{Size of array:C274(at_IDNacional_NamesTerceros)-2}:="(-"
at_IDNacional_NamesTerceros{Size of array:C274(at_IDNacional_NamesTerceros)-1}:="N° Pasaporte"
at_IDNacional_NamesTerceros{Size of array:C274(at_IDNacional_NamesTerceros)}:="Código interno"
vlACT_IdentificadorTer:=1
vs_IdentificadorTer:="Todos"
ARRAY POINTER:C280(aPtrsTerceros;0)
ARRAY POINTER:C280(aPtrsTerceros;Size of array:C274(at_IDNacional_NamesTerceros))
aPtrsTerceros{3}:=->[ACT_Terceros:138]RUT:4
aPtrsTerceros{4}:=->[ACT_Terceros:138]Identificador_Nacional2:20
aPtrsTerceros{5}:=->[ACT_Terceros:138]Identificador_Nacional3:21
aPtrsTerceros{7}:=->[ACT_Terceros:138]Pasaporte:25
aPtrsTerceros{8}:=->[ACT_Terceros:138]Codigo_Interno:29