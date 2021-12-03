

##
## NEW MACROS
##

## 16 colours palette
#PALETTE=0 1 2 3 6 9 11 12 13 15 16 18 20 24 25 26

## Default values
$(eval $(call IMG2SP, SET_MODE        , 0                  )) 
#$(eval $(call IMG2SP, SET_MASK        , none               ))  { interlaced, none }
$(eval $(call IMG2SP, SET_FOLDER      , src/sprites               ))
#$(eval $(call IMG2SP, SET_EXTRAPAR    ,                    ))
#$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))	{ sprites, zgtiles, screen }
#$(eval $(call IMG2SP, SET_OUTPUT      , c                  ))  { bin, c }
#$(eval $(call IMG2SP, SET_PALETTE_FW  , $(PALETTE)         ))
#$(eval $(call IMG2SP, CONVERT_PALETTE , $(PALETTE), g_palette ))
#$(eval $(call IMG2SP, CONVERT         , img.png , w, h, array, palette, tileset))
#$(eval $(call IMG2SP, CONVERT         , src/assets/hero_down.png , 8, 8, hero_down))
$(eval $(call IMG2SP, SET_IMG_FORMAT  , sprites            ))

$(eval $(call IMG2SP, CONVERT         , src/assets/joya.png , 8, 8, joya))
$(eval $(call IMG2SP, CONVERT         , src/assets/ladrillo.png , 8, 8, ladrillo))
$(eval $(call IMG2SP, CONVERT         , src/assets/enemy.png , 8, 10, enemy))
$(eval $(call IMG2SP, CONVERT         , src/assets/puerta.png , 8, 8, puerta))
$(eval $(call IMG2SP, CONVERT         , src/assets/puerta_abierta.png , 8, 8, puerta_abierta))
$(eval $(call IMG2SP, CONVERT         , src/assets/interrogante.png , 8, 8, interrogante))
$(eval $(call IMG2SP, CONVERT         , src/assets/vagoneta.png , 8, 8, vagoneta))
$(eval $(call IMG2SP, CONVERT         , src/assets/via.png , 8, 8, via))

$(eval $(call IMG2SP, CONVERT         , src/assets/pincho_abajo.png , 8, 8, pincho_abajo))
$(eval $(call IMG2SP, CONVERT         , src/assets/pincho_arriba.png , 8, 8, pincho_arriba))
$(eval $(call IMG2SP, CONVERT         , src/assets/c_derecha.png , 16, 32, c_derecha))
$(eval $(call IMG2SP, CONVERT         , src/assets/c_izquierda.png , 16, 32, c_izquierda))

$(eval $(call IMG2SP, CONVERT         , src/assets/hero_left.png , 8, 12, hero_left))
$(eval $(call IMG2SP, CONVERT         , src/assets/hero_left_1.png , 8, 12, hero_left_1))
$(eval $(call IMG2SP, CONVERT         , src/assets/hero_right_2.png , 8, 12, hero_right_2))
$(eval $(call IMG2SP, CONVERT         , src/assets/hero_right.png , 8, 12, hero_right))

$(eval $(call IMG2SP, CONVERT         , src/assets/escudo.png , 8, 8, escudo))

$(eval $(call IMG2SP, SET_IMG_FORMAT  , zgtiles            ))	
$(eval $(call IMG2SP, CONVERT         , src/assets/tileset_32x8.png, 8, 8, tiles))



############################################################################
##              DETAILED INSTRUCTIONS AND PARAMETERS                      ##
##------------------------------------------------------------------------##
##                                                                        ##
## Macro used for conversion is IMG2SPRITES, which has up to 9 parameters:##
##  (1): Image file to be converted into C sprite (PNG, JPG, GIF, etc)    ##
##  (2): Graphics mode (0,1,2) for the generated C sprite                 ##
##  (3): Prefix to add to all C-identifiers generated                     ##
##  (4): Width in pixels of each sprite/tile/etc that will be generated   ##
##  (5): Height in pixels of each sprite/tile/etc that will be generated  ##
##  (6): Firmware palette used to convert the image file into C values    ##
##  (7): (mask / tileset / zgtiles)                                       ##
##     - "mask":    generate interlaced mask for all sprites converted    ##
##     - "tileset": generate a tileset array with pointers to all sprites ##
##     - "zgtiles": generate tiles/sprites in Zig-Zag pixel order and     ##
##                  Gray Code row order                                   ##
##  (8): Output subfolder for generated .C/.H files (in project folder)   ##
##  (9): (hwpalette)                                                      ##
##     - "hwpalette": output palette array with hardware colour values    ##
## (10): Aditional options (you can use this to pass aditional modifiers  ##
##       to cpct_img2tileset)                                             ##
##                                                                        ##
## Macro is used in this way (one line for each image to be converted):   ##
##  $(eval $(call IMG2SPRITES,(1),(2),(3),(4),(5),(6),(7),(8),(9), (10))) ##
##                                                                        ##
## Important:                                                             ##
##  * Do NOT separate macro parameters with spaces, blanks or other chars.##
##    ANY character you put into a macro parameter will be passed to the  ##
##    macro. Therefore ...,src/sprites,... will represent "src/sprites"   ##
##    folder, whereas ...,  src/sprites,... means "  src/sprites" folder. ##
##                                                                        ##
##  * You can omit parameters but leaving them empty. Therefore, if you   ##
##  wanted to specify an output folder but do not want your sprites to    ##
##  have mask and/or tileset, you may omit parameter (7) leaving it empty ##
##     $(eval $(call IMG2SPRITES,imgs/1.png,0,g,4,8,$(PAL),,src/))        ##
############################################################################
