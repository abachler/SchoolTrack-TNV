Case of 
	: (viBBL_BarCodeEnterable=0)
		viBBL_BarCodeEnterable:=1
		OBJECT SET ENTERABLE:C238([BBL_Lectores:72]Código_de_barra:10;True:C214)
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";True:C214)
		OBJECT SET VISIBLE:C603(*;"padlockLocked";False:C215)
		GOTO OBJECT:C206([BBL_Lectores:72]Código_de_barra:10)
		HIGHLIGHT TEXT:C210([BBL_Lectores:72]Código_de_barra:10;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1)
	: (viBBL_BarCodeEnterable=1)
		viBBL_BarCodeEnterable:=0
		OBJECT SET ENTERABLE:C238([BBL_Lectores:72]Código_de_barra:10;False:C215)
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
		OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
End case 