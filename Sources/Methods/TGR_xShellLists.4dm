//%attributes = {}
  // TGR_xShellLists()
  // Por: Alberto Bachler K.: 01-07-14, 11:20:05
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($t_nodo;$t_refJson)

ARRAY TEXT:C222($at_listaElementos;0)



C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	If ((Trigger event:C369=On Saving Existing Record Event:K3:2) | (Trigger event:C369=On Saving New Record Event:K3:1))
		If (BLOB size:C605([xShell_List:39]Contents:9)=0)
			BLOB_Variables2Blob (->[xShell_List:39]Contents:9;0;->$at_listaElementos)
		End if 
		BLOB_Blob2Vars (->[xShell_List:39]Contents:9;0;->$at_listaElementos)
		
		
		  // Modificado por: Alexis Bustamante (10-06-2017)
		  //TICKET 179869
		  //cambio de plugin a comando nativo
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$at_listaElementos;"lang-es")
		[xShell_List:39]json:2:=OB_Object2Json ($ob_raiz)
		  //$t_refJson:=JSON New 
		  //$t_nodo:=JSON Append text array ($t_refJson;"lang-es";$at_listaElementos)
		  //[xShell_List]json:=JSON Export to text ($t_refJson;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($t_refJson)
	End if 
End if 
