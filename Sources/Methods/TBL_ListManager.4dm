//%attributes = {}
  //TBL_ListManager

C_LONGINT:C283($numPages;$width;$height)
C_BOOLEAN:C305($fixedWidth;$fixedHeight)
C_TEXT:C284($title)
FORM GET PROPERTIES:C674([xShell_List:39];"Configuration";$width;$height;$numPages;$fixedWidth;$fixedHeight;$title)
ALL RECORDS:C47([xShell_List:39])
FIRST RECORD:C50([xShell_List:39])
CFG_OpenConfigPanel (->[xShell_List:39];"Configuration";1;$title)