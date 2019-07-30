function _init()
 near = 10
 far = 1000
 fov = 0.25

 perspective_matrix = create_perspective_matrix()

 print_matrix(perspective_matrix)

--  cube = {
--   -- SOUTH
-- 		{ create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 0, 1, 0 }),    create_vector_matrix({ 1, 1, 0 }) },
-- 		{ create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 1, 1, 0 }),    create_vector_matrix({ 1, 0, 0 }) },

-- 		-- EAST                                                      
-- 		{ create_vector_matrix({ 1, 0, 0 }),    create_vector_matrix({ 1, 1, 0 }),    create_vector_matrix({ 1, 1, 1 }) },
-- 		{ create_vector_matrix({ 1, 0, 0 }),    create_vector_matrix({ 1, 1, 1 }),    create_vector_matrix({ 1, 0, 1 }) },

-- 		-- NORTH                                                     
-- 		{ create_vector_matrix({ 1, 0, 1 }),    create_vector_matrix({ 1, 1, 1 }),    create_vector_matrix({ 0, 1, 1 }) },
-- 		{ create_vector_matrix({ 1, 0, 1 }),    create_vector_matrix({ 0, 1, 1 }),    create_vector_matrix({ 0, 0, 1 }) },

-- 		-- WEST                                                      
-- 		{ create_vector_matrix({ 0, 0, 1 }),    create_vector_matrix({ 0, 1, 1 }),    create_vector_matrix({ 0, 1, 0 }) },
-- 		{ create_vector_matrix({ 0, 0, 1 }),    create_vector_matrix({ 0, 1, 0 }),    create_vector_matrix({ 0, 0, 0 }) },

-- 		-- TOP                                                       
-- 		{ create_vector_matrix({ 0, 1, 0 }),    create_vector_matrix({ 0, 1, 1 }),    create_vector_matrix({ 1, 1, 1 }) },
-- 		{ create_vector_matrix({ 0, 1, 0 }),    create_vector_matrix({ 1, 1, 1 }),    create_vector_matrix({ 1, 1, 0 }) },

-- 		-- BOTTOM                                                    
-- 		{ create_vector_matrix({ 1, 0, 1 }),    create_vector_matrix({ 0, 0, 1 }),    create_vector_matrix({ 0, 0, 0 }) },
-- 		{ create_vector_matrix({ 1, 0, 1 }),    create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 1, 0, 0 }) },
--  }

--  for triangle in all(cube) do
--   -- print_matrix(triangle[0]) 
--   -- print(triangle)

--   -- projected_triangle = multiply_matrices(perspective_matrix, triangle)
--   projected_triangle = {
--    homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[1])),
--    homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[2])),
--    homogenous_coordinate(multiply_matrices(perspective_matrix, triangle[3]))
--   }

--   print_matrix(projected_triangle[1])

--   -- draw_triangle(projected_triangle)
--  end
--  -- cls()
--  -- draw_triangle( {create_vector_matrix({ 0, 0, 0 }),    create_vector_matrix({ 0, 40, 0 }),    create_vector_matrix({ 40, 40, 0 })} )
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
--  perspective_matrix[3][3] = (far + near) / (far - near)
--  perspective_matrix[3][4] = -1
--  perspective_matrix[4][3] = 2 * far * near / (far - near)

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