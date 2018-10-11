//%attributes = {}
  // Método: UD_v20170719_EstilosEspecificos
  //
  //
  // por Alberto Bachler Klein
  // creación 30/07/17, 10:34:48
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($l_index)

Case of 
	: ((<>gRolBD="253103") & (<>vtXS_CountryCode="cl"))
		EVS_ReadStyleData (24)
		$l_index:=Find in array:C230(aSymbol;"NE")
		aSymbPctFrom{$l_index}:=1
		aSymbPctTo{$l_index}:=1
		aSymbPctEqu{$l_index}:=1
		$l_index:=Find in array:C230(aSymbol;"NL")
		aSymbPctFrom{$l_index}:=2
		aSymbPctTo{$l_index}:=49
		aSymbPctEqu{$l_index}:=49
		$l_index:=Find in array:C230(aSymbol;"PL")
		aSymbPctFrom{$l_index}:=50
		aSymbPctTo{$l_index}:=74
		aSymbPctEqu{$l_index}:=74
		$l_index:=Find in array:C230(aSymbol;"L")
		aSymbPctFrom{$l_index}:=75
		aSymbPctTo{$l_index}:=100
		aSymbPctEqu{$l_index}:=100
		EVS_WriteStyleData 
		
	: ((<>gRolBD="AEI720307SY4") & (<>vtXS_CountryCode="mx"))
		EVS_ReadStyleData (20)
		$l_index:=Find in array:C230(aSymbol;"1")
		aSymbPctFrom{$l_index}:=1
		aSymbPctTo{$l_index}:=33.3
		aSymbPctEqu{$l_index}:=33.3
		$l_index:=Find in array:C230(aSymbol;"2")
		aSymbPctFrom{$l_index}:=33.4
		aSymbPctTo{$l_index}:=66.6
		aSymbPctEqu{$l_index}:=66.6
		$l_index:=Find in array:C230(aSymbol;"3")
		aSymbPctFrom{$l_index}:=66.7
		aSymbPctTo{$l_index}:=100
		aSymbPctEqu{$l_index}:=100
		
		EVS_WriteStyleData 
End case 

