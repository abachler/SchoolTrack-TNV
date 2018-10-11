//%attributes = {}
  //BBLdc_DeleteSelection

$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar los ítems junto con sus copias, su historial de préstamos, sus descriptores y registros secundarios?");__ ("");__ ("No");__ ("Si"))
If ($r=2)
	OK:=1
	START TRANSACTION:C239
	  //CREATE SET([BBL_Items];"AEliminar")
	  //valido los items prestados
	  //ticket 163173 JVP 20160714
	SELECTION TO ARRAY:C260([BBL_Items:61];$al_rec_items)
	CREATE EMPTY SET:C140([BBL_Items:61];"AEliminar")
	For ($x;1;Size of array:C274($al_rec_items))
		GOTO RECORD:C242([BBL_Items:61];$al_rec_items{$x})
		If ([BBL_Items:61]Copias:24=[BBL_Items:61]Copias_disponibles:43)
			ADD TO SET:C119([BBL_Items:61];"AEliminar")
		End if 
	End for 
	
	If (Records in set:C195("AEliminar")>0)
		USE SET:C118("AEliminar")  // ASM 20170510 ticket 180498 Se estaban eliminando solo las copias de un item, ya que no estaba ingresado el use Set.
		KRL_RelateSelection (->[BBL_Registros:66]Número_de_item:1;->[BBL_Items:61]Numero:1)
		ARRAY LONGINT:C221($al_ID_copias;0)
		ARRAY LONGINT:C221($al_id_items;0)
		SELECTION TO ARRAY:C260([BBL_Registros:66]ID:3;$al_ID_copias;[BBL_Items:61]Numero:1;$al_id_items)
		
		OK:=KRL_DeleteSelection (->[BBL_Registros:66])
		If (OK=1)
			USE SET:C118("AEliminar")
			KRL_RelateSelection (->[BBL_RegistrosAnaliticos:74]ID:1;->[BBL_Items:61]Numero:1)
			OK:=KRL_DeleteSelection (->[BBL_RegistrosAnaliticos:74])
		End if 
		If (OK=1)
			USE SET:C118("AEliminar")
			KRL_RelateSelection (->[BBL_FichasCatalograficas:81]Nº de item:5;->[BBL_Items:61]Numero:1)
			OK:=KRL_DeleteSelection (->[BBL_FichasCatalograficas:81])
		End if 
		If (OK=1)
			USE SET:C118("AEliminar")
			KRL_RelateSelection (->[BBL_Reservas:115]ID_Item:2;->[BBL_Items:61]Numero:1)
			OK:=KRL_DeleteSelection (->[BBL_Reservas:115])
		End if 
		If (OK=1)
			USE SET:C118("AEliminar")
			KRL_RelateSelection (->[BBL_ItemMarcFields:205]ID_Item:1;->[BBL_Items:61]Numero:1)
			OK:=KRL_DeleteSelection (->[BBL_ItemMarcFields:205])
		End if 
		If (OK=1)
			ARRAY LONGINT:C221($itm_id;0)
			ARRAY TEXT:C222($itm_titulo;0)
			ARRAY TEXT:C222($itm_media;0)
			
			READ WRITE:C146([BBL_Items:61])
			$titulo:=[BBL_Items:61]Titulos:5
			$media:=[BBL_Items:61]Media:15
			$ID:=String:C10([BBL_Items:61]Numero:1)
			USE SET:C118("AEliminar")
			SELECTION TO ARRAY:C260([BBL_Items:61]Numero:1;$itm_id;[BBL_Items:61]Titulos:5;$itm_titulo;[BBL_Items:61]Media:15;$itm_media)
			DELETE SELECTION:C66([BBL_Items:61])
			VALIDATE TRANSACTION:C240
			
			C_TEXT:C284($log_msg;$id_copias)
			C_LONGINT:C283($i;$o)
			ARRAY LONGINT:C221($da_return;0)
			$log_msg:=""
			For ($i;1;Size of array:C274($itm_id))
				$log_msg:="Ha sido eliminado el item tipo "+$itm_media{$i}+" titulado "+$itm_titulo{$i}+" con ID "+String:C10($itm_id{$i})+". "
				$al_id_items{0}:=$itm_id{$i}
				AT_SearchArray (->$al_id_items;"=";->$da_return)
				ARRAY LONGINT:C221($id_temp;0)
				For ($o;1;Size of array:C274($da_return))
					APPEND TO ARRAY:C911($id_temp;$al_ID_copias{$da_return{$o}})
				End for 
				If (Size of array:C274($id_temp)>0)
					$id_copias:=AT_array2text (->$id_temp;", ")
					$log_msg:=$log_msg+"Y su(s) copia(s) con ID "+$id_copias+"."
				End if 
				LOG_RegisterEvt ($log_msg)
			End for 
			SET_ClearSets ("AEliminar")  //20160713 RCH Se limpia set usado
		Else 
			CANCEL TRANSACTION:C241
			CD_Dlog (0;__ ("Los registros no pueden ser eliminados en este momento ya que uno o más de ellos están siendo utilizados.\rPor favor intente nuevamente más tarde."))
		End if 
		
	Else 
		CANCEL TRANSACTION:C241
		CD_Dlog (0;__ ("Los registros no pueden ser eliminados en este momento ya que uno o más de ellos están siendo utilizados.\rPor favor intente nuevamente más tarde."))
		
	End if 
	
	  //KRL_RelateSelection (->[BBL_Registros]Número_de_item;->[BBL_Items]Numero)
	  //ARRAY LONGINT($al_ID_copias;0)
	  //ARRAY LONGINT($al_id_items;0)
	  //SELECTION TO ARRAY([BBL_Registros]ID;$al_ID_copias;[BBL_Items]Numero;$al_id_items)
	
	  //OK:=KRL_DeleteSelection (->[BBL_Registros])
	  //If (OK=1)
	  //USE SET("AEliminar")
	  //KRL_RelateSelection (->[BBL_RegistrosAnaliticos]ID;->[BBL_Items]Numero)
	  //OK:=KRL_DeleteSelection (->[BBL_RegistrosAnaliticos])
	  //End if 
	  //If (OK=1)
	  //USE SET("AEliminar")
	  //KRL_RelateSelection (->[BBL_FichasCatalograficas]Nº de item;->[BBL_Items]Numero)
	  //OK:=KRL_DeleteSelection (->[BBL_FichasCatalograficas])
	  //End if 
	  //If (OK=1)
	  //USE SET("AEliminar")
	  //KRL_RelateSelection (->[BBL_Reservas]ID_Item;->[BBL_Items]Numero)
	  //OK:=KRL_DeleteSelection (->[BBL_Reservas])
	  //End if 
	  //If (OK=1)
	  //USE SET("AEliminar")
	  //KRL_RelateSelection (->[BBL_ItemMarcFields]ID_Item;->[BBL_Items]Numero)
	  //OK:=KRL_DeleteSelection (->[BBL_ItemMarcFields])
	  //End if 
	  //If (OK=1)
	  //ARRAY LONGINT($itm_id;0)
	  //ARRAY TEXT($itm_titulo;0)
	  //ARRAY TEXT($itm_media;0)
	
	  //READ WRITE([BBL_Items])
	  //$titulo:=[BBL_Items]Titulos
	  //$media:=[BBL_Items]Media
	  //$ID:=String([BBL_Items]Numero)
	  //USE SET("AEliminar")
	  //SELECTION TO ARRAY([BBL_Items]Numero;$itm_id;[BBL_Items]Titulos;$itm_titulo;[BBL_Items]Media;$itm_media)
	  //DELETE SELECTION([BBL_Items])
	  //VALIDATE TRANSACTION
	
	  //C_TEXT($log_msg;$id_copias)
	  //C_LONGINT($i;$o)
	  //ARRAY LONGINT($da_return;0)
	  //$log_msg:=""
	  //For ($i;1;Size of array($itm_id))
	  //$log_msg:="Ha sido eliminado el item tipo "+$itm_media{$i}+" titulado "+$itm_titulo{$i}+" con ID "+String($itm_id{$i})+". "
	  //$al_id_items{0}:=$itm_id{$i}
	  //AT_SearchArray (->$al_id_items;"=";->$da_return)
	  //ARRAY LONGINT($id_temp;0)
	  //For ($o;1;Size of array($da_return))
	  //APPEND TO ARRAY($id_temp;$al_ID_copias{$da_return{$o}})
	  //End for 
	  //If (Size of array($id_temp)>0)
	  //$id_copias:=AT_array2text (->$id_temp;", ")
	  //$log_msg:=$log_msg+"Y su(s) copia(s) con ID "+$id_copias+"."
	  //End if 
	  //LOG_RegisterEvt ($log_msg)
	  //End for 
	  //SET_ClearSets ("AEliminar")  //20160713 RCH Se limpia set usado
	  //Else 
	  //CANCEL TRANSACTION
	  //CD_Dlog (0;__ ("Los registros no pueden ser eliminados en este momento ya que uno o más de ellos están siendo utilizados.\rPor favor intente nuevamente más tarde."))
	  //End if 
	$0:=OK
End if 