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
  push %rsi
  push %rdx

  /* Frame layout:
       48 - frame size
       40 - fill value
       32 - saved RA
       24 - saved flags
       16 - saved RDI
       8  - saved RSI
       0  - saved RDX
   */

  mov 48(%rsp), %rdi  // frame size

  lea 48(%rsp), %rdx
  add %rdi, %rdx  // stop address

  lea 48(%rsp), %rdi  // start address

  mov 40(%rsp), %rsi  # fill value

  # TODO: rep stosd (Oleg)
next:
  cmp %rdi, %rdx
  je done
  mov %esi, (%rdi)
  add $4, %rdi
  jmp next

done:
  pop %rdx
  pop %rsi
  pop %rdi
  popf

  ret
