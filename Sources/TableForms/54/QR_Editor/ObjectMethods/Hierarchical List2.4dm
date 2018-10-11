  //`xShell, Alberto Bachler
  //Metodo: Método de Objeto: hlQR_SortList
  //Por abachler
  //Creada el 21/01/2004, 08:37:44
  //Modificaciones:
If ("DESCRIPCION"="")
	  //
End if 

  //****DECLARACIONES****
C_POINTER:C301($fieldPtr)
C_LONGINT:C283(hlQR_SortList;$styles)
C_BOOLEAN:C305($enterable)
  //****INICIALIZACIONES****


  //****CUERPO****
Case of 
	: (Form event:C388=On Load:K2:1)
		If (Is a list:C621(hlQR_SortList))
			CLEAR LIST:C377(hlQR_SortList)
		End if 
		
		hlQR_SortList:=New list:C375
		SET LIST PROPERTIES:C387(hlQR_SortList;0;0;18)
		_O_REDRAW LIST:C382(hlQR_SortList)
		
		
		
	: (Form event:C388=On Drag Over:K2:13)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		GET LIST ITEM:C378($sourceObject->;$sourceNumber;$itemRef;$itemText)
		$tableNum:=$itemRef\1000
		$fieldNum:=$itemRef%1000
		Case of 
			: ($sourceObject=(Self:C308))
				$0:=0
			: (($sourceObject=(->hlQR_FieldList)) & ($fieldNum>0))
				$0:=0
			Else 
				$0:=-1
		End case 
		
		
	: (Form event:C388=On Drop:K2:12)
		DRAG AND DROP PROPERTIES:C607($sourceObject;$sourceNumber;$sourceProcess)
		$dropPosition:=Drop position:C608  // Because we may need to change this.
		GET LIST ITEM:C378($sourceObject->;$sourceNumber;$itemRef;$itemText)
		
		  //20130612 RCH. Se corrigen errores al crear reportes...
		GET LIST ITEM PARAMETER:C985($sourceObject->;$itemRef;"Tabla";$t_table)
		GET LIST ITEM PARAMETER:C985($sourceObject->;$itemRef;"Campo";$t_field)
		
		  //If ($itemRef>1000)
		If (($t_table#"") & ($t_field#""))
			  //$tableNum:=$itemRef\1000
			  //$fieldNum:=$itemRef%1000
			$tableNum:=Num:C11($t_table)
			$fieldNum:=Num:C11($t_field)
			
			  //If the object is from this list, we're just moving it.  We'll do that by deleting it
			  //   and then recreating it in the enw position.  This is where we delete it.
			If ($sourceObject=Self:C308)
				DELETE FROM LIST:C624(Self:C308->;$itemRef)
				If ($sourceNumber<$dropPosition)
					$dropPosition:=$dropPosition-1
				End if 
			End if 
			
			If ($fieldNum#0)  // Don't allow a table name drop.
				$position:=List item position:C629(Self:C308->;$itemRef)
				If (($position=0) | ($sourceObject=Self:C308))  // Make sure it's not already in this list.
					$itemText:="["+Table name:C256($tableNum)+"]"+Field name:C257($tableNum;$fieldNum)
					If ($dropPosition>0)
						GET LIST ITEM:C378(Self:C308->;$dropPosition;$beforeItemRef;$beforeItemitemText)
						INSERT IN LIST:C625(Self:C308->;$beforeItemRef;$itemText;$itemRef)
					Else 
						APPEND TO LIST:C376(Self:C308->;$itemText;$itemRef)
					End if 
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;Plain:K14:1;23087+Use PicRef:K28:4)
					
					_O_REDRAW LIST:C382(Self:C308->)
					
					  //20130612 RCH
					  // Now make sure this field is available in the report.
					  //$tableNum:=$itemRef\1000
					  //$fieldNum:=$itemRef%1000
					$fieldPtr:=Field:C253($tableNum;$fieldNum)
					$column:=QR Find column:C776(xQR_ReportArea;$fieldPtr)
					If ($column=-1)
						$column:=QR Count columns:C764(xQR_ReportArea)+1
						QR INSERT COLUMN:C748(xQR_ReportArea;$column;$fieldPtr)
					End if 
					QR SET SELECTION:C794(xQR_ReportArea;$column;0)
				End if 
				
				QR_SetSorts 
			End if 
		Else 
			If ($sourceObject=Self:C308)
				DELETE FROM LIST:C624(Self:C308->;$itemRef)
				If ($sourceNumber<$dropPosition)
					$dropPosition:=$dropPosition-1
				End if 
			End if 
			
			If ($dropPosition>0)
				GET LIST ITEM:C378(Self:C308->;$dropPosition;$beforeItemRef;$beforeItemitemText)
				INSERT IN LIST:C625(Self:C308->;$beforeItemRef;$itemText;$itemRef)
			Else 
				APPEND TO LIST:C376(Self:C308->;$itemText;$itemRef)
			End if 
			SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;Plain:K14:1;23087+Use PicRef:K28:4)
			
			_O_REDRAW LIST:C382(Self:C308->)
			QR_SetSorts 
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		If (Contextual click:C713)
			GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
			GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$styles;$icon)
			Case of 
				: ($icon=(23087+Use PicRef:K28:4))  //orden ascendente
					$popupText:="!"+Char:C90(18)+"Orden ascendente;Orden descendente;(-;Retirar"
				: ($icon=(23086+Use PicRef:K28:4))  // orden descendiente
					$popupText:="Orden ascendente;"+"!"+Char:C90(18)+"Orden descendente;(-;Retirar"
			End case 
			$choice:=Pop up menu:C542($popupText)
			Case of 
				: ($choice=1)
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;Plain:K14:1;23087+Use PicRef:K28:4)
				: ($choice=2)
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;False:C215;Plain:K14:1;23086+Use PicRef:K28:4)
				: ($choice=4)
					DELETE FROM LIST:C624(hlQR_sortList;$itemRef)
			End case 
			_O_REDRAW LIST:C382(Self:C308->)
			QR_SetSorts 
		Else 
			GET MOUSE:C468($mouseX;$mouseY;$mouseButton)
			OBJECT GET COORDINATES:C663(Self:C308->;$left;$top;$right;$bottom)
			Case of 
				: (($mouseX>$left) & ($mouseX<=($left+15)))
					GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$itemRef;$itemText)
					GET LIST ITEM PROPERTIES:C631(Self:C308->;$itemRef;$enterable;$styles;$icon)
					If ($icon=(23086+Use PicRef:K28:4))
						$icon:=23087+Use PicRef:K28:4
					Else 
						$icon:=23086+Use PicRef:K28:4
					End if 
					SET LIST ITEM PROPERTIES:C386(Self:C308->;$itemRef;$enterable;$styles;$icon)
					_O_REDRAW LIST:C382(Self:C308->)
					QR_SetSorts 
			End case 
		End if 
End case 

  //****LIMPIEZA****




