#include <libdragon.h>
#include <stdio.h>

#include "vec.h"
#define RSPQ_DEBUG 1
#define RSPQ_PROFILE 1
#define NUM_VECTOR_SLOTS 16
#define NUM_INT16_VECTORS                                                      \
  4 // We need 4 vectors to store 32 integers (vec_i16 is an array of 8 int16_t)

#define NUM_MATRICES 2 // Assuming you want to multiply two 4x4 matrices
mat4x4 *input_matrices;
mat4x4 *output_matrix;

void print_matrix(const mat4x4 matrix) {
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 4; j++) {
      printf("%ld ", matrix[i][j]);
    }
    printf("\n");
  }
  printf("\n");
}

int main() {
  // Initialize systems
  console_init();
  console_set_debug(true);
  debug_init_isviewer();
  debug_init_usblog();

  // Initialize the "vec" library (see vec.h)
  printf("Vec init\n");
  vec_init();
  printf("Vec init'd\n");

  // Allocate memory for DMA transfers
  /* input_vectors = */
  /*     malloc_uncached_aligned(8, sizeof(vec_i16) * NUM_VECTOR_SLOTS); */
  /* output_vectors = */
  /*     malloc_uncached_aligned(8, sizeof(vec_i16) * NUM_VECTOR_SLOTS); */

  input_matrices = malloc_uncached(sizeof(mat4x4) * NUM_MATRICES);
  output_matrix = malloc_uncached(sizeof(mat4x4));

  // Initialize the matrices with values from 1 to 16
  for (int i = 0; i < NUM_MATRICES; i++) {
    for (int j = 0; j < 4; j++) {
      for (int k = 0; k < 4; k++) {
        input_matrices[i][j][k] = i * 4 + j + k + 1;
      }
    }
  }

  /* printf("Original vectors (to be stored in RSP):\n"); */
  /* print_int16_vectors(input_vectors, NUM_INT16_VECTORS); */

  printf("Original matrix A:\n");
  print_matrix(input_matrices[0]);

  printf("Original matrix B:\n");
  print_matrix(input_matrices[1]);

  // Store the vectors to the RSP memory
  /* for (int j = 0; j < NUM_INT16_VECTORS; j++) { */
  /*   vec_i16_store(&input_vectors[j], j, */
  /*                 1); // Store each vec_i16 in a different RSP memory slot */
  /* } */
  /* rsp_load_data(input_vectors, sizeof(vec_i16) * NUM_INT16_VECTORS, 0); */
  printf("loading data\n");
  rsp_load_data(input_matrices, sizeof(mat4x4) * NUM_MATRICES, 0);

  // Wait for all storage operations to complete, note that this call is
  // blocking
  rspq_wait();
  printf("loaded data\n");

  // Perform matrix multiplication
  vec_i32_4x4_matmul((uint32_t)output_matrix, (uint32_t)&input_matrices[0],
                     (uint32_t)&input_matrices[1]);
  rspq_wait();
  // Load the vectors back from the RSP memory
  /* for (int j = 0; j < NUM_INT16_VECTORS; j++) { */
  /*   vec_i16_load(&output_vectors[j], j, */
  /*                1); // Load each vec_i16 from the corresponding RSP memory
   * slot */
  /* } */
  /* rsp_read_data(output_vectors, sizeof(vec_i16) * NUM_INT16_VECTORS, 0); */
  // Read the result back from RSP memory
  printf("reading data\n");
  rsp_read_data(output_matrix, sizeof(mat4x4), 0);

  // Wait for all loading operations to complete
  rspq_wait();

  /* printf("Loaded vectors (copied to-and-from RSP):\n"); */
  /* print_int16_vectors(output_vectors, NUM_INT16_VECTORS); */

  printf("Resulting matrix (A * B):\n");
  print_matrix(*output_matrix);

  printf("Done\n");
  // Clean up
  vec_close();

  return 0;
}
