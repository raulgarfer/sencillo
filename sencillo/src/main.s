;; Include all CPCtelera constant definitions, macros and variables
.include "cpctelera.h.s"
.include "datos/macros.s"
.include "main.h.s"
.area _DATA
;;==============================================
;;variables principales
;;
numero_entidades::   .db 0
puntuacion::         .db 0
vidas::              .db 3
pantalla::           .db 0
tesoro_recogido::    .db 0
;;declaracion para el uso en entidades
componente_enemigo     =(entidad_con_IA | entidad_pintable)

entidad_enemigo            = (entidad_pintable | entidad_mortal)
entidad_decoracion         = (entidad_pintable | entidad_solida)
entidad_obstaculo_mortal   = (entidad_pintable | entidad_mortal)
;;declaracion de plantilla de entidades
jugador::  Define_Entidad entidad_pintable,10,20,4, 12, _hero_left, 1,1,e_solido,entidad_pintable
enemigo::  Define_Entidad componente_enemigo,20,30,4,10, _enemy,   -1,0,e_enemy,entidad_enemigo
joya::     Define_Entidad entidad_pintable,40,60,4,8,_joya,    0,0,e_tesoro,entidad_pintable
puerta::   Define_Entidad entidad_pintable,60,80,4,8, _puerta,  0,0,e_salida,entidad_pintable
enemigo1:: Define_Entidad componente_enemigo,60,60,4,10, _enemy,   1,-1,e_enemy,entidad_enemigo  
vagoneta:: Define_Entidad entidad_pintable,10,80,4,8, _vagoneta,   -1,-1,e_enemy,entidad_enemigo  
ladrillo:: Define_Entidad entidad_pintable,10,170,4,8,_ladrillo,0,0,e_solido,entidad_decoracion
pincho_abajo:: Define_Entidad entidad_pintable,0,150,4,8,_pincho_abajo,0,0,e_solido,entidad_obstaculo_mortal
;;texto usado durante el juego
fin1:: .asciz "Gracias por jugar!!!.Unete al canal de telegram @cpctelera"
espacio::      .asciz "WASD/WAOP/Cursores"
controles::    .asciz "Coge los tesoros.   Esc salir"
linea1::       .asciz "Evita los enemigos. Pulsa Espacio"
player::       .asciz "Jugador"
enemy::        .asciz "Enemigo"
tesoro::       .asciz "Tesoro"
salida::       .asciz "Salida"
escudo::       .asciz "Escudo"
linea2::       .asciz "Granada,Spain 2021"
;;=========================================================
;; el juego salta aqui el principio
;;=========================================================
.area _CODE
_main::
   ;; Disable firmware to prevent it from interfering with string drawing
   call cpct_disableFirmware_asm
   cpctm_setBorder_asm #HW_RED
;;pone los valores del juego a su posicion original
   call reset_marcadores   
   ld c,#0
   call cpct_setVideoMode_asm

   call resetea_arrays

   call inicia_entidades 
   call reset_marcadores
   call resetea_entidades

   call sys_menu
      ;;llama a funciones para poner el array adecuado en cada una
   call get_array
   call pinta_entidad_init
   call sys_IA_init
   call fisica_init
   call colision_init
   call get_array
   call teclado_init
   call pantalla_init
   call marcador

   call turno_pantalla

loop:
   call game_update

   jr    loop
reset_marcadores::
   or a
   ld (pantalla),a
   ld (puntuacion),a
   ld (numero_entidades),a
   ld (tesoro_recogido),a
   ld a,#3
   ld (vidas),a
ret 
