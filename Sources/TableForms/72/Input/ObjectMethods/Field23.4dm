Case of 
	: (Form event:C388=On Getting Focus:K2:7)
		Self:C308->:=Replace string:C233(Self:C308->;"*";"")
		
	: (Form event:C388=On Data Change:K2:15)
		Self:C308->:=Replace string:C233(Self:C308->;"*";"")
		Self:C308->:="*"+Self:C308->+"*"
		$vb_Reject:=False:C215
		$barCode_Original:=Replace string:C233([BBL_Lectores:72]Código_de_barra:10;"*";"")
		Case of 
			: (Length:C16($barCode_Original)>18)
				CD_Dlog (0;__ ("El código de barra debe obligatoriamente estar compuesto de un prefijo de tres caracteres alfabéticos en mayúsculas y de una a quince cifras."))
				
			: (Length:C16($barCode_Original)>3)
				$prefijo_BarCode:=Substring:C12($barCode_Original;1;3)
				$ascii1:=((Character code:C91($prefijo_BarCode[[1]])>=65) & (Character code:C91($prefijo_BarCode[[1]])<=90))
				$ascii2:=((Character code:C91($prefijo_BarCode[[2]])>=65) & (Character code:C91($prefijo_BarCode[[2]])<=90))
				$ascii3:=((Character code:C91($prefijo_BarCode[[3]])>=65) & (Character code:C91($prefijo_BarCode[[3]])<=90))
				
				If ($ascii1 & $ascii2 & $ascii3)
					  //para evitar conversión de cadenas con la forma 10e3 (4D considera la "e" como un exponente durante la conversión)
					If (Not:C34(<>vbBBL_PatronBCodeUseRUT))
						For ($i;4;Length:C16($barCode_Original))
							If ((Character code:C91($barCode_Original[[$i]])<48) | (Character code:C91($barCode_Original[[$i]])>57))
								$vb_Reject:=True:C214
								$i:=Length:C16($barCode_Original)
								CD_Dlog (0;__ ("El código de barra debe obligatoriamente estar compuesto de un prefijo de tres caracteres alfabéticos en mayúsculas y de una a quince cifras."))
							End if 
						End for 
					End if 
				Else 
					$vb_Reject:=True:C214
					CD_Dlog (0;__ ("El código de barra debe obligatoriamente estar compuesto de un prefijo de tres caracteres alfabéticos en mayúsculas y de una a quince cifras."))
				End if 
			Else 
				$vb_Reject:=True:C214
				CD_Dlog (0;__ ("El código de barra debe obligatoriamente estar compuesto de un prefijo de tres caracteres alfabéticos en mayúsculas y de una a quince cifras."))
		End case 
		
		
		If (Not:C34($vb_Reject))
			$cleanBarcode:=Replace string:C233([BBL_Lectores:72]Código_de_barra:10;"*";"")
			$prefixBarcode:=Substring:C12($cleanBarcode;1;3)
			$el:=Find in array:C230(<>alBBL_GruposLectores;[BBL_Lectores:72]ID_GrupoLectores:37)
			If ($el>0)
				If (<>asBBL_AbrevGruposLectores{$el}#$prefixBarcode)
					OK:=CD_Dlog (0;__ ("El prefijo ingresado al prefijo establecido para el grupo de lectores al que pertenece este lector. Esto puede provocar confusiones y errores.\r\r¿Desea usted relamente mantener el prefijo ")+$prefixBarcode+__ ("?");__ ("");__ ("Si");__ ("No"))
					If (OK=1)
						$barcodeNumber:=Num:C11(Substring:C12($cleanBarcode;4))
						[BBL_Lectores:72]BarCode_SinFormato:38:=$prefixBarcode+String:C10($barcodeNumber)
						If (KRL_RecordExists (->[BBL_Lectores:72]BarCode_SinFormato:38))
							CD_Dlog (0;__ ("Ya existe un registro con el código ")+[BBL_Lectores:72]Código_de_barra:10+__ ("."))
							[BBL_Lectores:72]Código_de_barra:10:=Old:C35([BBL_Lectores:72]Código_de_barra:10)
							[BBL_Lectores:72]BarCode_SinFormato:38:=Old:C35([BBL_Lectores:72]BarCode_SinFormato:38)
							Self:C308->:=Replace string:C233(Self:C308->;"*";"")
							HIGHLIGHT TEXT:C210([BBL_Lectores:72]Código_de_barra:10;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1)
						Else 
							viBBL_BarCodeEnterable:=0
							[BBL_Lectores:72]Código_de_barra:10:=$prefixBarcode+String:C10($barcodeNumber;"#########000000")
							OBJECT SET ENTERABLE:C238([BBL_Lectores:72]Código_de_barra:10;False:C215)
							OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
							OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
						End if 
					Else 
						[BBL_Lectores:72]Código_de_barra:10:=Old:C35([BBL_Lectores:72]Código_de_barra:10)
						[BBL_Lectores:72]BarCode_SinFormato:38:=Old:C35([BBL_Lectores:72]BarCode_SinFormato:38)
						Self:C308->:=Replace string:C233(Self:C308->;"*";"")
						HIGHLIGHT TEXT:C210([BBL_Lectores:72]Código_de_barra:10;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1)
					End if 
				Else 
					
					If (Not:C34(<>vbBBL_PatronBCodeUseRUT))
						$barcodeNumber:=Num:C11(Substring:C12($cleanBarcode;4))
						[BBL_Lectores:72]BarCode_SinFormato:38:=$prefixBarcode+String:C10($barcodeNumber)
					End if 
					If (KRL_RecordExists (->[BBL_Lectores:72]BarCode_SinFormato:38))
						CD_Dlog (0;__ ("Ya existe un registro con el código ")+[BBL_Lectores:72]Código_de_barra:10+__ ("."))
						[BBL_Lectores:72]Código_de_barra:10:=Old:C35([BBL_Lectores:72]Código_de_barra:10)
						[BBL_Lectores:72]BarCode_SinFormato:38:=Old:C35([BBL_Lectores:72]BarCode_SinFormato:38)
						Self:C308->:=Replace string:C233(Self:C308->;"*";"")
						HIGHLIGHT TEXT:C210([BBL_Lectores:72]Código_de_barra:10;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1)
					Else 
						If (Not:C34(<>vbBBL_PatronBCodeUseRUT))
							viBBL_BarCodeEnterable:=0
							[BBL_Lectores:72]Código_de_barra:10:=$prefixBarcode+String:C10($barcodeNumber;"#########000000")
						End if 
						OBJECT SET ENTERABLE:C238([BBL_Lectores:72]Código_de_barra:10;False:C215)
						OBJECT SET VISIBLE:C603(*;"padlockUnlocked";False:C215)
						OBJECT SET VISIBLE:C603(*;"padlockLocked";True:C214)
					End if 
				End if 
			Else 
				[BBL_Lectores:72]Código_de_barra:10:=Old:C35([BBL_Lectores:72]Código_de_barra:10)
				[BBL_Lectores:72]BarCode_SinFormato:38:=Old:C35([BBL_Lectores:72]BarCode_SinFormato:38)
				Self:C308->:=Replace string:C233(Self:C308->;"*";"")
				HIGHLIGHT TEXT:C210([BBL_Lectores:72]Código_de_barra:10;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1)
				CD_Dlog (0;__ ("El prefijo de código de barra no corresponde ningún grupo de lectores definido."))
			End if 
		Else 
			[BBL_Lectores:72]Código_de_barra:10:=Old:C35([BBL_Lectores:72]Código_de_barra:10)
			[BBL_Lectores:72]BarCode_SinFormato:38:=Old:C35([BBL_Lectores:72]BarCode_SinFormato:38)
			Self:C308->:=Replace string:C233(Self:C308->;"*";"")
			HIGHLIGHT TEXT:C210([BBL_Lectores:72]Código_de_barra:10;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1;Length:C16([BBL_Lectores:72]Código_de_barra:10)+1)
		End if 
		
		If ([BBL_Lectores:72]Código_de_barra:10#Old:C35([BBL_Lectores:72]Código_de_barra:10))
			$barCodeType:="Code39"
			$createchecksum:=False:C215
			$showchecksum:=False:C215
			$printCode:=True:C214
			vp_PictureCodeBar:=Barcode_Create ($barCodeType;Replace string:C233([BBL_Lectores:72]Código_de_barra:10;"*";"");$createchecksum;$showchecksum;$printCode)
			vp_PictureCodeBar:=vp_PictureCodeBar*0.8
		End if 
		
	: (Form event:C388=On Losing Focus:K2:8)
		Self:C308->:=Replace string:C233(Self:C308->;"*";"")
		Self:C308->:="*"+Self:C308->+"*"
		
End case 