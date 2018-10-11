$text:=AT_array2text (->aCtasApdo)
$choice:=Pop up menu:C542($text)
If ($choice#0)
	  //RNApdo:=-1
	  //RNCta:=-1
	  //RNTercero:=-1
	ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
	ACTpgs_LimpiaVarsInterfaz ("UpdateAreas0")
	vbACT_ModOrderAvisos:=False:C215
	modcargos:=False:C215
	$ctaSel:=ST_GetWord (aCtasApdo{$choice};1;"\t")
	QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=$ctaSel)
	Case of 
		: (Records in selection:C76([Alumnos:2])=1)
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
			QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
			For ($i;1;Size of array:C274(aPtrsCtas))
				If (Not:C34(Is nil pointer:C315(aPtrsCtas{$i})))
					If (aPtrsCtas{$i}->#"")
						vsACT_RUTCta:=aPtrsCtas{$i}->
						vt_MsgCta:="Encontrado en "+at_IDNacional_NamesCtas{$i}
						$i:=Size of array:C274(aPtrsCtas)+1
					End if 
				End if 
			End for 
			RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
			ACTpgs_CargaDatosPagoCta (True:C214;vdACT_FechaPago)
			  //20130131 RCH
			OBJECT SET ENABLED:C1123(bIngresarPago;True:C214)
		: (Records in selection:C76([Personas:7])>1)
			CD_Dlog (0;__ ("Existe más de una cuenta con ese nombre. Use un identificador nacional para realizar la búsqueda."))
			IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
			ACTpgs_ClearDlogVars 
			  //CANCEL TRANSACTION
			GOTO OBJECT:C206(vsACT_RUTCta)
		: (Records in selection:C76([Alumnos:2])=0)
			CD_Dlog (0;__ ("No existe una cuenta con ese nombre."))
			IT_SetEnterable (False:C215;0;->vrACT_MontoDesctoAfecto;->vrACT_MontoDesctoExento)
			ACTpgs_ClearDlogVars 
			  //CANCEL TRANSACTION
	End case 
	ACTpgs_LimpiaVarsInterfaz ("UpdateAreas2")
End if 