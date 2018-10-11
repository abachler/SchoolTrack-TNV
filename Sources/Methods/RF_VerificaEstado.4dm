//%attributes = {}
C_BOOLEAN:C305($b_alert;$1;$b_fam)
C_REAL:C285($um)

If (Count parameters:C259=1)
	$b_alert:=$1
End if 

If (Records in selection:C76([Personas:7])=1)
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
	KRL_RelateSelection (->[Familia:78]Numero:1;->[Familia_RelacionesFamiliares:77]ID_Familia:2;"")
	$b_fam:=[Familia:78]Inactiva:31
	QUERY SELECTION:C341([Familia:78];[Familia:78]Inactiva:31=False:C215)
	If (Records in selection:C76([Familia:78])>0)
		[Personas:7]Inactivo:46:=False:C215
		If ($b_alert)
			CD_Dlog (0;__ ("El Apoderado ^0 se encuentra en una familia activa, primero inactive la familia.";[Personas:7]Apellidos_y_nombres:30))
		End if 
	Else 
		If ((Old:C35([Personas:7]Inactivo:46)) & ($b_fam))  //ABC // 200926 //20180309
			If ($b_alert)  //20180327 RCH
				CD_Dlog (0;__ ("El Apoderado ^0, no puede ser activado ya que se encuentra dentro de una familia Inactiva.\r\rPara que la familia sea activada debe tener al menos 1 alumno activo dentro de ella.";[Personas:7]Apellidos_y_nombres:30))
			End if 
			[Personas:7]Inactivo:46:=True:C214
		Else 
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9;=;[Personas:7]No:1)
			$sum:=Sum:C1([ACT_CuentasCorrientes:175]Total_Saldos:8)
			If ($sum=0)
				[Personas:7]Inactivo:46:=True:C214
				[Personas:7]Es_Apoderado_Academico:41:=False:C215
				[Personas:7]ES_Apoderado_de_Cuentas:42:=False:C215
			Else 
				[Personas:7]Inactivo:46:=False:C215
				If ($b_alert)
					CD_Dlog (0;__ ("El Apoderado ^0 tiene saldos en sus cuentas corrientes distintos a cero. No puede ser inactivado.";[Personas:7]Apellidos_y_nombres:30))
				End if 
			End if 
		End if 
	End if 
End if 