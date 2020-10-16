:- use_module(library(dcg/basics)).

%%% UTILITY FUNCTIONS %%%

%%  countAtStart(X:Term, L:List, N:Number)
%   It is true if N is the number of X occurences at the beginning of L
countAtStart(X,L,N) :- countAtStartAcc(X,L,0,N).

countAtStartAcc(X,[X|T],Acc,N) :-
    NewAcc is Acc+1,
    countAtStartAcc(X,T,NewAcc,N),!.
countAtStartAcc(_,[],A,A).
countAtStartAcc(X,[Y|_],A,A) :- X \= Y.

%%  writeRepeat(S:Term, N:number)
%   Writes S a numer of N times
writeRepeat(_,N) :- N =< 0.
writeRepeat(S,N) :-
    write(S),
    NN is N-1,
    writeRepeat(S,NN).

%%  eraseFromBeginning(S:List, L:List, R:List)
%   It is true if R is a copy of L, but without any element at the 
%   begining that is contained in S
%   example: eraseFromBeginning([2,3],[3,3,2,3,5,3,4,2,1],[5,3,4,2,1])
eraseFromBeginning(S,[X|T],R) :-
    member(X,S),!,
    eraseFromBeginning(S,T,R).
eraseFromBeginning(S,L,L) :-
    L = [X|_],
    \+ member(X,S).
eraseFromBeginning(_,[],[]).

%%  substitute(A:Term, B:Term, L1:List, L2:List)
%   It is true if L1 and L2 are the same List, but every A in L1 
%   is a B in L2 and every B in L2 is an A in L1
%   example: substitute(3,5,[1,3,2,3],[1,5,2,5])
substitute(_,_,[],[]).
substitute(A,B,[A|T1],[B|T2]) :-
    substitute(A,B,T1,T2),!.
substitute(A,B,[H|T1],[H|T2]) :-
    substitute(A,B,T1,T2).

%%% SECONDARY ROUTINES %%%
    
%%  update_toc(Level:Num, Line:Atom, SubToc:List, Toc:List)
%   Level:  Header level of the line (0 for body lines)
%   Line:   Content of the read line
%   SubToc: Accumulator for the entries,
%           complex terms with the form entry(Level, Line)
%   Toc:    Output list with all the entries
update_toc(0,_,X,X) :- !.
update_toc(Level,Line,SubToc,[entry(Level,Line)|SubToc]).

%%  writeToc(L:List)
%   L:  List of entries of the TOC
%   Writes the formated TOC to stdout
writeToc([entry(Level, Line)|T]) :-
    writeRepeat('  ',(Level-1)),
    % write('- '),
    atom_codes(' -#',[Sp,Hy,Al]),
    atom_codes(Line,Codes),
    eraseFromBeginning([Sp,Al],Codes,Codes2),
    substitute(Sp,Hy,Codes2,CodesLink),
    atom_codes(Header,Codes2),
    atom_codes(Link,[Al|CodesLink]),
    format('- [~w](~w)\n',[Header,Link]),
    writeToc(T).
writeToc([]).

%%  writeBody(L:List)
%   L:  List of lines of the body
%   Writes all the body, line by line, except a line containing the <toc>
%   label, that will be replaced by the TOC.
writeBody(['<toc>'|Rest]) :-
    getToc(T),
    writeToc(T),
    write("\n"),
    writeBody(Rest).
writeBody([Line|Rest]) :-
    writeln(Line),
    writeBody(Rest).
writeBody([]).

%%% GRAMMAR %%%

%%  file(TOC:List, Body:List)//
%   TOC:    List of entries
%   Body:   List of all the lines in the file
file(TOC,[Line|SubContent]) --> 
    line(Level,Line),
    file(SubToc,SubContent),
            {
            update_toc(Level,Line,SubToc,TOC)
            }.
file([],[],[],[]).

%%  line(Level:Num,Line:Atom)//
%   Level:  Number of # at start of the line
%   Line:   Content of the line
line(Level, Line) -->
    string(Codes),
    [10], % newline
        {
        atom_codes(Line,Codes),
        atom_codes('#',[Alm]),
        countAtStart(Alm,Codes,Level)
        }.

%%% MAIN %%%

% correct version
main :-
    current_prolog_flag(argv,[File]), !,
    Fun = phrase_from_file(file(T,Body), File),
    catch(Fun,_,(
        format('Didn\'t find file: ~w',[File]),
        fail
    )),
    assert(getToc(T)),
    writeBody(Body).
    
% print usage for incorrect arguments
main :-
    current_prolog_flag(argv,_),
    writeln('TOC-MD - Table of Contents for Markdown'),
    writeln(''),
    writeln('  Usage: tocmd <file>'),
    writeln(''),
    writeln('  Reads a Markdown file and prints it to the standard'),
    writeln('  output, but replacing lines that only contain <toc>'),
    writeln('  with the actual Table of Contents.').
    
