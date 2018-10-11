//%attributes = {}
  //DT_CalendarManager

C_LONGINT:C283($numPages;$left;$top;$right;$bottom;$width;$height)
C_BOOLEAN:C305($fixedWidth;$fixedHeight)
C_TEXT:C284($title)
GET WINDOW RECT:C443($left;$top;$right;$bottom)
FORM GET PROPERTIES:C674([xShell_Feriados:71];"Configuration";$width;$height;$numPages;$fixedWidth;$fixedHeight;$title)
SET WINDOW RECT:C444($left;$top;$width+$left;$height+$top)
SET WINDOW TITLE:C213($title)
DIALOG:C40([xShell_Feriados:71];"Configuration")