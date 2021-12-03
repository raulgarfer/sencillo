.module seleccion_pantalla.s
.include "cpctelera.h.s"
.include "datos/macros.s"
.include "seleccion_pantalla.h.s"
.include "cpc_funciones.h.s"


pantalla_init::
	ld (array_pantalla),ix
	ld (array_pantalla_3),ix
	ld (array_pantalla_4),ix
ret

seleccion_pantalla::
	cpctm_clearScreen_asm #0
	or a
	ld (tesoro_recogido),a
	call marcador
ret
turno_pantalla::
	or a
	ld (tesoro_recogido),a

	ld a,(pantalla)
	inc a
	ld (pantalla),a
	ld b,a
		cp #1
			call z,pantalla1
		ld a,b
		cp #2
			call z,pantalla2
		ld a,b
		cp #3
			call z,pantalla3
		ld a,b
		cp #4
			call z,pantalla4
		ld a,b
		cp #5
			jp z,juego_pasado
ret
pantalla1::
	ld hl,#jugador
   	call crea_entidades
	ld hl,#joya
   	call crea_entidades
   	ld hl,#puerta
   	call crea_entidades
ret
pantalla2::
	array_pantalla = .+2
	ld ix,#0x0000

	ld e_x(ix),#8		;;XY de jugador al 0,0
	ld e_y(ix),#8
	
	ld bc,#e_sizeof		;;cambia los valores XY de joya
	add ix,bc
	ld e_x(ix),#40
	ld e_y(ix),#40
	ld hl,#enemigo
	call crea_entidades
	ld hl,#joya
   	call crea_entidades
;;lleva el registro IX hasta la entidad joya
	ld bc,#e_sizeof		;;cambia los valores XY de joya
	ld bc,#e_sizeof		;;cambia los valores XY de joya

	add ix,bc
	ld e_x(ix),#10
	ld e_y(ix),#70

ret
pantalla3::
	array_pantalla_3 = .+2
	ld ix,#0x0000

	ld e_x(ix),#8		;;XY de jugador 
	ld e_y(ix),#8
	
	ld bc,#e_sizeof		;;cambia los valores XY de joya
	add ix,bc
	ld e_x(ix),#20
	ld e_y(ix),#30
	ld hl,#vagoneta
	call crea_entidades
	

ret
pantalla4::
	array_pantalla_4 = .+2
	ld ix,#0x0000

	ld e_x(ix),#8		;;XY de jugador 
	ld e_y(ix),#8
	
	ld bc,#e_sizeof		;;cambia los valores XY de joya
	add ix,bc
	ld e_x(ix),#30
	ld e_y(ix),#100
ret
;;================================================
;;juego pasado
;;
fin_1: .asciz "Felicidades.Espero tus comentarios en el canal."
juego_pasado:
 ld c,#2
	call cpct_setVideoMode_asm
		cpctm_clearScreen_asm #0
	
    cpctm_screenPtr_asm HL,0xc000,0,10
   
    ld iy,#fin_1
    call cpct_drawStringM2_asm
    call espera_espacio
    jp _main
ret
;;================================================
;;espera espacio
;;
espera_espacio:
	call cpct_scanKeyboard_asm
	ld hl,#Key_Space
	call cpct_isKeyPressed_asm
	jr z,espera_espacio
ret
