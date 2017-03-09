// Copyright 2017 Yury Gribov
//
// Use of this source code is governed by MIT license that can be
// found in the LICENSE.txt file.

  .text

  .globl __rancc_fill
  .hidden __rancc_fill

__rancc_fill:
  pushf
  push %rdi
  push %rcx
  push %rax

  /* Frame layout:
       48 - frame size
       40 - fill value
       32 - saved RA
       24 - saved flags
       16 - saved RDI
       8  - saved RCX
       0  - saved RAX
   */

  mov 40(%rsp), %rax  // fill value
  mov 48(%rsp), %rcx  // frame size
  shrq $3, %rcx  // qword count
  lea 48(%rsp), %rdi  // start address
  cld
  rep stosq

  pop %rax
  pop %rcx
  pop %rdi
  popf

  ret
