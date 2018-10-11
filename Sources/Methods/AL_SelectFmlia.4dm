//%attributes = {}
  // MÉTODO: AL_SelectFmlia
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 12:22:51
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AL_SelectFmlia()
  // ----------------------------------------------------
C_LONGINT:C283($i)

ARRAY TEXT:C222($at_Direccion;0)


  // CODIGO PRINCIPAL

$l_IdFamiliaAnterior:=[Alumnos:2]Familia_Número:24

Case of 
	: (<>vlSTR_UsarSoloUnApellido=1)  //`colegios de Brasil
		Case of 
			: (([Alumnos:2]Apellido_paterno:3#"") & ([Alumnos:2]Apellido_materno:4#""))  //se tiene apellido paterno y apellido materno
				QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=([Alumnos:2]Apellido_paterno:3+"@");*)
				QUERY:C277([Familia:78]; | ;[Familia:78]Nombre_de_la_familia:3=("@"+[Alumnos:2]Apellido_materno:4))
			: (([Alumnos:2]Apellido_paterno:3#"") & ([Alumnos:2]Apellido_materno:4=""))  //se tiene solo apellido paterno ingresado
				QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=([Alumnos:2]Apellido_paterno:3+"@"))
		End case 
		
		ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
		SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;aFamilia;[Familia:78]Dirección:7;$at_Direccion)
		For ($i;1;Size of array:C274(aFamilia))
			aFamilia{$i}:=aFamilia{$i}+" ("+$at_Direccion{$i}+")"
		End for 
		
		Case of 
			: (([Alumnos:2]Apellido_paterno:3#"") & ([Alumnos:2]Apellido_materno:4#""))  //`se tienen los dos apellidos
				vt_FamilyName:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
			: (([Alumnos:2]Apellido_paterno:3#"") & ([Alumnos:2]Apellido_materno:4=""))  //se tiene solo apellido paterno ingresado
				vt_FamilyName:=[Alumnos:2]Apellido_paterno:3
		End case 
		
		WDW_OpenDialogInDrawer (->[Alumnos:2];"SetFamilia";__ ("Seleccionar familia"))
		Case of 
			: ((bSelect=1) | (bCreateFamily=1) | (bCreateOtherFamily=1))
				GOTO RECORD:C242([Familia:78];vlPST_LinkedFamilyRec)
				$0:=[Familia:78]Numero:1
				If ([Alumnos:2]Direccion:12="")
					[Alumnos:2]Direccion:12:=[Familia:78]Dirección:7
					[Alumnos:2]Comuna:14:=[Familia:78]Comuna:8
					[Alumnos:2]Ciudad:15:=[Familia:78]Ciudad:9
					If (Not:C34(Is new record:C668([Alumnos:2])))
						SAVE RECORD:C53([Alumnos:2])
					End if 
				End if 
				If ([Alumnos:2]Telefono:17="")
					[Alumnos:2]Telefono:17:=[Familia:78]Telefono:10
					If (Not:C34(Is new record:C668([Alumnos:2])))
						SAVE RECORD:C53([Alumnos:2])
					End if 
				End if 
				If (<>gGroupAL=False:C215)
					[Alumnos:2]Grupo:11:=[Familia:78]Grupo_Familia:4
					If (Not:C34(Is new record:C668([Alumnos:2])))
						SAVE RECORD:C53([Alumnos:2])
					End if 
				End if 
			Else 
				$0:=[Alumnos:2]Familia_Número:24
		End case 
		
		
	Else 
		
		
		QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=([Alumnos:2]Apellido_paterno:3+"@");*)
		QUERY:C277([Familia:78]; | ;[Familia:78]Nombre_de_la_familia:3=("@"+[Alumnos:2]Apellido_materno:4))
		
		ORDER BY:C49([Familia:78];[Familia:78]Nombre_de_la_familia:3;>)
		SELECTION TO ARRAY:C260([Familia:78]Nombre_de_la_familia:3;aFamilia;[Familia:78]Dirección:7;$at_Direccion)
		For ($i;1;Size of array:C274(aFamilia))
			aFamilia{$i}:=aFamilia{$i}+" ("+$at_Direccion{$i}+")"
		End for 
		vt_FamilyName:=[Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4
		WDW_OpenDialogInDrawer (->[Alumnos:2];"SetFamilia";__ ("Seleccionar familia"))
		
		Case of 
			: ((bSelect=1) | (bCreateFamily=1) | (bCreateOtherFamily=1))
				GOTO RECORD:C242([Familia:78];vlPST_LinkedFamilyRec)
				$0:=[Familia:78]Numero:1
				If (([Alumnos:2]Direccion:12="") | (($l_IdFamiliaAnterior#[Alumnos:2]Familia_Número:24) & ($l_IdFamiliaAnterior#0)))
					[Alumnos:2]Direccion:12:=[Familia:78]Dirección:7
					[Alumnos:2]Comuna:14:=[Familia:78]Comuna:8
					[Alumnos:2]Ciudad:15:=[Familia:78]Ciudad:9
					If (Not:C34(Is new record:C668([Alumnos:2])))
						SAVE RECORD:C53([Alumnos:2])
					End if 
				End if 
				If (([Alumnos:2]Telefono:17="") | (($l_IdFamiliaAnterior#[Alumnos:2]Familia_Número:24) & ($l_IdFamiliaAnterior#0)))
					[Alumnos:2]Telefono:17:=[Familia:78]Telefono:10
					If (Not:C34(Is new record:C668([Alumnos:2])))
						SAVE RECORD:C53([Alumnos:2])
					End if 
				End if 
				If (<>gGroupAL=False:C215)
					[Alumnos:2]Grupo:11:=[Familia:78]Grupo_Familia:4
					If (Not:C34(Is new record:C668([Alumnos:2])))
						SAVE RECORD:C53([Alumnos:2])
					End if 
				End if 
			Else 
				$0:=[Alumnos:2]Familia_Número:24
		End case 
		
End case 
