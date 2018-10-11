//%attributes = {}
  //xALCB_EX_UserFields

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : AL_ExitUF
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 6:47 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2)
C_LONGINT:C283($i;vCol;vRow)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	
	  //campopropio:=True
	  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
	vb_guardarCambios:=True:C214
	
	If (AL_GetCellMod (vy_ReferenciaAreaList->)=1)
		AL_GetCurrCell (vy_ReferenciaAreaList->;vCol;vRow)
		If (vCol=2)
			$type:=aUFType{Find in array:C230(aUFList;aUFItmName{vrow})}
			$id:=String:C10(aUFId{Find in array:C230(aUFList;aUFItmName{vrow})};"00000/")
			$multi:=aUFMulti{Find in array:C230(aUFList;aUFItmName{vrow})}
			If (aUFItmVal{vRow}="")
				_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				While (_O_Records in subselection:C7(vy_SubTabla->)>0)
					_O_DELETE SUBRECORD:C96(vy_SubTabla->)
					_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				End while 
			End if 
			If ($multi=False:C215)
				$value:=""
				Case of 
					: ($type=0)
						$value:=aUFItmVal{vRow}
					: ($type=1)
						$n:=Num:C11(aUFItmVal{vRow})
						aUFItmVal{vRow}:=String:C10($n;"########0,00")  //RCH. Al modificar este formato, hacerlo también en el método UFLD_GetUserFieldValue
						$value:=String:C10($n;"0000000000,00")
					: ($type=4)
						$d:=Date:C102(DT_StrDateIsOK (aUFItmVal{vRow}))
						If ($d=!00-00-00!)
							aUFItmVal{vrow}:=""
						Else 
							aUFItmVal{vrow}:=String:C10($d;7)
							$value:=String:C10(DT_Date2Num (Date:C102(aUFItmVal{vRow}));"0000000000")
						End if 
					: ($type=9)
						$n:=Num:C11(aUFItmVal{vRow})
						aUFItmVal{vRow}:=String:C10($n;"########0")
						$value:=String:C10($n;"0000000000")
				End case 
				
				
				  //2011 AS. para evitar que se dupliquen los datos de los campos propios.
				_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				While (Not:C34(_O_End subselection:C37(vy_SubTabla->)))
					_O_DELETE SUBRECORD:C96(vy_SubTabla->)
					_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				End while 
				
				_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				If (_O_Records in subselection:C7(vy_SubTabla->)=0)
					_O_CREATE SUBRECORD:C72(vy_SubTabla->)
				End if 
				vy_CampoEnSubtabla->:=$id+$value
				  //AL_ExitCell (yUFxAL->)
			Else 
				$type:=aUFType{Find in array:C230(aUFList;aUFItmName{vrow})}
				$id:=String:C10(aUFId{Find in array:C230(aUFList;aUFItmName{vrow})};"00000/")
				ARRAY TEXT:C222(aText1;0)
				AT_Text2Array (->aText1;aUFItmVal{vRow};";")
				aUFItmVal{vRow}:=""
				_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				While (Not:C34(_O_End subselection:C37(vy_SubTabla->)))
					_O_DELETE SUBRECORD:C96(vy_SubTabla->)
					_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+"@"))
				End while 
				For ($i;1;Size of array:C274(aText1))
					Case of 
						: ($type=0)
							  //If (([xShell_Userfields]MultiEvaluado) & (aUFItmVal{vRow}#"")) 25-04-2011 AS. se modifica porque se estaba mostrando el dato duplicado.
							If ([xShell_Userfields:76]MultiEvaluado:8)
								If ($i=1)
									aUFItmVal{vRow}:=aUFItmVal{vRow}+aText1{$i}
								Else 
									aUFItmVal{vRow}:=aUFItmVal{vRow}+"; "+aText1{$i}
								End if 
							Else 
								aUFItmVal{vRow}:=aText1{$i}
							End if 
							$value:=aText1{$i}
						: ($type=1)
							$n:=Num:C11(aText1{$i})
							If (([xShell_Userfields:76]MultiEvaluado:8) & (aUFItmVal{vRow}#""))
								aUFItmVal{vRow}:=aUFItmVal{vRow}+"; "+String:C10($n;"########0,00")  //RCH al modificar este formato, hacerlo también en el método UFLD_GetUserFieldValue
							Else 
								aUFItmVal{vRow}:=String:C10($n;"########0,00")
							End if 
							$value:=String:C10($n;"0000000000,00")
						: ($type=4)
							$d:=Date:C102(DT_StrDateIsOK (aText1{$i}))
							aText1{$i}:=String:C10(DT_Date2Num (Date:C102(aUFItmVal{vRow}));"0000000000")
							If (([xShell_Userfields:76]MultiEvaluado:8) & (aUFItmVal{vRow}#""))
								aUFItmVal{vRow}:=aUFItmVal{vRow}+"; "+String:C10($d;7)
							Else 
								aUFItmVal{vRow}:=String:C10($d;1)
							End if 
							$value:=aText1{$i}
						: ($type=9)
							$n:=Num:C11(aText1{$i})
							If (([xShell_Userfields:76]MultiEvaluado:8) & (aUFItmVal{vRow}#""))
								aUFItmVal{vRow}:=aUFItmVal{vRow}+"; "+String:C10($n;"########0")
							Else 
								aUFItmVal{vRow}:=String:C10($n;"########0")
							End if 
							$value:=String:C10($n;"0000000000")
					End case 
					_O_QUERY SUBRECORDS:C108(vy_SubTabla->;vy_CampoEnSubtabla->=($id+aText1{$i}))
					If (_O_Records in subselection:C7(vy_SubTabla->)=0)
						_O_CREATE SUBRECORD:C72(vy_SubTabla->)
					End if 
					vy_CampoEnSubtabla->:=$id+aText1{$i}
				End for 
			End if 
		End if 
	End if 
End if 


