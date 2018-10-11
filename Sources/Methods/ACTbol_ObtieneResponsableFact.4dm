//%attributes = {}
  //ACTbol_ObtieneResponsableFact
C_TEXT:C284($t_accion)
C_LONGINT:C283($l_id)
C_TEXT:C284($t_retorno;$0)

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 
If (Count parameters:C259>=2)
	$l_id:=$2
End if 

Case of 
	: ($t_accion="")
		  //WDW_OpenFormWindow (->[ACT_Boletas];"DatosFacturacion";-1;4;__ ("Prueba"))
		WDW_OpenFormWindow (->[ACT_Boletas:181];"DatosFacturacion";-1;1;__ ("Facturación"))  //20150525 RCH
		DIALOG:C40([ACT_Boletas:181];"DatosFacturacion")
		CLOSE WINDOW:C154
		
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			ACTbol_ObtieneResponsableFact ("CargaVarDesdeFichaApdo")
		Else 
			If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
				ACTbol_ObtieneResponsableFact ("CargaVarDesdeFichaTer")
			End if 
		End if 
		
	: ($t_accion="CargaVarDesdeFichaApdo")
		Case of 
			: ([Personas:7]ACT_ReceptorDT_Tipo:112=0)
				t_datoFacturacion:="Mismo responsable"
			: ([Personas:7]ACT_ReceptorDT_Tipo:112=1)
				t_datoFacturacion:=ACTbol_ObtieneResponsableFact ("CargaVarApdo";[Personas:7]ACT_ReceptorDT_id_Apdo:113)
			: ([Personas:7]ACT_ReceptorDT_Tipo:112=2)
				t_datoFacturacion:=ACTbol_ObtieneResponsableFact ("CargaVarTer";[Personas:7]ACT_ReceptorDT_id_Ter:114)
			: ([Personas:7]ACT_ReceptorDT_Tipo:112=3)
				t_datoFacturacion:="Público general"
			: ([Personas:7]ACT_ReceptorDT_Tipo:112=4)
				t_datoFacturacion:="No emitir"
		End case 
		
	: ($t_accion="CargaVarDesdeFichaTer")
		Case of 
			: ([ACT_Terceros:138]ReceptorDT_tipo:76=0)
				t_datoFacturacion:="Mismo responsable"
				
			: ([ACT_Terceros:138]ReceptorDT_tipo:76=1)
				t_datoFacturacion:=ACTbol_ObtieneResponsableFact ("CargaVarApdo";[ACT_Terceros:138]ReceptorDT_id_apoderado:78)
				
			: ([ACT_Terceros:138]ReceptorDT_tipo:76=2)
				t_datoFacturacion:=ACTbol_ObtieneResponsableFact ("CargaVarTer";[ACT_Terceros:138]ReceptorDT_id_tercero:77)
				
			: ([ACT_Terceros:138]ReceptorDT_tipo:76=3)
				t_datoFacturacion:="Público general"
				
			: ([ACT_Terceros:138]ReceptorDT_tipo:76=4)
				t_datoFacturacion:="No emitir"
		End case 
		
	: ($t_accion="DeclaraVars")
		C_TEXT:C284(t_datoFacturacion)
		C_LONGINT:C283($l_id)
		
		ARRAY TEXT:C222(atACTbol_ApdosNombres;0)
		ARRAY LONGINT:C221(alACTbol_ApdosIds;0)
		
		ARRAY TEXT:C222(atACTbol_TercerosNombres;0)
		ARRAY LONGINT:C221(alACTbol_TercerosIds;0)
		
		  //JVP 20160810 ticket 166328 
		  //apilo registro en caso de ser nuevo
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			PUSH RECORD:C176([Personas:7])
		Else 
			  //JVP 20160831 ticket 167336 
			If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
				PUSH RECORD:C176([ACT_Terceros:138])
			End if 
		End if 
		
		$l_RecNumPersona:=Record number:C243([Personas:7])
		
		QUERY:C277([Personas:7];[Personas:7]No:1#[Personas:7]No:1;*)
		QUERY:C277([Personas:7]; & ;[Personas:7]Inactivo:46=False:C215)
		ORDER BY:C49([Personas:7]Apellidos_y_nombres:30;>)
		SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;atACTbol_ApdosNombres;[Personas:7]No:1;alACTbol_ApdosIds)
		
		  //Begin SQL
		  //select Apellidos_y_Nombres, No
		  //from Personas
		  //where No <> :$l_id AND Inactivo=false
		  //order by 1 ASC
		  //into :atACTbol_ApdosNombres, :alACTbol_ApdosIds
		  //End SQL
		
		$l_RecNumTercero:=Record number:C243([ACT_Terceros:138])
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1#[ACT_Terceros:138]Id:1;*)
		QUERY:C277([ACT_Terceros:138]; & ;[ACT_Terceros:138]Inactivo:24=False:C215)
		ORDER BY:C49([ACT_Terceros:138]Nombre_Completo:9;>)
		SELECTION TO ARRAY:C260([ACT_Terceros:138]Nombre_Completo:9;atACTbol_TercerosNombres;[ACT_Terceros:138]Id:1;alACTbol_TercerosIds)
		
		  //Begin SQL
		  //select Nombre_Completo, ID
		  //from ACT_Terceros
		  //where ID <> :$l_id AND Inactivo=false
		  //order by 1 ASC
		  //into :atACTbol_TercerosNombres, :alACTbol_TercerosIds
		  //End SQL
		  //
		KRL_GotoRecord (->[Personas:7];$l_RecNumPersona)
		KRL_GotoRecord (->[ACT_Terceros:138];$l_RecNumTercero)
		
		  //JVP 20160810 ticket 166328
		  //recargo registro en caso de ser nuevo
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Personas:7]))
			POP RECORD:C177([Personas:7])
		Else 
			  //JVP 20160831 ticket 167336 
			If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Terceros:138]))
				POP RECORD:C177([ACT_Terceros:138])
			End if 
		End if 
		
		
	: ($t_accion="CargaVarApdo")
		$l_pos:=Find in array:C230(alACTbol_ApdosIds;$l_id)
		If ($l_pos#-1)
			$t_retorno:="Apo: "+atACTbol_ApdosNombres{$l_pos}
		End if 
		
	: ($t_accion="CargaVarTer")
		$l_pos:=Find in array:C230(alACTbol_TercerosIds;$l_id)
		If ($l_pos#-1)
			$t_retorno:="Ter: "+atACTbol_TercerosNombres{$l_pos}
		End if 
		
End case 

$0:=$t_retorno