//%attributes = {}
  //dhBWR_BrowserMenuHandler

C_BOOLEAN:C305($trapped;$0)
C_LONGINT:C283($1;$2;$menu;$menuline)

$Menu:=$1
$command:=$2
Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Asignaturas:18]))
		RESOLVE POINTER:C394(Focus object:C278;$varName;$tableNum;$FieldNum)
		If ($varName="vObj_P@")
			If ($menu=2)
				If (($command=3) | ($command=5) | ($command=6))
					modObjetivos:=True:C214
					If ((FirstEntry=0) & ([Asignaturas:18]ConObjetivosEspecificos:62) & (Focus object:C278->#""))
						CD_Dlog (0;__ ("Las modificaciones a los objetivos comunes serán repercutidas a todas las asignaturas que compartan estos objetivos."))
						FirstEntry:=1
					End if 
				End if 
			End if 
		End if 
End case 

