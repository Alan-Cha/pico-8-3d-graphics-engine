-- Data types
-- Matrix - nested tables such that the inner tables are all the same size

-- @desc multiply two matrices and return the resulting matrix
-- @params m1 (Matrix), m2 (Matrix)
-- @return Matrix
function multiplyMatrices(m1, m2) 
 -- get dimensions of the two matrices
 local m1RowSize, m1ColumnSize = getMatrixSize(m1)
 local m2RowSize, m2ColumnSize = getMatrixSize(m2)

 -- TODO: removable
 -- error check
 if (m1RowSize != m2ColumnSize) error("Matrix sizes do not match")

 -- create the matrix that will be returned in the end
 local matrix = createEmptyMatrix(m2RowSize, m1ColumnSize)

 for i = 1, m2RowSize do
  for j = 1, m1ColumnSize do
   local sum = 0

   for k = 1, m1ColumnSize do
    sum += m1[i][k] * m2[k][j]
   end

   matrix[i][j] = sum
  end
 end

 return matrix
end

-- @desc for a given matrix, get the number or rows and columns
-- @params m (Matrix) 
-- @return number - the number of rows in the matrix, number - the number of columns in the matrix
function getMatrixSize(m)
 local rows = m.length
 local columns = m[0].length

 return rows, columns
end

-- @desc for a given row size and column size, create an empty matrix
-- @params rowSize (number) - number of rows, columnSize (number) - number of columns
-- @returns Matrix
function createEmptyMatrix(rowSize, columnSize)
 local matrix = {}

 for i = 1, rowSize do
  local vector = {}

  for j = 1, columnSize do
   add(vector, 0)
  end

  add(matrix, vector)
 end

 return matrix
end