//%attributes = {}
  //MPA_EtapasPorDefecto

  //ARRAY TEXT(atMPA_EtapasArea;9)
  //ARRAY LONGINT(alMPA_NivelDesde;9)
  //ARRAY LONGINT(alMPA_NivelHasta;9)

  //AT_Inc (0)
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Parvularia"
  //alMPA_NivelDesde{$index}:=-6
  //alMPA_NivelHasta{$index}:=-4
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Pre-escolar"
  //alMPA_NivelDesde{$index}:=-3
  //alMPA_NivelHasta{$index}:=-1
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Nivel Básico 1"
  //alMPA_NivelDesde{$index}:=1
  //alMPA_NivelHasta{$index}:=2
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Nivel Básico 2"
  //alMPA_NivelDesde{$index}:=3
  //alMPA_NivelHasta{$index}:=4
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Nivel Básico 5"
  //alMPA_NivelDesde{$index}:=7
  //alMPA_NivelHasta{$index}:=8
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Nivel Medio 1"
  //alMPA_NivelDesde{$index}:=9
  //alMPA_NivelHasta{$index}:=9
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Nivel Medio 2"
  //alMPA_NivelDesde{$index}:=10
  //alMPA_NivelHasta{$index}:=10
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Nivel Medio 3"
  //alMPA_NivelDesde{$index}:=11
  //alMPA_NivelHasta{$index}:=11
  //$index:=AT_Inc 
  //atMPA_EtapasArea{$index}:="Nivel Medio 4"
  //alMPA_NivelDesde{$index}:=12
  //alMPA_NivelHasta{$index}:=12

ARRAY TEXT:C222(atMPA_EtapasArea;0)
ARRAY LONGINT:C221(alMPA_NivelDesde;0)
ARRAY LONGINT:C221(alMPA_NivelHasta;0)

  //QUERY([xxSTR_Niveles];[xxSTR_Niveles]EsNivelSistema=False)
QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)

  //ARRAY TEXT(atMPA_EtapasArea;Records in selection([xxSTR_Niveles]))
  //ARRAY LONGINT(alMPA_NivelDesde;Records in selection([xxSTR_Niveles]))
  //ARRAY LONGINT(alMPA_NivelHasta;Records in selection([xxSTR_Niveles]))
  //SELECTION TO ARRAY([xxSTR_Niveles]Nivel;atMPA_EtapasArea;[xxSTR_Niveles]NoNivel;alMPA_NivelDesde;[xxSTR_Niveles]NoNivel;alMPA_NivelHasta)

While (Not:C34(End selection:C36([xxSTR_Niveles:6])))
	AT_Insert (0;1;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	atMPA_EtapasArea{Size of array:C274(atMPA_EtapasArea)}:=[xxSTR_Niveles:6]Nivel:1
	alMPA_NivelDesde{Size of array:C274(alMPA_NivelDesde)}:=[xxSTR_Niveles:6]NoNivel:5
	alMPA_NivelHasta{Size of array:C274(alMPA_NivelHasta)}:=[xxSTR_Niveles:6]NoNivel:5
	NEXT RECORD:C51([xxSTR_Niveles:6])
End while 

