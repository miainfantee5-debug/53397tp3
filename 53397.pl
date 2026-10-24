% =====================================================================
% UNIVERSIDAD TECNOLOGICA NACIONAL - FACULTAD REGIONAL MENDOZA
% PARADIGMAS DE PROGRAMACION - PARADIGMA LOGICO: PROLOG
% Trabajo Practico completo
% Legajo: 53397
% =====================================================================
%
% Nota:
% - El TP usa suma/2 tanto en el ejercicio 2 como en el ejercicio 9.
%   Para que ambos funcionen dentro del mismo archivo, este programa
%   despacha internamente segun el tipo de la primera llamada.
% - Los ejercicios 14 y 15 usan eliminar/3. Se implementa la version
%   que elimina todas las ocurrencias; en el ejercicio 14 la consigna
%   supone una sola ocurrencia, por lo que el resultado es el mismo.
%
% =====================================================================
% HECHOS Y REGLAS
% =====================================================================

% ---------------------------------------------------------------------
% 1) par(N)
% Verdadero si N es un numero par, sin utilizar mod.
% Ejemplos:
% ?- par(8).
% true
% ?- par(7).
% false
% ---------------------------------------------------------------------
par(0).
par(1) :- !, fail.
par(N) :- N > 0, N1 is N - 2, par(N1).
par(N) :- N < 0, N1 is N + 2, par(N1).

% ---------------------------------------------------------------------
% 2) suma(N,S)
% S es la sumatoria de los primeros N numeros naturales pares.
% Ejemplo:
% ?- suma(5,S).
% S = 30
% ---------------------------------------------------------------------
suma(N,S) :- number(N), !, sumaPares(N,S).

sumaPares(0,0) :- !.
sumaPares(N,S) :-
    N > 0,
    N1 is N - 1,
    sumaPares(N1,S1),
    S is (N * 2) + S1.

% ---------------------------------------------------------------------
% 3) potencia(B,E,V)
% V es B elevado a E.
% Ejemplo:
% ?- potencia(2,5,V).
% V = 32
% ---------------------------------------------------------------------
potencia(_,0,1) :- !.
potencia(B,E,V) :-
    E > 0,
    E1 is E - 1,
    potencia(B,E1,V1),
    V is B * V1.

% ---------------------------------------------------------------------
% 4) fibonacci(N,R)
% R es el termino N de la sucesion de Fibonacci.
% Ejemplo:
% ?- fibonacci(7,R).
% R = 13
% ---------------------------------------------------------------------
fibonacci(0,0).
fibonacci(1,1).
fibonacci(N,R) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1,R1),
    fibonacci(N2,R2),
    R is R1 + R2.

% ---------------------------------------------------------------------
% 5) Compuertas logicas y circuito
% ---------------------------------------------------------------------
and(0,0,0).
and(0,1,0).
and(1,0,0).
and(1,1,1).

or(0,0,0).
or(0,1,1).
or(1,0,1).
or(1,1,1).

not(0,1).
not(1,0).

circuito(Q1,Q2,S) :-
    not(Q1,A),
    and(A,Q2,B),
    not(Q2,C),
    and(C,Q1,D),
    or(B,D,S).

% Ejemplo:
% ?- circuito(0,1,S).

% ---------------------------------------------------------------------
% 6) Diagnostico de enfermedades
% ---------------------------------------------------------------------
sintoma(carina,estornudos).
sintoma(mauricio,fiebre).
sintoma(carlos,cafalea).

enfermedad(resfriado,estornudos).
enfermedad(virus,fiebre).
enfermedad(stress,cafalea).

diagnostico(P,S,E) :-
    sintoma(P,S),
    enfermedad(E,S).

% Ejemplo:
% ?- diagnostico(mauricio,S,E).
% S = fiebre, E = virus

% =====================================================================
% TRATAMIENTO DE LISTAS
% =====================================================================

% ---------------------------------------------------------------------
% 7) predecesor(L,R)
% R contiene los elementos de L que son iguales o mayores que su
% predecesor. El primer elemento siempre aparece.
% Ejemplo:
% ?- predecesor([1,2,2,5,4],R).
% R = [1,2,2,5]
% ---------------------------------------------------------------------
predecesor([],[]).
predecesor([X|L],[X|R]) :- predecesorAux(X,L,R).

predecesorAux(_,[],[]).
predecesorAux(P,[X|L],[X|R]) :-
    X >= P, !,
    predecesorAux(X,L,R).
predecesorAux(_, [X|L], R) :-
    predecesorAux(X,L,R).

% ---------------------------------------------------------------------
% 8) rotada(L,N,P)
% P es L rotada N posiciones hacia la izquierda.
% Ejemplo:
% ?- rotada([1,2,3,4,5],3,R).
% R = [4,5,1,2,3]
% ---------------------------------------------------------------------
rotada(R,0,R) :- !.
rotada([X|L],N,R) :-
    N > 0,
    N1 is N - 1,
    append(L,[X],R1),
    rotada(R1,N1,R).

% ---------------------------------------------------------------------
% 9) suma(S,L)
% S es la sumatoria de los valores de la lista L.
% Ejemplo:
% ?- suma(S,[3,4,5]).
% S = 12
% ---------------------------------------------------------------------
suma(S,[]) :- S is 0.
suma(S,[C|Q]) :-
    sumaLista(P,Q),
    S is P + C.

sumaLista(0,[]).
sumaLista(S,[C|Q]) :-
    sumaLista(P,Q),
    S is P + C.

% ---------------------------------------------------------------------
% 10) cantidad(L,N)
% N es la cantidad de elementos de L.
% ---------------------------------------------------------------------
cantidad([],0) :- !.
cantidad([_|Q],N) :-
    cantidad(Q,N1),
    N is N1 + 1.

% Ejemplo:
% ?- cantidad([4,5,6],N).
% N = 3

% ---------------------------------------------------------------------
% 11) ultimo(L,U)
% U es el ultimo elemento de L.
% ---------------------------------------------------------------------
ultimo([X],X) :- !.
ultimo([_|L],U) :- ultimo(L,U).

% Ejemplo:
% ?- ultimo([4,5,6],U).
% U = 6

% ---------------------------------------------------------------------
% 12) inversa(L,I)
% I es L invertida.
% ---------------------------------------------------------------------
inversa([],[]) :- !.
inversa([C|Q],I) :-
    inversa(Q,R),
    append(R,[C],I).

% Ejemplo:
% ?- inversa([4,5,6],I).
% I = [6,5,4]

% ---------------------------------------------------------------------
% 13) sacar(P,L,R)
% R es L sin el elemento que ocupa la posicion P (posiciones desde 1).
% ---------------------------------------------------------------------
sacar(1,[_|Q],Q) :- !.
sacar(P,[C|Q],[C|R]) :-
    P > 1,
    P1 is P - 1,
    sacar(P1,Q,R).

% Ejemplo:
% ?- sacar(2,[a,b,c,d,e],R).
% R = [a,c,d,e]

% ---------------------------------------------------------------------
% 14) eliminar(L,E,R)
% R es L sin E. La consigna supone una unica ocurrencia.
%
% 15) eliminar(L,E,R)
% Igual que el anterior, pero eliminando todas las ocurrencias.
%
% Se utiliza una unica version que elimina todas las ocurrencias.
% Para el ejercicio 14, al existir una sola ocurrencia, el resultado
% coincide exactamente con lo solicitado.
% ---------------------------------------------------------------------
eliminar([],_,[]) :- !.
eliminar([E|Q],E,R) :- !,
    eliminar(Q,E,R).
eliminar([C|Q],E,[C|R]) :-
    eliminar(Q,E,R).

% Ejemplos:
% Ej. 14: ?- eliminar([a,b,c,d,e],c,R).
%         R = [a,b,d,e]
% Ej. 15: ?- eliminar([a,b,c,d,e,c],c,R).
%         R = [a,b,d,e]

% ---------------------------------------------------------------------
% Auxiliar: pertenece(E,L)
% ---------------------------------------------------------------------
pertenece(X,[X|_]) :- !.
pertenece(X,[_|Q]) :- pertenece(X,Q).

% ---------------------------------------------------------------------
% 16) intersec(L1,L2,L3)
% L3 es la interseccion entre L1 y L2.
% ---------------------------------------------------------------------
intersec([],_,[]) :- !.
intersec([X|Q],L,[X|R]) :-
    pertenece(X,L), !,
    intersec(Q,L,R).
intersec([_|Q],L,R) :-
    intersec(Q,L,R).

% Ejemplo:
% ?- intersec([1,2,3,a],[a,1,b,c],R).
% R = [1,a]

% ---------------------------------------------------------------------
% 17) rotarIzq(L,N,R)
% R es L rotada N posiciones hacia la izquierda.
% ---------------------------------------------------------------------
rotarIzq(R,0,R) :- !.
rotarIzq([X|L],N,R) :-
    N > 0,
    N1 is N - 1,
    append(L,[X],R1),
    rotarIzq(R1,N1,R).

% Ejemplo:
% ?- rotarIzq([1,2,3,4,5],3,R).
% R = [4,5,1,2,3]

% ---------------------------------------------------------------------
% 18) insertarEn(E,L,P,R)
% Inserta E en la posicion P de L.
% ---------------------------------------------------------------------
insertarEn(E,L,1,[E|L]) :- !.
insertarEn(E,[C|Q],P,[C|R]) :-
    P > 1,
    P1 is P - 1,
    insertarEn(E,Q,P1,R).

% Ejemplo:
% ?- insertarEn(9,[1,2,3,4,5],3,R).
% R = [1,2,9,3,4,5]

% ---------------------------------------------------------------------
% 19) insOrden(E,O,D)
% Inserta E en la lista ordenada O y obtiene D ordenada.
% ---------------------------------------------------------------------
insOrden(E,[],[E]) :- !.
insOrden(E,[H|T],[E,H|T]) :-
    E =< H, !.
insOrden(E,[H|T],[H|R]) :-
    E > H,
    insOrden(E,T,R).

% Ejemplo:
% ?- insOrden(3,[1,2,5],D).
% D = [1,2,3,5]

% ---------------------------------------------------------------------
% 20) ordenada(L,O)
% O es L ordenada utilizando insOrden.
% ---------------------------------------------------------------------
ordenada([],[]).
ordenada([H|T],O) :-
    ordenada(T,OT),
    insOrden(H,OT,O).

% Ejemplo:
% ?- ordenada([2,4,1,0,6],O).
% O = [0,1,2,4,6]

% =====================================================================
% ESTRUCTURAS DE DATOS
% =====================================================================

% ---------------------------------------------------------------------
% 21) Arbol de personas
% Cada nodo utiliza el functor persona(Nombre,DNI,Edad).
% ---------------------------------------------------------------------
padre(persona('R',101,80),persona('A',102,60)).
padre(persona('R',101,80),persona('B',103,60)).
padre(persona('R',101,80),persona('C',104,60)).

padre(persona('A',102,60),persona('D',105,40)).
padre(persona('A',102,60),persona('E',106,40)).
padre(persona('E',106,40),persona('H',107,20)).

padre(persona('B',103,60),persona('F',108,40)).
padre(persona('B',103,60),persona('G',109,40)).
padre(persona('F',108,40),persona('I',110,20)).
padre(persona('F',108,40),persona('J',111,20)).
padre(persona('G',109,40),persona('K',112,20)).

ascendientes(X,Y) :- padre(Y,X).
ascendientes(X,Y) :-
    padre(Z,X),
    ascendientes(Z,Y).

descendientes(X,Y) :- ascendientes(Y,X).

% Ejemplo:
% ?- descendientes(persona('F',108,40),X).
% X = persona('I',110,20) ;
% X = persona('J',111,20)

% ---------------------------------------------------------------------
% 22) parejas(L1,L2,L3)
% L1 y L2 deben tener la misma longitud. Si no, el predicado falla.
% ---------------------------------------------------------------------
parejas([],[],[]).
parejas([C1|L1],[C2|L2],[(C1,C2)|R]) :-
    parejas(L1,L2,R).

% Ejemplo:
% ?- parejas([1,2,3],[a,b,c],R).
% R = [(1,a),(2,b),(3,c)]

% ---------------------------------------------------------------------
% 23) Base de datos de personas
% Functor: persona(nombre,telefono,sexo,edad)
% ---------------------------------------------------------------------
persona(nombre('Mauricio'),telefono('155002354'),sexo('M'),edad(35)).
persona(nombre('Carlos'),telefono('15512345678'),sexo('M'),edad(35)).
persona(nombre('Carina'),telefono('15512345679'),sexo('F'),edad(35)).

% Buscar si una persona existe.
existepersona(X) :- persona(nombre(X),_,_,_).

% Mostrar todas las personas.
mostrar(X) :- persona(nombre(X),_,_,_).

% Mostrar todas las mujeres.
mostrarmujeres(X) :- persona(nombre(X),_,sexo('F'),_).

% Mostrar todos los varones mayores de 21 anos.
varonesmayores(X) :-
    persona(nombre(X),_,sexo('M'),edad(E)),
    E > 21.

% Relacion casado.
casado(nombre('Mauricio'),nombre('Carina')).

% Persona casada que posee telefono.
casadocontelefono(X) :-
    (casado(nombre(X),_); casado(_,nombre(X))),
    persona(nombre(X),telefono(Tel),_,_),
    Tel \== ''.

% Relacion de visita de una persona a otra.
visita(nombre('Carlos'),nombre('Carina')).

% Mostrar los casados.
casados(X) :- casado(X,_).
casados(X) :- casado(_,X).

% c(X): existe un casado X con Y, Y visita a Z y Z es varon.
c(X) :-
    casado(X,Y),
    visita(Y,Z),
    persona(Z,_,sexo('M'),_).

% Ejemplos:
% ?- existepersona('Mauricio').
% ?- mostrar(X).
% ?- mostrarmujeres(X).
% ?- varonesmayores(X).
% ?- casados(X).

% ---------------------------------------------------------------------
% 24) Grafo de ciudades
% ---------------------------------------------------------------------
ruta(sanjuan,cordoba,480).
ruta(cordoba,sanluis,350).
ruta(sanluis,bsas,710).
ruta(cordoba,santafe,280).
ruta(cordoba,misiones,950).
ruta(cordoba,bsas,540).
ruta(misiones,santafe,570).
ruta(mendoza,sanjuan,160).
ruta(mendoza,sanluis,280).

% Indicar si existe un camino entre dos ciudades.
camino(X,Y) :- ruta(X,Y,_).
camino(X,Y) :-
    ruta(X,Z,_),
    camino(Z,Y).

% Determinar la distancia total entre dos ciudades.
distancia(X,Y,D) :- ruta(X,Y,D).
distancia(X,Y,D) :-
    ruta(X,Z,D1),
    distancia(Z,Y,D2),
    D is D1 + D2.

% Mostrar las ciudades intermedias por las que se pasa.
mostrarCiudad(X,Y) :- ruta(X,Y,_).
mostrarCiudad(X,Y) :-
    ruta(X,Z,_),
    mostrarCiudad(Z,Y),
    write(Z),
    write(' ').

% Ejemplos:
% ?- camino(mendoza,misiones).
% true
% ?- distancia(mendoza,misiones,D).
% D = 1590
% ?- mostrarCiudad(sanjuan,bsas).

% =====================================================================
% FIN DEL TRABAJO PRACTICO
% =====================================================================
