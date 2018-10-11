//%attributes = {}
  //WDW_ExpandVertically


C_BOOLEAN:C305(vb_WindowsExpanded)
C_LONGINT:C283($grow;$left;top;$right;$bottom;$i)
$grow:=Abs:C99($1)  //numero de pixeles a expandir/colapsar. 

If (Not:C34(vb_WindowsExpanded))  //<---- para saber si estamos expandidos o no. Inicializar en el On Load del formulario
	vb_WindowsExpanded:=True:C214
	
	GET WINDOW RECT:C443($left;$top;$right;$bottom)
	If (SYS_IsWindows )
		$step:=5
	Else 
		$step:=20
	End if 
	For ($i;$bottom;$bottom+$grow;$step)
		SET WINDOW RECT:C444($left;$top;$right;$i)
	End for 
	SET WINDOW RECT:C444($left;$top;$right;$bottom+$grow)
	GET PICTURE FROM LIBRARY:C565(12980;vp_ExpandCollapse)  //<---- para cambiar el icono del boton expansor
Else 
	vb_WindowsExpanded:=False:C215
	$grow:=-$grow
	GET WINDOW RECT:C443($left;$top;$right;$bottom)
	If (SYS_IsWindows )
		$step:=-5
	Else 
		$step:=-20
	End if 
	For ($i;$bottom;$bottom+$grow;$step)
		SET WINDOW RECT:C444($left;$top;$right;$i)
	End for 
	SET WINDOW RECT:C444($left;$top;$right;$bottom+$grow)
	GET PICTURE FROM LIBRARY:C565(12979;vp_ExpandCollapse)  //<---- para cambiar el icono del boton expansor
End if 