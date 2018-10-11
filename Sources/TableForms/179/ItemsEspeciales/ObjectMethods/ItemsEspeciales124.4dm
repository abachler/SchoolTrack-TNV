CD_Dlog (0;__ ("La configuración aplicará solo a los nuevos intereses que se generen."))
OBJECT SET ENABLED:C1123(*;"vr_afectoIVAIE";<>bint_AfectoExentoSegunCargo=0)
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)