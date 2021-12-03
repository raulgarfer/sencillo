.module pintado.s
.include "pintado.h.s"
.include "cpctelera.h.s"
.include "datos/macros.s"


pinta_entidad_init::
   ld (array_pinta_entidad),ix

ret

pinta_entidad::
   array_pinta_entidad = .+2
   ld ix,#0x0000
  loop_pintado:
   ld a,e_ancho(ix)     ;|A=ancho_entidad
      cp #e_novalida    ;|if A==0 ret
      ret z             ;|

      ld e,e_oldVMem+0(ix)
      ld d,e_oldVMem+1(ix)
      xor a 
      ld c,e_ancho(ix)
      ld b,e_alto(ix)
      push bc
         call cpct_drawSolidBox_asm
   ld   de, #CPCT_VMEM_START_ASM ;; DE = Pointer to start of the screen
   ld    b, e_y(ix)                  ;; B = y coordinate (24 = 0x18)
   ld    c, e_x(ix)                  ;; C = x coordinate (16 = 0x10)

   call cpct_getScreenPtr_asm    ;; Calculate video memory location and return it in HL
   
   ld e_oldVMem+0(ix),l          ;|se guarda la posicion antigua en la entidad
   ld e_oldVMem+1(ix),h          ;|

   ex de,hl

   ld l,e_sprite+0(ix)
   ld h,e_sprite+1(ix)
   pop bc
   call cpct_drawSprite_asm

   ld bc,#e_sizeof
   add ix,bc
   jr loop_pintado
   pinta_toda_entidad::
      ld hl,#pintable_Puntero_Array 
      ld a,l      ;;si HL*==0 ret
      or h        ;;
      ret z       ;;
      call pinta_entidad
   inc hl         ;;hl+=2
   inc hl
   jr pinta_toda_entidad


