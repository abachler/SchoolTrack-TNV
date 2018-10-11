//%attributes = {}
  // MÉTODO: AL_RelateToFamily
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/02/12, 12:19:51
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AL_RelateToFamily()
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($l_IdFamilia)

If (False:C215)
	C_LONGINT:C283(AL_RelateToFamily ;$0)
End if 


  // CODIGO PRINCIPAL
Case of 
	: (<>vlSTR_UsarSoloUnApellido#1)
		If (([Alumnos:2]Familia_Número:24=0) & ([Alumnos:2]Apellido_paterno:3#"") & ([Alumnos:2]Apellido_materno:4#""))
			$0:=AL_SelectFmlia 
		Else 
			$0:=[Alumnos:2]Familia_Número:24
		End if 
	Else   //`se trata de Brasil
		
		  //`si no tiene fanilia y se ha ingresado uno al menos de los dos apellidos
		If (([Alumnos:2]Familia_Número:24=0) & (([Alumnos:2]Apellido_paterno:3#"") | ([Alumnos:2]Apellido_materno:4#"")))
			$0:=AL_SelectFmlia 
		Else 
			$0:=[Alumnos:2]Familia_Número:24
		End if 
End case 
