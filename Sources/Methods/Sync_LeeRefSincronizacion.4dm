//%attributes = {"executedOnServer":true}
  // Sync_LeeRefSincronizacion()
  // Por: Alberto Bachler K.: 15-04-15, 17:34:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_semaforoPuesto)
_O_C_INTEGER:C282($i_campos;$i_tablas)
C_LONGINT:C283($l_posicion;$l_ultimaTabla)

ARRAY LONGINT:C221($al_campos;0)
ARRAY LONGINT:C221($al_tablas;0)

While (Test semaphore:C652("Sync_RegistrandoModificacion"))
	DELAY PROCESS:C323(Current process:C322;10)
End while 

$b_semaforoPuesto:=Semaphore:C143("LecturaRefSincronizacion")


READ ONLY:C145([sync_diccionario:285])
QUERY:C277([sync_diccionario:285];[sync_diccionario:285]sincronizable:12=True:C214)
ORDER BY:C49([sync_diccionario:285];[sync_diccionario:285]st_tabla:8)
DISTINCT VALUES:C339([sync_diccionario:285]st_tabla:8;$al_tablas)

$l_ultimaTabla:=Get last table number:C254

ARRAY POINTER:C280(<>ay_syncronizacion;Get last table number:C254;0)
For ($i_tablas;1;$l_ultimaTabla)
	If (Is table number valid:C999($i_tablas))
		QUERY:C277([sync_diccionario:285];[sync_diccionario:285]st_tabla:8;=;$i_tablas;*)
		QUERY:C277([sync_diccionario:285]; & ;[sync_diccionario:285]sincronizable:12=True:C214)
		SELECTION TO ARRAY:C260([sync_diccionario:285]st_campo:9;$al_campos)
		For ($i_campos;1;Size of array:C274($al_campos))
			If (Is field number valid:C1000($i_Tablas;$al_campos{$i_campos}))
				APPEND TO ARRAY:C911(<>ay_syncronizacion{$i_tablas};Field:C253($i_tablas;$al_campos{$i_campos}))
			End if 
		End for 
	End if 
End for 

CLEAR SEMAPHORE:C144("LecturaRefSincronizacion")

