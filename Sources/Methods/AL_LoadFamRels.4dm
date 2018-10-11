//%attributes = {}
  //AL_LoadFamRels

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : AL_LoadFamRels
	  //Autor: Alberto Bachler
	  //Creada el 30/6/96 a 3:59 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 

ARRAY INTEGER:C220($aTypeAp;0)
ARRAY INTEGER:C220($aTypeRel;0)
ARRAY TEXT:C222(aRelName;0)
ARRAY TEXT:C222(aTelDom;0)
ARRAY TEXT:C222(aTelOf;0)
ARRAY LONGINT:C221(aPersID;0)
ARRAY REAL:C219(arACT_PctEmision;0)

READ ONLY:C145([Familia_RelacionesFamiliares:77])
QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#0)
ORDER BY:C49([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Tipo_Relación:4;>)
SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]Tipo_Relación:4;$aTypeRel;[Familia_RelacionesFamiliares:77]Apoderado:5;$aTypeAp;[Familia_RelacionesFamiliares:77]Parentesco:6;aParentesco;[Personas:7]Apellidos_y_nombres:30;aRelName;[Personas:7]Celular:24;aCellPhone;[Personas:7]Telefono_domicilio:19;aTelDom;[Personas:7]Telefono_profesional:29;aTelOF;[Personas:7]No:1;aPersID)

AT_RedimArrays (Size of array:C274(aPersID);->arACT_PctEmision)
ARRAY LONGINT:C221($al_idsApdos;0)
ARRAY REAL:C219($ar_PctApdos;0)
ACTcc_DividirEmision ("LeeArreglos";->[ACT_CuentasCorrientes:175]o_pct_emision:56;->$al_idsApdos;->$ar_PctApdos)

For ($i;Size of array:C274($aTypeRel);1;-1)
	If (aPersID{$i}=0)
		  //AT_Delete ($i;1;->aRelName;->aTelDom;->aTelOF;->aPersID;->aParentesco;->aCellPhone)
		AT_Delete ($i;1;->aRelName;->aTelDom;->aTelOF;->aPersID;->aParentesco;->aCellPhone;->arACT_PctEmision)
		DELETE FROM ARRAY:C228($aTypeRel;$i)
		DELETE FROM ARRAY:C228($aTypeAp;$i)
	Else 
		  //aParentesco{$i}:=<>aParentesco{$atypeRel{$i}}
		  //If (aPersId{$i}=[Familia]Padre_Número)
		  //aParentesco{$i}:=<>aParentesco{2}
		  //End if 
		  //If (aPersId{$i}=[Familia]Madre_Número)
		  //aParentesco{$i}:=<>aParentesco{1}
		  //End if 
		$l_pos:=Find in array:C230($al_idsApdos;aPersID{$i})
		If ($l_pos>0)
			arACT_PctEmision{$i}:=$ar_PctApdos{$l_pos}
		End if 
	End if 
End for 

ARRAY TEXT:C222(aParentesco;Size of array:C274($aTypeRel))
ARRAY TEXT:C222(aApoderado;Size of array:C274($aTypeRel))
For ($i;1;Size of array:C274($aTypeRel))
	aApoderado{$i}:="No"
End for 
$n1:=Find in array:C230(aPersID;[Alumnos:2]Apoderado_académico_Número:27)
$n2:=Find in array:C230(aPersID;[Alumnos:2]Apoderado_Cuentas_Número:28)
If (($n1>0) & ($n2>0) & ($n1=$n2))
	aApoderado{$n1}:="General"
Else 
	If ($n1>0)
		aApoderado{$n1}:="Académico"
	End if 
	If ($n2>0)
		aApoderado{$n2}:="Cuentas"
	End if 
End if 