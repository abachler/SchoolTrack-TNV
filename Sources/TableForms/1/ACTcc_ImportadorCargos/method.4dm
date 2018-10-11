Case of 
	: (Form event:C388=On Load:K2:1)
		
		  // Modificado por: Saúl Ponce (20/02/2018) Ticket Nº 198965, recargar el icono de ACT
		XS_SetInterface 
		
		LOC_LoadIdenNacionales 
		ARRAY TEXT:C222(aIdentificadores;0)
		ARRAY POINTER:C280(aIDFieldPointers;6)
		COPY ARRAY:C226(<>at_IDNacional_Names;aIdentificadores)
		ARRAY TEXT:C222(aIdentificadores;6)
		aIdentificadores{4}:="Código Alumno"
		aIdentificadores{5}:="Código Cta. Cte."
		  //20120528 RCH Se agrega nuevo identificador
		aIdentificadores{6}:="Número de Letra"
		
		aIDFieldPointers{1}:=->[Alumnos:2]RUT:5
		aIDFieldPointers{2}:=->[Alumnos:2]IDNacional_2:71
		aIDFieldPointers{3}:=->[Alumnos:2]IDNacional_3:70
		aIDFieldPointers{4}:=->[Alumnos:2]Codigo_interno:6
		aIDFieldPointers{5}:=->[ACT_CuentasCorrientes:175]Codigo:19
		aIDFieldPointers{6}:=->[ACT_Documentos_de_Pago:176]NoSerie:12
		aIdentificadores:=1
		aIDFieldPointers:=1
		
		
		vt_URL:=Get 4D folder:C485(Current resources folder:K5:16)+"PDFs"+Folder separator:K24:12+"ImportCargos_ACT.pdf"
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable JavaScript:K62:4;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable Java applets:K62:3;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable plugins:K62:5;True:C214)
		WA SET PREFERENCE:C1041(x4DLiveWindow;WA enable contextual menu:K62:6;True:C214)
		WA OPEN URL:C1020(x4DLiveWindow;vt_URL)
		
		vt_g1:=""
		vt_g1Temp:=""
		vt_id:=""
		vt_idTemp:=""
		If (SYS_IsMacintosh )
			r1:=1
			r2:=0
		Else 
			r1:=0
			r2:=1
		End if 
		cb_TieneEncabezado:=0
		vi_PageNumber:=1
		vi_Step:=1
		vt_Motivo:=""
		
		OBJECT SET ENABLED:C1123(bPrev;False:C215)
		OBJECT SET ENABLED:C1123(bNext;True:C214)
		OBJECT SET ENABLED:C1123(bImport;False:C215)
		
		ACTimp_ArrayDeclarations 
		xALP_ACT_SET_PreImport 
		
		vlACT_CargosImpTotal:=0
		vlACT_CargosImpAprobado:=0
		vlACT_CargosImpRechazado:=0
		
		If (Application type:C494=4D Remote mode:K5:5)
			bc_ExecuteOnServer:=0
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;True:C214)
		Else 
			bc_ExecuteOnServer:=0
			OBJECT SET VISIBLE:C603(bc_ExecuteOnServer;False:C215)
		End if 
		OBJECT SET VISIBLE:C603(*;"uf@";(<>vtXS_CountryCode="cl"))
		vdACT_FechaUFSel:=Current date:C33(*)
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
