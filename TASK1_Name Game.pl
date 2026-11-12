% ============================================================
% Lab 9 - I/O and Database Manipulation
% Lab Activity: The "Name Game"
% ------------------------------------------------------------
% The user starts with the letters a, b, c and can add,
% delete or move letters to build his/her name.
% Letters are stored as facts letter(X) and changed with
% assert / asserta / assertz / retract / retractall.
%
% Run with:   ?- start.
% Type a full stop after every input, e.g.  2.   and   h.
% ============================================================

% letter/1 changes while the program runs
:- dynamic letter/1.

% ---------------- Start ----------------
% Every new game starts with the set a, b, c
start :-
    retractall(letter(_)),
    assertz(letter(a)),
    assertz(letter(b)),
    assertz(letter(c)),
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

% ---------------- Menu ----------------
menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    option(Choice).

% ---------------- Options ----------------
% 1 - Display the current set of letters
option(1) :- !,
    display_letters,
    menu.

% 2 - Add a letter (assert adds it as the last fact)
option(2) :- !,
    write('Enter the letter you want to add:'), nl,
    read(X),
    assert(letter(X)),
    write('The letter has been added.'), nl,
    menu.

% 3 - Add a letter at the top (asserta puts it first)
option(3) :- !,
    write('Enter the letter you want to add at the top:'), nl,
    read(X),
    asserta(letter(X)),
    write('The letter has been added at the top.'), nl,
    menu.

% 4 - Add a letter at the bottom (assertz puts it last)
option(4) :- !,
    write('Enter the letter you want to add at the bottom:'), nl,
    read(X),
    assertz(letter(X)),
    write('The letter has been added at the bottom.'), nl,
    menu.

% 5 - Delete a letter (retract removes the first match)
option(5) :- !,
    write('Enter the letter you want to delete:'), nl,
    read(X),
    delete_letter(X),
    menu.

% 6 - Delete all letters (retractall)
option(6) :- !,
    retractall(letter(_)),
    write('All letters have been deleted.'), nl,
    menu.

% 7 - Exit
option(7) :- !,
    write('Goodbye!'), nl.

% Anything else
option(_) :-
    write('Invalid choice, please enter a number from 1 to 7.'), nl,
    menu.

% ---------------- Helpers ----------------
% Delete one letter, or say it is not in the set
delete_letter(X) :-
    retract(letter(X)), !,
    write('The letter has been deleted.'), nl.
delete_letter(_) :-
    write('This letter is not in the set.'), nl.

% Display the letters from top to bottom
display_letters :-
    \+ letter(_), !,
    write('The set of letters is empty.'), nl.
display_letters :-
    findall(X, letter(X), Letters),
    write('Current set of letters:'), nl,
    print_list(Letters).

% Recursion over the list, stopping at the empty list
print_list([]).
print_list([H|T]) :-
    write(H), nl,
    print_list(T).

% ------------------------------------------------------------
% Example: building the name "hala"  (to MOVE a letter, delete
% it with 5 and add it again with 3 or 4 where you want it)
% ?- start.
% |: 6.              (delete all)
% |: 4.  |: h.       (add h at the bottom)
% |: 4.  |: a.
% |: 4.  |: l.
% |: 4.  |: a.
% |: 1.              (display -> h a l a)
% |: 7.              (exit)
% ------------------------------------------------------------
