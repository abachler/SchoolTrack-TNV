
Case of 
	: (FORM Get current page:C276=1)
		  //If (vl_VerifMineduc>=0)
		vt_text1:=""
		vl_VerifMineduc:=1
		vt_msg2:="Verificando los datos, un momento por favor…"
		OBJECT SET VISIBLE:C603(*;"printreport";False:C215)
		OBJECT SET COLOR:C271(vt_msg2;-5)
		POST KEY:C465(Character code:C91("+");256)
		FORM GOTO PAGE:C247(2)
		vi_pageNumber:=2
		  //Else 
		  //
		  //End if 
	: (FORM Get current page:C276=2)
		If (r2_Matricula=1)
			OBJECT SET VISIBLE:C603(*;"actas@";False:C215)
			OBJECT SET VISIBLE:C603(*;"matricula@";True:C214)
		Else 
			OBJECT SET VISIBLE:C603(*;"actas@";True:C214)
			OBJECT SET VISIBLE:C603(*;"matricula@";False:C215)
		End if 
		FORM GOTO PAGE:C247(3)
		vi_pageNumber:=3
		
		NIV_LoadArrays 
		ARRAY TEXT:C222(at_NivelesRech;0)
		ARRAY LONGINT:C221(al_NivelesRech;0)
		For ($i;1;12)
			$l_item:=Find in array:C230(<>aNivNo;$i)
			APPEND TO ARRAY:C911(al_NivelesRech;$i)
			APPEND TO ARRAY:C911(at_NivelesRech;<>aNivel{$l_item})
		End for 
		For ($i;1;12)
			LISTBOX SELECT ROW:C912(lb_niveles;$i;1)
			  //lb_niveles{$i}:=True
		End for 
		cb_Niveles:=1
		GOTO OBJECT:C206(lb_niveles)
		
		
	: (FORM Get current page:C276=3)
		If (vt_foldername#"")
			If (Test path name:C476(vt_foldername)>=0)
				_O_ENABLE BUTTON:C192(bGenerar)
			End if 
		End if 
		If (r1_Actas=1)
			FORM GOTO PAGE:C247(5)
			vi_pageNumber:=5
		Else 
			If (b22=1)
				FORM GOTO PAGE:C247(4)
				vi_pageNumber:=4
			Else 
				FORM GOTO PAGE:C247(5)
				vi_pageNumber:=5
			End if 
		End if 
		
	: (FORM Get current page:C276=4)
		  //guardamos la configuracion del tipo de enseñanza seleccionado
		C_BLOB:C604($blob;$blob2)
		$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
		BLOB_Variables2Blob ($blobPointer;0;->at_DatosUnidadesEduc_Values)
		PREF_SetBlob (0;$prefRecord;$blob)
		
		$OK:=True:C214
		For ($i;1;Size of array:C274(al_DatosUnidadesEduc_Codes))
			ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;0)
			ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;29)
			al_DatosUnidadesEduc_Codes:=$i
			$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
			SET BLOB SIZE:C606($blob;0)
			BLOB_Variables2Blob (->$blob;0;->at_DatosUnidadesEduc_Values)
			$blob2:=PREF_fGetBlob (0;$prefRecord;$blob)
			$blob:=$blob2
			BLOB_Blob2Vars (->$blob;0;->at_DatosUnidadesEduc_Values)
			ARRAY TEXT:C222(at_DatosUnidadesEduc_Values;29)
			$foundElement:=Find in array:C230(at_DatosUnidadesEduc_Values;"")
			If ($foundElement>0)
				$ok:=False:C215
			End if 
		End for 
		
		If (Not:C34($ok))
			OK:=CD_Dlog (0;__ ("Algunos campos de los datos de las unidades educativas no han sido completados en al menos un tipo de enseñanza.\rPuede continuar con la generación de archivos pero es posible que el Ministerio los rechace.\r\r¿Que desea hacer?");__ ("");__ ("Completar la información");__ ("Generar los archivos"))
			If (OK=1)
				AL_UpdateArrays (xALP_UNIDADES;0)
				at_DatosUnidadesEduc_Tipos:=1
				al_DatosUnidadesEduc_Codes:=1
				$prefRecord:="MatriculaInicial_"+String:C10(al_DatosUnidadesEduc_Codes{1})
				SET BLOB SIZE:C606($blob;0)
				SET BLOB SIZE:C606($blob2;0)
				BLOB_Variables2Blob (->$blob;0;->at_DatosUnidadesEduc_Values)
				$blob2:=PREF_fGetBlob (0;$prefRecord;$blob)
				$blob:=$blob2
				BLOB_Blob2Vars (->$blob;0;->at_DatosUnidadesEduc_Values)
				
				If (at_DatosUnidadesEduc_Values{1}="")
					QUERY:C277([Cursos:3];[Cursos:3]cl_CodigoTipoEnseñanza:21=al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
					at_DatosUnidadesEduc_Values{1}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;1;Length:C16([Cursos:3]cl_RolBaseDatos:20)-1)
					at_DatosUnidadesEduc_Values{2}:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;Length:C16([Cursos:3]cl_RolBaseDatos:20))
				End if 
				
				If (at_DatosUnidadesEduc_Values{3}="")
					at_DatosUnidadesEduc_Values{3}:=String:C10(al_DatosUnidadesEduc_Codes{al_DatosUnidadesEduc_Codes})
				End if 
				AL_UpdateArrays (xALP_UNIDADES;-2)
				vi_PageNumber:=vi_PageNumber-1
				FORM GOTO PAGE:C247(4)
				vi_pageNumber:=4
			Else 
				FORM GOTO PAGE:C247(5)
				vi_pageNumber:=5
			End if 
		Else 
			FORM GOTO PAGE:C247(5)
			vi_pageNumber:=5
		End if 
		
	Else 
End case 