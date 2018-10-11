//%attributes = {}
  //KRL_DeleteOrphans

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
ALL RECORDS:C47($nFile->)
If (Records in selection:C76($nFile->)>0)
	CREATE SET:C116($nFile->;"ALL")
	CREATE EMPTY SET:C140($nFile->;"unlinked")
	ALL RECORDS:C47($oneFile->)
	KRL_RelateSelection ($nField;$oneField;"")
	CREATE SET:C116($nFile->;"Linked")
	DIFFERENCE:C122("All";"Linked";"Unlinked")
	READ WRITE:C146($nFile->)
	USE SET:C118("Unlinked")
	DELETE SELECTION:C66($nFile->)
	READ ONLY:C145($nFile->)
	
End if 
  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 
