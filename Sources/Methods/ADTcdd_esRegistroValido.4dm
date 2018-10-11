//%attributes = {}
  // ADTcdd_esRegistroValido()
  // Por: Alberto Bachler K.: 08-12-13, 09:46:12
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_registroValidado)
C_TEXT:C284($t_listaObligatoriedades)


If (False:C215)
	C_BOOLEAN:C305(ADTcdd_esRegistroValido ;$0)
End if 

$t_listaObligatoriedades:=""
If ((<>al_IDNational_Mandatory{1} ?? 1) & ([Alumnos:2]RUT:5=""))
	If ([Alumnos:2]Nacionalidad:8=LOC_GetNacionalidad )
		$t_listaObligatoriedades:=$t_listaObligatoriedades+"- "+<>at_IDNacional_Names{1}+"\r"
	End if 
End if 

If ((<>al_IDNational_Mandatory{1} ?? 2) & ([Alumnos:2]IDNacional_2:71=""))
	If ([Alumnos:2]Nacionalidad:8=LOC_GetNacionalidad )
		$t_listaObligatoriedades:=$t_listaObligatoriedades+"- "+<>at_IDNacional_Names{2}+"\r"
	End if 
End if 

If ((<>al_IDNational_Mandatory{1} ?? 3) & ([Alumnos:2]IDNacional_3:70=""))
	If ([Alumnos:2]Nacionalidad:8=LOC_GetNacionalidad )
		$t_listaObligatoriedades:=$t_listaObligatoriedades+"- "+<>at_IDNacional_Names{3}+"\r"
	End if 
End if 

If ([Alumnos:2]Apellido_paterno:3="")
	$t_listaObligatoriedades:=$t_listaObligatoriedades+"- "+__ ("Primer apellido")+"\r"
End if 

If ([Alumnos:2]Nombres:2="")
	$t_listaObligatoriedades:=$t_listaObligatoriedades+"- "+__ ("Nombres")+"\r"
End if 

If ([Alumnos:2]Sexo:49="")
	$t_listaObligatoriedades:=$t_listaObligatoriedades+"- "+__ ("Sexo")+"\r"
End if 

If ([Alumnos:2]Fecha_de_nacimiento:7=!00-00-00!)
	$t_listaObligatoriedades:=$t_listaObligatoriedades+"- "+__ ("Fecha de nacimiento del postulante.")+"\r"
End if 

If ($t_listaObligatoriedades#"")
	ModernUI_Notificacion (__ ("Por favor complete complete los siguientes campos antes de continuar:");$t_listaObligatoriedades)
Else 
	$b_registroValidado:=True:C214
End if 

$0:=$b_registroValidado

