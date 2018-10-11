  // [Alumnos].Retiros.Botón invisible()
  // Por: Alberto Bachler: 13/11/13, 11:05:45
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
ARRAY TEXT:C222($aColegiosGrupo;0)
C_BLOB:C604($x_blob)
SET BLOB SIZE:C606($x_blob;0)
BLOB_Variables2Blob (->$x_blob;0;->$aColegiosGrupo)
$x_blob:=PREF_fGetBlob (0;"colegiosgrupo";$x_blob)
BLOB_Blob2Vars (->$x_blob;0;->$aColegiosGrupo)


$t_refMenuColegios:=Create menu:C408
If (Size of array:C274($aColegiosGrupo)>0)
	$t_refMenuColegiosGrupo:=Create menu:C408
	For ($i;1;Size of array:C274($aColegiosGrupo))
		APPEND MENU ITEM:C411($t_refMenuColegiosGrupo;$aColegiosGrupo{$i};"";Current process:C322;*)
		SET MENU ITEM PARAMETER:C1004($t_refMenuColegiosGrupo;-1;String:C10(-$i))
	End for 
	APPEND MENU ITEM:C411($t_refMenuColegios;__ ("Colegios del grupo");$t_refMenuColegiosGrupo;Current process:C322;*)
Else 
	APPEND MENU ITEM:C411($t_refMenuColegios;"("+__ ("Colegios del grupo");"";0)
End if 
If (Size of array:C274(<>aPrevSchool)>0)
	$t_refMenuColegiosOtros:=Create menu:C408
	For ($i;1;Size of array:C274(<>aPrevSchool))
		APPEND MENU ITEM:C411($t_refMenuColegiosOtros;<>aPrevSchool{$i};"";Current process:C322;*)
		SET MENU ITEM PARAMETER:C1004($t_refMenuColegiosOtros;-1;String:C10($i))
	End for 
	APPEND MENU ITEM:C411($t_refMenuColegios;__ ("Otras instituciones");$t_refMenuColegiosOtros;Current process:C322;*)
Else 
	APPEND MENU ITEM:C411($t_refMenuColegios;"("+__ ("Otras instituciones");"";0)
End if 
  //GET WINDOW RECT($l_izquierdaV;$l_arribaV;$derechaV;$l_abajoV)
  //OBJECT GET COORDINATES(*;"fakeMenu";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
$l_refMenuItem:=Num:C11(Dynamic pop up menu:C1006($t_refMenuColegios))
If ($l_refMenuItem<0)
	[Alumnos:2]Colegio_destino:102:=$aColegiosGrupo{Abs:C99($l_refMenuItem)}
	[Alumnos:2]Va_a_colegio_del_grupo:101:=True:C214
Else 
	[Alumnos:2]Colegio_destino:102:=<>aPrevSchool{Abs:C99($l_refMenuItem)}
	[Alumnos:2]Va_a_colegio_del_grupo:101:=False:C215
End if 
RELEASE MENU:C978($t_refMenuColegios)
RELEASE MENU:C978($t_refMenuColegiosOtros)
RELEASE MENU:C978($t_refMenuColegiosGrupo)

If ([Alumnos:2]Colegio_destino:102#"")
	OBJECT SET TITLE:C194(*;"$boton_popupColegioDestino";[Alumnos:2]Colegio_destino:102)
Else 
	OBJECT SET TITLE:C194(*;"$boton_popupColegioDestino";__ ("Seleccione la institución de destino"))
End if 




