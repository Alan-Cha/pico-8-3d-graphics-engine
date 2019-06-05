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
  
  print(sub(line, 1, #line - 2)..'}')
 end

 -- closing bracket
 print('}')
end