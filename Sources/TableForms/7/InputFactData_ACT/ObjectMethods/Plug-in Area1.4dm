Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		If ($line>0)
			If (abACT_ReqDatos{$line}=True:C214)
				$width:=508
				$height:=427
				$VisibleData:=True:C214
			Else 
				$width:=508
				$height:=227
				$VisibleData:=False:C215
			End if 
			[Personas:7]ACT_DocumentoTributario:45:=älACT_IDsCats{$line}
		Else 
			$line:=0
			$width:=508
			$height:=227
			$botTopPosChange:=-200
			$VisibleData:=False:C215
			[Personas:7]ACT_DocumentoTributario:45:=0
		End if 
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		$ActualWidth:=$right-$left
		$ActualHeight:=$bottom-$top
		If ($ActualHeight<$height)
			OBJECT MOVE:C664(*;"boton@";0;200)
			If (($ActualWidth#$width) | ($ActualHeight#$height))
				OBJECT SET VISIBLE:C603(*;"DA@";$VisibleData)
				If (SYS_IsWindows )
					$Resizeby:=5
				Else 
					$Resizeby:=20
				End if 
				WDW_AdjustWindowSize ($width;$height;$Resizeby)
			End if 
		Else 
			If ($ActualHeight>$height)
				If (($ActualWidth#$width) | ($ActualHeight#$height))
					OBJECT SET VISIBLE:C603(*;"DA@";$VisibleData)
					If (SYS_IsWindows )
						$Resizeby:=5
					Else 
						$Resizeby:=20
					End if 
					WDW_AdjustWindowSize ($width;$height;$Resizeby)
				End if 
				OBJECT MOVE:C664(*;"boton@";0;-200)
			End if 
		End if 
End case 