//%attributes = {}
  // MÉTODO: SYS_Notify
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 15/06/11, 10:15:40
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // SYS_Notify()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES
C_TEXT:C284($1;$2;cdT_Msg;vtext;$font)
C_LONGINT:C283($3;vl_SecondsToClose)
C_POINTER:C301($y_nil)

  // CODIGO PRINCIPAL
If (<>vb_MsgON)
	cdT_Title:=$1
	vl_SecondsToClose:=5
	cdT_Msg:=$2
	
	
	If (Count parameters:C259=3)
		vl_SecondsToClose:=$3
	End if 
	
	
	
	If (SYS_IsMacintosh )
		WDW_OpenFormWindow ($y_nil;"Notify";4;32)
		DIALOG:C40("Notify")
		CLOSE WINDOW:C154
	Else 
		DISPLAY NOTIFICATION:C910(cdT_Title;cdT_Msg;vl_SecondsToClose)
	End if 
End if 


