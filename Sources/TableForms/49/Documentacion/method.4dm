Case of 
	: (Form event:C388=On Load:K2:1)
		C_PICTURE:C286($dummyPict)
		XS_SetInterface 
		ARRAY BOOLEAN:C223(abADT_DRevisado;0)
		ARRAY BOOLEAN:C223(abADT_DCertificado;0)
		ARRAY TEXT:C222(atADT_DNombre;0)
		ARRAY DATE:C224(adADT_DFecha;0)
		ARRAY TEXT:C222(atADT_DObs;0)
		ARRAY PICTURE:C279(apADT_DVer;0)
		ARRAY TEXT:C222(atADT_DID;0)
		ARRAY BOOLEAN:C223(abADT_DElectronico;0)
		ARRAY TEXT:C222(atADT_DPath;0)
		ARRAY PICTURE:C279(apADT_DAbrir;0)
		ARRAY PICTURE:C279(apADT_DEliminar;0)
		ARRAY PICTURE:C279(apADT_DTempIcono;0)
		_O_ALL SUBRECORDS:C109([ADT_Candidatos:49]Documentos:50)
		AT_RedimArrays (_O_Records in subselection:C7([ADT_Candidatos:49]Documentos:50);->apADT_DVer;->apADT_DEliminar)
		GET PICTURE FROM LIBRARY:C565(2633;$dummyPict)
		AT_Populate (->apADT_DVer;->$dummyPict)
		GET PICTURE FROM LIBRARY:C565(19879;$dummyPict)
		AT_Populate (->apADT_DEliminar;->$dummyPict)
		AT_Initialize (->abADT_DCertificado)
		SF_Subtable2Array (->[ADT_Candidatos:49]Documentos:50;->[ADT_Candidatos]Documentos'Revisado;->abADT_DRevisado;->[ADT_Candidatos]Documentos'Nombre;->atADT_DNombre;->[ADT_Candidatos]Documentos'Fecha;->adADT_DFecha;->[ADT_Candidatos]Documentos'Observaciones;->atADT_DObs;->[ADT_Candidatos]Documentos'ID;->atADT_DID;->[ADT_Candidatos]Documentos'Electronico;->abADT_DElectronico;->[ADT_Candidatos]Documentos'path;->atADT_DPath;->[ADT_Candidatos]Documentos'icono;->apADT_DAbrir)
		SORT ARRAY:C229(adADT_DFecha;atADT_DNombre;abADT_DRevisado;atADT_DObs;apADT_DVer;atADT_DID;abADT_DElectronico;atADT_DPath;apADT_DVer;apADT_DEliminar;>)
		For ($i;1;Size of array:C274(abADT_DElectronico))
			
			If (Num:C11(atADT_DID{$i})<0)
				APPEND TO ARRAY:C911(abADT_DCertificado;True:C214)
			Else 
				APPEND TO ARRAY:C911(abADT_DCertificado;False:C215)
			End if 
			
			If (Not:C34(abADT_DElectronico{$i}))
				GET PICTURE FROM LIBRARY:C565(27511;apADT_DAbrir{$i})
				apADT_DVer{$i}:=apADT_DVer{$i}*0
				apADT_DEliminar{$i}:=apADT_DEliminar{$i}*0
			End if 
		End for 
		
		COPY ARRAY:C226(apADT_DAbrir;apADT_DTempIcono)
		_O_DISABLE BUTTON:C193(bDelDoc)
		LISTBOX SELECT ROW:C912(*;"documentos";0;lk remove from selection:K53:3)
		OBJECT SET FORMAT:C236(apADT_DVer;Char:C90(1))
		OBJECT SET FORMAT:C236(apADT_DAbrir;Char:C90(1))
		OBJECT SET FORMAT:C236(apADT_DEliminar;Char:C90(1))
		SET TIMER:C645(30)
		REDRAW WINDOW:C456
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Timer:K2:25)
		If (IT_AltKeyIsDown )
			C_PICTURE:C286($dummyPict)
			AT_Populate (->apADT_DVer;->$dummyPict)
			AT_Populate (->apADT_DEliminar;->$dummyPict)
			GET PICTURE FROM LIBRARY:C565(27511;$dummyPict)
			AT_Populate (->apADT_DAbrir;->$dummyPict)
		Else 
			COPY ARRAY:C226(apADT_DTempIcono;apADT_DAbrir)
			GET PICTURE FROM LIBRARY:C565(2633;$dummyPict)
			AT_Populate (->apADT_DVer;->$dummyPict)
			GET PICTURE FROM LIBRARY:C565(19879;$dummyPict)
			AT_Populate (->apADT_DEliminar;->$dummyPict)
			For ($i;1;Size of array:C274(abADT_DElectronico))
				If (Not:C34(abADT_DElectronico{$i}))
					GET PICTURE FROM LIBRARY:C565(27511;apADT_DAbrir{$i})
					apADT_DVer{$i}:=apADT_DVer{$i}*0
					apADT_DEliminar{$i}:=apADT_DEliminar{$i}*0
				End if 
			End for 
		End if 
		REDRAW WINDOW:C456
End case 