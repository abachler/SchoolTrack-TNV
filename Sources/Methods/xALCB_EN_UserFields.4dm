//%attributes = {}
  //xALCB_EN_UserFields

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : AL_EntryUF
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 5:12 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
ARRAY TEXT:C222(<>aUFValues;0)
ARRAY BOOLEAN:C223(lb_UserField_Choices;0)
C_LONGINT:C283($1;$2;$x;$y;$btn)
GET MOUSE:C468($x;$y;$btn;*)

  //C_BOOLEAN(campopropio)  //198018 ABC
  //campopropio:=False
  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
  //vb_guardarCambios:=False

AL_GetCurrCell (vy_ReferenciaAreaList->;vCol;vRow)
If (vCol=2)
	
	QUERY:C277([xShell_Userfields:76];[xShell_Userfields:76]UserFieldName:1=aUFItmName{vRow})
	If ([xShell_Userfields:76]ListOfValues:4)
		OBJECT SET ENTERABLE:C238(vUFvalue;False:C215)
		BLOB_Blob2Vars (->[xShell_Userfields:76]xListOfValues:9;0;-><>aUFValues)
		ARRAY BOOLEAN:C223(lb_UserField_Choices;Size of array:C274(<>aUFValues))
		For ($i;1;ST_CountWords (aUFItmVal{vRow};0;"; "))
			$word:=ST_ClearSpaces (ST_GetWord (aUFItmVal{vRow};$i;"; "))
			$found:=Find in array:C230(<>aUFValues;$word)
			If ($found>0)
				lb_UserField_Choices{$found}:=True:C214
			End if 
		End for 
		
		
		
		sTitle:=aUFItmName{vRow}
		WDW_OpenFormWindow (->[xShell_Userfields:76];"ChoiceList";7;8;aUFItmName{vRow})
		DIALOG:C40([xShell_Userfields:76];"ChoiceList")
		CLOSE WINDOW:C154
		bClose:=0
		bCancel:=0
		
		Case of 
			: (bOKList=1)
				$type:=aUFType{Find in array:C230(aUFList;aUFItmName{vrow})}
				$id:=String:C10(aUFId{Find in array:C230(aUFList;aUFItmName{vrow})};"00000/")
				_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				While (_O_Records in subselection:C7(vy_SubTabla->)>0)
					_O_DELETE SUBRECORD:C96(vy_SubTabla->)
					_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				End while 
				aUFItmVal{vRow}:=""
				
				For ($i;1;Size of array:C274(lb_UserField_Choices))
					If (lb_UserField_Choices{$i})
						$value:=<>aUFValues{$i}
						If (([xShell_Userfields:76]MultiEvaluado:8) & (aUFItmVal{vRow}#""))
							aUFItmVal{vRow}:=aUFItmVal{vRow}+"; "+$value
						Else 
							aUFItmVal{vRow}:=$value
						End if 
						Case of 
							: ($type=0)
								
							: ($type=1)
								$n:=Num:C11($value)
								$value:=String:C10($n;"0000000000,00")
							: ($type=4)
								$d:=Date:C102(DT_StrDateIsOK ($value))
								$value:=String:C10(DT_Date2Num ($d);"0000000000")
							: ($type=9)
								$n:=Num:C11($value)
								$value:=String:C10($n;"0000000000")
						End case 
						If (aUFItmVal{vRow}#"")
							_O_CREATE SUBRECORD:C72(vy_SubTabla->)
							vy_CampoEnSubtabla->:=$id+$value
						End if 
					End if 
				End for 
				
				
			: (bClearValue=1)
				$type:=aUFType{Find in array:C230(aUFList;aUFItmName{vrow})}
				$id:=String:C10(aUFId{Find in array:C230(aUFList;aUFItmName{vrow})};"00000/")
				_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				While (_O_Records in subselection:C7(vy_SubTabla->)>0)
					_O_DELETE SUBRECORD:C96(vy_SubTabla->)
					_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				End while 
				aUFItmVal{vRow}:=""
				_O_DELETE SUBRECORD:C96(vy_SubTabla->)
				
			Else 
				ARRAY INTEGER:C220(aALPLines;0)
				ARRAY TEXT:C222(<>aUFValues;0)
				
		End case 
		
		AL_ExitCell (vy_ReferenciaAreaList->)
		AL_UpdateArrays (vy_ReferenciaAreaList->;-2)
		POST KEY:C465(9)  //para redibujar el area, al parecer hay un bug en ALP y al_UpdateArrays no basta para redibujar el contenido.
		
		  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
		  //campopropio:=True
		vb_guardarCambios:=True:C214
		
	End if 
End if 