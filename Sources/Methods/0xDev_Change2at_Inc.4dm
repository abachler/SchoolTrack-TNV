//%attributes = {}
  //0xDev_Change2at_Inc

If (False:C215)
	  //Este metodo simplemente cambia los indices de cualquier asignacion por AT_Inc
	  //y agrega la linea AT_Inc(0) al principio del texto
	
	  //Para usarlo copie el metodo al portapapeles y llame este metodo desde el modo User
	  //una vez concluida la ejecucion pegue el contenido del portapapeles en su metodo.
End if 

If (Pasteboard data size:C400("TEXT")>0)
	ARRAY TEXT:C222(at_ClipboardContents;0)
	$text:=Get text from pasteboard:C524
	AT_Text2Array (->at_ClipboardContents;$text;"\r")
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Reemplazando índices por at_Inc..."))
	For ($i;1;Size of array:C274(at_ClipboardContents))
		$line:=at_ClipboardContents{$i}
		$posIni:=Position:C15("{";$line)+1
		$PosFin:=Position:C15("}";$line)-1
		$numChars:=$PosFin-$posIni+1
		$replaceStr:=Substring:C12($line;$posIni;$numChars)
		If ($posIni>0)
			$line:=Replace string:C233($line;$replaceStr;"at_Inc";1)
		End if 
		at_ClipboardContents{$i}:=$line
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(at_ClipboardContents);__ ("Reemplazando índices por at_Inc..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	INSERT IN ARRAY:C227(at_ClipboardContents;1;1)
	at_ClipboardContents{1}:="at_Inc(0)"
	$text:=AT_array2text (->at_ClipboardContents;"\r")
	SET TEXT TO PASTEBOARD:C523($text)
	AT_Initialize (->at_ClipboardContents)
Else 
	CD_Dlog (0;__ ("El portapapeles está vacio o no contiene datos tipo TEXT."))
End if 