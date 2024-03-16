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

.data
  RSPQ_BeginOverlayHeader
    RSPQ_DefineCommand mulMat4Mat4, 12
  RSPQ_EndOverlayHeader

  RSPQ_EmptySavedState

.text

mulMat4Mat4:
  ldv $v27, 0, 0, $a1
  ldv $v27, 8, 0, $a1
  ldv $v28, 0, 8, $a1
  ldv $v28, 8, 8, $a1
  ldv $v25, 0, 16, $a1
  ldv $v25, 8, 16, $a1
  ldv $v26, 0, 24, $a1
  ldv $v26, 8, 24, $a1
  ldv $v23, 0, 32, $a1
  ldv $v23, 8, 32, $a1
  ldv $v24, 0, 40, $a1
  ldv $v24, 8, 40, $a1
  ldv $v21, 0, 48, $a1
  ldv $v21, 8, 48, $a1
  ldv $v22, 0, 56, $a1
  ldv $v22, 8, 56, $a1
  ldv $v19, 0, 0, $a2
  ldv $v20, 0, 8, $a2
  ldv $v19, 8, 16, $a2
  ldv $v20, 8, 24, $a2
  ldv $v17, 0, 32, $a2
  ldv $v18, 0, 40, $a2
  ldv $v17, 8, 48, $a2
  ldv $v18, 8, 56, $a2
  vmudl $v29, $v28, $v20.h0
  vmadm $v29, $v27, $v20.h0
  vmadn $v16, $v28, $v19.h0
  vmadh $v15, $v27, $v19.h0
  vmadl $v29, $v26, $v20.h1
  vmadm $v29, $v25, $v20.h1
  vmadn $v16, $v26, $v19.h1
  vmadh $v15, $v25, $v19.h1
  vmadl $v29, $v24, $v20.h2
  vmadm $v29, $v23, $v20.h2
  vmadn $v16, $v24, $v19.h2
  vmadh $v15, $v23, $v19.h2
  vmadl $v29, $v22, $v20.h3
  vmadm $v29, $v21, $v20.h3
  vmadn $v20, $v22, $v19.h3
  vmadh $v19, $v21, $v19.h3
  vmudl $v29, $v28, $v18.h0
  vmadm $v29, $v27, $v18.h0
  vmadn $v16, $v28, $v17.h0
  vmadh $v15, $v27, $v17.h0
  vmadl $v29, $v26, $v18.h1
  vmadm $v29, $v25, $v18.h1
  vmadn $v16, $v26, $v17.h1
  vmadh $v15, $v25, $v17.h1
  vmadl $v29, $v24, $v18.h2
  vmadm $v29, $v23, $v18.h2
  vmadn $v16, $v24, $v17.h2
  vmadh $v15, $v23, $v17.h2
  vmadl $v29, $v22, $v18.h3
  vmadm $v29, $v21, $v18.h3
  vmadn $v18, $v22, $v17.h3
  vmadh $v17, $v21, $v17.h3
  sdv $v20, 0, 8, $a0
  sdv $v19, 8, 16, $a0
  sdv $v20, 8, 24, $a0
  sdv $v17, 0, 32, $a0
  sdv $v18, 0, 40, $a0
  sdv $v17, 8, 48, $a0
  sdv $v18, 8, 56, $a0
  j RSPQ_Loop
  sdv $v19, 0, 0, $a0

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
