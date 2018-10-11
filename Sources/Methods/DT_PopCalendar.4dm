//%attributes = {}
  // DT_PopCalendar()
  // Por: Alberto Bachler K.: 26-03-14, 19:16:37
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_DATE:C307($0)

vt_encabezadoCalendario:=""
If (Count parameters:C259=1)
	vt_encabezadoCalendario:=$1
Else 
	
End if 


If (Is nil pointer:C315(Self:C308))
	WDW_OpenFormWindow (->[xShell_Dialogs:114];"PopCalendar";-1;32;__ ("Calendario");"wdw_CloseDlog")
Else 
	WDW_OpenPopupWindow (Self:C308;->[xShell_Dialogs:114];"PopCalendar";32)
End if 
DIALOG:C40([xShell_Dialogs:114];"PopCalendar")
CLOSE WINDOW:C154
If (oK=1)
	$0:=dDate
Else 
	$0:=!00-00-00!
End if 