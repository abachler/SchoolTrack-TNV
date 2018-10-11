AL_UpdateArrays (xALP_EducAntSTR;0)

CREATE RECORD:C68([STR_EducacionAnterior:87])
$l_id:=SQ_SeqNumber (->[STR_EducacionAnterior:87]ID_EducacionAnterior:9)
[STR_EducacionAnterior:87]ID_EducacionAnterior:9:=$l_id
[STR_EducacionAnterior:87]Tipo_Persona:8:="pe"
[STR_EducacionAnterior:87]ID_Persona:6:=[Personas:7]No:1
[STR_EducacionAnterior:87]País:2:=<>gPais
SAVE RECORD:C53([STR_EducacionAnterior:87])

READ WRITE:C146([STR_EducacionAnterior:87])
QUERY:C277([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]ID_Persona:6=[Personas:7]No:1)
ORDER BY:C49([STR_EducacionAnterior:87];[STR_EducacionAnterior:87]Año:4;<;[STR_EducacionAnterior:87]Tipo_Institucion:10;>)

AL_ExitCell (xALP_EducAntSTR)
AT_Insert (1;1;->atTipoInstitucion;->atInstitucion;->atPaisEducacion;->atGradoONivel;->aiAno;->IDEducacionAnterior)
IDEducacionAnterior{1}:=$l_id
atPaisEducacion{1}:=<>gPais
AL_UpdateArrays (xALP_EducAntSTR;-2)
GOTO OBJECT:C206(xALP_EducAntSTR)
AL_GotoCell (xALP_EducAntSTR;1;1)
AL_SetLine (xALP_EducAntSTR;0)

