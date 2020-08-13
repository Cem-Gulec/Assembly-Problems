#include <iostream>

using namespace std;

int main()
{
    int a1 = 3;
    int a2 = 4;

    int A[3][4] = {
        {3, 7, 8, 12},
        {5, 6, 7, 2},
        {4, 3, 2, 5}};

    int B[4][2] = {
        {2, 5},
        {6, 3},
        {7, 8},
        {9, 1}};

    int lenB = 8;
    int x = 8 / 4;
    // resulting array will be c[3][2]

    int C[3][2] = {0}; // consider 2 as x's value
                       /*
        {
            {0,0  0,1}
            {1,0  1,1}
            {2,0  2,1}
        }

    */

    // for (int i = 0; i < a1; i++) // 3 times, one row of A each time
    // {
    //     for (int j = 0; j < x; j++) // 2 times
    //     {
    //         for (int k = 0; k < a2; k++)
    //         {
    //             C[i][j] = C[i][j] + (A[i][k] * B[k][j]);
    //         }
    //     }
    // }

    for (int i = 0; i < a1; i++) // 3 times, one row of A each time
    {
        for (int j = 0; j < x; j++) // 2 times
        {
            int res = 0;
            for (int k = 0; k < a2; k++)
            {
                res = res + (A[i][k] * B[k][j]);
            }
            cout << res << " ";
        }
        cout << endl;
    }
    
    // for (int i = 0; i < 3; ++i)
    // {
    //     for (int j = 0; j < 2; ++j)
    //     {
    //         std::cout << C[i][j] << ' ';
    //     }
    //     std::cout << std::endl;
    // }
}
