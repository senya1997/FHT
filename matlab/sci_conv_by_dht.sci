function [tree] = sci_conv_by_dht(tree)
// Сформирован с помощью M2SCI
// Функция преобразования для Matlab conv_by_dht()
// Вход: tree = вызов функции в Matlab tree
// Выход: tree = эквивалент в Scilab для tree

tree=Funcall("exec",1,Rhs_tlist(tree.name),tree.lhs)
endfunction
