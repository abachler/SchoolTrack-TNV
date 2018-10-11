//%attributes = {}
  //IT_UThermometer

C_LONGINT:C283($uTherProcessID;$0;$state)
  //20130320 RCH El proceso podia quedar pegado al cerrar la ventana.
C_TEXT:C284($t_procNameOrg;$t_procName)
C_LONGINT:C283($l_time)

$0:=0
$winPos:=5
  //If (Application type#4D Server )
$uTherProcessID:=0
$action:=0
$textMsg:=""

$t_procNameOrg:="$uThermometer"

Case of 
	: (Count parameters:C259=0)
		$action:=0
	: (Count parameters:C259=1)
		$action:=$1
	: (Count parameters:C259=2)
		$action:=$1
		$uTherProcessID:=$2
	: (Count parameters:C259=3)
		$action:=$1
		$uTherProcessID:=$2
		$textMsg:=$3
	: (Count parameters:C259=4)
		$action:=$1
		$uTherProcessID:=$2
		$textMsg:=$3
		$winPos:=$4
End case 
Case of 
	: ($action=1)
		Fl_Blink:=True:C214
		  //vl_milliseconds:=Milliseconds
		  //20130320 RCH
		  //$uTherProcessID:=New process("IT_DisplayUnlimitedThermo";Pila_256K;"$uThermometer";$textMsg;$winPos)
		$uTherProcessID:=New process:C317("IT_DisplayUnlimitedThermo";Pila_256K;$t_procNameOrg;$textMsg;$winPos)
		$0:=$uTherProcessID
	: ($action=0)
		vThermoText:=$textMsg
		SET PROCESS VARIABLE:C370($uTherProcessID;vThermoText;$textMsg)
		POST OUTSIDE CALL:C329($uTherProcessID)
	: ($action=-2)
		Fl_Blink:=False:C215
		SET PROCESS VARIABLE:C370($uTherProcessID;Fl_Blink;False:C215)
		POST OUTSIDE CALL:C329($uTherProcessID)
		  //20130320 RCH Se podia estar testeando infinitamente otro proceso si es que, por ejemplo, el id de proceso era reasignado
		  //$state:=Process state($uTherProcessID)
		  //While ($state>=0)
		PROCESS PROPERTIES:C336($uTherProcessID;$t_procName;$state;$l_time)
		While ((($state>=0) & ($t_procName=$t_procNameOrg)))
			SET PROCESS VARIABLE:C370($uTherProcessID;Fl_Blink;False:C215)
			POST OUTSIDE CALL:C329($uTherProcessID)
			DELAY PROCESS:C323(Current process:C322;10)
			  //20130320 RCH 
			  //$state:=Process state($uTherProcessID)
			PROCESS PROPERTIES:C336($uTherProcessID;$t_procName;$state;$l_time)
		End while 
End case 
$0:=$uTherProcessID
  //Else 
  //
  //End if 

If (False:C215)  //utilizar despues de cambiar textos a recursos...
	C_LONGINT:C283($uTherProcessID;$0)
	
	
	$0:=0
	$winPos:=5
	If (Application type:C494#4D Server:K5:6)
		$uTherProcessID:=0
		$action:=0
		$textMsg:=""
		Case of 
			: (Count parameters:C259=0)
				$action:=0
			: (Count parameters:C259=1)
				$action:=$1
			: (Count parameters:C259=2)
				$action:=$1
				$uTherProcessID:=$2
			: (Count parameters:C259=3)
				$action:=$1
				$uTherProcessID:=$2
				$textMsg:=$3
			: (Count parameters:C259=4)
				$action:=$1
				$uTherProcessID:=$2
				$textMsg:=$3
				$winPos:=$4
		End case 
		
		Case of 
			: ($action=1)
				<>Fl_Blink:=True:C214
				  //vl_milliseconds:=Milliseconds
				$uTherProcessID:=New process:C317("IT_DisplayUnlimitedThermo";16000;"$uThermometer";$textMsg;$winPos)
				$0:=$uTherProcessID
			: ($action=0)
				<>vThermoText:=$textMsg
				POST OUTSIDE CALL:C329($uTherProcessID)
			: ($action=-2)
				<>Fl_Blink:=False:C215
				POST OUTSIDE CALL:C329($uTherProcessID)
				$state:=Process state:C330($uTherProcessID)
				While ($state>=0)
					POST OUTSIDE CALL:C329($uTherProcessID)
					DELAY PROCESS:C323(Current process:C322;10)
					$state:=Process state:C330($uTherProcessID)
				End while 
		End case 
		$0:=$uTherProcessID
	Else 
		
	End if 
	
End if 