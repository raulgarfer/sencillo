.module game_manager.s
.include "game_manager.h.s"
.include "cpctelera.h.s"

game_update::
	;call borra_entidad
    call escanea_teclado
    call fisica
	call pinta_entidad
	call comprueba_colision
	call sys_IA_update
	call cpct_waitVSYNC_asm
ret
