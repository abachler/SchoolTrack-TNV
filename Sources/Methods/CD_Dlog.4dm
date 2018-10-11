//%attributes = {}
  //CD_Dlog

If (False:C215)
	  //cd_alert(n°icono(0,1,2);"Texto mensaje";"Texto mas info";"Texto btn defecto";"Te
	  //btn1";"Texto btn3")
	  //El primer y el segundo parametros son obligatorios.
	  //Los otros dependen de las combinaciones de botones que se deseen realizar.
	  //Por ejemplo, para tener el icono, el mensaje, boton OK y boton 1:
	  //cd_alert(1;"Texto mensaje";"";"";"Texto boton 1")
	  //Pero si desea además mas info...: cd_alert(1;"Texto mensaje";"Texto mas info";
	  //"";"Texto boton 1")
	  //Si desea solo el boton 3: cd_alert(1;"Texto mensaje";"";"";"";"Texto boton 3)
	  //Ojo: el ejemplo anterior no tiene mas info ni botones 1 y 2, pero de todas
	  //formas hay que incluir los parametros.
	  //Courtesy of Jaime Herreros B. (Que patuo, ja ja ja!!!)
	  //el tercer argumento no se utiliza actualmente
End if 

C_LONGINT:C283($1;$0;iResult)
C_TEXT:C284($2;$3;$4;$5;$6;$7;$8;cdT_Msg;cdT_HelpTxt;cdS_btn1;cdS_btn2;cdS_btn3;vt_Prompt;vt_UserEntry)
C_PICTURE:C286(vpXS_IconModule)
C_TEXT:C284(vsBWR_CurrentModule)

If ((<>vb_MsgON) & (Application type:C494#4D Server:K5:6))
	
	cdS_btn1:=""
	$pars:=Count parameters:C259
	
	Case of 
		: ($pars=2)
			cdT_Msg:=$2
			cdT_HelpTxt:=""
			cdS_btn1:="OK"
			cdS_btn2:=""
			cdS_btn3:=""
			$title:="Atención !!"
			$layout:="cd_ALERT"
			BEEP:C151
		: ($pars=3)
			cdT_Msg:=$2
			cdT_HelpTxt:=$3
			cdS_btn1:="OK"
			cdS_btn2:=""
			cdS_btn3:=""
			$title:="Atención !!"
			$layout:="cd_ALERT"
			BEEP:C151
		: ($pars=4)
			cdT_Msg:=$2
			cdT_HelpTxt:=$3
			cdS_btn1:=$4
			cdS_btn2:=""
			cdS_btn3:=""
			BEEP:C151
			$title:="Atención !!"
			$layout:="cd_ALERT"
		: ($pars=5)
			cdT_Msg:=$2
			cdT_HelpTxt:=$3
			cdS_btn1:=$4
			cdS_btn2:=$5
			cdS_btn3:=""
			$title:="Confirmación"
			$layout:="cd_2BTNS"
		: ($pars=6)
			cdT_Msg:=$2
			cdT_HelpTxt:=$3
			cdS_btn1:=$4
			cdS_btn2:=$5
			If ($6#"")
				cdS_btn3:=$6
			Else 
				cdS_btn3:=""
			End if 
			$title:="Confirmación"
			$layout:="cd_3BTNS"
		: ($pars>6)
			cdT_Msg:=$2
			cdT_HelpTxt:=$3
			cdS_btn1:=$4
			cdS_btn2:=$5
			cdS_btn3:=$6
			vt_Prompt:=$7
			vt_UserEntry:=$8
			$title:="Confirmación"
			$layout:="cd_Request"
	End case 
	If (vsBWR_CurrentModule="")
		vsBWR_CurrentModule:="SchoolTrack"
	End if 
	
	If (Picture size:C356(vpXS_IconModule)=0)
		GET PICTURE FROM LIBRARY:C565("Module "+vsBWR_CurrentModule;vpXS_IconModule)
	End if 
	
	C_POINTER:C301($y_nil)
	WDW_OpenFormWindow (->[xShell_Dialogs:114];$layout;-1;Movable form dialog box:K39:8)
	DIALOG:C40([xShell_Dialogs:114];$layout)
	CLOSE WINDOW:C154
	
	$0:=iResult
End if 

