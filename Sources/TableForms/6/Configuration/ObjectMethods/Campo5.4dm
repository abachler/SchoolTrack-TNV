If ([xxSTR_Niveles:6]EsNivelRegular:4)
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelOficial:15;True:C214)
Else 
	OBJECT SET ENTERABLE:C238([xxSTR_Niveles:6]EsNivelOficial:15;False:C215)
	[xxSTR_Niveles:6]EsNivelOficial:15:=False:C215
End if 
Case of 
	: ([xxSTR_Niveles:6]EsNivelOficial:15)
		aTextRGBColors{<>aNivel}:=0x0000
		aTextStyles{<>aNivel}:=5
	: ([xxSTR_Niveles:6]EsNivelRegular:4)
		aTextRGBColors{<>aNivel}:=0x0000
		aTextStyles{<>aNivel}:=1
	: (Not:C34([xxSTR_Niveles:6]EsNIvelActivo:30))
		aTextRGBColors{<>aNivel}:=0x00969696
		aTextStyles{<>aNivel}:=0
	Else 
		aTextRGBColors{<>aNivel}:=0x0000
		aTextStyles{<>aNivel}:=0
End case 