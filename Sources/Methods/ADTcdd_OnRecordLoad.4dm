//%attributes = {}
  //ADTcdd_OnRecordLoad




If (vbBWR_IsNewRecord)  // 20110811 ABK Inicio transacción si es registro nuevo
	START TRANSACTION:C239
End if 

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
vb_guardarCambios:=False:C215

vbPST_FamilyMenuDrawed:=False:C215
vs_ShowLinkedTable:=""
vlPST_AlumnosRecNum:=-1  // 20110811 ABK, estaba en 0 lo que excluía un rec num 0, que es válido
vlPST_LinkedFamilyRec:=-1  // 20110811 ABK, estaba en 0 lo que excluía un rec num 0, que es válido
viPST_FATHERRecNum:=-1  // 20110811 ABK, estaba en 0 lo que excluía un rec num 0, que es válido
viPST_MOTHERRecNum:=-1  // 20110811 ABK, estaba en 0 lo que excluía un rec num 0, que es válido
vsPST_LinkedFamilyName:=""
vlPST_IDMOTHER:=0
vsPST_aPaternoMOTHER:=""
vsPST_aMaternoMOTHER:=""
vsPST_NombresMOTHER:=""
vdPST_fNacMOTHER:=!00-00-00!
vsPST_ProfesionMOTHER:=""
vsPST_TelPersMOTHER:=""
vsPST_TelProMOTHER:=""
vsPST_TelCelMOTHER:=""
vlPST_IDFATHER:=0
vsPST_aPaternoFather:=""
vsPST_aMaternoFather:=""
vsPST_NombresFather:=""
vdPST_fNacFather:=!00-00-00!
vsPST_ProfesionFather:=""
vsPST_TelPersFather:=""
vsPST_TelProFather:=""
vsPST_TelCelFather:=""
vi_FmySmnu:=0
viPST_MotherAC:=0
viPST_MotherAA:=0
vtPST_MotherNacionalidad:=""
viPST_FatherAC:=0
viPST_FatherAA:=0
vtPST_FatherNacionalidad:=""
vsPST_RUTMOTHER:=""
vsPST_IDN2MOTHER:=""
vsPST_IDN3MOTHER:=""
vsPST_PasMOTHER:=""
vsPST_CodMOTHER:=""
vsPST_RUTFATHER:=""
vsPST_IDN2FATHER:=""
vsPST_IDN3FATHER:=""
vsPST_PasFATHER:=""
vsPST_CodFATHER:=""
obligatorio:=0

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
ARRAY TEXT:C222($atADT_ID;0)
ARRAY TEXT:C222($atADT_Nombre;0)
C_TEXT:C284(v_idCertificado)

C_BOOLEAN:C305(vb_updateAddress)
vb_updateAddress:=False:C215
C_BOOLEAN:C305(campopropio)
campopropio:=False:C215

If ((Form event:C388#On Load:K2:1) & (Form event:C388#On Activate:K2:9))
	AL_UpdateArrays (xALP_UFields;0)
End if 


If (Undefined:C82(viPST_PostCurrentPage))
	viPST_PostCurrentPage:=1
End if 
If (viPST_PostCurrentPage=0)
	viPST_PostCurrentPage:=1
End if 

vlPST_AlumnosRecNum:=Record number:C243([Alumnos:2])
READ WRITE:C146([Alumnos:2])
  //FONT STYLE(*;"labelcandidate";Underline )
  //SET COLOR(*;"labelCandidate";-6)
OBJECT SET VISIBLE:C603(bSelectPGMember;True:C214)
If (Is new record:C668([ADT_Candidatos:49]))
	viPST_PostCurrentPage:=1
	CREATE RECORD:C68([Alumnos:2])
	ADTcdd_NewCddDefFieldValues 
	
	  //`si es Brasil, deshabilito Apellido Materno, se habilitará cuando se ingrese el paterno
	  //If (<>vlSTR_UsarSoloUnApellido=1)
	  //OBJECT SET ENTERABLE(*;"Champ8";False)
	  //End if 
	
	If (Size of array:C274(aiADT_NivNo)>0)
		[ADT_Candidatos:49]Postula_a:6:=aiADT_NivNo{1}
		[ADT_Candidatos:49]Postula_a_Nombre:41:=atADT_NivName{1}
	End if 
	
	OBJECT SET ENTERABLE:C238(*;"Family@";False:C215)
	  //FONT STYLE(*;"labelcandidate";Underline )
	  //SET COLOR(*;"labelCandidate";-6)
	hl_porqueLlego:=New list:C375
	hl_comoLlego:=New list:C375
	  //cargo las listas de como y porque llego
	For ($i;1;Size of array:C274(<>porqueLlegoColegio))
		APPEND TO LIST:C376(hl_porqueLlego;<>porqueLlegoColegio{$i};$i)
	End for 
	_O_REDRAW LIST:C382(hl_porqueLlego)
	
	For ($i;1;Size of array:C274(<>comoLlegoColegio))
		APPEND TO LIST:C376(hl_comoLlego;<>comoLlegoColegio{$i};$i)
	End for 
	_O_REDRAW LIST:C382(hl_comoLlego)
	
Else 
	OBJECT SET ENTERABLE:C238(*;"Champ8";True:C214)
	  //para cargar información de hermanos en el Colegio, si es que la hay
	ADT_HermanosEnColegio (1)
	  //cargar las notificaciones
	If ([ADT_Candidatos:49]EstadoNotPresentacion:60=1)
		cs_notificaPresentacion:=1
		_O_DISABLE BUTTON:C193(*;"PostGrupo22")
		_O_ENABLE BUTTON:C192(*;"PostGrupo29")
	Else 
		_O_ENABLE BUTTON:C192(*;"PostGrupo22")
		cs_notificaPresentacion:=0
		_O_DISABLE BUTTON:C193(*;"PostGrupo29")
	End if 
	
	If ([ADT_Candidatos:49]EstadoNotEntrevista:59=1)
		cs_notificaEntrevista:=1
		_O_DISABLE BUTTON:C193(*;"PostGrupo23")
		_O_ENABLE BUTTON:C192(*;"PostGrupo30")
	Else 
		cs_notificaEntrevista:=0
		_O_ENABLE BUTTON:C192(*;"PostGrupo23")
		_O_DISABLE BUTTON:C193(*;"PostGrupo30")
	End if 
	
	If ([ADT_Candidatos:49]EstadoNotExamen:61=1)
		cs_noticaExamen:=1
		_O_DISABLE BUTTON:C193(*;"btn_notificaExamen")
		_O_ENABLE BUTTON:C192(*;"cs_confirmaExamen")
	Else 
		cs_noticaExamen:=0
		_O_ENABLE BUTTON:C192(*;"btn_notificaExamen")
		_O_DISABLE BUTTON:C193(*;"cs_confirmaExamen")
	End if 
	
	If ([ADT_Candidatos:49]EstadoNotJornada:62=1)
		cs_notificaVisita:=1
		_O_DISABLE BUTTON:C193(*;"btn_notificaVisita")
		_O_ENABLE BUTTON:C192(*;"cs_confirmaVisita")
	Else 
		cs_notificaVisita:=0
		_O_ENABLE BUTTON:C192(*;"btn_notificaVisita")
		_O_DISABLE BUTTON:C193(*;"cs_confirmaVisita")
	End if 
	
	  //cargar las confirmaciones a las notificaciones
	If ([ADT_Candidatos:49]confirmacionPresentacion:64=True:C214)
		cs_confirmaPresentacion:=1
	Else 
		cs_confirmaPresentacion:=0
	End if 
	
	If ([ADT_Candidatos:49]confirmacionEntrevista:63=True:C214)
		cs_confirmaEntrevista:=1
	Else 
		cs_confirmaEntrevista:=0
	End if 
	
	If ([ADT_Candidatos:49]confirmacionJornada:66=True:C214)
		cs_confirmaVisita:=1
	Else 
		cs_confirmaVisita:=0
	End if 
	
	If ([ADT_Candidatos:49]confirmacionExamen:65=True:C214)
		cs_confirmaExamen:=1
	Else 
		cs_confirmaExamen:=0
	End if 
	
	  //no es nuevo registro, verifico si tiene el certificado de nacimiento adjunto
	v_certificado:=""
	v_idCertificado:=""
	_O_ALL SUBRECORDS:C109([ADT_Candidatos:49]Documentos:50)
	SF_Subtable2Array (->[ADT_Candidatos:49]Documentos:50;->[ADT_Candidatos]Documentos'ID;->$atADT_ID;->[ADT_Candidatos]Documentos'Nombre;->$atADT_Nombre)
	SF_Subtable2Array (->[ADT_Candidatos:49]Documentos:50;->[ADT_Candidatos]Documentos'Revisado;->abADT_DRevisado;->[ADT_Candidatos]Documentos'Nombre;->atADT_DNombre;->[ADT_Candidatos]Documentos'Fecha;->adADT_DFecha;->[ADT_Candidatos]Documentos'Observaciones;->atADT_DObs;->[ADT_Candidatos]Documentos'ID;->atADT_DID;->[ADT_Candidatos]Documentos'Electronico;->abADT_DElectronico;->[ADT_Candidatos]Documentos'path;->atADT_DPath;->[ADT_Candidatos]Documentos'icono;->apADT_DAbrir)
	
	For ($i;1;Size of array:C274($atADT_ID))
		If (Num:C11($atADT_ID{$i})<0)
			v_certificado:=$atADT_Nombre{$i}
			v_idCertificado:=$atADT_ID{$i}
		End if 
	End for 
	
	  //cargar en memoria, la jornada de visita que tiene asignada el candidato, si es que la tiene
	If ([ADT_Candidatos:49]ID_JornadaVisita:57#0)
		READ ONLY:C145([ADT_JornadasVisita:144])
		QUERY:C277([ADT_JornadasVisita:144];[ADT_JornadasVisita:144]ID:1=[ADT_Candidatos:49]ID_JornadaVisita:57)
	Else 
		KRL_UnloadReadOnly (->[ADT_JornadasVisita:144])
	End if 
	  //
	  //FONT STYLE(*;"labelcandidate";Plain )
	  //SET COLOR(*;"labelCandidate";-15)
	  //SET VISIBLE(bSelectPGMember;False)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
	If ([Alumnos:2]Familia_Número:24#0)
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		If (Records in selection:C76([Familia:78])=1)
			OBJECT SET ENTERABLE:C238(*;"Family@";True:C214)
			vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
			vsPST_LinkedFamilyName:=[Familia:78]Nombre_de_la_familia:3
		Else 
			OBJECT SET ENTERABLE:C238(*;"Family@";False:C215)
		End if 
	Else 
		OBJECT SET ENTERABLE:C238(*;"Family@";False:C215)
	End if 
	hl_porqueLlego:=New list:C375
	hl_comoLlego:=New list:C375
	  //cargo las listas de como y porque llego
	For ($i;1;Size of array:C274(<>porqueLlegoColegio))
		APPEND TO LIST:C376(hl_porqueLlego;<>porqueLlegoColegio{$i};$i)
	End for 
	_O_REDRAW LIST:C382(hl_porqueLlego)
	
	For ($i;1;Size of array:C274(<>comoLlegoColegio))
		APPEND TO LIST:C376(hl_comoLlego;<>comoLlegoColegio{$i};$i)
	End for 
	_O_REDRAW LIST:C382(hl_comoLlego)
	
	ARRAY TEXT:C222($atComoLlego;0)
	C_LONGINT:C283($indice)
	AT_AppendItems2TextArray (->$atComoLlego;[ADT_Candidatos:49]Como_Llego_al_Colegio:47)
	For ($i;1;Count list items:C380(hl_comoLlego))
		GET LIST ITEM:C378(hl_comoLlego;$i;$ref;$text)
		
		$indice:=Find in array:C230($atComoLlego;$text)
		If ($indice=-1)
			  //no esta
			SET LIST ITEM PROPERTIES:C386(hl_comoLlego;$ref;False:C215;Plain:K14:1;0;0x00FF)
		Else 
			  //esta
			SET LIST ITEM PROPERTIES:C386(hl_comoLlego;$ref;False:C215;Bold:K14:2;0;0x00FF)
		End if 
	End for 
	_O_REDRAW LIST:C382(hl_comoLlego)
	
	ARRAY TEXT:C222($atPorqueLlego;0)
	AT_AppendItems2TextArray (->$atPorqueLlego;[ADT_Candidatos:49]Por_que_Eligio_Colegio:48)
	
	For ($i;1;Count list items:C380(hl_porqueLlego))
		GET LIST ITEM:C378(hl_porqueLlego;$i;$ref;$text)
		
		$indice:=Find in array:C230($atPorqueLlego;$text)
		
		If ($indice=-1)
			  //no está
			SET LIST ITEM PROPERTIES:C386(hl_porqueLlego;$ref;False:C215;Plain:K14:1;0;0x00FF)
		Else 
			  //esta
			SET LIST ITEM PROPERTIES:C386(hl_porqueLlego;$ref;False:C215;Bold:K14:2;0;0x00FF)
		End if 
	End for 
	_O_REDRAW LIST:C382(hl_porqueLlego)
End if 
IT_SetButtonState (([ADT_Candidatos:49]Familia_numero:30#0);->bDelFamily)

PST_GetFamilyRelations 
$con:=AL_GetLine (xALP_Connexions)
IT_SetButtonState (($con>0);->bDelConnexion)

ADTCdd_LoadMetaData (0)
ADTcdd_LoadEducacionAnterior ([ADT_Candidatos:49]Candidato_numero:1;"al")
  //DELETE FROM LIST(vl_TabMetaDatos;1)
  //SELECT LIST ITEMS BY REFERENCE(vl_TabMetaDatos;2)
  //20110803 As. se cambia la lista de los metadatos, porque se estaba eliminando una pestaña.
vl_TabMetaDatosC:=Copy list:C626(vl_TabMetaDatos)
DELETE FROM LIST:C624(vl_TabMetaDatosC;1)
SELECT LIST ITEMS BY REFERENCE:C630(vl_TabMetaDatosC;2)

If (viPST_PostCurrentPage=3)
	PST_AutoAsignIViewAndPresent 
	PST_AsignExamsDate 
	PST_AsignarJornadaVisita 
End if 

SELECT LIST ITEMS BY POSITION:C381(hlTab_ADT_Postulantes;viPST_PostCurrentPage)
If (Not:C34(Is a list:C621(hlTab_ADT_Postulantes)))
	dhBWR_LoadLists 
	_O_REDRAW LIST:C382(hlTab_ADT_Postulantes)
End if 
FORM GOTO PAGE:C247(viPST_PostCurrentPage)

vb_ConnectionsModified:=False:C215

OBJECT SET VISIBLE:C603(*;"lista_espera@";[ADT_Candidatos:49]ID_Estado:49=-4)
$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
$cond:=(([ADT_Candidatos:49]ID_SitFinal:51=$estadoTerm) & ($estadoTerm#0))
OBJECT SET VISIBLE:C603(*;"acceptOTF@";$cond)
If (Record number:C243([Alumnos:2])>=0)
	SET WINDOW TITLE:C213(__ ("Candidato: ")+[Alumnos:2]apellidos_y_nombres:40)
End if 

  //OBJECT SET VISIBLE(*;"CurrentJF@";([Alumnos]Nivel_Número=-3)) //20120912 ASM. No se mostraba el mensaje.
OBJECT SET VISIBLE:C603(*;"CurrentJF@";((([Alumnos:2]nivel_numero:29=Nivel_AdmissionTrack) | ([Alumnos:2]nivel_numero:29=-3)) & ([Alumnos:2]curso:20#"POST") & ([Alumnos:2]curso:20#"RET@")))
OBJECT SET ENTERABLE:C238(*;"iviewed@";Not:C34(([ADT_Candidatos:49]Fecha_de_Entrevista:4=!00-00-00!)))
OBJECT SET ENTERABLE:C238(*;"presed@";Not:C34(([ADT_Candidatos:49]Fecha_de_presentación:5=!00-00-00!)))
IT_SetButtonState ((Not:C34([ADT_Candidatos:49]Fecha_de_Entrevista:4=!00-00-00!));->bIViewIndicators)

ADTcdd_SetIdentificadorPrincipa 

$nivel:=Find in array:C230(<>al_NumeroNivelesAdmissionTrack;[ADT_Candidatos:49]Postula_a:6)
If ($nivel=-1)
	If ([ADT_Candidatos:49]Postula_a:6#0)
		CD_Dlog (0;__ ("El nivel al que postulaba este candidato ya no es postulable. Por favor seleccione un nuevo nivel."))
		[ADT_Candidatos:49]Postula_a:6:=0
		[ADT_Candidatos:49]Postula_a_Nombre:41:=""
	End if 
Else 
	atADT_NivName:=$nivel
End if 

  //◊atPST_FinalSit:=Find in array(◊atPST_FinalSit;[ADT_Candidatos]Situación_final)
  //If (◊atPST_FinalSit=-1)
  //[ADT_Candidatos]Situación_final:=◊atPST_FinalSit{1}
  //◊atPST_FinalSit:=1
  //End if 

UFLD_LoadFields (->[ADT_Candidatos:49];->[ADT_Candidatos:49]UserFields:42;->[ADT_Candidatos]UserFields'Value;->xALP_UFields)
hl_Estados:=ADTcfg_LoadEstados 
GET LIST ITEM:C378(hl_Estados;1;$ref;$text)
INSERT IN LIST:C625(hl_Estados;$ref;"-";MAXLONG:K35:2)
INSERT IN LIST:C625(hl_Estados;MAXLONG:K35:2;"Indeterminado";0)
hl_EstadosGeneral:=Copy list:C626(hl_Estados)
$estado:=HL_FindInListByReference (hl_Estados;[ADT_Candidatos:49]ID_Estado:49;True:C214)
$estadoPos:=List item position:C629(hl_Estados;[ADT_Candidatos:49]ID_Estado:49)
If (($estado="") | ([ADT_Candidatos:49]ID_Estado:49=0))
	[ADT_Candidatos:49]Estado:52:="Indeterminado"
End if 
HL_ExpandAll (hl_Estados)
HL_ExpandAll (hl_EstadosGeneral)
hl_SitFinal:=New list:C375
$j:=1
For ($i;Count list items:C380(hl_Estados);1;-1)
	GET LIST ITEM:C378(hl_Estados;$i;$ref;$text)
	If ($ref<=-100)
		$parent:=List item parent:C633(hl_Estados;$ref)
		If ($parent=[ADT_Candidatos:49]ID_Estado:49)
			If (Count list items:C380(hl_sitFinal)=0)
				APPEND TO LIST:C376(hl_SitFinal;$text;$ref)
			Else 
				GET LIST ITEM:C378(hl_SitFinal;$j;$refSF;$textSF)
				INSERT IN LIST:C625(hl_SitFinal;$refSF;$text;$ref)
			End if 
		End if 
		DELETE FROM LIST:C624(hl_Estados;$ref)
		$j:=$j+1
	End if 
End for 
If (Count list items:C380(hl_Estados)>0)
	$estadoPos:=List item position:C629(hl_Estados;[ADT_Candidatos:49]ID_Estado:49)
Else 
	[ADT_Candidatos:49]Estado:52:="Indeterminado"
	[ADT_Candidatos:49]ID_Estado:49:=0
	APPEND TO LIST:C376(hl_Estados;[ADT_Candidatos:49]Estado:52;[ADT_Candidatos:49]ID_Estado:49)
	$estadoPos:=1
End if 
SELECT LIST ITEMS BY POSITION:C381(hl_estados;$estadoPos)
If (Count list items:C380(hl_SitFinal)>0)
	$sitFinal:=HL_FindInListByReference (hl_SitFinal;[ADT_Candidatos:49]ID_SitFinal:51;True:C214)
	$sitFinalPos:=List item position:C629(hl_SitFinal;[ADT_Candidatos:49]ID_SitFinal:51)
Else 
	APPEND TO LIST:C376(hl_SitFinal;[ADT_Candidatos:49]Estado:52;[ADT_Candidatos:49]ID_Estado:49)
	$sitFinalPos:=1
End if 
SELECT LIST ITEMS BY POSITION:C381(hl_SitFinal;$sitFinalPos)
_O_REDRAW LIST:C382(hl_Estados)
_O_REDRAW LIST:C382(hl_SitFinal)

$saltar:=Num:C11(PREF_fGet (0;"SaltarEstadosADT";"0"))
OBJECT SET VISIBLE:C603(*;"salta@";($saltar=1))
OBJECT SET VISIBLE:C603(*;"nosalta@";($saltar#1))

If ($saltar=1)
	OBJECT MOVE:C664(hl_Estados;0;0;35;0)
End if 

If (Count list items:C380(hl_Estados)>0)
	$estadoPos:=List item position:C629(hl_Estados;[ADT_Candidatos:49]ID_Estado:49)
	If ($saltar=0)
		ARRAY LONGINT:C221(alADT_TresEstados;3)
		If ([ADT_Candidatos:49]ID_Estado:49=0)
			GET LIST ITEM:C378(hl_Estados;3;$ref;$text)
			$vNextEstadoADT:=$ref
			$vPrevEstadoADT:=0
		Else 
			If ($estadoPos=Count list items:C380(hl_Estados))
				GET LIST ITEM:C378(hl_Estados;$estadoPos;$ref;$text)
			Else 
				GET LIST ITEM:C378(hl_Estados;$estadoPos+1;$ref;$text)
			End if 
			$vNextEstadoADT:=$ref
			If ($estadoPos=1)
				$vPrevEstadoADT:=0
			Else 
				GET LIST ITEM:C378(hl_Estados;$estadoPos-1;$ref;$text)
				If ($ref=MAXLONG:K35:2)
					GET LIST ITEM:C378(hl_Estados;$estadoPos-2;$ref;$text)
				End if 
				$vPrevEstadoADT:=$ref
			End if 
		End if 
		alADT_TresEstados{1}:=$vPrevEstadoADT
		alADT_TresEstados{2}:=[ADT_Candidatos:49]ID_Estado:49
		alADT_TresEstados{3}:=$vNextEstadoADT
		vEstadoActualIdx:=2
		vLimit:=3
		If (alADT_TresEstados{1}=alADT_TresEstados{2})
			DELETE FROM ARRAY:C228(alADT_TresEstados;1;1)
			vEstadoActualIdx:=1
			vLimit:=2
			_O_DISABLE BUTTON:C193(bPrevEstado)
		Else 
			If (alADT_TresEstados{2}=alADT_TresEstados{3})
				DELETE FROM ARRAY:C228(alADT_TresEstados;2;1)
				vEstadoActualIdx:=2
				vLimit:=2
				_O_DISABLE BUTTON:C193(bNextEstado)
			End if 
		End if 
	End if 
Else 
	IT_SetButtonState (False:C215;->bNextEstado;->bPrevEstado)
End if 

OBJECT SET VISIBLE:C603(*;"colegioanterior@";([Alumnos:2]Viene_de_colegio_grupo:100))

ARRAY TEXT:C222(aColegiosGrupo;0)
C_BLOB:C604(blob)
SET BLOB SIZE:C606(blob;0)
BLOB_Variables2Blob (->blob;0;->aColegiosGrupo)
blob:=PREF_fGetBlob (0;"colegiosgrupo";blob)
BLOB_Blob2Vars (->blob;0;->aColegiosGrupo)

ACTcc_CampoMatriculado 
  //para actualizar las vista del examen y las entrevistas del formulario
ADT_VistasIViewExam 
ADTcdd_InputForm 

REDRAW WINDOW:C456

If (Size of array:C274(aiADT_NivNo)=0)
	CD_Dlog (1;__ ("No se tienen niveles postulables para AdmissionTrack, debe configurarlos desde SchoolTrack en el menú Archivos->Configuración->Niveles."))
End if 

op1:=1
op2:=0

If (<>gGroupAL)
	vt_Grupo:=[Alumnos:2]Grupo:11
Else 
	vt_Grupo:=[Familia:78]Grupo_Familia:4
End if 

If ([ADT_Candidatos:49]Transf_ST:68)
	  //Mono 17-05-2011 Los datos de los candidatos transferidos ya no son eliminados ticket 97847 
	  // al consultar se debe bloquear todo en la ficha del candidato
	KRL_ReloadAsReadOnly (->[ADT_Candidatos:49])
	KRL_ReloadAsReadOnly (->[Alumnos:2])
	KRL_ReloadAsReadOnly (->[Familia:78])
	KRL_ReloadAsReadOnly (->[Personas:7])
	
	OBJECT SET ENABLED:C1123(*;"buttonFamilia";False:C215)
	OBJECT SET ENABLED:C1123(*;"mother@";False:C215)
	OBJECT SET ENABLED:C1123(*;"father@";False:C215)
	OBJECT SET ENABLED:C1123(*;"Family@";False:C215)
	OBJECT SET ENABLED:C1123(*;"Variable@";False:C215)
	OBJECT SET ENABLED:C1123(*;"acceptOTF1";False:C215)
	OBJECT SET ENABLED:C1123(*;"choicesfamilia";False:C215)
	OBJECT SET ENABLED:C1123(*;"matrireligioso@";False:C215)
	OBJECT SET ENABLED:C1123(*;"Botón@";False:C215)
	OBJECT SET ENABLED:C1123(*;"bFoto@";False:C215)
	OBJECT SET ENABLED:C1123(*;"Popup@";False:C215)
	OBJECT SET ENABLED:C1123(*;"btn_@";False:C215)
	  //OBJECT SET ENABLED(*;"btn_pop@";False)
	OBJECT SET ENABLED:C1123(*;"Lista_esp@";False:C215)
	OBJECT SET ENABLED:C1123(*;"Menú jerárquico@";False:C215)
	OBJECT SET ENABLED:C1123(*;"btnPopEstados@";False:C215)
	OBJECT SET ENABLED:C1123(*;"hl_comoLlego";False:C215)
	OBJECT SET ENABLED:C1123(*;"hl_porqueLlego";False:C215)
	OBJECT SET ENABLED:C1123(*;"cs_notificaVisita";False:C215)
	OBJECT SET ENABLED:C1123(*;"cs_noticaVisita1";False:C215)
	OBJECT SET ENABLED:C1123(*;"PostGrupo@";False:C215)  //pagina 3
	OBJECT SET ENABLED:C1123(*;"bDeleteExam";False:C215)  // pagina 3
	
	OBJECT SET ENABLED:C1123(*;"Botón de opción1";True:C214)
	OBJECT SET ENABLED:C1123(*;"Botón de opción";True:C214)
	OBJECT SET ENABLED:C1123(*;"Botón imagen";True:C214)
	OBJECT SET ENABLED:C1123(*;"Botón invisible7";True:C214)
	
End if 