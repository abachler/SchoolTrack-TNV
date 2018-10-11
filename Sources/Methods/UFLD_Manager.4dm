//%attributes = {}
  //UFLD_Manager

C_LONGINT:C283($numPages;$width;$height)
C_BOOLEAN:C305($fixedWidth;$fixedHeight)
C_TEXT:C284($title)
SYS_TableModulesWithUF 
If (Size of array:C274(<>aUFFileNo)=0)
	CD_Dlog (0;__ ("No hay tablas para las cuales definir campos propios."))
Else 
	FORM GET PROPERTIES:C674([xShell_Userfields:76];"Configuration";$width;$height;$numPages;$fixedWidth;$fixedHeight;$title)
	CFG_OpenConfigPanel (->[xShell_Userfields:76];"Configuration";0;$title)
End if 