//%attributes = {}
  //TMT_Initialize

ARRAY TEXT:C222(atSTK_Subsectores_shortName;0)
ARRAY TEXT:C222(atSTK_Subsectores_longName;0)
ARRAY TEXT:C222(atSTK_Subsectores_TeacherName;0)
ARRAY LONGINT:C221(alSTK_IDSubsectores;0)


ARRAY INTEGER:C220(aiSTK_Hora;0)
ARRAY TEXT:C222(atSTK_HoraAlias;0)  //MONO Ticket 144924
ARRAY LONGINT:C221(alSTK_Desde;0)
ARRAY LONGINT:C221(alSTK_Hasta;0)
ARRAY TEXT:C222(atSTK_Day1;0)
ARRAY TEXT:C222(atSTK_Day2;0)
ARRAY TEXT:C222(atSTK_Day3;0)
ARRAY TEXT:C222(atSTK_Day4;0)
ARRAY TEXT:C222(atSTK_Day5;0)
ARRAY TEXT:C222(atSTK_Day6;0)
ARRAY TEXT:C222(atSTK_Day7;0)
ARRAY TEXT:C222(atSTK_Day8;0)  //para ciclos horarios de 8 días
ARRAY LONGINT:C221(alSTK_Day1;0)
ARRAY LONGINT:C221(alSTK_Day2;0)
ARRAY LONGINT:C221(alSTK_Day3;0)
ARRAY LONGINT:C221(alSTK_Day4;0)
ARRAY LONGINT:C221(alSTK_Day5;0)
ARRAY LONGINT:C221(alSTK_Day6;0)
ARRAY LONGINT:C221(alSTK_Day7;0)
ARRAY LONGINT:C221(alSTK_Day8;0)  //para ciclos horarios de 8 días

COPY ARRAY:C226(aiSTR_Horario_HoraNo;aiSTK_Hora)
COPY ARRAY:C226(alSTR_Horario_Desde;alSTK_Desde)
COPY ARRAY:C226(alSTR_Horario_hasta;alSTK_Hasta)
$s:=Size of array:C274(aiSTK_Hora)
ARRAY TEXT:C222(atSTK_Day1;$S)
ARRAY TEXT:C222(atSTK_Day2;$S)
ARRAY TEXT:C222(atSTK_Day3;$S)
ARRAY TEXT:C222(atSTK_Day4;$S)
ARRAY TEXT:C222(atSTK_Day5;$S)
ARRAY TEXT:C222(atSTK_Day6;$S)
ARRAY TEXT:C222(atSTK_Day7;$S)
ARRAY TEXT:C222(atSTK_Day8;$S)  //para ciclos horarios de 8 días
ARRAY LONGINT:C221(alSTK_Day1;$S)
ARRAY LONGINT:C221(alSTK_Day2;$S)
ARRAY LONGINT:C221(alSTK_Day3;$S)
ARRAY LONGINT:C221(alSTK_Day4;$S)
ARRAY LONGINT:C221(alSTK_Day5;$S)
ARRAY LONGINT:C221(alSTK_Day6;$S)
ARRAY LONGINT:C221(alSTK_Day7;$S)
ARRAY LONGINT:C221(alSTK_Day8;$S)  //para ciclos horarios de 8 días

ARRAY BOOLEAN:C223(abSTK_ActivoDay1;$S)
ARRAY BOOLEAN:C223(abSTK_ActivoDay2;$S)
ARRAY BOOLEAN:C223(abSTK_ActivoDay3;$S)
ARRAY BOOLEAN:C223(abSTK_ActivoDay4;$S)
ARRAY BOOLEAN:C223(abSTK_ActivoDay5;$S)
ARRAY BOOLEAN:C223(abSTK_ActivoDay6;$S)
ARRAY BOOLEAN:C223(abSTK_ActivoDay7;$S)
ARRAY BOOLEAN:C223(abSTK_ActivoDay8;$S)

vi_gLong1:=-1
AT_Populate (->alSTK_Day1;->vi_gLong1)
AT_Populate (->alSTK_Day2;->vi_gLong1)
AT_Populate (->alSTK_Day3;->vi_gLong1)
AT_Populate (->alSTK_Day4;->vi_gLong1)
AT_Populate (->alSTK_Day5;->vi_gLong1)
AT_Populate (->alSTK_Day6;->vi_gLong1)
AT_Populate (->alSTK_Day7;->vi_gLong1)
