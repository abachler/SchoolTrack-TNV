//%attributes = {}
  //ST_Uppercase

$text:=$1
$uppercaseText:=Uppercase:C13($text;*)
  //For ($i;1;Length($text))
  //Case of 
  //: (Character code($text≤$i≥)<127)
  //$uppercaseText:=$uppercaseText+Uppercase($text≤$i≥)
  //: ((Character code($text≤$i≥)=Character code("á")) | (Character code($text≤$i≥)=Character code("Á")))
  //$uppercaseText:=$uppercaseText+"Á"
  //: ((Character code($text≤$i≥)=Character code("é")) | (Character code($text≤$i≥)=Character code("É")))
  //$uppercaseText:=$uppercaseText+"É"
  //: ((Character code($text≤$i≥)=Character code("í")) | (Character code($text≤$i≥)=Character code("Í")))
  //$uppercaseText:=$uppercaseText+"Í"
  //: ((Character code($text≤$i≥)=Character code("ó")) | (Character code($text≤$i≥)=Character code("Ó")))
  //$uppercaseText:=$uppercaseText+"Ó"
  //: ((Character code($text≤$i≥)=Character code("ú")) | (Character code($text≤$i≥)=Character code("Ú")))
  //$uppercaseText:=$uppercaseText+"Ú"
  //: ((Character code($text≤$i≥)=Character code("à")) | (Character code($text≤$i≥)=Character code("À")))
  //$uppercaseText:=$uppercaseText+"À"
  //: ((Character code($text≤$i≥)=Character code("è")) | (Character code($text≤$i≥)=Character code("È")))
  //$uppercaseText:=$uppercaseText+"È"
  //: ((Character code($text≤$i≥)=Character code("ì")) | (Character code($text≤$i≥)=Character code("Ì")))
  //$uppercaseText:=$uppercaseText+"Ì"
  //: ((Character code($text≤$i≥)=Character code("ò")) | (Character code($text≤$i≥)=Character code("Ò")))
  //$uppercaseText:=$uppercaseText+"Ò"
  //: ((Character code($text≤$i≥)=Character code("ù")) | (Character code($text≤$i≥)=Character code("Ù")))
  //$uppercaseText:=$uppercaseText+"Ù"
  //: ((Character code($text≤$i≥)=Character code("ä")) | (Character code($text≤$i≥)=Character code("Ä")))
  //$uppercaseText:=$uppercaseText+"Ä"
  //: ((Character code($text≤$i≥)=Character code("ë")) | (Character code($text≤$i≥)=Character code("Ë")))
  //$uppercaseText:=$uppercaseText+"Ë"
  //: ((Character code($text≤$i≥)=Character code("ï")) | (Character code($text≤$i≥)=Character code("Ï")))
  //$uppercaseText:=$uppercaseText+"Ï"
  //: ((Character code($text≤$i≥)=Character code("ö")) | (Character code($text≤$i≥)=Character code("Ö")))
  //$uppercaseText:=$uppercaseText+"Ö"
  //: ((Character code($text≤$i≥)=Character code("ü")) | (Character code($text≤$i≥)=Character code("Ü")))
  //$uppercaseText:=$uppercaseText+"Ü"
  //: ((Character code($text≤$i≥)=Character code("â")) | (Character code($text≤$i≥)=Character code("Â")))
  //$uppercaseText:=$uppercaseText+"Â"
  //: ((Character code($text≤$i≥)=Character code("ê")) | (Character code($text≤$i≥)=Character code("Ê")))
  //$uppercaseText:=$uppercaseText+"Ê"
  //: ((Character code($text≤$i≥)=Character code("î")) | (Character code($text≤$i≥)=Character code("Î")))
  //$uppercaseText:=$uppercaseText+"Î"
  //: ((Character code($text≤$i≥)=Character code("ô")) | (Character code($text≤$i≥)=Character code("Ô")))
  //$uppercaseText:=$uppercaseText+"Ô"
  //: ((Character code($text≤$i≥)=Character code("û")) | (Character code($text≤$i≥)=Character code("Û")))
  //$uppercaseText:=$uppercaseText+"Û"
  //: ((Character code($text≤$i≥)=Character code("ñ")) | (Character code($text≤$i≥)=Character code("Ñ")))
  //$uppercaseText:=$uppercaseText+"Ñ"
  //: ((Character code($text≤$i≥)=Character code("ç")) | (Character code($text≤$i≥)=Character code("Ç")))
  //$uppercaseText:=$uppercaseText+"Ç"
  //: ((Character code($text≤$i≥)=Character code("œ")) | (Character code($text≤$i≥)=Character code("Œ")))
  //$uppercaseText:=$uppercaseText+"Œ"
  //: ((Character code($text≤$i≥)=Character code("å")) | (Character code($text≤$i≥)=Character code("Å")))
  //$uppercaseText:=$uppercaseText+"Å"
  //: (Character code($text≤$i≥)=216)
  //$uppercaseText:=$uppercaseText+Char(217)
  //Else 
  //$uppercaseText:=$uppercaseText+Uppercase($text≤$i≥)
  //End case 
  //End for 
$0:=$uppercaseText