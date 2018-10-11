  // VC4D.universo()
  //
  //
  // creado por: Alberto Bachler Klein: 01-03-16, 07:56:48
  // -----------------------------------------------------------
C_POINTER:C301($y_universo)

$y_universo:=OBJECT Get pointer:C1124(Object named:K67:5;"universo")

Case of 
	: (Form event:C388=On Load:K2:1)
		AT_Initialize ($y_universo)
		APPEND TO ARRAY:C911($y_universo->;"Cambios no integrados")
		APPEND TO ARRAY:C911($y_universo->;"-")
		APPEND TO ARRAY:C911($y_universo->;"Última hora")
		APPEND TO ARRAY:C911($y_universo->;"Ultimas 3 horas")
		APPEND TO ARRAY:C911($y_universo->;"-")
		APPEND TO ARRAY:C911($y_universo->;"Hoy")
		APPEND TO ARRAY:C911($y_universo->;"Desde ayer")
		APPEND TO ARRAY:C911($y_universo->;"Desde antes de ayer")
		APPEND TO ARRAY:C911($y_universo->;"Últimos 3 días")
		APPEND TO ARRAY:C911($y_universo->;"Última semana")
		APPEND TO ARRAY:C911($y_universo->;"Últimas dos semanas")
		APPEND TO ARRAY:C911($y_universo->;"Último Mes")
		APPEND TO ARRAY:C911($y_universo->;"-")
		APPEND TO ARRAY:C911($y_universo->;"Desde el…")
		APPEND TO ARRAY:C911($y_universo->;"Entre dos fechas…")
		
		  //$y_universo->->:=Pop up menu(AT_array2text (->$at_opciones))
		
		Case of 
			: ($y_universo->=14)  //
				OBJECT SET VISIBLE:C603(*;"fechas@";True:C214)
				OBJECT SET VISIBLE:C603(*;"fechas_@_hasta";False:C215)
				OBJECT SET VISIBLE:C603(*;"universo";False:C215)
				
			: ($y_universo->=15)  //
				OBJECT SET VISIBLE:C603(*;"fechas@";True:C214)
				OBJECT SET VISIBLE:C603(*;"fechas_@_hasta";True:C214)
				OBJECT SET VISIBLE:C603(*;"universo";False:C215)
			Else 
				OBJECT SET VISIBLE:C603(*;"fechas@";False:C215)
				OBJECT SET VISIBLE:C603(*;"universo";True:C214)
		End case 
		
		$y_universo->:=1
		If ($y_universo->>0)
			OBJECT SET TITLE:C194(*;"fechasTitulo";$y_universo->{$y_universo->})
		End if 
		
		
		
		
	: (Form event:C388=On Data Change:K2:15)
		
	: (Form event:C388=On Clicked:K2:4)
		
		Case of 
			: ($y_universo->>0) & ($y_universo-><14)
				  //POST KEY(F5 key)
				$l_opcion:=$y_universo->
				VC4D_LoadChanges ($l_opcion)
				$y_universo->:=$l_opcion
				
			: ($y_universo->=14)  //
				OBJECT SET VISIBLE:C603(*;"fechas@";True:C214)
				OBJECT SET VISIBLE:C603(*;"fechas_@_hasta";False:C215)
				OBJECT SET VISIBLE:C603(*;"universo";False:C215)
				GOTO OBJECT:C206(*;"fechas_fecha_desde")
				OBJECT SET TITLE:C194(*;"fechas_fechaTitulo_Desde";"Desde el:")
				
			: ($y_universo->=15)  //
				OBJECT SET VISIBLE:C603(*;"fechas@";True:C214)
				OBJECT SET VISIBLE:C603(*;"fechas_@_hasta";True:C214)
				OBJECT SET VISIBLE:C603(*;"universo";False:C215)
				GOTO OBJECT:C206(*;"fechas_fecha_desde")
				OBJECT SET TITLE:C194(*;"fechas_fechaTitulo_Desde";"Entre el:")
				
			Else 
				OBJECT SET VISIBLE:C603(*;"fechas@";False:C215)
				OBJECT SET VISIBLE:C603(*;"universo";True:C214)
		End case 
		
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: (Form event:C388=On Page Change:K2:54)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		
End case 

