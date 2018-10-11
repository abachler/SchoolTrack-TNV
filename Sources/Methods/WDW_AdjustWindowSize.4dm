//%attributes = {}
  // WDW_AdjustWindowSize()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 06/01/13, 18:50:36
  // ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_bottom;$l_currentHeigth;$l_currentwidth;$l_left;$l_newHeight;$l_newWidth;$l_resizeBy;$l_right;$l_top)

If (False:C215)
	C_LONGINT:C283(WDW_AdjustWindowSize ;$1)
	C_LONGINT:C283(WDW_AdjustWindowSize ;$2)
	C_LONGINT:C283(WDW_AdjustWindowSize ;$3)
End if 

  // CÓDIGO
$l_newWidth:=$1
$l_newHeight:=$2

If (Count parameters:C259=3)
	$l_resizeBy:=$3
End if 

If ($l_resizeBy=0)
	$l_resizeBY:=Choose:C955($l_newWidth>$l_newHeight;$l_newWidth;$l_newHeight)
End if 




SCREEN COORDINATES:C438($l_limiteIzquierdo;$l_limiteSuperior;$l_LimiteDerecho;$l_limiteInferior)
$l_limiteSuperior:=$l_limiteSuperior+Menu bar height:C440+20
GET WINDOW RECT:C443($l_left;$l_top;$l_right;$l_bottom)
$l_currentwidth:=$l_right-$l_left
$l_currentHeigth:=$l_bottom-$l_top



Repeat 
	Case of 
		: ($l_currentHeigth<$l_newHeight)
			$l_bottom:=$l_bottom+$l_resizeBy
			If ($l_top<$l_limiteSuperior)
				$l_top:=$l_limiteSuperior
			End if 
			$l_currentHeigth:=$l_bottom+$l_top
			If ($l_currentHeigth>$l_newHeight)
				$l_currentHeigth:=$l_newHeight
				$l_Bottom:=$l_top+$l_newHeight
			End if 
			Case of 
				: (($l_bottom<$l_limiteInferior) & ($l_top>$l_limiteSuperior))
					SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
					$l_currentHeigth:=$l_bottom-$l_top
				: ($l_bottom<$l_limiteInferior)
					$l_top:=$l_top+$l_resizeBy
					SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
					$l_currentHeigth:=$l_bottom-$l_top
				: ($l_bottom>$l_limiteInferior)
					$l_bottom:=$l_bottom+$l_resizeBy
					SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
					$l_currentHeigth:=$l_bottom-$l_top
				Else 
					$l_currentHeigth:=$l_newHeight
			End case 
		: ($l_currentHeigth>$l_newHeight)
			$l_bottom:=$l_bottom-$l_resizeBy
			$l_top:=$l_top-$l_resizeBy
			$l_currentHeigth:=$l_bottom-$l_top
			If ($l_currentHeigth<$l_newHeight)
				$l_currentHeigth:=$l_newHeight
			End if 
			SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
	End case 
	Case of 
		: ($l_currentwidth<$l_newWidth)
			$l_left:=$l_left-$l_resizeBy
			$l_right:=$l_right+$l_resizeBy
			$l_currentWidth:=$l_right+$l_left
			If ($l_currentWidth>$l_newWidth)
				$l_currentWidth:=$l_newWidth
				$l_right:=$l_left+$l_newWidth
			End if 
			Case of 
				: (($l_left>$l_limiteIzquierdo) & ($l_right<$l_LimiteDerecho))
					SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
					$l_currentWidth:=$l_right+$l_left
				: ($l_right<$l_limiteDerecho)
					$l_left:=$l_left+$l_resizeBy
					SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
					$l_currentWidth:=$l_right+$l_left
				: ($l_right>$l_limiteDerecho)
					$l_right:=$l_right-$l_resizeBy
					SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
					$l_currentWidth:=$l_right-$l_left
				Else 
					$l_currentWidth:=$l_newWidth
			End case 
		: ($l_currentwidth>$l_newWidth)
			$l_left:=$l_left+$l_resizeBy
			$l_right:=$l_right-$l_resizeBy
			$l_currentWidth:=$l_right-$l_left
			If ($l_currentWidth<$l_newWidth)
				$l_currentWidth:=$l_newWidth
			End if 
			SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_bottom)
	End case 
Until (($l_currentwidth>=$l_newWidth) & ($l_currentHeigth>=$l_newHeight))

SET WINDOW RECT:C444($l_left;$l_top;$l_left+$l_newWidth;$l_top+$l_newHeight)