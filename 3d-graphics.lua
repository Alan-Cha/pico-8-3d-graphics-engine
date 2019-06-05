-- Data types
-- Matrix - nested tables such that the inner tables are all the same size

-- @desc multiply two matrices and return the resulting matrix
-- @params Matrix m1
-- @params Matrix m2
-- @return Matrix
function multiply_matrices(m1, m2) 
 -- get dimensions of the two matrices
 local m1_row_size, m1_column_size = get_matrix_size(m1)
 local m2_row_size, m2_column_size = get_matrix_size(m2)

 -- TODO: removable
 -- error check
 if (m1_row_size != m2_column_size) error("Matrix sizes do not match")

 -- create the matrix that will be returned in the end
 local matrix = create_empty_matrix(m2_row_size, m1_column_size)

 for i = 1, m2_row_size do
  for j = 1, m1_column_size do
   local sum = 0

   -- m1_row_size is the same as m2_column_size so either can be used
   for k = 1, m1_row_size do
    sum += m1[i][k] * m2[k][j]
   end

   matrix[i][j] = sum
  end
 end

 return matrix
end


-- @desc for a given matrix, get the number or rows and columns
-- @params Matrix m
-- @return number - the number of rows in the matrix
-- @return number - the number of columns in the matrix
function get_matrix_size(m)
 local row_size = #m
 local column_size = #m[1]

 return row_size, column_size
end


-- @desc for a given row size and column size, create an empty matrix
-- @params number row_size - number of rows
-- @params number column_size - number of columns
-- @returns Matrix
function create_empty_matrix(row_size, column_size)
 local matrix = {}

 for i = 1, row_size do
  local vector = {}

  for j = 1, column_size do
   add(vector, 0)
  end

  add(matrix, vector)
 end

 return matrix
end