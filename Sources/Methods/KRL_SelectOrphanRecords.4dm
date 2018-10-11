//%attributes = {}
  //KRL_SelectOrphanRecords

If (False:C215)
	  //Method: dbu_DeleteOrphans
	  //Written by  Administrateur on 14/03/99
	  //Module: 
	  //Purpose: Delete unlinked records
	  //Syntax:  dbu_DeleteOrphans()
	  //Parameters:
	  //   $1:=Pointer to the destination field
	  //   $2:=Pointer to the source field 
	  //Copyright 1999 Transeo Chile
	<>ST_v532:=False:C215
End if 


  //DECLARATIONS
C_POINTER:C301($1;$2;$oneFile;$nFile;$oneField;$nField)

  //INITIALIZATION
$oneField:=$1
$nField:=$2
$oneFile:=Table:C252(Table:C252($1))
$nFile:=Table:C252(Table:C252($2))


  //MAIN CODE
READ ONLY:C145($oneFile->)
  //All RECORDS($nFile->)
CREATE SET:C116($nFile->;"Current selection")
CREATE EMPTY SET:C140($nFile->;"unlinked")
ALL RECORDS:C47($oneFile->)
KRL_RelateSelection ($nField;$oneField;"")
CREATE SET:C116($nFile->;"Linked")
DIFFERENCE:C122("Current selection";"Linked";"Unlinked")

USE SET:C118("Unlinked")
While (Not:C34(End selection:C36($nFile->)))
	QUERY:C277($oneFile->;$oneField->=$nField->)
	If (Records in selection:C76($oneFile->)>0)
		REMOVE FROM SET:C561("Unlinked")
	End if 
	NEXT RECORD:C51($nFile->)
End while 
USE SET:C118("Unlinked")
CLEAR SET:C117("Current selection")
CLEAR SET:C117("unlinked")
CLEAR SET:C117("linked")


  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 
