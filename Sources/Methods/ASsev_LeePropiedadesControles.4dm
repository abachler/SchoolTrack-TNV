//%attributes = {}
  //ASsev_LeePropiedadesControles

C_LONGINT:C283($1;$controlSelected;$bHeight;$bWidth)
If (Count parameters:C259=1)
	$controlSelected:=$1
End if 



OBJECT SET VISIBLE:C603(*;"ponderacionControl@";False:C215)
OBJECT SET VISIBLE:C603(*;"vs_FijoControles@";False:C215)


$examValue2Show:=""
$controlValue2Show:=""

vsAS_PonderacionControl:=""
If ((Count parameters:C259=0) | ($controlSelected>0))
	$popupContent:=__ ("01Ponderado en:;(-;(Si es inferior al Promedio;  11se pondera en:;  12la Calificación Final será igual al Promedio;  13la Calificación Final será igual al Control;  14la Calificación Final será igual a:;(Si es superior a Promedio;  21se po"+"ndera en:;  "+"22la Calificación Final será igual al Promedio;  23la Calificación Final será igual al Control;  24la Calificación Final será igual a:;(-;Sin Controles Periódicos")
	If ($controlSelected>0)
		vi_ModoControlesSeleccionado:=$controlSelected
		Case of 
			: ($controlSelected=14)
				vtAS_ModoControles:=ST_GetWord ($popupContent;14;";")
			: ($controlSelected=1)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;1;";");3)
				vsAS_PonderacionControl:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlInferior:8)+"%"
				$controlValue2Show:="ponderacionControlInferior"
			: ($controlSelected=4)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;4;";");5)
				vsAS_PonderacionControl:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlInferior:8)+"%"
				$controlValue2Show:="ponderacionControlInferior"
			: ($controlSelected=5)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;5;";");5)
			: ($controlSelected=6)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;6;";");5)
			: ($controlSelected=7)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;7;";");5)
				$controlValue2Show:="vs_FijoControles"
				vs_FijoControles:=NTA_PercentValue2StringValue ([xxSTR_Subasignaturas:83]ValorControlSiInferior:9)
				vi_ModoControlesSeleccionado:=7
			: ($controlSelected=9)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;9;";");5)
				vsAS_PonderacionControl:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlSuperior:15)+"%"
				$controlValue2Show:="ponderacionControlSuperior"
			: ($controlSelected=10)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;10;";");5)
			: ($controlSelected=11)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;11;";");5)
			: ($controlSelected=12)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;12;";");5)
				$controlValue2Show:="vs_FijoControles"
				vs_FijoControles:=NTA_PercentValue2StringValue ([xxSTR_Subasignaturas:83]ValorControlSiSuperior:10)
				vi_ModoControlesSeleccionado:=12
		End case 
	Else 
		Case of 
			: ([xxSTR_Subasignaturas:83]ModoControles:5=0)
				vtAS_ModoControles:=ST_GetWord ($popupContent;14;";")
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 1)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;1;";");3)
				vsAS_PonderacionControl:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlSuperior:15)+"%"
				$controlValue2Show:="ponderacionControlInferior"
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 11)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;4;";");5)
				vsAS_PonderacionControl:=String:C10([xxSTR_Subasignaturas:83]PonderacionControlSuperior:15)+"%"
				$controlValue2Show:="ponderacionControlInferior"
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 12)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;5;";");5)
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 13)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;6;";");5)
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 14)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;3;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;7;";");5)
				$controlValue2Show:="vs_FijoControles"
				vs_FijoControles:=NTA_PercentValue2StringValue ([xxSTR_Subasignaturas:83]ValorControlSiInferior:9)
				vi_ModoControlesSeleccionado:=7
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 21)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;9;";");5)
				vsAS_PonderacionControl:=String:C10([xxSTR_Subasignaturas:83]ValorControlSiSuperior:10)+"%"
				$controlValue2Show:="ponderacionControlSuperior"
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 22)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;10;";");5)
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 23)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;11;";");5)
			: ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 24)
				vtAS_ModoControles:=Substring:C12(ST_GetWord ($popupContent;8;";");2)+", "+Substring:C12(ST_GetWord ($popupContent;12;";");5)
				$controlValue2Show:="vs_FijoControles"
				vs_FijoControles:=NTA_PercentValue2StringValue ([xxSTR_Subasignaturas:83]ValorControlSiSuperior:10)
				vi_ModoControlesSeleccionado:=12
		End case 
	End if 
End if 

If ([xxSTR_Subasignaturas:83]ModoControles:5 ?? 1)
	[xxSTR_Subasignaturas:83]PonderacionControlSuperior:15:=[xxSTR_Subasignaturas:83]PonderacionControlInferior:8
End if 



OBJECT GET COORDINATES:C663(*;"labelControles";$oLeft;$oTop;$oRigth;$oBottom)
OBJECT GET BEST SIZE:C717(*;"labelControles";$bWidth;$bHeight)
IT_SetNamedObjectRect ("labelControles";$oLeft;$oTop;$oLeft+$bWidth;$oBottom)

OBJECT GET COORDINATES:C663(*;"labelControles";$oLeft;$oTop;$oRigth;$oBottom)
$leftObjectAlign:=$oRigth+8
$leftTextAlign:=$leftObjectAlign+9
$oTop:=$oTop-3
$oLeft:=$leftObjectAlign
$oRigth:=$oLeft+8
$oBottom:=$oTop+18
$oBtnLeft:=$oLeft
$oBtnTop:=$oTop
IT_SetNamedObjectRect ("popupMacLeft1";$oLeft;$oTop;$oRigth;$oBottom)
OBJECT GET BEST SIZE:C717(vtAS_ModoControles;$bWidth;$bHeight)
$oLeft:=$oRigth
$oRigth:=$oLeft+$bWidth+10
$oBottom:=$oTop+18
$oTextLeft:=$leftTextAlign  // $oLeft+1
$oTextTop:=$oTop+3
$oTextRigth:=$oTextLeft+$bWidth
$oTextBottom:=$oTextTop+$bHeight
IT_SetNamedObjectRect ("vtAS_ModoControles";$oTextLeft;$oTextTop;$oTextRigth;$oTextBottom)
IT_SetNamedObjectRect ("popupMacMiddle1";$oLeft;$oTop;$oRigth;$oBottom)
$oLeft:=$oRigth
$oRigth:=$oLeft+19
$oBottom:=$oTop+18
IT_SetNamedObjectRect ("popupMacRight1";$oLeft;$oTop;$oRigth;$oBottom)
$oBtnRight:=$oRigth
$oBtnBottom:=$oBottom
IT_SetNamedObjectRect ("bPopupControles";$oBtnLeft;$oBtnTop;$oBtnRight;$oBtnBottom)

OBJECT SET VISIBLE:C603(*;$controlValue2Show;True:C214)
If ($controlValue2Show#"")
	$oLeft:=$oRigth+8
	IT_SetNamedObjectRect ($controlValue2Show;$oLeft;$oTextTop;$oLeft+40;$oTextTop+$bHeight)
End if 

If (<>vb_BloquearModifSituacionFinal)
	_O_DISABLE BUTTON:C193(bPopupControles)
	OBJECT SET ENTERABLE:C238(*;$controlValue2Show;False:C215)
	OBJECT SET ENTERABLE:C238(vs_FijoControles;False:C215)
	OBJECT SET COLOR:C271(vtAS_ModoControles;-14)
Else 
	_O_ENABLE BUTTON:C192(bPopupControles)
	OBJECT SET ENTERABLE:C238(*;$controlValue2Show;True:C214)
	OBJECT SET ENTERABLE:C238(vs_FijoControles;True:C214)
	OBJECT SET COLOR:C271(vtAS_ModoControles;-15)
End if 


