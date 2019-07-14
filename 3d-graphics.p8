pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
 near = 10
 far = 1000
 fov = 0.25

 perspective_matrix = create_perspective_matrix()

 cube = {
  -- SOUTH
		{ create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 0, 40, 0 }),    create_vector_matrix({ 40, 40, 0 }) },
		{ create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 40, 40, 0 }),    create_vector_matrix({ 40, 0, 0 }) },

		-- EAST                                                      
		{ create_vector_matrix({ 40, 0, 0 }),    create_vector_matrix({ 40, 40, 0 }),    create_vector_matrix({ 40, 40, 40 }) },
		{ create_vector_matrix({ 40, 0, 0 }),    create_vector_matrix({ 40, 40, 40 }),    create_vector_matrix({ 40, 0, 40 }) },

		-- NORTH                                                     
		{ create_vector_matrix({ 40, 0, 40 }),    create_vector_matrix({ 40, 40, 40 }),    create_vector_matrix({ 0, 40, 40 }) },
		{ create_vector_matrix({ 40, 0, 40 }),    create_vector_matrix({ 0, 40, 40 }),    create_vector_matrix({ 0, 0, 40 }) },

		-- WEST                                                      
		{ create_vector_matrix({ 0, 0, 40 }),    create_vector_matrix({ 0, 40, 40 }),    create_vector_matrix({ 0, 40, 0 }) },
		{ create_vector_matrix({ 0, 0, 40 }),    create_vector_matrix({ 0, 40, 0 }),    create_vector_matrix({ 0, 0, 0 }) },

		-- TOP                                                       
		{ create_vector_matrix({ 0, 40, 0 }),    create_vector_matrix({ 0, 40, 40 }),    create_vector_matrix({ 40, 40, 40 }) },
		{ create_vector_matrix({ 0, 40, 0 }),    create_vector_matrix({ 40, 40, 40 }),    create_vector_matrix({ 40, 40, 0 }) },

		-- BOTTOM                                                    
		{ create_vector_matrix({ 40, 0, 40 }),    create_vector_matrix({ 0, 0, 40 }),    create_vector_matrix({ 0, 0, 0 }) },
		{ create_vector_matrix({ 40, 0, 40 }),    create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 40, 0, 0 }) },
 }

 for triangle in all(cube) do
  -- print_matrix(triangle[0]) 
  -- print(triangle)

  -- projected_triangle = multiply_matrices(perspective_matrix, triangle)
  projected_triangle = {
   homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[1])),
   homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[2])),
   homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[3]))
  }

  print_matrix(projected_triangle[1])

  -- draw_triangle(projected_triangle)
 end
 -- cls()
 -- draw_triangle( {create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 0, 40, 0 }),    create_vector_matrix({ 40, 40, 0 })} )
end


-- function _draw()
--  cls()

--  for triangle in all(cube) do
--   -- print_matrix(triangle[0]) 
--   -- print(triangle)

--   -- projected_triangle = multiply_matrices(perspective_matrix, triangle)
--   projected_triangle = {
--    homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[1])),
--    homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[2])),
--    homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[3]))
--   }

--   draw_triangle(projected_triangle)
--  end
-- end


function create_perspective_matrix()
 local perspective_matrix = create_empty_matrix(4, 4)

 local cotan_component = 1 / tan(fov / 2)

 perspective_matrix[1][1] = cotan_component
 perspective_matrix[2][2] = cotan_component
 perspective_matrix[3][3] = (far + near) / (far - near)
 perspective_matrix[3][4] = -1
 perspective_matrix[4][3] = 2 * far * near / (far - near)

 return perspective_matrix
end


function tan(angle)
 return sin(angle) / cos(angle)
end


function draw_triangle(triangle)
 color(8)

 line(triangle[1][1][1] * 128, triangle[1][2][1] * 128, triangle[2][1][1] * 128, triangle[2][2][1] * 128)
 line(triangle[3][1][1] * 128, triangle[3][2][1] * 128)
 line(triangle[1][1][1] * 128, triangle[1][2][1] * 128)
end

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
 if (m1_column_size != m2_row_size) error("Matrix sizes do not match")

 -- create the matrix that will be returned in the end
 local matrix = create_empty_matrix(m1_row_size, m2_column_size)

 -- cycle index of new matrix
 for m1_row_index = 1, m1_row_size do
  for m2_column_index = 1, m2_column_size do
   local sum = 0

   -- m1_row_size is the same as m2_column_size so either can be used
   for row_column_index = 1, m1_column_size do
    sum += m1[m1_row_index][row_column_index] * m2[row_column_index][m2_column_index]
   end

   matrix[m1_row_index][m2_column_index] = sum
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


-- TODO: simply by assuming array of size 3
function create_vector_matrix(coordinates)
 local vector = create_empty_matrix(#coordinates + 1, 1)

 for i = 1, #coordinates do
  vector[i][1] = coordinates[i]
 end

 vector[#coordinates + 1][1] = 1

 return vector
end


function homogenous_coordinate(m)
 m[1][1] /= m[4][1]
 m[2][1] /= m[4][1]
 m[3][1] /= m[4][1]
 m[4][1] = 1

 return m
end

-- @desc print a matrix in human-readable form 
-- @params Matrix m
-- @return void
function print_matrix(m) 
 -- opening bracket
 print('{')

 for i = 1, #m do
  local line = ' {'

  for j = 1, #m[1] do
   line = line..m[i][j]..', '
  end
  
  -- remove `, `
  line = sub(line, 1, #line - 2)

  -- trailing comma
  if (i == #m) then
   print(line..'}')
  else
   print(line..'},')
  end
 end

 -- closing bracket
 print('}')
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
