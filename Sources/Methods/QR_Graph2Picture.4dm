//%attributes = {}
  // QR_Graph2Picture
  // Saúl Ponce - 16 de Marzo 2015
  // Se reincorpora el método para trabajar con graph() y graph settings() en lugar del método que utilizabamos en 11.8
Case of 
	: (Count parameters:C259>3)
		
		C_BOOLEAN:C305(NoLegend)
		C_PICTURE:C286(imagen)
		C_LONGINT:C283(i;graph_type;vl_ancho1;vl_alto1;vl_fontsize;Categoria;Serie;CTArea;vl_fontID;colorID;vl_orient;vl_location)
		C_POINTER:C301(pointer_serie;pointer_categ;pointer_valores;pointercolor)
		C_TEXT:C284(msg_error;vt_font;title;$vt_comando)
		
		ARRAY TEXT:C222(arraycolor;0)
		msg_error:=""
		
		
		C_POINTER:C301(y_puntero)
		C_TEXT:C284(vt_nombres;vt_serie1)
		C_LONGINT:C283(vl_cantElementos;vl_buclePrincipal;vl_bucleSec;vl_posicion;vl_auxiliar;w;x;vl_cantSeries)
		vt_nombres:=""
		vt_serie1:=""
		
		graph_type:=$1
		
		  //cambiaron los tipos de gráficos
		If (graph_type=1)
			graph_type:=5
		Else 
			If (graph_type=2)
				graph_type:=1
			Else 
				If (graph_type=3)
					graph_type:=8
				Else 
					If (graph_type=4)
						graph_type:=4
					Else 
						If (graph_type=5)
							graph_type:=1  // no encontré equivalente para el gráfico de disperción
						Else 
							If (graph_type=6)
								graph_type:=7
							Else 
								If (graph_type=7)
									graph_type:=1
								Else 
									If (graph_type=8)
										graph_type:=1
									Else 
										If (graph_type=9)
											graph_type:=1
										Else 
											If (graph_type=100)
												graph_type:=1
											Else 
												If (graph_type=101)
													graph_type:=1
												Else 
													If (graph_type=101)
														graph_type:=1
													Else 
														If (graph_type=102)
															graph_type:=1
														Else 
															If (graph_type=103)
																graph_type:=1
															Else 
																If (graph_type=104)
																	graph_type:=1
																Else 
																	If (graph_type=105)
																		graph_type:=1
																	Else 
																		graph_type:=1
																	End if 
																End if 
															End if 
														End if 
													End if 
												End if 
											End if 
										End if 
									End if 
								End if 
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		
		pointer_categ:=$2
		pointer_serie:=$3
		pointer_valores:=$4
		
		
		  //recepcion de parámetros adicionales - no se utilizarán todos
		If (True:C214)
			If (Count parameters:C259>=5)
				vl_ancho1:=$5
			Else 
				vl_ancho1:=320
			End if 
			
			If (Count parameters:C259>=6)
				vl_alto1:=$6
			Else 
				vl_alto1:=240
			End if 
			
			If (Count parameters:C259>=7)
				vt_font:=$7
			Else 
				vt_font:="Arial"
			End if 
			
			If (Count parameters:C259>=8)
				vl_fontsize:=$8
			Else 
				vl_fontsize:=8
			End if 
			
			If (Count parameters:C259>=9)
				pointercolor:=$9
			Else 
				pointercolor:=->arraycolor
			End if 
			
			If (Count parameters:C259>=10)
				title:=$10
			Else 
				title:=""
			End if 
			
			If (Count parameters:C259>=11)
				NoLegend:=$11
			Else 
				NoLegend:=True:C214
			End if 
			
			If (Count parameters:C259>=12)
				
				Case of 
					: ($12=True:C214)
						vl_orient:=1
					: ($12=False:C215)
						vl_orient:=0
					Else 
						vl_orient:=1
				End case 
				
			End if 
			
			If (Count parameters:C259>=13)
				If (($13>=1) & ($13<=8))
					vl_location:=$13
				Else 
					vl_location:=3
				End if 
			Else 
				vl_location:=3
			End if 
			
			If (Count parameters:C259>=14)
				mostrarValor:=$14
			Else 
				mostrarValor:=1
			End if 
			
		End if 
		
		  //comprueba el tipo de array que contiene los datos
		If (True:C214)
			C_TEXT:C284(vt_tipoArray;vt_nombreArray)
			vt_tipoArray:=""
			
			If (Type:C295(pointer_valores->)=17)  //date array
				vt_tipoArray:="DATE"
				vt_nombreArray:="ad_date"
			Else 
				If (Type:C295(pointer_valores->)=15)  //array integer
					vt_tipoArray:="INTEGER"
					vt_nombreArray:="ai_integer"
				Else 
					If (Type:C295(pointer_valores->)=16)  //array longint
						vt_tipoArray:="LONGINT"
						vt_nombreArray:="al_longint"
					Else 
						If (Type:C295(pointer_valores->)=14)  //array real
							vt_tipoArray:="REAL"
							vt_nombreArray:="ar_real"
						Else 
							If (Type:C295(pointer_valores->)=18)  //array text
								vt_tipoArray:="TEXT"
								vt_nombreArray:="at_text"
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		
		vl_cantSeries:=Size of array:C274(pointer_valores->)/Size of array:C274(pointer_categ->)
		
		For (w;1;vl_cantSeries)
			
			  //generar los arrays para los valores
			y_puntero:=Get pointer:C304(vt_nombreArray+String:C10(w))
			
			  //guardar el nombre de los arrays
			vt_nombres:=vt_nombres+vt_nombreArray+String:C10(w)
			
			  //guardar el nombre de las series
			vt_serie1:=vt_serie1+Char:C90(Double quote:K15:41)+pointer_serie->{w}+Char:C90(Double quote:K15:41)
			
			If (w<vl_cantSeries)
				vt_nombres:=vt_nombres+";"
				vt_serie1:=vt_serie1+";"
			End if 
		End for 
		
		vl_cantElementos:=Size of array:C274(pointer_valores->)/vl_cantSeries
		vl_buclePrincipal:=1
		vl_bucleSec:=1
		vl_auxiliar:=1
		
		  //bucle para separar los elementos de las diferentes categorias
		While (vl_buclePrincipal<=vl_cantElementos)
			
			While (vl_bucleSec<=vl_cantSeries)
				
				If (vl_buclePrincipal=1)
					vl_posicion:=vl_bucleSec
				Else 
					vl_posicion:=vl_cantSeries*vl_auxiliar+vl_bucleSec
				End if 
				
				y_puntero:=Get pointer:C304(vt_nombreArray+String:C10(vl_bucleSec))
				
				APPEND TO ARRAY:C911(y_puntero->;pointer_valores->{vl_posicion})
				
				vl_bucleSec:=vl_bucleSec+1
			End while 
			
			
			If (vl_buclePrincipal>1)
				vl_auxiliar:=vl_auxiliar+1
			End if 
			
			vl_bucleSec:=1
			vl_buclePrincipal:=vl_buclePrincipal+1
		End while 
		
		
		$vt_comando:="GRAPH(imagen;"+String:C10(graph_type)+";pointer_categ->;"+vt_nombres+")"
		  //FRRunTextRaw (vt_comando)
		EXECUTE FORMULA:C63($vt_comando)
		vt_comando:="GRAPH SETTINGS(imagen;0;0;0;0;False;False;True;"+vt_serie1+")"
		  //FRRunTextRaw (vt_comando)
		EXECUTE FORMULA:C63($vt_comando)
		$0:=imagen
		
End case 