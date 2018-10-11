//%attributes = {}
  //WDW_Title

  //WINDOW TITLE
$procName:=""
$state:=0
$pTime:=0

Case of 
	: (vLocation="Output")
		SET WINDOW TITLE:C213(Table name:C256($1)+": "+String:C10(Records in selection:C76($1->))+__ (" de ")+String:C10(Records in table:C83($1->)))
	: ((vLocation="Input") & (Record number:C243($1->)>=0))
		SET WINDOW TITLE:C213(Table name:C256($1)+": "+String:C10(Selected record number:C246($1->))+__ (" entre ")+String:C10(Records in selection:C76($1->)))
	: ((vLocation="Input") & (Record number:C243($1->)=-3))
		SET WINDOW TITLE:C213(__ ("Creación de ")+Table name:C256($1))
End case 