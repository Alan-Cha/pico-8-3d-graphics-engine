function _init()
 cls()

 -- print_matrix(create_empty_matrix(3, 3))
 -- print_matrix(create_empty_matrix(1, 3))
 -- print_matrix(create_empty_matrix(3, 1))
 -- print_matrix(create_empty_matrix(5, 5))

 -- ***

 matrix = create_empty_matrix(1, 3)
 row_size, column_size = get_matrix_size(matrix)
 print(row_size..', '..column_size)
end