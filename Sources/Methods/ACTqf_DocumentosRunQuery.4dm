//%attributes = {}
  //ACTqf_DocumentosRunQuery

If (bSeleccion=0)
	ALL RECORDS:C47(yBWR_CurrentTable->)
Else 
	$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
	USE SET:C118($set)
End if 


CREATE SET:C116(yBWR_CurrentTable->;"SeleccionActual")
Var1:=Bash_Get_Variable_By_Type (aTiposCamposQF{aCamposQFDocumentos})
Var2:=Bash_Get_Variable_By_Type (aTiposCamposQF{aCamposQFDocumentos})
Case of 
	: (aTiposCamposQF{aCamposQFDocumentos}=Is date:K8:7)
		Var1->:=Date:C102(vValor1)
		If (Var1->=!00-00-00!)
			$EmptyvValor1:=True:C214
		Else 
			$EmptyvValor1:=False:C215
		End if 
		Var2->:=Date:C102(vValor2)
		If (Var2->=!00-00-00!)
			$EmptyvValor2:=True:C214
		Else 
			$EmptyvValor2:=False:C215
		End if 
	: ((aTiposCamposQF{aCamposQFDocumentos}=Is text:K8:3) | (aTiposCamposQF{aCamposQFDocumentos}=Is string var:K8:2))
		Var1->:=vValor1
		If (Var1->="")
			$EmptyvValor1:=True:C214
		Else 
			$EmptyvValor1:=False:C215
		End if 
		Var2->:=vValor2
		If (Var2->="")
			$EmptyvValor2:=True:C214
		Else 
			$EmptyvValor2:=False:C215
		End if 
	: ((aTiposCamposQF{aCamposQFDocumentos}=Is real:K8:4) | (aTiposCamposQF{aCamposQFDocumentos}=Is longint:K8:6))
		Var1->:=Num:C11(vValor1)
		If (Var1->=0)
			$EmptyvValor1:=True:C214
		Else 
			$EmptyvValor1:=False:C215
		End if 
		Var2->:=Num:C11(vValor2)
		If (Var2->=0)
			$EmptyvValor2:=True:C214
		Else 
			$EmptyvValor2:=False:C215
		End if 
End case 
If (aRangoFechasQF{aCamposQFDocumentos})
	Var3:=Bash_Get_Variable_By_Type (Is date:K8:7)
	Var4:=Bash_Get_Variable_By_Type (Is date:K8:7)
	Var3->:=Date:C102(vFecha1)
	Var4->:=Date:C102(vFecha2)
End if 
If (Not:C34($EmptyvValor1))
	Case of 
		: (r1=1)
			If (aUsaComodinQF{aCamposQFDocumentos})
				If (Not:C34(Is nil pointer:C315(aRelationFieldQF{aCamposQFDocumentos})))
					QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->;aPrimerQuery{aCamposQFDocumentos}->;"=";Var1->+"@")
					KRL_RelateSelection (aCamposQuery{aCamposQFDocumentos};aRelationFieldQF{aCamposQFDocumentos};"")
				Else 
					QUERY SELECTION:C341(yBWR_CurrentTable->;aCamposQuery{aCamposQFDocumentos}->;"=";Var1->+"@";*)
				End if 
			Else 
				If (Not:C34(Is nil pointer:C315(aRelationFieldQF{aCamposQFDocumentos})))
					QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->;aPrimerQuery{aCamposQFDocumentos}->;"=";Var1->)
					KRL_RelateSelection (aCamposQuery{aCamposQFDocumentos};aRelationFieldQF{aCamposQFDocumentos};"")
				Else 
					QUERY SELECTION:C341(yBWR_CurrentTable->;aCamposQuery{aCamposQFDocumentos}->;"=";Var1->;*)
				End if 
			End if 
		: (r2=1)
			If (Not:C34(Is nil pointer:C315(aRelationFieldQF{aCamposQFDocumentos})))
				QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->;aPrimerQuery{aCamposQFDocumentos}->;"=";"@"+Var1->+"@")
				KRL_RelateSelection (aCamposQuery{aCamposQFDocumentos};aRelationFieldQF{aCamposQFDocumentos};"")
			Else 
				QUERY SELECTION:C341(yBWR_CurrentTable->;aCamposQuery{aCamposQFDocumentos}->;"=";"@"+Var1->+"@";*)
			End if 
		: (r3=1)
			If (aUsaComodinQF{aCamposQFDocumentos})
				If (Not:C34(Is nil pointer:C315(aRelationFieldQF{aCamposQFDocumentos})))
					QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->;aPrimerQuery{aCamposQFDocumentos}->;">=";Var1->+"@";*)
					If (Not:C34($EmptyvValor2))
						QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->; & ;aPrimerQuery{aCamposQFDocumentos}->;"<=";Var2->+"@")
					Else 
						QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->)
					End if 
					KRL_RelateSelection (aCamposQuery{aCamposQFDocumentos};aRelationFieldQF{aCamposQFDocumentos};"")
				Else 
					QUERY SELECTION:C341(yBWR_CurrentTable->;aCamposQuery{aCamposQFDocumentos}->;">=";Var1->+"@";*)
					If (Not:C34($EmptyvValor2))
						QUERY SELECTION:C341(yBWR_CurrentTable->; & ;aCamposQuery{aCamposQFDocumentos}->;"<=";Var2->+"@";*)
					End if 
				End if 
			Else 
				If (Not:C34(Is nil pointer:C315(aRelationFieldQF{aCamposQFDocumentos})))
					QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->;aPrimerQuery{aCamposQFDocumentos}->;">=";Var1->;*)
					If (Not:C34($EmptyvValor2))
						QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->; & ;aPrimerQuery{aCamposQFDocumentos}->;"<=";Var2->)
					Else 
						QUERY:C277(Table:C252(Table:C252(aPrimerQuery{aCamposQFDocumentos}))->)
					End if 
					KRL_RelateSelection (aCamposQuery{aCamposQFDocumentos};aRelationFieldQF{aCamposQFDocumentos};"")
				Else 
					QUERY SELECTION:C341(yBWR_CurrentTable->;aCamposQuery{aCamposQFDocumentos}->;">=";Var1->;*)
					If (Not:C34($EmptyvValor2))
						QUERY SELECTION:C341(yBWR_CurrentTable->; & ;aCamposQuery{aCamposQFDocumentos}->;"<=";Var2->;*)
					End if 
				End if 
			End if 
	End case 
	If (aRangoFechasQF{aCamposQFDocumentos})
		QUERY SELECTION:C341(yBWR_CurrentTable->; & ;aFechasQuery{aCamposQFDocumentos}->;">=";Var3->;*)
		If (Var4->=!00-00-00!)
			QUERY SELECTION:C341(yBWR_CurrentTable->)
		Else 
			QUERY SELECTION:C341(yBWR_CurrentTable->; & ;aFechasQuery{aCamposQFDocumentos}->;"<=";Var4->)
		End if 
	Else 
		QUERY SELECTION:C341(yBWR_CurrentTable->)
	End if 
	dhQF_RefineQuery 
	If (Records in selection:C76(yBWR_CurrentTable->)>0)
		If (bSeleccion=1)
			CREATE SET:C116(yBWR_CurrentTable->;"SeleccionEncontrada")
			INTERSECTION:C121("SeleccionActual";"SeleccionEncontrada";"SeleccionActual")
			USE SET:C118("SeleccionActual")
			SET_ClearSets ("SeleccionActual";"SeleccionEncontrada")
		End if 
		If (Records in selection:C76(yBWR_CurrentTable->)>0)
			ACCEPT:C269
		Else 
			BEEP:C151
		End if 
	Else 
		BEEP:C151
	End if 
Else 
	BEEP:C151
End if 
If (Not:C34(Is nil pointer:C315(Var1)))
	Bash_Return_Variable (Var1)
End if 
If (Not:C34(Is nil pointer:C315(Var2)))
	Bash_Return_Variable (Var2)
End if 
If (Not:C34(Is nil pointer:C315(Var3)))
	Bash_Return_Variable (Var3)
End if 
If (Not:C34(Is nil pointer:C315(Var4)))
	Bash_Return_Variable (Var4)
End if 