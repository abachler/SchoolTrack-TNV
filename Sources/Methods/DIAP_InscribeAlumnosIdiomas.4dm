//%attributes = {}

C_LONGINT:C283($vl_records;$id_alu;$1)

$id_alu:=$1

READ ONLY:C145([DIAP_AlumnosIdiomas:218])
SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
QUERY:C277([DIAP_AlumnosIdiomas:218];[DIAP_AlumnosIdiomas:218]ID_alumno:2=$id_alu;*)
QUERY:C277([DIAP_AlumnosIdiomas:218]; & ;[DIAP_AlumnosIdiomas:218]Año:9=<>gyear)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

READ WRITE:C146([DIAP_AlumnosIdiomas:218])
CREATE RECORD:C68([DIAP_AlumnosIdiomas:218])
[DIAP_AlumnosIdiomas:218]ID_alumno:2:=$id_alu
[DIAP_AlumnosIdiomas:218]Año:9:=<>gyear
[DIAP_AlumnosIdiomas:218]NumeroNivel_Desde:6:=1
[DIAP_AlumnosIdiomas:218]NumeroNivel_Hasta:7:=12
[DIAP_AlumnosIdiomas:218]Orden:8:=$vl_records+1
SAVE RECORD:C53([DIAP_AlumnosIdiomas:218])
KRL_UnloadReadOnly (->[DIAP_AlumnosIdiomas:218])

