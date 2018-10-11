//%attributes = {}
  //IT_MODIFIERS

<>Command:=(Macintosh command down:C546 | Windows Ctrl down:C562)
<>Shift:=Shift down:C543
<>CapsLock:=Caps lock down:C547
<>Option:=(Macintosh option down:C545 | Windows Alt down:C563)
<>Control:=Macintosh control down:C544
GET MOUSE:C468($vlMouseX;$vlMouseY;<>MouseButton)
