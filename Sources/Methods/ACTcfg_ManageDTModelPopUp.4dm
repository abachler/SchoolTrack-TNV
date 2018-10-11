//%attributes = {}
  //ACTcfg_ManageDTModelPopUp

$choice:=$1
Case of 
	: ($choice=1)
		POST KEY:C465(Character code:C91("N");Command key mask:K16:1+Shift key mask:K16:3)
	: ($choice=2)
		POST KEY:C465(Character code:C91("O");Command key mask:K16:1+Shift key mask:K16:3)
	: ($choice=3)
		
	: ($choice=4)
		POST KEY:C465(Character code:C91("D");Command key mask:K16:1+Shift key mask:K16:3)
	: ($choice=5)
		
	: ($choice=6)
		POST KEY:C465(127;0)
	: ($choice=7)
		
	: ($choice=8)
		POST KEY:C465(Character code:C91("S");Command key mask:K16:1+Shift key mask:K16:3)
	: ($choice=9)
		POST KEY:C465(Character code:C91("L");Command key mask:K16:1+Shift key mask:K16:3)
	: ($choice=11)
		$row:=AL_GetLine (xAL_ModelosAvisos)
		PREF_Set (0;"ACT_AvisoSeleccionado2PDF";String:C10(alACT_ModelosAvID{$row}))
End case 