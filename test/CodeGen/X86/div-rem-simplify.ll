; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown | FileCheck %s

; FIXME: Div/rem by zero is undef.

define i32 @srem0(i32 %x) {
; CHECK-LABEL: srem0:
; CHECK:       # BB#0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movl %edx, %eax
; CHECK-NEXT:    retq
  %rem = srem i32 %x, 0
  ret i32 %rem
}

define i32 @urem0(i32 %x) {
; CHECK-LABEL: urem0:
; CHECK:       # BB#0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movl %edx, %eax
; CHECK-NEXT:    retq
  %rem = urem i32 %x, 0
  ret i32 %rem
}

define i32 @sdiv0(i32 %x) {
; CHECK-LABEL: sdiv0:
; CHECK:       # BB#0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    retq
  %div = sdiv i32 %x, 0
  ret i32 %div
}

define i32 @udiv0(i32 %x) {
; CHECK-LABEL: udiv0:
; CHECK:       # BB#0:
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    movl %edi, %eax
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    retq
  %div = udiv i32 %x, 0
  ret i32 %div
}

; FIXME: Div/rem by zero vectors is undef.

define <4 x i32> @srem_vec0(<4 x i32> %x) {
; CHECK-LABEL: srem_vec0:
; CHECK:       # BB#0:
; CHECK-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[3,1,2,3]
; CHECK-NEXT:    movd %xmm1, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %edx, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,2,3]
; CHECK-NEXT:    movd %xmm2, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %edx, %xmm2
; CHECK-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %edx, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %edx, %xmm0
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %rem = srem <4 x i32> %x, zeroinitializer
  ret <4 x i32> %rem
}

define <4 x i32> @urem_vec0(<4 x i32> %x) {
; CHECK-LABEL: urem_vec0:
; CHECK:       # BB#0:
; CHECK-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[3,1,2,3]
; CHECK-NEXT:    movd %xmm1, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %edx, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,2,3]
; CHECK-NEXT:    movd %xmm2, %eax
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %edx, %xmm2
; CHECK-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %edx, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %edx, %xmm0
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %rem = urem <4 x i32> %x, zeroinitializer
  ret <4 x i32> %rem
}

define <4 x i32> @sdiv_vec0(<4 x i32> %x) {
; CHECK-LABEL: sdiv_vec0:
; CHECK:       # BB#0:
; CHECK-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[3,1,2,3]
; CHECK-NEXT:    movd %xmm1, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %eax, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,2,3]
; CHECK-NEXT:    movd %xmm2, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %eax, %xmm2
; CHECK-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %eax, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    cltd
; CHECK-NEXT:    idivl %ecx
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %div = sdiv <4 x i32> %x, zeroinitializer
  ret <4 x i32> %div
}

define <4 x i32> @udiv_vec0(<4 x i32> %x) {
; CHECK-LABEL: udiv_vec0:
; CHECK:       # BB#0:
; CHECK-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[3,1,2,3]
; CHECK-NEXT:    movd %xmm1, %eax
; CHECK-NEXT:    xorl %ecx, %ecx
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %eax, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm2 = xmm0[1,1,2,3]
; CHECK-NEXT:    movd %xmm2, %eax
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %eax, %xmm2
; CHECK-NEXT:    punpckldq {{.*#+}} xmm2 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %eax, %xmm1
; CHECK-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; CHECK-NEXT:    movd %xmm0, %eax
; CHECK-NEXT:    xorl %edx, %edx
; CHECK-NEXT:    divl %ecx
; CHECK-NEXT:    movd %eax, %xmm0
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm0[0],xmm1[1],xmm0[1]
; CHECK-NEXT:    punpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; CHECK-NEXT:    movdqa %xmm1, %xmm0
; CHECK-NEXT:    retq
  %div = udiv <4 x i32> %x, zeroinitializer
  ret <4 x i32> %div
}
