% Примеры запросов:
%   run([b, b, r, b, b, r], [r, r, b, r, b, b], [b, r, r, b, b, r]). <- начальное состояние из условия
%   run([b, r, b, r, r, r], [r, b, b, r, b, r], [r, b, b, b, r, r]).
%   run([b, b, b, b, b, b], [r, b, r, r, r, b], [b, r, r, r, b, r]).
%
% Каждый список - окружность
% Первый элемент списка - крайняя левая точка окружности, далее против часовой стрелки
% r - красная точка, b - синяя точка

run(A, B, C):-
    iter(A, B, C, 0, 0, 0, [1, 2, 3]);
    iter(A, B, C, 0, 0, 0, [1, 3, 2]);
    iter(A, B, C, 0, 0, 0, [2, 1, 3]);
    iter(A, B, C, 0, 0, 0, [2, 3, 1]);
    iter(A, B, C, 0, 0, 0, [3, 1, 2]);
    iter(A, B, C, 0, 0, 0, [3, 2, 1]).

log(A, B, C):-
    write(A),
    write(" "),
    write(B),
    write(" "),
    write(C),
    nl.

% Конечное состояние
iter([A1, b, b, b, b, A6], [b, b, b, B4, B5, b], [b, C2, C3, b, b, b], _, _, _, _):-
    log([A1, b, b, b, b, A6], [b, b, b, B4, B5, b], [b, C2, C3, b, b, b]),
    nl,
    !.

iter(A, B, C, A_ITER, B_ITER, C_ITER, [Q, W, E]):-
    log(A, B, C), % <---
    (C_ITER < 7 ->
        shift_with_order(A, B, C, A_ITER, B_ITER, C_ITER + 1, [Q, W, E], Q), !
    ;
        (B_ITER < 6 ->
            shift_with_order(A, B, C, A_ITER, B_ITER + 1, 0, [Q, W, E], W), !
        ;
            (A_ITER < 6 ->
                shift_with_order(A, B, C, A_ITER + 1, 0, 0, [Q, W, E], E), !
            ;
                fail
            )
        )
     ).

shift_with_order(A, B, C, A_ITER, B_ITER, C_ITER, OREDER, NUM):-
    (NUM = 1 -> shift_first(A, B, C, A_ITER, B_ITER, C_ITER, OREDER);
    (NUM = 2 -> shift_second(A, B, C, A_ITER, B_ITER, C_ITER, OREDER);
    (NUM = 3 -> shift_third(A, B, C, A_ITER, B_ITER, C_ITER, OREDER)))).

shift_first([A1, A2, A3, A4, A5, A6], [B1, _, B3, B4, B5, _], [_, C2, C3, C4, _, C6], A_ITER, B_ITER, C_ITER, OREDER):-
    iter([A6, A1, A2, A3, A4, A5], [B1, A2, B3, B4, B5, A4], [A1, C2, C3, C4, A3, C6], A_ITER, B_ITER, C_ITER, OREDER).

shift_second([A1, A2, _, A4, _, A6], [B1, B2, B3, B4, B5, B6], [C1, C2, C3, _, C5, _], A_ITER, B_ITER, C_ITER, OREDER):-
    iter([A1, A2, B1, A4, B5, A6], [B6, B1, B2, B3, B4, B5], [C1, C2, C3, B2, C5, B6], A_ITER, B_ITER, C_ITER, OREDER).

shift_third([A1, _, A3, _, A5, A6], [_, B2, _, B4, B5, B6], [C1, C2, C3, C4, C5, C6], A_ITER, B_ITER, C_ITER, OREDER):-
    iter([A1, C6, A3, C4, A5, A6], [C5, B2, C3, B4, B5, B6], [C6, C1, C2, C3, C4, C5], A_ITER, B_ITER, C_ITER, OREDER).
