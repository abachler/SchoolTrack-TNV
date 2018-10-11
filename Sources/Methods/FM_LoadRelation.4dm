//%attributes = {}
  //FM_LoadRelation

AL_RemoveArrays (xALP_Familia;1;6)
QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
QUERY:C277([Familia_RelacionesFamiliares:77]; & [Personas:7]No:1#0)
ORDER BY:C49([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Tipo_Relación:4;>)
SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]Tipo_Relación:4;$aTypeRel;[Familia_RelacionesFamiliares:77]Apoderado:5;$aApoderado;[Familia_RelacionesFamiliares:77]Parentesco:6;aParentesco;[Personas:7]Apellidos_y_nombres:30;aRelName;[Personas:7]Telefono_domicilio:19;aTelDom;[Personas:7]Celular:24;aCellPhone;[Personas:7]Telefono_profesional:29;aTelOF;[Personas:7]No:1;aPersID)
ARRAY TEXT:C222(aParentesco;Size of array:C274($aTypeRel))
For ($i;1;Size of array:C274($aTypeRel))
	If ($atypeRel{$i}#11)
		aParentesco{$i}:=<>aParentesco{$atypeRel{$i}}
	Else 
		If (aParentesco{$i}="")
			aParentesco{$i}:="Otros"
		End if 
	End if 
	  //If (aPersId{$i}=[Familia]Padre_Número)
	  //aParentesco{$i}:=◊aParentesco{2}
	  //End if 
	  //If (aPersId{$i}=[Familia]Madre_Número)
	  //aParentesco{$i}:=◊aParentesco{1}
	  //End if 
End for 
If (([Familia:78]Dirección:7="") & ([Familia:78]Comuna:8="") & ([Familia:78]Ciudad:9=""))
	[Familia:78]Dirección:7:=[Personas:7]Direccion:14
	[Familia:78]Comuna:8:=[Personas:7]Comuna:16
	[Familia:78]Ciudad:9:=[Personas:7]Ciudad:17
End if 
If ([Familia:78]Telefono:10="")
	[Familia:78]Telefono:10:=[Personas:7]Telefono_domicilio:19
End if 
$err:=AL_SetArraysNam (xALP_Familia;1;6;"aParentesco";"aRelName";"aCellPhone";"aTelDom";"aTelOF";"aPersID")
AL_SetHeaders (xALP_Familia;1;5;__ ("Relación");__ ("Nombre");__ ("Celular");__ ("Tel. Domicilio");__ ("Tel. Oficina"))
AL_SetHdrStyle (xALP_Familia;0;"Tahoma";9;1)
AL_SetStyle (xALP_Familia;0;"Tahoma";9;0)
AL_SetMiscOpts (xALP_Familia;0;0;"\\";0;1)
AL_SetRowOpts (xALP_Familia;0;1;0;0;0)
AL_SetLine (xALP_Familia;0)
AL_SetColOpts (xALP_Familia;1;1;0;1;0;0;0)
AL_SetWidths (xALP_Familia;1;4;50;154;70;70;70)
AL_SetSortOpts (xALP_Familia;0;0;0;"";0)
AL_SetColLock (xALP_Familia;2)
AL_SetDividers (xALP_Familia;"Black";"";15*16+3;"Black";"";15*16+3)
AL_SetHeight (xALP_Familia;1;6;1;8;0;0)
AL_SetScroll (xALP_Familia;0;-3)
AL_SetFormat (xALP_Familia;0;"";0;2;0;0)
ALP_SetDefaultAppareance (xALP_Familia;9;1;6;1;10)
