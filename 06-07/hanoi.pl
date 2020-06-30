hanoi(N) :-
    move(N, left, middle, right).
move(1, A, _, C) :-
    inform(A, C), !.
move(N, A, B, C) :-
    N1 is N-1,
    move(N1, A, C, B),  % 1~N1枚目をAからBにCを使って移す作業に対応
    inform(A, C),       % N枚目をAからCに移す作業に対応
    move(N1, B, A, C).  % 1~N1枚目をBからCにAを使って移す作業に対応
inform(Loc1, Loc2) :-
    format('~Ndisk from ~w to ~w', [Loc1, Loc2]).