//%attributes = {}
  //IT_SetEnterable

If (False:C215)
	  //Method: ITF_SetEnterable
	  //Written by  Alberto Bachler on 13/6/98
	  //Module: INTERFACE pack
	  //Purpose: Set enterability & color of a serie of objects
	  //Syntax:  ITF_SetEnterable(&BOOLEAN;&INT;&POINTER;…;{&POINTER})
	  //Parameters:
	  //    $1: Enterability (true or false)
	  //    $2: Color (if 0, no color change)
	  //    $3…$N: pointers
	  //Copyright 1998 Transeo Chile
	<>ST_v451:=False:C215
End if 


  //DECLARATIONS
C_LONGINT:C283($i;$2;$color)
C_BOOLEAN:C305($1;$enterable)
C_POINTER:C301(${3})

  //INITIALIZATION
$enterable:=$1
$color:=$2

  //MAIN CODE
If ($color=0)
	For ($i;3;Count parameters:C259)
		OBJECT SET ENTERABLE:C238(${$i}->;$enterable)
	End for 
Else 
	For ($i;3;Count parameters:C259)
		OBJECT SET ENTERABLE:C238(${$i}->;$enterable)
		OBJECT SET COLOR:C271(${$i}->;$color)
	End for 
End if 
  //END OF MAIN CODE 


  //CLEANING


  //END OF METHOD 
