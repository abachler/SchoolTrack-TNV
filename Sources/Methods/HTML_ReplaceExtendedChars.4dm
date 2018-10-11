//%attributes = {}
  //HTML_ReplaceExtendedChars

C_TEXT:C284($text;$1;$0)
$text:=$1

$text:=Replace string:C233($text;"á";ISO L1 a acute:K32:39;*)
$text:=Replace string:C233($text;"â";ISO L1 a circumflex:K32:40;*)
$text:=Replace string:C233($text;"à";ISO L1 a grave:K32:38;*)
$text:=Replace string:C233($text;"å";ISO L1 a ring:K32:43;*)
$text:=Replace string:C233($text;"ã";ISO L1 a tilde:K32:41;*)
$text:=Replace string:C233($text;"ä";ISO L1 a umlaut:K32:42;*)

$text:=Replace string:C233($text;"æ";ISO L1 ae ligature:K32:44;*)

$text:=Replace string:C233($text;"ç";ISO L1 c cedilla:K32:45;*)

$text:=Replace string:C233($text;"Á";ISO L1 Cap A acute:K32:8;*)
$text:=Replace string:C233($text;"Â";ISO L1 Cap A circumflex:K32:9;*)
$text:=Replace string:C233($text;"Å";ISO L1 Cap A ring:K32:12;*)
$text:=Replace string:C233($text;"Ã";ISO L1 Cap A tilde:K32:10;*)
$text:=Replace string:C233($text;"Ä";ISO L1 Cap A umlaut:K32:11;*)

$text:=Replace string:C233($text;"Æ";ISO L1 Cap AE ligature:K32:13;*)

$text:=Replace string:C233($text;"Ç";ISO L1 Cap C cedilla:K32:14;*)

$text:=Replace string:C233($text;"É";ISO L1 Cap E acute:K32:16;*)
$text:=Replace string:C233($text;"Ê";ISO L1 Cap E circumflex:K32:17;*)
$text:=Replace string:C233($text;"È";ISO L1 Cap E grave:K32:15;*)
$text:=Replace string:C233($text;"Ë";ISO L1 Cap E umlaut:K32:18;*)

$text:=Replace string:C233($text;"Í";ISO L1 Cap I acute:K32:20;*)
$text:=Replace string:C233($text;"Î";ISO L1 Cap I circumflex:K32:21;*)
$text:=Replace string:C233($text;"Ì";ISO L1 Cap I grave:K32:19;*)
$text:=Replace string:C233($text;"Ï";ISO L1 Cap I umlaut:K32:22;*)

$text:=Replace string:C233($text;"Ñ";ISO L1 Cap N tilde:K32:24;*)

$text:=Replace string:C233($text;"Ó";ISO L1 Cap O acute:K32:26;*)
$text:=Replace string:C233($text;"Ô";ISO L1 Cap O circumflex:K32:27;*)
$text:=Replace string:C233($text;"Ò";ISO L1 Cap O grave:K32:25;*)
$text:=Replace string:C233($text;"Ø";ISO L1 Cap O slash:K32:30;*)
$text:=Replace string:C233($text;"Õ";ISO L1 Cap O tilde:K32:28;*)
$text:=Replace string:C233($text;"Ö";ISO L1 Cap O umlaut:K32:29;*)

$text:=Replace string:C233($text;"Ú";ISO L1 Cap U acute:K32:32;*)
$text:=Replace string:C233($text;"Û";ISO L1 Cap U circumflex:K32:33;*)
$text:=Replace string:C233($text;"Ù";ISO L1 Cap U grave:K32:31;*)
$text:=Replace string:C233($text;"Ü";ISO L1 Cap U umlaut:K32:34;*)

$text:=Replace string:C233($text;"©";ISO L1 Copyright:K32:5;*)

$text:=Replace string:C233($text;"é";ISO L1 e acute:K32:47;*)
$text:=Replace string:C233($text;"ê";ISO L1 e circumflex:K32:48;*)
$text:=Replace string:C233($text;"è";ISO L1 e grave:K32:46;*)
$text:=Replace string:C233($text;"ë";ISO L1 e umlaut:K32:49;*)

$text:=Replace string:C233($text;"í";ISO L1 i acute:K32:51;*)
$text:=Replace string:C233($text;"î";ISO L1 i circumflex:K32:52;*)
$text:=Replace string:C233($text;"ì";ISO L1 i grave:K32:50;*)
$text:=Replace string:C233($text;"ï";ISO L1 i umlaut:K32:53;*)

$text:=Replace string:C233($text;"ñ";ISO L1 n tilde:K32:55;*)

$text:=Replace string:C233($text;"ó";ISO L1 o acute:K32:57;*)
$text:=Replace string:C233($text;"ô";ISO L1 o circumflex:K32:58;*)
$text:=Replace string:C233($text;"ò";ISO L1 o grave:K32:56;*)
$text:=Replace string:C233($text;"ø";ISO L1 o slash:K32:61;*)
$text:=Replace string:C233($text;"õ";ISO L1 o tilde:K32:59;*)
$text:=Replace string:C233($text;"ö";ISO L1 o umlaut:K32:60;*)

$text:=Replace string:C233($text;"®";ISO L1 Registered:K32:6;*)

$text:=Replace string:C233($text;"ß";ISO L1 sharp s German:K32:37;*)

$text:=Replace string:C233($text;"ú";ISO L1 u acute:K32:63;*)
$text:=Replace string:C233($text;"û";ISO L1 u circumflex:K32:64;*)
$text:=Replace string:C233($text;"ù";ISO L1 u grave:K32:62;*)
$text:=Replace string:C233($text;"ü";ISO L1 u umlaut:K32:65;*)

$text:=Replace string:C233($text;"ÿ";ISO L1 y umlaut:K32:68;*)

$text:=Replace string:C233($text;"°";"&deg")

$0:=$text


  //  `HTML_ReplaceExtendedChars
  //
  //C_TEXT($text;$1;$0)
  //$text:=$1
  //
  //If (SYS_IsWindows )
  //$text:=Win to Mac($text)
  //End if 
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;135;ISO L1 a acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;137;ISO L1 a circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;136;ISO L1 a grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;140;ISO L1 a ring )
  //$text:=HTML_ReplaceExtendedCharacter ($text;139;ISO L1 a tilde )
  //$text:=HTML_ReplaceExtendedCharacter ($text;138;ISO L1 a umlaut )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;190;ISO L1 ae ligature )
  //
  //  `$text:=Replace string($text;Char(38);ISO L1 Ampersand )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;141;ISO L1 c cedilla )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;231;ISO L1 Cap A acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;229;ISO L1 Cap A circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;129;ISO L1 Cap A ring )
  //$text:=HTML_ReplaceExtendedCharacter ($text;204;ISO L1 Cap A tilde )
  //$text:=HTML_ReplaceExtendedCharacter ($text;128;ISO L1 Cap A umlaut )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;174;ISO L1 Cap AE ligature )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;130;ISO L1 Cap C cedilla )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;131;ISO L1 Cap E acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;230;ISO L1 Cap E circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;233;ISO L1 Cap E grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;232;ISO L1 Cap E umlaut )
  //
  //  `$text:=Replace string(Char();ISO L1 Cap Eth Icelandic )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;234;ISO L1 Cap I acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;235;ISO L1 Cap I circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;237;ISO L1 Cap I grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;236;ISO L1 Cap I umlaut )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;132;ISO L1 Cap N tilde )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;238;ISO L1 Cap O acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;239;ISO L1 Cap O circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;241;ISO L1 Cap O grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;175;ISO L1 Cap O slash )
  //$text:=HTML_ReplaceExtendedCharacter ($text;205;ISO L1 Cap O tilde )
  //$text:=HTML_ReplaceExtendedCharacter ($text;133;ISO L1 Cap O umlaut )
  //
  //  `$text:=Replace string(Char();ISO L1 Cap THORN Icelandic )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;242;ISO L1 Cap U acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;243;ISO L1 Cap U circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;244;ISO L1 Cap U grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;134;ISO L1 Cap U umlaut )
  //
  //  `$text:=Replace string(Char();ISO L1 Cap Y acute )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;169;ISO L1 Copyright )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;142;ISO L1 e acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;144;ISO L1 e circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;143;ISO L1 e grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;145;ISO L1 e umlaut )
  //
  //  `$text:=Replace string(Char();ISO L1 eth Icelandic )
  //
  //  `$text:=Replace string(Char();ISO L1 Greater than )  `esta no
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;146;ISO L1 i acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;148;ISO L1 i circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;147;ISO L1 i grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;149;ISO L1 i umlaut )
  //
  //  `$text:=Replace string(Char();ISO L1 Less than )  `esta no
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;150;ISO L1 n tilde )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;151;ISO L1 o acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;153;ISO L1 o circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;152;ISO L1 o grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;191;ISO L1 o slash )
  //$text:=HTML_ReplaceExtendedCharacter ($text;155;ISO L1 o tilde )
  //$text:=HTML_ReplaceExtendedCharacter ($text;154;ISO L1 o umlaut )
  //
  //  `$text:=Replace string(Char();ISO L1 Quotation mark )  `esta no
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;168;ISO L1 Registered )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;167;ISO L1 sharp s German )
  //
  //  `$text:=Replace string(Char();ISO L1 thorn Icelandic )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;156;ISO L1 u acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;158;ISO L1 u circumflex )
  //$text:=HTML_ReplaceExtendedCharacter ($text;157;ISO L1 u grave )
  //$text:=HTML_ReplaceExtendedCharacter ($text;159;ISO L1 u umlaut )
  //
  //  `$text:=Replace string(Char();ISO L1 y acute )
  //$text:=HTML_ReplaceExtendedCharacter ($text;216;ISO L1 y umlaut )
  //
  //$text:=HTML_ReplaceExtendedCharacter ($text;161;"&deg")
  //
  //$0:=$text