$text:=AT_array2text (->atACT_PrinterNames)
$choice:=Pop up menu:C542($text)

If ($choice#0)
	  //If (SYS_IsWindows )
	  //$err:=sys_SetDefPrinter (atACT_PrinterNames{$choice})
	  //vtACT_Printer:=atACT_PrinterNames{$choice}
	  //End if 
	If (SYS_IsWindows )
		$el:=-1
		For ($i;1;Size of array:C274(atACT_SystemPrinters))
			$vt_PrinterName:=ST_GetWord (atACT_SystemPrinters{$i};1;",")
			If ($vt_PrinterName=atACT_PrinterNames{$choice})
				$el:=$i
				$i:=Size of array:C274(atACT_SystemPrinters)
			End if 
		End for 
		If ($el#-1)
			$err:=sys_SetDefPrinter (atACT_SystemPrinters{$el})
			vtACT_Printer:=atACT_PrinterNames{$choice}
		End if 
	Else 
		SET CURRENT PRINTER:C787(atACT_PrinterNames{$choice})
		vtACT_Printer:=atACT_PrinterNames{$choice}  //20130826 RCH
	End if 
End if 