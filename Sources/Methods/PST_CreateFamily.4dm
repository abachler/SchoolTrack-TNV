//%attributes = {}
  // MÉTODO: PST_CreateFamily
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 08/03/12, 14:33:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // PST_CreateFamily()
  // ----------------------------------------------------
C_BOOLEAN:C305($crearFather;$crearMadre)
_O_C_INTEGER:C282($l_posicionEspacio)
C_TEXT:C284($t_apellidoMaterno;$t_apellidoPaterno;$t_nombreFamilia)




  // CODIGO PRINCIPAL
Case of 
	: (Count parameters:C259=1)
		$t_nombreFamilia:=$1
		$t_apellidoMaterno:=Replace string:C233(ST_GetWord ($t_nombreFamilia;2);"_";" ")
		$t_apellidoPaterno:=Replace string:C233(ST_GetWord ($t_nombreFamilia;1);"_";" ")
	: (Count parameters:C259=2)
		$t_apellidoMaterno:=Replace string:C233($2;"_";" ")
		$t_apellidoPaterno:=Replace string:C233($1;"_";" ")
		$t_nombreFamilia:=$t_apellidoPaterno+" "+$t_apellidoMaterno
End case 

  //limpiar espacios antes y despues del nombre de la Familia, Precaución tomada por Colegios en Brasil, donde se ingresa cualquier cosa en los apellidos
$l_posicionEspacio:=Position:C15(" ";$t_nombreFamilia)
If ($l_posicionEspacio=1)
	$t_nombreFamilia:=Substring:C12($t_nombreFamilia;2;Length:C16($t_nombreFamilia))
End if 
$t_nombreFamilia:=ST_ClearExtraCR ($t_nombreFamilia)

If (<>vlSTR_UsarSoloUnApellido=1)
	CREATE RECORD:C68([Familia:78])
	[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
	[Familia:78]Nombre_de_la_familia:3:=$t_nombreFamilia
	[Familia:78]Es_Postulante:18:=True:C214
	SAVE RECORD:C53([Familia:78])
	vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
	vsPST_LinkedFamilyName:=[Familia:78]Nombre_de_la_familia:3
	[ADT_Candidatos:49]Familia_numero:30:=[Familia:78]Numero:1  //asignacion de la familia creada al registroi del postulante
	
	  //MONO ticket 110792 - 18-06-2012
	CREATE RECORD:C68([Personas:7])
	[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
	
	If ($t_apellidoMaterno#"")
		[Personas:7]Apellido_paterno:3:=$t_apellidoMaterno
		[Personas:7]Sexo:8:="F"
	Else 
		[Personas:7]Apellido_paterno:3:=$t_apellidoPaterno
		[Personas:7]Sexo:8:="M"
	End if 
	
	[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
	[Personas:7]Temp_postulante:33:=True:C214
	SAVE RECORD:C53([Personas:7])
	If ($t_apellidoMaterno#"")
		viPST_MotherRecNum:=Record number:C243([Personas:7])
		vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
	Else 
		vsPST_aPaternoFaTHER:=[Personas:7]Apellido_paterno:3
		viPST_FatherRecNum:=Record number:C243([Personas:7])
	End if 
	CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
	[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
	[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
	If ($t_apellidoMaterno#"")
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
	Else 
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
	End if 
	SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
	
	If ($t_apellidoMaterno#"")
		[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
		[Familia:78]Madre_Número:6:=[Personas:7]No:1
	Else 
		[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
		[Familia:78]Padre_Número:5:=[Personas:7]No:1
	End if 
	
	SAVE RECORD:C53([Familia:78])
	
	
Else 
	
	
	  // creacion del registro de familia
	CREATE RECORD:C68([Familia:78])
	[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
	[Familia:78]Nombre_de_la_familia:3:=$t_nombreFamilia
	[Familia:78]Es_Postulante:18:=True:C214
	SAVE RECORD:C53([Familia:78])
	vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
	vsPST_LinkedFamilyName:=[Familia:78]Nombre_de_la_familia:3
	[ADT_Candidatos:49]Familia_numero:30:=[Familia:78]Numero:1  //asignacion de la familia creada al registroi del postulante
	
	
	
	  // si el registro de contacto existe
	If (Records in selection:C76([ADT_Contactos:95])>0)
		  //`vengo de traer al candidato desde contactos
		
		
		  //si es de sexo femenino es la madre
		If ([ADT_Contactos:95]Sexo:6="F")
			If ([ADT_Contactos:95]ID_Persona:20#0)  //`ya esta la madre, la vinculo a la familia
				QUERY:C277([Personas:7];[Personas:7]No:1=[ADT_Contactos:95]ID_Persona:20)
				viPST_MotherRecNum:=Record number:C243([Personas:7])
				vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Madre_Número:6:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
				
				  //creacion del registro del padre
				CREATE RECORD:C68([Personas:7])
				[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
				[Personas:7]Sexo:8:="M"
				[Personas:7]Apellido_paterno:3:=$t_apellidoPaterno
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				SAVE RECORD:C53([Personas:7])
				vsPST_aPaternoFaTHER:=[Personas:7]Apellido_paterno:3
				viPST_FatherRecNum:=Record number:C243([Personas:7])
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Padre_Número:5:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
				
				
				
			Else 
				  //creacion del registro de la madre
				CREATE RECORD:C68([Personas:7])
				[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
				[Personas:7]Sexo:8:="F"
				[Personas:7]Apellido_paterno:3:=$t_apellidoMaterno
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				[Personas:7]Temp_postulante:33:=True:C214
				SAVE RECORD:C53([Personas:7])
				viPST_MotherRecNum:=Record number:C243([Personas:7])
				vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Madre_Número:6:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
				
				  //creacion del registro del padre
				CREATE RECORD:C68([Personas:7])
				[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
				[Personas:7]Sexo:8:="M"
				[Personas:7]Apellido_paterno:3:=$t_apellidoPaterno
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				SAVE RECORD:C53([Personas:7])
				vsPST_aPaternoFaTHER:=[Personas:7]Apellido_paterno:3
				viPST_FatherRecNum:=Record number:C243([Personas:7])
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Padre_Número:5:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
				
			End if 
		Else 
			
			  //padre
			
			If ([ADT_Contactos:95]ID_Persona:20#0)
				QUERY:C277([Personas:7];[Personas:7]No:1=[ADT_Contactos:95]ID_Persona:20)
				vsPST_aPaternoFaTHER:=[Personas:7]Apellido_paterno:3
				viPST_FatherRecNum:=Record number:C243([Personas:7])
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Padre_Número:5:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
				
				  //creating mother record
				CREATE RECORD:C68([Personas:7])
				[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
				[Personas:7]Sexo:8:="F"
				[Personas:7]Apellido_paterno:3:=$t_apellidoMaterno
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				[Personas:7]Temp_postulante:33:=True:C214
				SAVE RECORD:C53([Personas:7])
				viPST_MotherRecNum:=Record number:C243([Personas:7])
				vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Madre_Número:6:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
			Else 
				  //creating father record
				CREATE RECORD:C68([Personas:7])
				[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
				[Personas:7]Sexo:8:="M"
				[Personas:7]Apellido_paterno:3:=$t_apellidoPaterno
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				SAVE RECORD:C53([Personas:7])
				vsPST_aPaternoFaTHER:=[Personas:7]Apellido_paterno:3
				viPST_FatherRecNum:=Record number:C243([Personas:7])
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Padre_Número:5:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
				
				  //creating mother record
				CREATE RECORD:C68([Personas:7])
				[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
				[Personas:7]Sexo:8:="F"
				[Personas:7]Apellido_paterno:3:=$t_apellidoMaterno
				[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
				[Personas:7]Temp_postulante:33:=True:C214
				SAVE RECORD:C53([Personas:7])
				viPST_MotherRecNum:=Record number:C243([Personas:7])
				vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
				[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
				[Familia:78]Madre_Número:6:=[Personas:7]No:1
				SAVE RECORD:C53([Familia:78])
			End if 
		End if 
	Else   // si no existe se crea el registro de la madre
		CREATE RECORD:C68([Personas:7])
		[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
		[Personas:7]Sexo:8:="F"
		[Personas:7]Apellido_paterno:3:=$t_apellidoMaterno
		[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
		[Personas:7]Temp_postulante:33:=True:C214
		SAVE RECORD:C53([Personas:7])
		viPST_MotherRecNum:=Record number:C243([Personas:7])
		vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
		CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
		[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
		[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
		[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
		[Familia:78]Madre_Número:6:=[Personas:7]No:1
		SAVE RECORD:C53([Familia:78])
		
		  //creating father record
		CREATE RECORD:C68([Personas:7])
		[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
		[Personas:7]Sexo:8:="M"
		[Personas:7]Apellido_paterno:3:=$t_apellidoPaterno
		[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
		SAVE RECORD:C53([Personas:7])
		vsPST_aPaternoFaTHER:=[Personas:7]Apellido_paterno:3
		viPST_FatherRecNum:=Record number:C243([Personas:7])
		CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
		[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
		[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
		[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
		[Familia:78]Padre_Número:5:=[Personas:7]No:1
		SAVE RECORD:C53([Familia:78])
	End if 
End if 