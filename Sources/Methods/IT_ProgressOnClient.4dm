//%attributes = {}
  // IT_ProgressOnClient()
  //
  // Descripción
  //
  // Parámetros
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/12/12, 19:18:03
  // ---------------------------------------------
C_LONGINT:C283($l_indexCliente;$l_ProgressProcessID;$l_Thermomethers)
C_REAL:C285($r_ProgressRate1;$r_ProgressRate2;$r_ProgressRate3;$r_tasaEjecucion;$r_tasaEjecucion)
C_TEXT:C284($t_NombreCliente;$t_ProgressMessage1;$t_ProgressMessage2;$t_ProgressMessage3)

ARRAY LONGINT:C221($al_metodos;0)
ARRAY TEXT:C222($at_Clientes;0)

  // CODIGO
Case of 
	: (Count parameters:C259=8)
		$t_NombreCliente:=$1
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$t_ProgressMessage2:=$6
		$r_ProgressRate3:=$7
		$t_ProgressMessage3:=$8
		$l_Thermomethers:=3
		$r_tasaEjecucion:=$r_ProgressRate3
		
	: (Count parameters:C259=7)
		$t_NombreCliente:=$1
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$t_ProgressMessage2:=$6
		$r_ProgressRate3:=$7
		$l_Thermomethers:=3
		$r_tasaEjecucion:=$r_ProgressRate3
		
	: (Count parameters:C259=6)
		$t_NombreCliente:=$1
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$t_ProgressMessage2:=$6
		$l_Thermomethers:=2
		$r_tasaEjecucion:=$r_ProgressRate2
		
	: (Count parameters:C259=5)
		$t_NombreCliente:=$1
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$l_Thermomethers:=2
		$r_tasaEjecucion:=$r_ProgressRate2
		
	: (Count parameters:C259=4)
		$t_NombreCliente:=$1
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$l_Thermomethers:=1
		$r_tasaEjecucion:=$r_ProgressRate1
		
	: (Count parameters:C259=3)
		$t_NombreCliente:=$1
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$l_Thermomethers:=1
		$r_tasaEjecucion:=$r_ProgressRate1
End case 

$l_indexCliente:=-1
  //If ((Dec(Round($r_tasaEjecucion*100/10;1))=0) & (($r_tasaEjecucion>=0,0001) | ($r_tasaEjecucion=0)))
GET REGISTERED CLIENTS:C650($at_Clientes;$al_metodos)
$l_indexCliente:=Find in array:C230($at_Clientes;$t_NombreCliente)
  //End if 
If ($l_indexCliente>0)
	If ($al_metodos{$l_indexCliente}<=10)
		Case of 
			: ($l_Thermomethers=1)
				EXECUTE ON CLIENT:C651($t_NombreCliente;"IT_Progress";0;$l_ProgressProcessID;$r_ProgressRate1;$t_ProgressMessage1)
			: ($l_Thermomethers=2)
				EXECUTE ON CLIENT:C651($t_NombreCliente;"IT_Progress";0;$l_ProgressProcessID;$r_ProgressRate1;$t_ProgressMessage1;$r_ProgressRate2;$t_ProgressMessage2)
			: ($l_Thermomethers=3)
				EXECUTE ON CLIENT:C651($t_NombreCliente;"IT_Progress";0;$l_ProgressProcessID;$r_ProgressRate1;$t_ProgressMessage1;$r_ProgressRate2;$t_ProgressMessage2;$r_ProgressRate3;$t_ProgressMessage3)
		End case 
	End if 
End if 

