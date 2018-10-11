//%attributes = {}
  //ST_Lowercase

$text:=$1
$lowercaseText:=Lowercase:C14($text;*)
  //For ($i;1;Length($text))
  //Case of 
  //: (Character code($text≤$i≥)<127)
  //$lowercaseText:=$lowercaseText+Lowercase($text≤$i≥)
  //: (Character code($text≤$i≥)=Character code("Á"))
  //$lowercaseText:=$lowercaseText+"á"
  //: (Character code($text≤$i≥)=Character code("É"))
  //$lowercaseText:=$lowercaseText+"é"
  //: (Character code($text≤$i≥)=Character code("Í"))
  //$lowercaseText:=$lowercaseText+"í"
  //: (Character code($text≤$i≥)=Character code("Ó"))
  //$lowercaseText:=$lowercaseText+"ó"
  //: (Character code($text≤$i≥)=Character code("Ú"))
  //$lowercaseText:=$lowercaseText+"ú"
  //: (Character code($text≤$i≥)=Character code("À"))
  //$lowercaseText:=$lowercaseText+"à"
  //: (Character code($text≤$i≥)=Character code("È"))
  //$lowercaseText:=$lowercaseText+"è"
  //: (Character code($text≤$i≥)=Character code("Ì"))
  //$lowercaseText:=$lowercaseText+"ì"
  //: (Character code($text≤$i≥)=Character code("Ò"))
  //$lowercaseText:=$lowercaseText+"ò"
  //: (Character code($text≤$i≥)=Character code("Ù"))
  //$lowercaseText:=$lowercaseText+"ù"
  //: (Character code($text≤$i≥)=Character code("Ä"))
  //$lowercaseText:=$lowercaseText+"ä"
  //: (Character code($text≤$i≥)=Character code("Ë"))
  //$lowercaseText:=$lowercaseText+"ë"
  //: (Character code($text≤$i≥)=Character code("Ï"))
  //$lowercaseText:=$lowercaseText+"ï"
  //: (Character code($text≤$i≥)=Character code("Ö"))
  //$lowercaseText:=$lowercaseText+"ö"
  //: (Character code($text≤$i≥)=Character code("Ü"))
  //$lowercaseText:=$lowercaseText+"ù"
  //: (Character code($text≤$i≥)=Character code("Â"))
  //$lowercaseText:=$lowercaseText+"â"
  //: (Character code($text≤$i≥)=Character code("Ê"))
  //$lowercaseText:=$lowercaseText+"ê"
  //: (Character code($text≤$i≥)=Character code("Î"))
  //$lowercaseText:=$lowercaseText+"î"
  //: (Character code($text≤$i≥)=Character code("Ô"))
  //$lowercaseText:=$lowercaseText+"ô"
  //: (Character code($text≤$i≥)=Character code("Û"))
  //$lowercaseText:=$lowercaseText+"ü"
  //: (Character code($text≤$i≥)=Character code("Ñ"))
  //$lowercaseText:=$lowercaseText+"ñ"
  //: (Character code($text≤$i≥)=Character code("Ç"))
  //$lowercaseText:=$lowercaseText+"ç"
  //: (Character code($text≤$i≥)=Character code("Œ"))
  //$lowercaseText:=$lowercaseText+"œ"
  //: (Character code($text≤$i≥)=Character code("Å"))
  //$lowercaseText:=$lowercaseText+"å"
  //: (Character code($text≤$i≥)=217)
  //$lowercaseText:=$lowercaseText+Char(216)
  //Else 
  //$lowercaseText:=$lowercaseText+Lowercase($text≤$i≥)
  //End case 
  //End for 
$0:=$lowercaseText