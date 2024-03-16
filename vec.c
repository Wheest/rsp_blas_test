#include "vec.h"
#include <string.h>

DEFINE_RSP_UCODE(rsp_vec);

uint32_t vec_id;

void vec_init() {
  rspq_init();

  // Initialize the saved state
  void *state = UncachedAddr(rspq_overlay_get_state(&rsp_vec));
  memset(state, 0, 0x400);

  // Register the overlay
  vec_id = rspq_overlay_register(&rsp_vec);
}

void vec_close() { rspq_overlay_unregister(vec_id); }
