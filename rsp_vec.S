#include <rsp_queue.inc>

#define SLOT_SIZE 0x20
#define NUM_SLOTS 0x20

    .set noreorder
    .set at

    .data

RSPQ_BeginOverlayHeader
    RSPQ_DefineCommand VecCmd_Load,         8
    RSPQ_DefineCommand VecCmd_Store,        8
    RSPQ_DefineCommand VecCmd_Transform,    8
    RSPQ_DefineCommand mulMat4Mat4,    8
RSPQ_EndOverlayHeader

RSPQ_BeginSavedState
    .align 4
VEC_SLOTS: .ds.b NUM_SLOTS * SLOT_SIZE
RSPQ_EndSavedState

    .text

VecCmd_Load:
    j Vec_DMA
    li t2, DMA_IN

VecCmd_Store:
    li t2, DMA_OUT

Vec_DMA:
    andi s4, a1, 0xFFF0
    addiu s4, %lo(VEC_SLOTS)
    srl t0, a1, 16
    j DMAExec
    move s0, a0

VecCmd_Transform:
    #define trans_mtx t0
    #define trans_vec t1
    #define trans_out t2
    #define m0i $v01
    #define m0f $v02
    #define m1i $v03
    #define m1f $v04
    #define m2i $v05
    #define m2f $v06
    #define m3i $v07
    #define m3f $v08
    #define v01i $v09
    #define v01f $v10
    #define o01i $v13
    #define o01f $v14
    #define vtemp $v17

    srl trans_mtx, a1, 16
    andi trans_mtx, 0xFF0
    andi trans_vec, a1, 0xFF0
    andi trans_out, a0, 0xFF0

    addiu trans_mtx, %lo(VEC_SLOTS)
    addiu trans_vec, %lo(VEC_SLOTS)
    addiu trans_out, %lo(VEC_SLOTS)

    # Load matrix columns, repeating each column twice in a register
    ldv m0i,0x0,  0x00,trans_mtx
    ldv m0i,0x8,  0x00,trans_mtx
    ldv m0f,0x0,  0x10,trans_mtx
    ldv m0f,0x8,  0x10,trans_mtx
    ldv m1i,0x0,  0x08,trans_mtx
    ldv m1i,0x8,  0x08,trans_mtx
    ldv m1f,0x0,  0x18,trans_mtx
    ldv m1f,0x8,  0x18,trans_mtx
    ldv m2i,0x0,  0x20,trans_mtx
    ldv m2i,0x8,  0x20,trans_mtx
    ldv m2f,0x0,  0x30,trans_mtx
    ldv m2f,0x8,  0x30,trans_mtx
    ldv m3i,0x0,  0x28,trans_mtx
    ldv m3i,0x8,  0x28,trans_mtx
    ldv m3f,0x0,  0x38,trans_mtx
    ldv m3f,0x8,  0x38,trans_mtx

    # Load vector (a slot always contains two vectors)
    lqv v01i,0x0,  0x00,trans_vec
    lqv v01f,0x0,  0x10,trans_vec

    # Perform transformation by computing the dot products of the matrix rows with the vector.
    # We take advantage of the accumulator by letting it perform the addition automatically
    # with each multiplication.

    vmudl vtemp, m0f, v01f,e(0h) #   m(x,0) * v(0)
    vmadm vtemp, m0i, v01f,e(0h)
    vmadn vtemp, m0f, v01i,e(0h)
    vmadh vtemp, m0i, v01i,e(0h)

    vmadl vtemp, m1f, v01f,e(1h) # + m(x,1) * v(1)
    vmadm vtemp, m1i, v01f,e(1h)
    vmadn vtemp, m1f, v01i,e(1h)
    vmadh vtemp, m1i, v01i,e(1h)

    vmadl vtemp, m2f, v01f,e(2h) # + m(x,2) * v(2)
    vmadm vtemp, m2i, v01f,e(2h)
    vmadn vtemp, m2f, v01i,e(2h)
    vmadh vtemp, m2i, v01i,e(2h)

    vmadl vtemp, m3f, v01f,e(3h) # + m(x,3) * v(3)
    vmadm vtemp, m3i, v01f,e(3h)
    vmadn o01f,  m3f, v01i,e(3h)
    vmadh o01i,  m3i, v01i,e(3h)

    # Write result
    sqv o01i,0x0,  0x00,trans_out
    jr ra
    sqv o01f,0x0,  0x10,trans_out

    #undef trans_mtx
    #undef trans_vec
    #undef trans_out
    #undef m0i
    #undef m0f
    #undef m1i
    #undef m1f
    #undef m2i
    #undef m2f
    #undef m3i
    #undef m3f
    #undef v01i
    #undef v01f
    #undef o01i
    #undef o01f
    #undef vtemp

## Auto-generated file, transpiled with RSPL
#include <rsp_queue.inc>
#include <rdpq_macros.h>

.set noreorder
.set noat
.set nomacro

#undef zero
#undef at
#undef v0
#undef v1
#undef a0
#undef a1
#undef a2
#undef a3
#undef t0
#undef t1
#undef t2
#undef t3
#undef t4
#undef t5
#undef t6
#undef t7
#undef s0
#undef s1
#undef s2
#undef s3
#undef s4
#undef s5
#undef s6
#undef s7
#undef t8
#undef t9
#undef k0
#undef k1
#undef gp
#undef sp
#undef fp
#undef ra
.equ hex.$zero, 0
.equ hex.$at, 1
.equ hex.$v0, 2
.equ hex.$v1, 3
.equ hex.$a0, 4
.equ hex.$a1, 5
.equ hex.$a2, 6
.equ hex.$a3, 7
.equ hex.$t0, 8
.equ hex.$t1, 9
.equ hex.$t2, 10
.equ hex.$t3, 11
.equ hex.$t4, 12
.equ hex.$t5, 13
.equ hex.$t6, 14
.equ hex.$t7, 15
.equ hex.$s0, 16
.equ hex.$s1, 17
.equ hex.$s2, 18
.equ hex.$s3, 19
.equ hex.$s4, 20
.equ hex.$s5, 21
.equ hex.$s6, 22
.equ hex.$s7, 23
.equ hex.$t8, 24
.equ hex.$t9, 25
.equ hex.$k0, 26
.equ hex.$k1, 27
.equ hex.$gp, 28
.equ hex.$sp, 29
.equ hex.$fp, 30
.equ hex.$ra, 31
#define vco 0
#define vcc 1
#define vce 2

.text

mulMat4Mat4:
  ldv $v01, 0, 0, $s3
  ldv $v01, 8, 0, $s3
  ldv $v02, 0, 8, $s3
  ldv $v02, 8, 8, $s3
  ldv $v03, 0, 16, $s3
  ldv $v03, 8, 16, $s3
  ldv $v04, 0, 24, $s3
  ldv $v04, 8, 24, $s3
  ldv $v05, 0, 32, $s3
  ldv $v05, 8, 32, $s3
  ldv $v06, 0, 40, $s3
  ldv $v06, 8, 40, $s3
  ldv $v07, 0, 48, $s3
  ldv $v07, 8, 48, $s3
  ldv $v08, 0, 56, $s3
  ldv $v08, 8, 56, $s3
  ldv $v09, 0, 0, $s4
  ldv $v10, 0, 8, $s4
  ldv $v09, 8, 16, $s4
  ldv $v10, 8, 24, $s4
  ldv $v11, 0, 32, $s4
  ldv $v12, 0, 40, $s4
  ldv $v11, 8, 48, $s4
  ldv $v12, 8, 56, $s4
  vmudl $v29, $v02, $v10.h0
  vmadm $v29, $v01, $v10.h0
  vmadn $v14, $v02, $v09.h0
  vmadh $v13, $v01, $v09.h0
  vmadl $v29, $v04, $v10.h1
  vmadm $v29, $v03, $v10.h1
  vmadn $v14, $v04, $v09.h1
  vmadh $v13, $v03, $v09.h1
  vmadl $v29, $v06, $v10.h2
  vmadm $v29, $v05, $v10.h2
  vmadn $v14, $v06, $v09.h2
  vmadh $v13, $v05, $v09.h2
  vmadl $v29, $v08, $v10.h3
  vmadm $v29, $v07, $v10.h3
  vmadn $v10, $v08, $v09.h3
  vmadh $v09, $v07, $v09.h3
  vmudl $v29, $v02, $v12.h0
  vmadm $v29, $v01, $v12.h0
  vmadn $v14, $v02, $v11.h0
  vmadh $v13, $v01, $v11.h0
  vmadl $v29, $v04, $v12.h1
  vmadm $v29, $v03, $v12.h1
  vmadn $v14, $v04, $v11.h1
  vmadh $v13, $v03, $v11.h1
  vmadl $v29, $v06, $v12.h2
  vmadm $v29, $v05, $v12.h2
  vmadn $v14, $v06, $v11.h2
  vmadh $v13, $v05, $v11.h2
  vmadl $v29, $v08, $v12.h3
  vmadm $v29, $v07, $v12.h3
  vmadn $v12, $v08, $v11.h3
  vmadh $v11, $v07, $v11.h3
  sdv $v09, 0, 0, $s2
  sdv $v10, 0, 8, $s2
  sdv $v09, 8, 16, $s2
  sdv $v10, 8, 24, $s2
  sdv $v11, 0, 32, $s2
  sdv $v12, 0, 40, $s2
  sdv $v11, 8, 48, $s2
  sdv $v12, 8, 56, $s2
  jr $ra
  nop

#define zero $0
#define v0 $2
#define v1 $3
#define a0 $4
#define a1 $5
#define a2 $6
#define a3 $7
#define t0 $8
#define t1 $9
#define t2 $10
#define t3 $11
#define t4 $12
#define t5 $13
#define t6 $14
#define t7 $15
#define s0 $16
#define s1 $17
#define s2 $18
#define s3 $19
#define s4 $20
#define s5 $21
#define s6 $22
#define s7 $23
#define t8 $24
#define t9 $25
#define k0 $26
#define k1 $27
#define gp $28
#define sp $29
#define fp $30
#define ra $31

.set at
.set macro
