//%attributes = {}
  // FM_OnRecordLoad()
  // Por: Alberto Bachler K.: 30-03-14, 17:26:23
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_PICTURE:C286(vp_Picture)
vb_UpdateAddress:=False:C215
_O_C_STRING:C293(80;vs_RemoteName)
C_LONGINT:C283($table)

  //C_BOOLEAN(campopropio)
  //campopropio:=False
  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
vb_guardarCambios:=False:C215

If (Record number:C243([Familia:78])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva familia"))
Else 
	SET WINDOW TITLE:C213(__ ("Familias: ")+[Familia:78]Nombre_de_la_familia:3)
End if 

If ([Familia:78]Numero:1=0)
	If ((Not:C34(<>gGroupAL)) & (<>gAutoGroup) & (Size of array:C274(<>aColor)>0))
		[Familia:78]Grupo_Familia:4:=<>aColor{MATH_RandomLongint (1;Size of array:C274(<>aColor))}
	End if 
	[Familia:78]Año__de_ingreso:17:=<>gYear
Else 
	GOTO OBJECT:C206([Familia:78]Nombre_de_la_familia:3)
	
	FM_LoadRelation 
	
	REDUCE SELECTION:C351([Alumnos:2];0)
	FM_LoadBrothers 
	
	If (([Familia:78]Dirección:7="") & ([Familia:78]Comuna:8="") & ([Familia:78]Ciudad:9="") & ([Familia:78]Codigo_postal:19="") & ([Familia:78]Region_o_estado:34=""))
		[Familia:78]Dirección:7:=[Alumnos:2]Direccion:12
		[Familia:78]Comuna:8:=[Alumnos:2]Comuna:14
		[Familia:78]Ciudad:9:=[Alumnos:2]Ciudad:15
		[Familia:78]Codigo_postal:19:=[Alumnos:2]Codigo_Postal:13
		[Familia:78]Region_o_estado:34:=[Alumnos:2]Región_o_estado:16
	End if 
	If ([Familia:78]Fax:20="")
		[Familia:78]Fax:20:=[Alumnos:2]Fax:69
	End if 
	If ([Familia:78]Telefono:10="")
		[Familia:78]Telefono:10:=[Alumnos:2]Telefono:17
	End if 
	If (KRL_FieldChanges (->[Familia:78]Dirección:7;->[Familia:78]Comuna:8;->[Familia:78]Ciudad:9;->[Familia:78]Codigo_postal:19;->[Familia:78]Telefono:10;->[Familia:78]Fax:20))
		SAVE RECORD:C53([Familia:78])
	End if 
	
	UFLD_LoadFileTplt (->[Familia:78])
	UFLD_LoadFields (->[Familia:78];->[Familia:78]Userfields:13;->[Familia]Userfields'Value;->xALP_FamUFields)
	FM_LoadEvents 
	
End if 

$err:=AL_SetArraysNam (xALP_Hermano;1;4;"aBthrName";"aBthrCurso";"aBrotherNumber";"aBthrID")
AL_SetHeaders (xALP_Hermano;1;3;__ ("Nombre");__ ("Curso");__ ("Nº en Familia"))
AL_SetWidths (xALP_Hermano;1;3;270;70;80)
AL_SetHdrStyle (xALP_Hermano;0;"Tahoma";9;1)
AL_SetStyle (xALP_Hermano;0;"Tahoma";9;0)
AL_SetMiscOpts (xALP_Hermano;0;0;"\\";0;1)
AL_SetRowOpts (xALP_Hermano;0;1;0;0;0)
AL_SetLine (xALP_Hermano;0)
AL_SetColOpts (xALP_Hermano;1;1;0;1;0;0;0)
AL_SetSortOpts (xALP_Hermano;0;0;0;"";0)
AL_SetDividers (xALP_Hermano;"Black";"";15*16+3;"Black";"";15*16+3)
AL_SetHeight (xALP_Hermano;1;6;1;8;0;0)
AL_SetScroll (xALP_Hermano;0;-3)
AL_SetFormat (xALP_Hermano;1;"";0;2;0;0)
AL_SetFormat (xALP_Hermano;2;"";0;2;0;0)
AL_SetFormat (xALP_Hermano;3;"####";0;2;0;0)
ALP_SetDefaultAppareance (xALP_Hermano;9;1;6;1;8)


SET LIST ITEM PROPERTIES:C386(hltab_STR_Familias;2;(USR_checkRights ("L";->[Familia_RegistroEventos:140]));1;0)

$page:=Selected list items:C379(hltab_STR_Familias)
If ($page=3)
	If (Picture size:C356([Familia:78]Fotografia:35)>0)
		$table:=Table:C252(->[Familia:78])
		$folder:="Fotografías "+<>gCountryCode+" "+<>grolBD+Folder separator:K24:12+String:C10($table;"0000")
		$fileName:=<>gCountryCode+"."+<>gRolBD+"."+String:C10([Familia:78]Numero:1)+PICT_GetDefaultExtension 
		vp_Picture:=xDOC_ReadExternalPicture ($folder;$fileName)
		If (Picture size:C356(vp_Picture)=0)
			vp_Picture:=[Familia:78]Fotografia:35
		End if 
	Else 
		vp_Picture:=vp_Picture*0
	End if 
End if 
OBJECT SET VISIBLE:C603(*;"matricivil@";[Familia:78]Matrimonio_Civil:36)
OBJECT SET VISIBLE:C603(*;"matrireligioso@";[Familia:78]Matrimonio_Religioso:38)
FORM GOTO PAGE:C247($page)