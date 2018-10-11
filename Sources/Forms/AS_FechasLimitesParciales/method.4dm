Case of 
	: (Form event:C388=On Load:K2:1)
		
		C_LONGINT:C283($proc;$i;$l_maxNumperiodo)
		C_POINTER:C301($ptr_col;$ptr_enc)
		
		$proc:=IT_UThermometer (1;0;__ ("Cargando..."))
		
		ARRAY LONGINT:C221($al_numnivel;0)
		ARRAY LONGINT:C221($al_configPeriodo;0)
		ARRAY LONGINT:C221($al_numnivel;0)
		
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([xxSTR_Niveles:6])
		READ ONLY:C145([xxSTR_DatosPeriodos:132])
		
		CREATE SELECTION FROM ARRAY:C640([Asignaturas:18];alBWR_recordNumber)
		DISTINCT VALUES:C339([Asignaturas:18]Numero_del_Nivel:6;$al_numnivel)
		QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;$al_numnivel)
		DISTINCT VALUES:C339([xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44;$al_configPeriodo)
		QUERY WITH ARRAY:C644([xxSTR_DatosPeriodos:132]ID_Configuracion:9;$al_configPeriodo)
		ORDER BY:C49([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]NumeroPeriodo:1;<)
		$l_maxNumperiodo:=[xxSTR_DatosPeriodos:132]NumeroPeriodo:1
		
		  //arrays para el listbox
		ARRAY TEXT:C222(at_parciales;0)  //nombre de las parciales
		  //fechas limites para cada parcial de cada posible periodo
		ARRAY DATE:C224(ad_fechaP1;0)
		ARRAY DATE:C224(ad_fechaP2;0)
		ARRAY DATE:C224(ad_fechaP3;0)
		ARRAY DATE:C224(ad_fechaP4;0)
		ARRAY DATE:C224(ad_fechaP5;0)
		
		C_LONGINT:C283(vl_enc1;vl_enc2;vl_enc3;vl_enc4;vl_enc5)
		
		For ($i;1;12)  //para las 12 parciales
			APPEND TO ARRAY:C911(at_parciales;"Parcial "+String:C10($i))
		End for 
		
		For ($i;1;$l_maxNumperiodo)
			$ptr_col:=Get pointer:C304("ad_fechaP"+String:C10($i))
			ARRAY DATE:C224($ptr_col->;12)
			$ptr_enc:=Get pointer:C304("vl_enc"+String:C10($i))
			
			LISTBOX INSERT COLUMN:C829(*;"FechaBloqueoParciales";$i+1;"Periodo"+String:C10($i);$ptr_col->;"Periodo "+String:C10($i);$ptr_enc->)
			OBJECT SET TITLE:C194($ptr_enc->;"Periodo "+String:C10($i))
			LISTBOX SET COLUMN WIDTH:C833(*;"parciales";600/$i+1;600/$i+1;600/$i+1)
			LISTBOX SET PROPERTY:C1440(*;"FechaBloqueoParciales";lk sortable:K53:45;0)
			LISTBOX SET PROPERTY:C1440(*;"FechaBloqueoParciales";lk single click edit:K53:70;1)
		End for 
		
		IT_UThermometer (-2;$proc)
		
End case 