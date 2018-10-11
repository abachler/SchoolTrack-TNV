//%attributes = {}
  //AS_Estadisticas


C_LONGINT:C283($i)
C_POINTER:C301($1)
ARRAY TEXT:C222(<>aStatItems;8)

ARRAY REAL:C219(<>aStat1;0)
ARRAY REAL:C219(<>aStat2;0)
ARRAY REAL:C219(<>aStat3;0)
ARRAY REAL:C219(<>aStat4;0)
ARRAY REAL:C219(<>aStat5;0)
ARRAY REAL:C219(<>aStat6;0)
ARRAY REAL:C219(<>aStat7;0)
ARRAY REAL:C219(<>aStat8;0)
ARRAY REAL:C219(<>aStat9;0)
ARRAY REAL:C219(<>aStat10;0)
ARRAY REAL:C219(<>aStat11;0)
ARRAY REAL:C219(<>aStat12;0)
ARRAY REAL:C219(<>aStatEP;0)
ARRAY REAL:C219(<>aStatP1;0)
ARRAY REAL:C219(<>aStatP2;0)
ARRAY REAL:C219(<>aStatP3;0)
ARRAY REAL:C219(<>aStatP4;0)
ARRAY REAL:C219(<>aStatP5;0)
ARRAY REAL:C219(<>aStatPF;0)
ARRAY REAL:C219(<>aStatEX;0)
ARRAY REAL:C219(<>aStatNF;0)
ARRAY REAL:C219(<>aStat1;8)
ARRAY REAL:C219(<>aStat2;8)
ARRAY REAL:C219(<>aStat3;8)
ARRAY REAL:C219(<>aStat4;8)
ARRAY REAL:C219(<>aStat5;8)
ARRAY REAL:C219(<>aStat6;8)
ARRAY REAL:C219(<>aStat7;8)
ARRAY REAL:C219(<>aStat8;8)
ARRAY REAL:C219(<>aStat9;8)
ARRAY REAL:C219(<>aStat10;8)
ARRAY REAL:C219(<>aStat11;8)
ARRAY REAL:C219(<>aStat12;8)
ARRAY REAL:C219(<>aStatEP;8)
ARRAY REAL:C219(<>aStatP1;8)
ARRAY REAL:C219(<>aStatP2;8)
ARRAY REAL:C219(<>aStatP3;8)
ARRAY REAL:C219(<>aStatP4;8)
ARRAY REAL:C219(<>aStatP5;8)
ARRAY REAL:C219(<>aStatPF;8)
ARRAY REAL:C219(<>aStatEX;8)
ARRAY REAL:C219(<>aStatNF;8)

LOC_LoadList2Array ("STR_VariablesEstadisticas";-><>aStatItems)

  //`••••••••••••••••••••••••••••••••
  //SELECTION VERS TABLEAU($1>>;$aStatValues)

For ($i;1;[Asignaturas:18]Numero_de_evaluaciones:38)
	$pNota:=Get pointer:C304("aNta"+String:C10($i))  //pointeur sur le tableau contenant les notes
	$pStat:=Get pointer:C304("<>aStat"+String:C10($i))
	AS_EstadisticasNotas ($pNota)
	
	For ($j;1;8)
		$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
	End for 
End for 

$pNota:=Get pointer:C304("aNtaEXP"+String:C10(atSTR_Periodos_Nombre))  //pointeur sur le tableau contenant les notes
$pStat:=-><>aStatEP
AS_EstadisticasNotas ($pNota)
For ($j;1;8)
	$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
End for 

For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
	$pNota:=Get pointer:C304("aNtaP"+String:C10($i))  //pointeur sur le tableau contenant les notes
	$pStat:=Get pointer:C304("<>aStatP"+String:C10($i))
	AS_EstadisticasNotas ($pNota)
	For ($j;1;8)
		$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
	End for 
End for 

$pStat:=-><>aStatPF
AS_EstadisticasNotas (->aNtaPF)
For ($j;1;8)
	$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
End for 


$pStat:=-><>aStatEX
AS_EstadisticasNotas (->aNtaEX)
For ($j;1;8)
	$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
End for 

$pStat:=-><>aStatNF
AS_EstadisticasNotas (->aNtaF)
For ($j;1;8)
	$pStat->{$j}:=Round:C94(<>aStatR{$j};2)
End for 