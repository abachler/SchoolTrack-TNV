//%attributes = {}
  //INstk_CreaMatrizVacunacion


  //ARRAY LONGINT(<>alSTK_MesesVacunacion;18)
  //ARRAY TEXT(<>atSTK_Vacunas;18)
  //ARRAY TEXT(<>atSTK_Edades;18)
  //
  //<>alSTK_MesesVacunacion{1}:=0
  //<>alSTK_MesesVacunacion{2}:=2
  //<>alSTK_MesesVacunacion{3}:=2
  //<>alSTK_MesesVacunacion{4}:=2
  //<>alSTK_MesesVacunacion{5}:=4
  //<>alSTK_MesesVacunacion{6}:=4
  //<>alSTK_MesesVacunacion{7}:=4
  //<>alSTK_MesesVacunacion{8}:=6
  //<>alSTK_MesesVacunacion{9}:=6
  //<>alSTK_MesesVacunacion{10}:=6
  //<>alSTK_MesesVacunacion{11}:=12
  //<>alSTK_MesesVacunacion{12}:=18
  //<>alSTK_MesesVacunacion{13}:=18
  //<>alSTK_MesesVacunacion{14}:=48
  //<>alSTK_MesesVacunacion{15}:=48
  //<>alSTK_MesesVacunacion{16}:=72
  //<>alSTK_MesesVacunacion{17}:=72
  //<>alSTK_MesesVacunacion{18}:=84
  //
  //<>atSTK_Vacunas{1}:="BCG"
  //<>atSTK_Vacunas{2}:="DPT"
  //<>atSTK_Vacunas{3}:="Polio"
  //<>atSTK_Vacunas{4}:="Haemophilus Influenzae B"
  //<>atSTK_Vacunas{5}:="DPT"
  //<>atSTK_Vacunas{6}:="Polio"
  //<>atSTK_Vacunas{7}:="Haemophilus Influenzae B"
  //<>atSTK_Vacunas{8}:="DPT"
  //<>atSTK_Vacunas{9}:="Polio"
  //<>atSTK_Vacunas{10}:="Haemophilus Influenzae B"
  //<>atSTK_Vacunas{11}:="Tresvírica"
  //<>atSTK_Vacunas{12}:="DPT"
  //<>atSTK_Vacunas{13}:="Polio"
  //<>atSTK_Vacunas{14}:="DPT"
  //<>atSTK_Vacunas{15}:="Polio"
  //<>atSTK_Vacunas{16}:="BCG"
  //<>atSTK_Vacunas{17}:="Tresvírica"
  //<>atSTK_Vacunas{18}:="Toxoide DT"
  //
  //For ($i;1;Size of array(<>atSTK_Edades))
  //<>atSTK_Edades{$i}:=DT_Months2AgeLongString (<>alSTK_MesesVacunacion{$i})
  //End for 
  //
  //se cambia debido al nuevo calendario de vacunación 2016
  //JVP 20160706 tikcet 161006

ARRAY LONGINT:C221(<>alSTK_MesesVacunacion;21)
ARRAY TEXT:C222(<>atSTK_Vacunas;21)
ARRAY TEXT:C222(<>atSTK_Edades;21)

<>alSTK_MesesVacunacion{1}:=0
<>alSTK_MesesVacunacion{2}:=2
<>alSTK_MesesVacunacion{3}:=2
<>alSTK_MesesVacunacion{4}:=2
<>alSTK_MesesVacunacion{5}:=4
<>alSTK_MesesVacunacion{6}:=4
<>alSTK_MesesVacunacion{7}:=4
<>alSTK_MesesVacunacion{8}:=6
<>alSTK_MesesVacunacion{9}:=6
<>alSTK_MesesVacunacion{10}:=6
<>alSTK_MesesVacunacion{11}:=12
<>alSTK_MesesVacunacion{12}:=12
<>alSTK_MesesVacunacion{13}:=12
<>alSTK_MesesVacunacion{14}:=18
<>alSTK_MesesVacunacion{15}:=18
<>alSTK_MesesVacunacion{16}:=18
<>alSTK_MesesVacunacion{17}:=72
<>alSTK_MesesVacunacion{18}:=72
<>alSTK_MesesVacunacion{19}:=108
<>alSTK_MesesVacunacion{20}:=120
<>alSTK_MesesVacunacion{21}:=156

<>atSTK_Vacunas{1}:="BCG"  //0
<>atSTK_Vacunas{2}:="Pentavalente"  //2
<>atSTK_Vacunas{3}:="Polio"  //2
<>atSTK_Vacunas{4}:="Neumocócica conjugada"  //2
<>atSTK_Vacunas{5}:="Pentavalente"  //4
<>atSTK_Vacunas{6}:="Polio"  //4
<>atSTK_Vacunas{7}:="Neumocócica conjugada"  //4
<>atSTK_Vacunas{8}:="Pentavalente"  //6
<>atSTK_Vacunas{9}:="Polio"  //6
<>atSTK_Vacunas{10}:="Neumocócica conjugada"  //6
<>atSTK_Vacunas{11}:="Tres vírica"  //12
<>atSTK_Vacunas{12}:="Meningocócica conjugada"  //12
<>atSTK_Vacunas{13}:="Neumocócica conjugada"  //12
<>atSTK_Vacunas{14}:="Pentavalente"  //18
<>atSTK_Vacunas{15}:="Polio"  //18
<>atSTK_Vacunas{16}:="Hepatitis A"  //18
<>atSTK_Vacunas{17}:="Tres vírica"  //72 1er basico
<>atSTK_Vacunas{18}:="dTp"  //72 1ro basico
<>atSTK_Vacunas{19}:="VPH"  //108
<>atSTK_Vacunas{20}:="VPH"  //120
<>atSTK_Vacunas{21}:="dTp"  //156



For ($i;1;Size of array:C274(<>atSTK_Edades))
	<>atSTK_Edades{$i}:=DT_Months2AgeLongString (<>alSTK_MesesVacunacion{$i})
End for 