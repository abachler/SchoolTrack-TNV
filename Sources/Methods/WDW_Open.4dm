//%attributes = {}
  //WDW_Open

If (False:C215)
	  //Method: wdw_Open
	  //Written by  Alberto Bachler on 01/01/92
	  //Purpose: open new window
	  //Parameters:
	  //   $1=width; $2=height; $3=position; $4=type; $5=name $6=close proc
	  //Syntax:  wdw_Open(width;height;position;type;name;close proc)
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
	  //Programming style conventions applied
	  //return window reference (for use only in v6)
End if 


  //DECLARATIONS
C_LONGINT:C283($1;$2;$3;$4;$sh;$sw;$x1;$y1;$x2;$y2;$winWidth;$winPosition;$winType;$toolBar;$mseX;$mseY;$btn)
_O_C_STRING:C293(35;$closeMethod)
_O_C_STRING:C293(255;$5;$winTitle)

  //INITIALIZATION
$pars:=Count parameters:C259

If (($3=8) | ($3=9) | ($3<0))
	GET WINDOW RECT:C443($left;$top;$sw;$sh;Frontmost window:C447)
	If ((Undefined:C82($left)) & (Undefined:C82($top)) & (Undefined:C82($sw)) & (Undefined:C82($sh)))
		$sh:=Screen height:C188
		$sw:=Screen width:C187
	Else 
		If (($left=0) & ($top=0) & ($sw=0) & ($sh=0))
			$sh:=Screen height:C188
			$sw:=Screen width:C187
		End if 
	End if 
	$winPosition:=$3
Else 
	$sh:=Screen height:C188
	$sw:=Screen width:C187
	$winPosition:=$3
End if 

$toolBar:=0
$toolBar:=0
$winWidth:=$1
$winHeight:=$2

$winType:=0
$winTitle:=""
$closeMethod:=""
If ($pars>=4)
	$winType:=$4
	If ($pars>=5)
		$winTitle:=$5
		If ($pars=6)
			$closeMethod:=$6
		End if 
	End if 
End if 



  //MAIN CODE
If ($winType=4)  //forcing type 8 (with zoom box) when type 4 is requested
	  //$winType:=4
End if 
If ($winType=5)
	  //$winType:=-1984
End if 
$absWinType:=Abs:C99($winType)
Case of   //setting windows coordinates
	: (($winType=0) | ($absWinType=4) | ($absWinType=8) | ($winType=16))
		$winLeft:=4
		$winTop:=50+$toolBar
		$winRight:=$sw
		$winBottom:=$sh
	: ($winType=1)
		$winLeft:=10
		$winTop:=30+$toolBar
		$winRight:=$sw-10
		$winBottom:=$sh-10
	: ($winType=2)
		$winLeft:=3
		$winTop:=3+$toolBar
		$winRight:=$sw-3
		$winBottom:=$sh-3
	: ($winType=3)
		$winLeft:=3
		$winTop:=3+$toolBar
		$winRight:=$sw-10
		$winBottom:=$sh-10
	: ($winType=5)
		$winLeft:=10
		$winTop:=46+$toolBar
		$winRight:=$sw-10
		$winBottom:=$sh-10
	: ((($absWinType>=Palette form window:K39:9) & ($absWinType<=1999)) | (($absWinType>=700) & ($absWinType<=799)) | (($absWinType>=14000) & ($absWinType<=14015)))
		$winLeft:=3
		$winTop:=36+$toolBar
		$winRight:=$sw
		$winBottom:=$sh
		If ($winType<0)
			$winTYpe:=-1984
		Else 
			$winTYpe:=$absWinType  //1984
		End if 
	Else 
		$winLeft:=10
		$winTop:=46+$toolBar
		$winRight:=$sw
		$winBottom:=$sh
End case 

Case of   //setting window position
	: ($winPosition=-2)  //Center on screen (jhb)
		$w:=Screen width:C187
		$h:=Screen height:C188
		$x1:=($w\2)-($winWidth/2)
		$y1:=($h\2)-($winHeight/2)
		$x2:=($w\2)+($winWidth/2)
		$y2:=($h\2)+($winHeight/2)
	: ($winPosition=0)  //Centered     modificación especial para SCHOOLTRACK
		$width:=Screen width:C187
		$height:=Screen height:C188
		If ($width>=792)
			$w:=792
			$h:=520
		Else 
			$w:=624
			$h:=410
		End if 
		$x1:=($w\2)-($winWidth/2)
		$y1:=($h\2)-($winHeight/2)
		$x2:=($w\2)+($winWidth/2)
		$y2:=($h\2)+($winHeight/2)
		
	: ($winPosition=1)  //Stacked    
		GET WINDOW RECT:C443($left;$top;$right;$bottom)
		$offsetW:=$left+24
		$offsetH:=$top+15
		If (($winWidth+$offsetW)>$sw) | (($winHeight+$offsetH)>$sh)
			  //the window would open off screen, so reset to the upper left
			$offsetW:=2
			$offsetH:=40+$toolBar
		End if 
		$x1:=$offsetW
		$y1:=$offsetH
		$x2:=$winWidth+$offsetW
		$y2:=$winHeight+$offsetH
		
		
	: ($winPosition=2)  //Upper left corner
		$x1:=$winLeft
		$y1:=$winTop
		$x2:=$x1+$winWidth
		$y2:=$y1+$winHeight
		
	: ($winPosition=3)  //Upper right corner
		$x1:=$sw-$winWidth-10
		$y1:=$winTop
		$x2:=$x1+$winWidth
		$y2:=$y1+$winHeight
		
	: ($winPosition=4)  //Lower left corner
		$x1:=2
		$y1:=$sh-$winHeight-20
		$x2:=$x1+$winWidth
		$y2:=$y1+$winHeight
		
	: ($winPosition=5)  //Lower right corner
		$x1:=$sw-$winWidth-20
		$y1:=$sh-$winHeight-20
		$x2:=$x1+$winWidth
		$y2:=$y1+$winHeight
		
	: ($winPosition=6)  //1/3 from top & centered (courtesy of Vance Miller)
		$sh:=$sh\3
		$sw:=$sw\3
		$x1:=$sw-($winWidth\2)
		$y1:=$sh-($winHeight\2)
		$x2:=$sw+($winWidth\2)
		$y2:=$sh+($winHeight\2)
		
	: ($winPosition=7)  //Click related (courtesy of Alberto Bächler)
		
		GET MOUSE:C468($mseX;$mseY;$btn;*)
		$mseX:=$mseX+10
		$mseY:=$mseY+10
		  //  $x1:=mseX-($winWidth)+<>winX
		$x1:=$mseX-($winWidth)
		$x1:=$mseX
		$x2:=$x1+$winWidth
		  //$y1:=mseY+<>winY+20+$toolBar
		$y1:=$mseY
		$y2:=$y1+$winHeight
		If ($x1<$sw)
			$x1:=$mseX
			$x2:=$x1+$winWidth
		End if 
		If ($x2>$sw)
			$x1:=$sw-$winWidth
			$x2:=$x1+$winWidth
		End if 
		If ($y1<($sh))
			$y1:=$mseY
			$y2:=$Y1+$winHeight
		End if 
		If ($y2>$sh)
			$y1:=$sh-$winHeight
			$y2:=$y1+$winHeight
		End if 
		
	: ($winPosition=8)  //Upper right related to window (courtesy of Alberto Bächler)
		$x1:=$sw-$winWidth-70
		$y1:=$winTop
		$x2:=$x1+$winWidth
		$y2:=$y1+$winHeight
	: ($winPosition=9)  //Lower right related to window (courtesy of Alberto Bächler)
		$x1:=$sw-$winWidth
		$y1:=$sh-$winHeight
		$x2:=$x1+$winWidth
		$y2:=$y1+$winHeight
		
	: ($winPosition=10)  //Top, centered horizontally on parent window
		GET WINDOW RECT:C443($left;$top;$sw;$sh;Frontmost window:C447)
		$x1:=(($sw-$left)/2)-($winWidth/2)+$left
		$x2:=(($sw-$left)/2)+($winWidth/2)
		$y1:=$top
		$y2:=(($sh-$top)/2)+($winHeight/2)
		
	: ($winposition=-1)  //centered over parent window
		$x1:=(($sw-$left)/2)-($winWidth/2)+$left
		$x2:=(($sw-$left)/2)+($winWidth/2)+$left
		$y1:=(($sh-$top)/2)-($winHeight/2)+$top
		$y2:=(($sh-$top)/2)+($winHeight/2)+$top
End case 


If ($y1<$winTop)
	$y1:=$winTop
	$y2:=$y1+$winHeight
End if 
If ($y2>$winBottom)
	$y2:=$winBottom
End if 
If ($x1<$winLeft)
	$x1:=$winLeft
	$x2:=$x1+$winWidth
End if 
If ($x2>$winRight)
	$x2:=$winRight
End if 

If (Window kind:C445(Frontmost window:C447)=Modal dialog:K27:2)
	$winType:=1
End if 

Case of 
	: ($pars=3)
		$0:=Open window:C153($x1;$y1;$x2;$y2)
	: ($pars=4)
		$0:=Open window:C153($x1;$y1;$x2;$y2;$winType)
	: ($pars=5)
		$0:=Open window:C153($x1;$y1;$x2;$y2;$winType;$winTitle)
	: ($pars=6)
		$0:=Open window:C153($x1;$y1;$x2;$y2;$winType;$winTitle;$closeMethod)
End case 
  //END OF METHOD 
WDW_SetWindowIcon ($0)