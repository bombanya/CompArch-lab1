#include <stdio.h>

#define N 4
#define M 3

void max_from_matrix(int matrix[M][N], int result[2]){
    int max = matrix[0][0], maxRow = 0, maxColumn = 0;
    for (int i = 0; i < M; i++){
        for (int j = 0; j < N; j++){
            if (matrix[i][j] > max){
                max = matrix[i][j];
                maxRow = i;
                maxColumn = j;
            }
        }
    }
    result[0] = maxRow;
    result[1] = maxColumn;
}

int main() {

    int matrix[M][N];
    int result[2];

    for (int i = 0; i < M; i++){
        for (int j = 0; j < N; j++){
            scanf("%d", &matrix[i][j]);
        }
    }

    max_from_matrix(matrix, result);
    printf("(%d,%d)\n", result[0], result[1]);
    return 0;
}
