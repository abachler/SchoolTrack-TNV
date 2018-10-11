//%attributes = {}
  //IT_HandleTextDragAndDrop

C_LONGINT:C283($vlList)

Case of 
		  // Use this event for accepting or rejecting the drag and drop
	: (Form event:C388=On Drag Over:K2:13)
		  // Initialize $0 for rejecting    
		$0:=-1
		  // Get the information about the drag and drop source object
		DRAG AND DROP PROPERTIES:C607($vpSrcObj;$vlSrcElem;$vlPID)
		  // In this example, we do not allow drag and drop from an object to itself
		If ($vpSrcObj#$1)
			  // Get the type of the data which is being dragged      
			$vlSrcType:=Type:C295($vpSrcObj->)
			Case of 
				: ($vlSrcType=Is alpha field:K8:1)
					  // Alphanumeric Field is OK                    
					$0:=0
					  // Copy the value now into an IP variable
					<>vtDraggedData:=$vpSrcObj->
				: ($vlSrcType=Is text:K8:3)
					  // Text Field or Variable is OK          
					$0:=0
					RESOLVE POINTER:C394($vpSrcObj;$vsVarName;$vlTableNum;$vlFieldNum)
					  // If it is a field
					If (($vlTableNum>0) & ($vlFieldNum>0))
						  // Copy the value now into an IP variable            
						<>vtDraggedData:=$vpSrcObj->
					End if 
				: ($vlSrcType=Is string var:K8:2)
					  // String Variable is OK          
					$0:=0
				: (($vlSrcType=String array:K8:15) | ($vlSrcType=Text array:K8:16))
					  // String and Text Arrays are OK          
					$0:=0
				: (($vlSrcType=Is longint:K8:6) | ($vlSrcType=Is real:K8:4))
					If (Is a list:C621($vpSrcObj->))
						  // Hierarchical list is OK            
						$0:=0
					End if 
			End case 
		End if 
		
		  // Use this event for performing the actual drag and drop action
	: (Form event:C388=On Drop:K2:12)
		$vtDraggedData:=""
		  // Get the information about the drag and drop source object
		DRAG AND DROP PROPERTIES:C607($vpSrcObj;$vlSrcElem;$vlPID)
		RESOLVE POINTER:C394($vpSrcObj;$vsVarName;$vlTableNum;$vlFieldNum)
		  // If it is field
		If (($vlTableNum>0) & ($vlFieldNum>0))
			  // Just grab the IP variable set during the On Drag Over event      
			$vtDraggedData:=<>vtDraggedData
		Else 
			  // Get the type of the variable which has been dragged      
			$vlSrcType:=Type:C295($vpSrcObj->)
			Case of 
					  // If it is an array          
				: (($vlSrcType=String array:K8:15) | ($vlSrcType=Text array:K8:16))
					If ($vlPID#Current process:C322)
						  // Read the element from the source process instance of the variable            
						GET PROCESS VARIABLE:C371($vlPID;$vpSrcObj->{$vlSrcElem};$vtDraggedData)
					Else 
						  // Copy the array element            
						$vtDraggedData:=$vpSrcObj->{$vlSrcElem}
					End if 
				: (($vlSrcType=Is longint:K8:6) | ($vlSrcType=Is real:K8:4))
					  // If it is a hierarcical list          
					If (Is a list:C621($vpSrcObj->))
						  // If it is a list from another process            
						If ($vlPID#Current process:C322)
							  // Get the List Reference from the other process              
							GET PROCESS VARIABLE:C371($vlPID;$vpSrcObj->;$vlList)
						Else 
							$vlList:=$vpSrcObj->
						End if 
						  // Get the text of the item whose position was obtained            
						GET LIST ITEM:C378($vlList;$vlSrcElem;$vlItemRef;$vsItemText)
						$vtDraggedData:=$vsItemText
					End if 
				Else 
					  // It is a string or a text variable
					If ($vlPID#Current process:C322)
						GET PROCESS VARIABLE:C371($vlPID;$vpSrcObj->;$vtDraggedData)
					Else 
						$vtDraggedData:=$vpSrcObj->
					End if 
			End case 
		End if 
		  // If there is actually something to drop (the source object may be empty)
		If ($vtDraggedData#"")
			  // Check that the length of the text variable will not exceed 32,000 characters   
			If ((Length:C16($1->)+Length:C16($vtDraggedData))<=32000)
				$1->:=$1->+$vtDraggedData
			Else 
				BEEP:C151
				ALERT:C41("The drag and drop cannot be completed because the text would become too long.")
			End if 
		End if 
		
End case 