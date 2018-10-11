//%attributes = {}
  //xPLCB_AL_HeaderInformeNotas

C_LONGINT:C283($1;$2;$4;$5)
_O_C_STRING:C293(82;$3)
C_TEXT:C284($0)

If (bGrpArea=1)
	Case of 
		: ($2=1)
			$0:="Sector "+Substring:C12(aSector{$4};3)
		: ((aArraysName{$2}="aNtaP1") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNtaP1;$4;$5)
		: ((aArraysName{$2}="aNtaP2") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNtaP2;$4;$5)
		: ((aArraysName{$2}="aNtaP3") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNtaP3;$4;$5)
		: ((aArraysName{$2}="aNtaP4") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNta4;$4;$5)
		: ((aArraysName{$2}="aNtaPF") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNtaPF;$4;$5)
		: ((aArraysName{$2}="aNtaEX") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNtaEX;$4;$5)
		: ((aArraysName{$2}="aNtaF") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNtaF;$4;$5)
		: ((aArraysName{$2}="aNtaEXp") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealNtaExP;$4;$5)
		: ((aArraysName{$2}="aStrAsgAverage") & (bSectorAvg=1))
			$0:=ALrc_SectionAverage (->aRealAsgAverage;$4;$5)
		Else 
			$0:=""
	End case 
Else 
	If ((aElectiva{$4}) & ($1=1))
		$0:=aText1{4}
	Else 
		$0:=aText1{3}
	End if 
End if 
