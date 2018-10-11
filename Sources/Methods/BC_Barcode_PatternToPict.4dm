//%attributes = {}
  //  //Barcode_PatternToPict

  //  // Barcode
  //  // Thomas Maul, 4D Germany, July 2004

  //  // draw the pattern. $1 = pattern, $2 displayed text, may be empty; $3 = Barcodetype, needed if $2#""
  //  //  $4 optional: longint with chart area
  //  // this allows to reuse the same chart area several time. Always clear it (CT NEW Document).
  //  // this speeds up to create many barcodes
  //  // example (2400 MHZ AMD, compiled, 1000 x EAN13, 3225 ticks to 1232 ticks)

  //C_TEXT($Pattern;$1)
  //$Pattern:=$1
  //C_TEXT($ShowText;$2)
  //$ShowText:=$2
  //C_TEXT($BarcodeType;$3)
  //$BarcodeType:=$3

  //C_PICTURE($Code;$0)
  //_o_C_STRING(5;$EAN;$line)
  //C_LONGINT($distance;$x;$y;$middlex;$i;$count;$y2;$x2;$object)
  //C_TEXT($text)

  //C_LONGINT($l_ChartAreaRef)  //ABK 20110822: uso una variable interproceso para reutilizar la misma referencia de área offscreen
  //  //ABK 20110822: abandonado
  //  //If (Count parameters=4) 
  //  //$chart:=$4
  //  //End if 

  //$l_ChartAreaRef:=Ô14500;10Ô 
  //  //If ($l_ChartAreaRef=0)
  //  //
  //  //Else 
  //  //CT NEW DOCUMENT ($l_ChartAreaRef)
  //  //End if 

  //  // <>vl_ChartRef:=Open external window(50;50;500;500;0;"test";"_4D Chart")  ` for debugging

  //$distance:=Barcode_Width*2  // used to move the text beyond the code

  //If ($BarcodeType="Supplemental@")
  //$y:=Barcode_FontSize+Barcode_FontOffset
  //Else 
  //$y:=1
  //End if 
  //If (($BarcodeType="EAN13") | ($BarcodeType="UPC@"))
  //$x:=Barcode_FontSize
  //Else 
  //$x:=1
  //End if 
  //$i:=1
  //$middlex:=0

  //$pattern:=$pattern+"X"  // end of code, to make looping easier
  //While ($i<Length($pattern))
  //$count:=0
  //$line:=$pattern[[$i]]
  //  // check if similar are following
  //While ($line=$pattern[[$i+1]])  // we cannot go longer than the string, thanks to "X"
  //$count:=$count+1
  //$i:=$i+1
  //End while 

  //Case of 
  //: (($line="1") | ($line="2"))
  //If ($line="2")
  //If (($x>(Barcode_FontSize+10)) & ($middlex=0))
  //$middlex:=$x
  //End if 
  //$y2:=$y+Barcode_Height+Barcode_Add
  //Else 
  //$y2:=$y+Barcode_Height
  //End if 

  //If (($count=0) & (Barcode_Width=1))
  //$x2:=$x
  //$object:=Ô14500;59Ô ($l_ChartAreaRef;$x;$y;$x2;$y2;0)
  //Ô14500;72Ô ($l_ChartAreaRef;$object;3;Ô14500;80Ô (16);1)
  //Else 
  //$x2:=$x+($count*Barcode_Width)+Barcode_Width-1
  //$object:=Ô14500;60Ô ($l_ChartAreaRef;$x;$y;$x2;$y2;0)
  //Ô14500;74Ô ($l_ChartAreaRef;$object;3;Ô14500;80Ô (16))
  //  // CT Draw rectangle (Bereich;Links;Oben;Rechts;Unten;Abgerundet)Lange Ganzzahl
  //End if 

  //: ($line="0")  // White, don't draw 
  //$x2:=$x+($count*Barcode_Width)+Barcode_Width-1

  //End case 
  //$x:=$x2+1

  //$i:=$i+1
  //End while 

  //If ($ShowText#"")
  //Case of 
  //: (($BarcodeType="EAN@") | ($BarcodeType="UPC@"))
  //$y:=$y+Barcode_Height
  //: ($BarcodeType="Supplemental@")
  //$y:=1
  //Else 
  //$y:=$y+Barcode_Height+Barcode_Add
  //End case 
  //$y2:=$y+Barcode_FontSize+Barcode_FontOffset
  //$x:=1
  //Case of 
  //: ($BarcodeType="UPC-E")
  //$text:=Substring($ShowText;1;1)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x;$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;2;6)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x+Barcode_FontSize+($distance+$distance);$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;8;1)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x2+2;$y;$x2+(Barcode_FontSize*2);$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)

  //: ($BarcodeType="UPC-A")
  //$text:=Substring($ShowText;1;1)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x;$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;2;5)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x+Barcode_FontSize+($distance+$distance);$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;7;5)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$middlex+($distance+$distance);$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;12;1)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x2+2;$y;$x2+(Barcode_FontSize*2);$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)

  //: ($BarcodeType="EAN8")
  //$text:=Substring($ShowText;1;4)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x+$distance;$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;5;4)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$middlex+($distance*2);$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)

  //: ($BarcodeType="EAN13")
  //$text:=Substring($ShowText;1;1)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x;$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;2;6)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x+Barcode_FontSize+($distance+$distance);$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //$text:=Substring($ShowText;8;6)
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$middlex+($distance+$distance);$y;$x2;$y2;$text)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);0)
  //Else 
  //$object:=Ô14500;58Ô ($l_ChartAreaRef;$x;$y;$x2;$y2;$ShowText)
  //Ô14500;70Ô ($l_ChartAreaRef;$object;Ô14500;85Ô (Barcode_Font);Barcode_FontSize;0;Ô14500;80Ô (16);1)
  //End case 
  //End if 

  //Ô14500;75Ô ($l_ChartAreaRef;-1;1)
  //$code:=Ô14500;9Ô ($l_ChartAreaRef;0)  // should work?


  //  // ABK 20110822: no elimino el area offscreen (CT DELETE OFFSCREEN AREA), la inicializo para que pueda ser reutilizada
  //  // el area es eliminada al salir de la aplicación (on Exit, on Server
  //  //CT NEW DOCUMENT ($l_ChartAreaRef)  
  //  // CT DO COMMAND ($l_ChartAreaRef;2004)
  //  //If (Count parameters<4)
  //Ô14500;11Ô ($l_ChartAreaRef)
  //  //End if 



  //  // GET PICTURE FROM CLIPBOARD($code)
  //$0:=$code