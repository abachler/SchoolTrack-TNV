//%attributes = {}
  //SYS_ModifyRGBColor

C_LONGINT:C283($0;$1;$2;$rgb_i;$change_i;$red_i;$green_i;$blue_i)

$rgb_i:=$1
$change_i:=$2

  // Get the individual RGB values.
$red_i:=(($rgb_i >> 16) & 0x00FF)  // get the blue byte, 0..255
$green_i:=(($rgb_i >> 8) & 0x00FF)  // get the green byte, 0..255
$blue_i:=($rgb_i & 0x00FF)  // get the red byte, 0..255

  // Modify the individual colors.
$red_i:=$red_i+$change_i
Case of 
	: ($red_i<0x0000)
		$red_i:=0x0000
	: ($red_i>0x00FF)
		$red_i:=0x00FF
End case 

$green_i:=$green_i+$change_i
Case of 
	: ($green_i<0x0000)
		$green_i:=0x0000
	: ($green_i>0x00FF)
		$green_i:=0x00FF
End case 

$blue_i:=$blue_i+$change_i
Case of 
	: ($blue_i<0x0000)
		$blue_i:=0x0000
	: ($blue_i>0x00FF)
		$blue_i:=0x00FF
End case 

  // Combine them into a single RGB value again.
$rgb_i:=($red_i << 16)+($green_i << 8)+$blue_i
$0:=$rgb_i