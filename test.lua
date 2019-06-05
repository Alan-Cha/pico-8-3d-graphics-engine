function _init()
 cls()

 -- print_matrix(create_empty_matrix(3, 3))
 -- print_matrix(create_empty_matrix(1, 3))
 -- print_matrix(create_empty_matrix(3, 1))
 -- print_matrix(create_empty_matrix(5, 5))

 -- ***

 -- matrix = create_empty_matrix(1, 3)
 -- row_size, column_size = get_matrix_size(matrix)
 -- print(row_size..', '..column_size)

 -- ***

 m1 = create_empty_matrix(1, 3)
 m1[1][1] = 1
 m1[1][2] = 2
 m1[1][3] = 3

 print_matrix(m1)

 -- identity matrix
 m2 = create_empty_matrix(3, 3)
 m2[1][1] = 1
 m2[2][2] = 1
 m2[3][3] = 1
 
 print_matrix(m2)

 m3 = multiply_matrices(m1, m2)
 
 print_matrix(m3)
end