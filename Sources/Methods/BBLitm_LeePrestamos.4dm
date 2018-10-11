//%attributes = {}
  // BBLitm_LeePrestamos()
  // Por: Alberto Bachler: 16/11/13, 17:16:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_DATE:C307($d_fechaActual)
_O_C_INTEGER:C282($i_prestamos)

ARRAY LONGINT:C221($al_IDsCopias;0)
ARRAY LONGINT:C221($al_recNumPrestamo;0)
If (False:C215)
	C_POINTER:C301(BBLitm_LeePrestamos ;$1)
End if 

COPY ARRAY:C226($1->;$al_IDsCopias)

READ ONLY:C145([BBL_Prestamos:60])
READ ONLY:C145([BBL_Lectores:72])
QRY_QueryWithArray (->[BBL_Prestamos:60]Número_de_registro:1;->$al_IDsCopias)

AL_UpdateArrays (xALP_Prestamos;0)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([BBL_Prestamos:60];$al_recNumPrestamo;[BBL_Prestamos:60]Desde:3;adBBL_PrestamosDesde;[BBL_Prestamos:60]Hasta:4;adBBL_PrestamosHasta;[BBL_Prestamos:60]Duración:6;aiBBL_PrestamosDuracion;[BBL_Prestamos:60]Fecha_de_devolución:5;adBBL_PrestamosDevolucion;[BBL_Prestamos:60]Días_de_atraso:15;aiBBL_PrestamosAtraso;[BBL_Lectores:72]NombreCompleto:3;atBBL_PrestamosLector;[BBL_Lectores:72]Grupo:2;atBBL_PrestamosTipoLector;[BBL_Lectores:72]Seccion_o_curso:5;atBBL_PrestamosSecciónLector)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

AL_UpdateArrays (xALP_Prestamos;Size of array:C274(adBBL_PrestamosDesde))
AL_SetSort (xALP_Prestamos;-2)
$d_fechaActual:=Current date:C33(*)
For ($i_prestamos;1;Size of array:C274(adBBL_PrestamosDesde))
	If (adBBL_PrestamosDevolucion{$i_prestamos}=!00-00-00!)
		aiBBL_PrestamosDuracion{$i_prestamos}:=($d_fechaActual-adBBL_PrestamosDesde{$i_prestamos})+1
	Else 
		aiBBL_PrestamosDuracion{$i_prestamos}:=adBBL_PrestamosDevolucion{$i_prestamos}-adBBL_PrestamosDesde{$i_prestamos}+1
	End if 
	If (adBBL_PrestamosDevolucion{$i_prestamos}>adBBL_PrestamosHasta{$i_prestamos})
		aiBBL_PrestamosAtraso{$i_prestamos}:=DT_GetWorkingDays (adBBL_PrestamosHasta{$i_prestamos};adBBL_PrestamosDevolucion{$i_prestamos})-1
	Else 
		If (adBBL_PrestamosDevolucion{$i_prestamos}=!00-00-00!) & (adBBL_PrestamosHasta{$i_prestamos}>$d_fechaActual)
			aiBBL_PrestamosAtraso{$i_prestamos}:=DT_GetWorkingDays (adBBL_PrestamosHasta{$i_prestamos};$d_fechaActual)-1
		Else 
			aiBBL_PrestamosAtraso{$i_prestamos}:=0
		End if 
	End if 
	If (adBBL_PrestamosDevolucion{$i_prestamos}=!00-00-00!) & (adBBL_PrestamosHasta{$i_prestamos}<$d_fechaActual)
		aiBBL_PrestamosAtraso{$i_prestamos}:=DT_GetWorkingDays (adBBL_PrestamosHasta{$i_prestamos};$d_fechaActual)-1
	Else 
		aiBBL_PrestamosAtraso{$i_prestamos}:=0
	End if 
	
	If (($d_fechaActual>adBBL_PrestamosHasta{$i_prestamos}) & (adBBL_PrestamosDevolucion{$i_prestamos}=!00-00-00!))
		AL_SetRowColor (xALP_Prestamos;$i_prestamos;"Red";0)
	Else 
		AL_SetRowColor (xALP_Prestamos;$i_prestamos;"Black";0)
	End if 
	If (atBBL_PrestamosLector{$i_prestamos}="")
		atBBL_PrestamosLector{$i_prestamos}:=[BBL_Prestamos:60]Lector_Eliminado:16
		atBBL_PrestamosTipoLector{$i_prestamos}:=[BBL_Prestamos:60]Tipo_Eliminado:17
		atBBL_PrestamosSecciónLector{$i_prestamos}:=__ ("Lector Eliminado")
	End if 
End for 
ALP_SetAlternateLigneColor (xALP_Prestamos;Size of array:C274(adBBL_PrestamosDesde))