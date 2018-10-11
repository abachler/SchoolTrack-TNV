


C_TEXT:C284($resultadoJSON)
C_LONGINT:C283(vTitRegistros;$fia;$vl_vistoALU;$vl_vistoREL;$vl_downloadALU;$vl_downloadREL)
If (Form event:C388=On Clicked:K2:4)
	$selectedIndex:=Find in array:C230(lbEventos;True:C214)
	ARRAY TEXT:C222(atQR_SNEnviosRegistros;0)
	ARRAY TEXT:C222(atQR_SNEnviosCursos;0)
	ARRAY LONGINT:C221(alQR_SNEnviosIDRegistros;0)
	ARRAY TEXT:C222(atQR_SNEnviosLinkDownload;0)
	  //Mono ticket 142225
	ARRAY BOOLEAN:C223(ab_descargado_rel;0)
	ARRAY BOOLEAN:C223(ab_descargado_alu;0)
	ARRAY BOOLEAN:C223(ab_visto_rel;0)
	ARRAY BOOLEAN:C223(ab_visto_alu;0)
	
	
	OBJECT SET ENABLED:C1123(bEliminarEvento;($selectedIndex>0))
	If ($selectedIndex>0)
		$p:=IT_UThermometer (1;0;__ ("Solicitando datos a SchoolNet…");-1)
		$idEvento:=atQR_SNEnviosIDEvento{$selectedIndex}
		WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)
		WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
		WEB SERVICE SET PARAMETER:C777("idevento";$idEvento)
		$err:=SN3_CallWebService ("sn3ws_Informes_proceso.consulta_alumnos_x_evento")
		If ($err="")
			
			WEB SERVICE GET RESULT:C779($resultadoJSON;"resultado";*)
			
			
			  // Modificado por: Alexis Bustamante (10-06-2017)
			  //TICKET Ticket 179869
			
			C_OBJECT:C1216($ob)
			ARRAY OBJECT:C1221($ao_registros;0)
			$ob:=JSON Parse:C1218($resultadoJSON;Is object:K8:27)
			OB_GET ($ob;->$ao_registros;"registros")
			
			  //$root:=JSON Parse text ($resultadoJSON)
			  //$registros:=JSON Get child by position ($root;1)
			  //ARRAY TEXT($nodes1;0)
			  //ARRAY LONGINT($types1;0)
			  //ARRAY TEXT($names1;0)
			  //ARRAY TEXT($values1;0)
			  //JSON GET CHILD NODES ($registros;$nodes1;$types1;$names1)
			
			If (Size of array:C274($ao_registros)>0)
				
				For ($i;1;Size of array:C274($ao_registros))
					$vl_vistoALU:=0
					$vl_vistoREL:=0
					$vl_downloadALU:=0
					$vl_downloadREL:=0
					
					  //ARRAY TEXT($nodes;0)
					  //ARRAY LONGINT($types;0)
					  //ARRAY TEXT($names;0)
					C_TEXT:C284($vt_id;$vt_vistoALU;$vt_vistoREL;$vt_downloadALU;$vt_downloadREL;$link;$id)
					
					OB_GET ($ao_registros{$i};->$vt_id;"idalumno")
					OB_GET ($ao_registros{$i};->$vt_vistoALU;"visto_alumno")
					OB_GET ($ao_registros{$i};->$vt_vistoREL;"visto_relacion")
					OB_GET ($ao_registros{$i};->$vt_downloadALU;"descargado_alumno")
					OB_GET ($ao_registros{$i};->$vt_downloadREL;"descargado_relacion")
					OB_GET ($ao_registros{$i};->$link;"link_descarga")
					
					$vl_vistoALU:=Num:C11($vt_vistoALU)
					$vl_vistoREL:=Num:C11($vt_vistoREL)
					$vl_downloadALU:=Num:C11($vt_downloadALU)
					$vl_downloadREL:=Num:C11($vl_downloadREL)
					$id:=$vt_id
					
					APPEND TO ARRAY:C911(alQR_SNEnviosIDRegistros;Num:C11($id))
					APPEND TO ARRAY:C911(atQR_SNEnviosLinkDownload;$link)
					
					APPEND TO ARRAY:C911(ab_visto_rel;($vl_vistoREL=1))
					APPEND TO ARRAY:C911(ab_visto_alu;($vl_vistoALU=1))
					APPEND TO ARRAY:C911(ab_descargado_rel;($vl_downloadREL=1))
					APPEND TO ARRAY:C911(ab_descargado_alu;($vl_downloadALU=1))
				End for 
				
				  //For ($j;1;Size of array($nodes1))
				  //$vl_vistoALU:=0
				  //$vl_vistoREL:=0
				  //$vl_downloadALU:=0
				  //$vl_downloadREL:=0
				
				  //ARRAY TEXT($nodes;0)
				  //ARRAY LONGINT($types;0)
				  //ARRAY TEXT($names;0)
				
				
				  //JSON GET CHILD NODES ($nodes1{$j};$nodes;$types;$names)
				  //$id:=Num(JSON Get text ($nodes{1}))
				  //  //MONO TICKET 145401 lo hago con "find in array" por que el defecto que habia era por que esto marcaba una posición donde realmente no venia el dato que se esperaba.
				  //$fia:=Find in array($names;"link_descarga")
				  //If ($fia>0)
				  //$link:=JSON Get text ($nodes{$fia})
				  //Else 
				  //$link:=""
				  //End if 
				
				  //  //Mono ticket 142225
				  //$fia:=Find in array($names;"visto_relacion")
				  //If ($fia>0)
				  //$vl_vistoREL:=JSON Get long ($nodes{$fia})
				  //End if 
				  //$fia:=Find in array($names;"visto_alumno")
				  //If ($fia>0)
				  //$vl_vistoALU:=JSON Get long ($nodes{$fia})
				  //End if 
				  //$fia:=Find in array($names;"descargado_relacion")
				  //If ($fia>0)
				  //$vl_downloadREL:=JSON Get long ($nodes{$fia})
				  //End if 
				  //$fia:=Find in array($names;"descargado_alumno")
				  //If ($fia>0)
				  //$vl_downloadALU:=JSON Get long ($nodes{$fia})
				  //End if 
				
				  //APPEND TO ARRAY(alQR_SNEnviosIDRegistros;$id)
				  //APPEND TO ARRAY(atQR_SNEnviosLinkDownload;$link)
				
				  //APPEND TO ARRAY(ab_visto_rel;($vl_vistoREL=1))
				  //APPEND TO ARRAY(ab_visto_alu;($vl_vistoALU=1))
				  //APPEND TO ARRAY(ab_descargado_rel;($vl_downloadREL=1))
				  //APPEND TO ARRAY(ab_descargado_alu;($vl_downloadALU=1))
				  //End for 
				
				
				Case of 
					: (Table:C252(vyQR_TablePointer)=Table:C252(->[Alumnos:2]))
						READ ONLY:C145(vyQR_TablePointer->)
						For ($x;1;Size of array:C274(alQR_SNEnviosIDRegistros))
							If (Find in field:C653([Alumnos:2]numero:1;alQR_SNEnviosIDRegistros{$x})#-1)
								$nombre:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->alQR_SNEnviosIDRegistros{$x};->[Alumnos:2]apellidos_y_nombres:40)
								$curso:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->alQR_SNEnviosIDRegistros{$x};->[Alumnos:2]curso:20)
								APPEND TO ARRAY:C911(atQR_SNEnviosRegistros;$nombre)
								APPEND TO ARRAY:C911(atQR_SNEnviosCursos;$curso)
							End if 
						End for 
						
						  //Mono ticket 142225
						C_LONGINT:C283(vTitCurso;vTit3;vTit4;vTit5;vTit6)
						LISTBOX DELETE COLUMN:C830(lbRegistros;2;LISTBOX Get number of columns:C831(lbRegistros)-1)
						LISTBOX INSERT COLUMN:C829(lbRegistros;2;"Curso";atQR_SNEnviosCursos;"Curso";vTitCurso)
						
						LISTBOX INSERT COLUMN:C829(lbRegistros;3;"VR";ab_visto_rel;"VR";vTit3)  //visto relacion familiar
						LISTBOX INSERT COLUMN:C829(lbRegistros;4;"VA";ab_visto_alu;"VA";vTit4)  //visto alumno
						LISTBOX INSERT COLUMN:C829(lbRegistros;5;"DR";ab_descargado_rel;"DR";vTit5)  //download relacion familiar
						LISTBOX INSERT COLUMN:C829(lbRegistros;6;"DA";ab_descargado_alu;"DA";vTit6)  //download alumno
						
						OBJECT SET TITLE:C194(vTitCurso;"Curso")
						OBJECT SET FONT STYLE:C166(vTitCurso;Bold:K14:2)
						
						OBJECT SET TITLE:C194(vTit3;"VF")
						OBJECT SET FONT STYLE:C166(vTit3;Bold:K14:2)
						OBJECT SET HELP TIP:C1181(vTit3;"Visto por familiar")
						OBJECT SET TITLE:C194(vTit4;"VA")
						OBJECT SET FONT STYLE:C166(vTit4;Bold:K14:2)
						OBJECT SET HELP TIP:C1181(vTit4;"Visto por alumno")
						OBJECT SET TITLE:C194(vTit5;"DF")
						OBJECT SET FONT STYLE:C166(vTit5;Bold:K14:2)
						OBJECT SET HELP TIP:C1181(vTit5;"Descargado por familiar")
						OBJECT SET TITLE:C194(vTit6;"DA")
						OBJECT SET FONT STYLE:C166(vTit6;Bold:K14:2)
						OBJECT SET HELP TIP:C1181(vTit6;"Descargado por alumno")
						
						OBJECT GET COORDINATES:C663(lbRegistros;$l;$t;$r;$b)
						$w:=$r-$l-18
						$w1:=$w*0.6
						$w2:=$w*0.2
						$w3:=$w*0.05
						$w4:=$w*0.05
						$w5:=$w*0.05
						$w6:=$w*0.05
						
						LISTBOX SET COLUMN WIDTH:C833(atQR_SNEnviosRegistros;$w1)
						LISTBOX SET COLUMN WIDTH:C833(atQR_SNEnviosCursos;$w2)
						LISTBOX SET COLUMN WIDTH:C833(ab_visto_rel;$w3)
						LISTBOX SET COLUMN WIDTH:C833(ab_visto_alu;$w4)
						LISTBOX SET COLUMN WIDTH:C833(ab_descargado_rel;$w5)
						LISTBOX SET COLUMN WIDTH:C833(ab_descargado_alu;$w6)
						
						OBJECT SET ENTERABLE:C238(ab_visto_rel;False:C215)
						OBJECT SET ENTERABLE:C238(ab_visto_alu;False:C215)
						OBJECT SET ENTERABLE:C238(ab_descargado_rel;False:C215)
						OBJECT SET ENTERABLE:C238(ab_descargado_alu;False:C215)
						
						SORT ARRAY:C229(atQR_SNEnviosRegistros;atQR_SNEnviosCursos;alQR_SNEnviosIDRegistros;atQR_SNEnviosLinkDownload;ab_visto_rel;ab_visto_alu;ab_descargado_rel;ab_descargado_alu)
						vTitRegistros:=0
				End case 
			End if 
			  //JSON CLOSE ($root)  //20150421 RCH Se agrega cierre
		Else 
			CD_Dlog (0;__ ("No se pudo establecer conexión con SchoolNet."))
		End if 
		IT_UThermometer (-2;$p)
	Else 
		ARRAY TEXT:C222(atQR_SNEnviosRegistros;0)
		ARRAY TEXT:C222(atQR_SNEnviosCursos;0)
		ARRAY LONGINT:C221(alQR_SNEnviosIDRegistros;0)
		ARRAY TEXT:C222(atQR_SNEnviosLinkDownload;0)
		  //Mono ticket 142225
		ARRAY BOOLEAN:C223(ab_descargado_rel;0)
		ARRAY BOOLEAN:C223(ab_descargado_alu;0)
		ARRAY BOOLEAN:C223(ab_visto_rel;0)
		ARRAY BOOLEAN:C223(ab_visto_alu;0)
		
		OBJECT SET ENABLED:C1123(bDownload;False:C215)
		OBJECT SET ENABLED:C1123(bEliminarRegistros;False:C215)
		
	End if 
End if 