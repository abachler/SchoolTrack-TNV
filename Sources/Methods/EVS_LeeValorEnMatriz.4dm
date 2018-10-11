//%attributes = {}
  //EVS_LeeValorEnMatriz

C_LONGINT:C283($id;$1)
C_TEXT:C284($itemName;$2)
C_REAL:C285($0)
$0:=-1

$id:=$1
$itemName:=$2
$i:=Find in array:C230(<>alEVS_Ids;$id)

If ($i>0)
	Case of 
		: ($itemName="iEvaluationMode")
			$0:=<>alEVS_EvaluationMode{$i}
		: ($itemName="iPrintMode")
			$0:=<>alEVS_PrintMode{$i}
		: ($itemName="iPrintActa")
			$0:=<>alEVS_PrintActa{$i}
		: ($itemName="iGradesDecPP")
			$0:=<>alEVS_iGradesDecPP{$i}
		: ($itemName="iGradesDecPF")
			$0:=<>alEVS_iGradesDecPF{$i}
		: ($itemName="iGradesDecNF")
			$0:=<>alEVS_iGradesDecNF{$i}
		: ($itemName="iGradesDecNO")
			$0:=<>alEVS_iGradesDecNO{$i}
		: ($itemName="rGradesFrom")
			$0:=<>arEVS_rGradesFrom{$i}
			
		: ($itemName="iPointsDecPP")
			$0:=<>alEVS_iPointsDecPP{$i}
		: ($itemName="iPointsDecPF")
			$0:=<>alEVS_iPointsDecPF{$i}
		: ($itemName="iPointsDecNF")
			$0:=<>alEVS_iPointsDecNF{$i}
		: ($itemName="iPointsDecNO")
			$0:=<>alEVS_iPointsDecNO{$i}
		: ($itemName="rPointsFrom")
			$0:=<>arEVS_rPointsFrom{$i}
			
		: ($itemName="vrNTA_MinimoEscalaReferencia")
			$0:=<>arEVS_MinimoEscalaReferencia{$i}
	End case 
Else 
	$0:=-1
End if 