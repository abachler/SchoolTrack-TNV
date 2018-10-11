//%attributes = {}
  // MÉTODO: IT_Progress
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 07/12/11, 09:36:32
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // IT_Progress()
  // ----------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_action;$l_ProgressProcessID;$l_windowsPosition;$state;$1)
C_REAL:C285($r_ProgressRate1;$r_ProgressRate2;$r_ProgressRate3;$3;$5;$7)
C_TEXT:C284($t_ProgressMessage1;$t_ProgressMessage2;$t_ProgressMessage3;$4;$6;$8)




  // CODIGO PRINCIPAL
$l_action:=$1

Case of 
	: (Count parameters:C259=8)
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$t_ProgressMessage2:=$6
		$r_ProgressRate3:=$7
		$t_ProgressMessage3:=$8
		$t_Thermomethers:=3
		
	: (Count parameters:C259=7)
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$t_ProgressMessage2:=$6
		$r_ProgressRate3:=$7
		$t_Thermomethers:=3
		
	: (Count parameters:C259=6)
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$t_ProgressMessage2:=$6
		$t_Thermomethers:=2
		
	: (Count parameters:C259=5)
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$r_ProgressRate2:=$5
		$t_Thermomethers:=2
		
	: (Count parameters:C259=4)
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_ProgressMessage1:=$4
		$t_Thermomethers:=1
		
	: (Count parameters:C259=3)
		$l_ProgressProcessID:=$2
		$r_ProgressRate1:=$3
		$t_Thermomethers:=1
		
	: (Count parameters:C259=2)
		$l_action:=$1
		$l_ProgressProcessID:=$2
		
End case 
$r_ProgressRate1:=Int:C8($r_ProgressRate1*100)
$r_ProgressRate2:=Int:C8($r_ProgressRate2*100)
$r_ProgressRate3:=Int:C8($r_ProgressRate3*100)


Case of 
	: ($l_action=1)
		vb_ShowProgress:=True:C214
		$l_ProgressProcessID:=New process:C317("IT_ShowProgressIndicator";Pila_256K;"$progress";$r_ProgressRate1;$t_ProgressMessage1;$r_ProgressRate2;$t_ProgressMessage2;$r_ProgressRate3;$t_ProgressMessage3)
		DELAY PROCESS:C323($l_ProgressProcessID;10)
		$0:=$l_ProgressProcessID
		
	: ($l_action=-1)
		vb_ShowProgress:=False:C215
		SET PROCESS VARIABLE:C370($l_ProgressProcessID;vb_ShowProgress;False:C215)
		POST OUTSIDE CALL:C329($l_ProgressProcessID)
		$state:=Process state:C330($l_ProgressProcessID)
		While ($state>=0)
			SET PROCESS VARIABLE:C370($l_ProgressProcessID;vb_ShowProgress;False:C215)
			POST OUTSIDE CALL:C329($l_ProgressProcessID)
			DELAY PROCESS:C323(Current process:C322;10)
			$state:=Process state:C330($l_ProgressProcessID)
		End while 
		
	: (($l_action=0) & (Count parameters:C259>2))
		SET PROCESS VARIABLE:C370($l_ProgressProcessID;vl_IndicatorsToDisplay;$t_Thermomethers)
		If ($t_ProgressMessage1#"")
			SET PROCESS VARIABLE:C370($l_ProgressProcessID;vt_ProgressMessage1;$t_ProgressMessage1)
		End if 
		SET PROCESS VARIABLE:C370($l_ProgressProcessID;vr_Progress1;$r_ProgressRate1)
		
		If ($t_ProgressMessage2#"")
			SET PROCESS VARIABLE:C370($l_ProgressProcessID;vt_ProgressMessage2;$t_ProgressMessage2)
		End if 
		SET PROCESS VARIABLE:C370($l_ProgressProcessID;vr_Progress2;$r_ProgressRate2)
		
		If ($t_ProgressMessage3#"")
			SET PROCESS VARIABLE:C370($l_ProgressProcessID;vt_ProgressMessage3;$t_ProgressMessage3)
		End if 
		SET PROCESS VARIABLE:C370($l_ProgressProcessID;vr_Progress3;$r_ProgressRate3)
		POST OUTSIDE CALL:C329($l_ProgressProcessID)
		
		
End case 

$0:=$l_ProgressProcessID