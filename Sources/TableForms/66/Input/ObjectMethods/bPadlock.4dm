Case of 
	: (viBBL_BarCodeEnterable=0)
		viBBL_BarCodeEnterable:=1
		OBJECT SET ENTERABLE:C238([BBL_Registros:66]Barcode_SinFormato:26;True:C214)
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";True:C214)
		OBJECT SET VISIBLE:C603(*;"padlockLocked";False:C215)
		GOTO OBJECT:C206([BBL_Registros:66]Barcode_SinFormato:26)
		HIGHLIGHT TEXT:C210([BBL_Registros:66]Barcode_SinFormato:26;Length:C16([BBL_Registros:66]Barcode_SinFormato:26)+1;Length:C16([BBL_Registros:66]Barcode_SinFormato:26)+1)
	: (viBBL_BarCodeEnterable=1)
		viBBL_BarCodeEnterable:=0
		OBJECT SET ENTERABLE:C238([BBL_Registros:66]Barcode_SinFormato:26;False:C215)
		OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
		OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
End case 
