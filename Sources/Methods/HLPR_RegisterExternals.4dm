//%attributes = {}
  // HLPR_RegisterExternals()
  // Por: Alberto Bachler: 02/09/13, 11:11:48
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_licenciaValida_ALP;$b_licenciaValida_hmBC;$b_licenciaValida_hmFree;$b_licenciaValida_OT;$b_licenciaValida_PgSQL;$b_licenciaValida_PLP;$b_licenciaValida_SRP)


  // LICENCIAS e-Node VALIDAS HASTA 20190831
  // licencia SRP
$b_licenciaValida_SRP:=(SR_Register ("008095-OEM COLEGIUM-NPG2DVjg/r6yNy/+PngbPVTGnhHtMvJZ")=0)  // SRP3
If (Not:C34($b_licenciaValida_SRP))
	$b_licenciaValida_SRP:=(SR_Register ("008096-OEM COLEGIUM-kwzZe7+J7dHPldBsvO2vNvnX5q2yNcBQ")=0)  // SRP4
End if 

  // licencia ALP
$b_licenciaValida_ALP:=(AL_Register ("008091-OEM COLEGIUM-FG1xAeeZ8pM2fPxqboSyODrKF96xbqyj")=0)  // ALP v9
If (Not:C34($b_licenciaValida_ALP))
	$b_licenciaValida_ALP:=(AL_Register ("008089-OEM COLEGIUM-L5rKsX7gFzSKXWZex3x7ot05EGscvF8m")=0)  // ALP v10
End if 

  // licencia PLP
$b_licenciaValida_PLP:=(PL_Register ("008092-OEM COLEGIUM-1UBIRF-1R5SAENO-HLLSEA44N6-ERRE88-KUCUFR9R")=0)  //PLP v5
If (Not:C34($b_licenciaValida_PLP))
	$b_licenciaValida_PLP:=$b_licenciaValida_PLP | (PL_Register ("008093-OEM COLEGIUM-NH1MTqSbPgwZ2ygSADt9Pcwu7C0lzNDy")=0)  // PLP v6
End if 


  //$b_licenciaValida_SRP:=(SR_Register ("007077-OEM COLEGIUM-sChnqoW74kwKF9HEEAhI/6m7MnpCdoEA")=0)
  //If (Not($b_licenciaValida_SRP))
  //$b_licenciaValida_SRP:=(SR_Register ("007078-OEM COLEGIUM-rKxw7VHFO8YGRjTtkcFrGPFGB6il2Wse")=0)
  //End if 

  //  // licencia ALP
  //$b_licenciaValida_ALP:=(AL_Register ("007073-OEM COLEGIUM-GdR2rJK6j+xroBKj0c4wv08OBGtBMMRC")=0)  // ALP v9
  //If (Not($b_licenciaValida_ALP))
  //$b_licenciaValida_ALP:=(AL_Register ("007071-OEM COLEGIUM-cNV2NYJ4rYgy/htoe+rR/ls+VHDaTdrp")=0)  // ALP v10
  //End if 

  //  // licencia PLP
  //$b_licenciaValida_PLP:=(PL_Register ("007074-OEM COLEGIUM-M/D9w+ODozrKiSkZTvogkBWVMLlxhIpb")=0)  //PLP v5
  //If (Not($b_licenciaValida_PLP))
  //$b_licenciaValida_PLP:=$b_licenciaValida_PLP | (PL_Register ("007075-OEM COLEGIUM-Mp8MqfhkWFEm8haoyyQKhksLYuiWhE8u")=0)  // PLP v6
  //End if 


  // licencia ObjectTools
$b_licenciaValida_OT:=(OT Register ("2BQo-9FFq-Fe2V-343T")=1)

  // Licencias Heubach Media
$b_licenciaValida_hmBC:=(hmBC_Register ("5PuAHSYj1AODAAAABsAGrBjIAMeAANAD0AHbALCEXd")>=0)
$b_licenciaValida_hmFree:=(hmFree_Register ("8DTAK2Yn7ACYAAAAGIALCBn6ABjAFVAJHAM5AA3HPZ")>=0)