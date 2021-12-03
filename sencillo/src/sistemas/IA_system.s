.module sys_IA
.include "cpctelera.h.s"
.include "datos/macros.s"

sys_IA_init::
	ld (ent_array),ix
ret
sys_IA_update::
	;;puntero automodificable
	ent_array=.+2
	ld ix,#0x0000

loop:
	ld a,e_ancho(ix)     ;|A=ancho_entidad
	cp #e_novalida    ;|if A==0 ret
	ret z             ;|

	ld a,e_componente(ix)
	and #entidad_con_IA
	jr z,Entidad_sin_ia
tiene_IA:
	;;crea comportamiento para entidad
	
	;ld e_vx(ix),#1
	;ld e_vy(ix),#1
Entidad_sin_ia:
	ld de,#e_sizeof
	add ix,de
	jr loop

ret
