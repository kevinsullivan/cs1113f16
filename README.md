# CS1 Through Type Theory

This repository records the progression of my CS1 course at UVa, 
Fall 2016. I informally call it "A Constructive Approach to CS1" 
or "CS1 Through Type Theory." It draws on lessons from Pierce's 
Software Foundations. With students it first constructs, step by 
step, starting from nothing but the core constructive logic of
Idris,  a "standard library" or "prelude" of the usual data types 
for functional programming (unit, bool, byte, nat, list a, etc).
About 2/3 of the way through the semester, it builds a simple 
imperative language using this library, introducing types for 
state (variable -> value), and the syntax and evaluation of,
both Boolean and arithmetic expressions and imperative commands
(skip, assignment, ifthenelse, while, etc). That Idris allows for
non-enforcement of totality is beneficial here, as otherwise it
would not be possible to write a semantic evaluator as a function. 

At this point we also bring in Python to see how the fundamentals 
of imperative programming play out in an industrial language. We 
start decidedly *not* with "Hello World!" but with programs that 
create state and perform assignment operations. (We introduce the 
Python print statement here, for the first time giving students a 
capability that they haven't built entirely by themselves, for 
ease of inspecting program state.) 

The progression of concepts and mechanisms is "constructive" (in 
the math/logic sense). No ideas or capabilities are used in the
first 2/3 of course that we don't build ourselves. We started
with the idea that there are (data and function) (types and values).
That's a two-by-two. 

We build through a progression of abstract data type modules, each
comprising definitions of data and function types and values. We 
start with unit and bool types and run up through dictionaries 
implemented using lists and finally state and commands. 

State and commands come a little past 2/3 of the way through the 
semester. At that point, we bring in Python and guide  students
through the language with what we've learned in the foundational
part of the class to understand it very rapidly: the basic data 
types of Python (variables, tuples, dictionaries, etc.), and the
concept of commands as compositions of state transformers. 

The that this is a CS1 course, not an upper division or graduate 
course, imposes a need for very careful attention to the ordering 
and explication of concepts, from programming language mechanisms 
to software design concepts to functional and imperative paradigms,
and careful separation of computation from effects. 

The contribution of this class, if there is one, is the analysis 
and design work, validated through several offerings of this class,
to produce the specific progression of ideas that you'll find in 
this repo.

By iterating through the tagged versions of this repository, you
will animate the evolution of a simple Idris prelude library that 
the class and I built, followed by the construction of a simple
imperative language. A class project required the extension of the
language to support unsigned integer arithmetic (in limited form)
based on our previously implemented Byte8 type and the algorithm
we implemented (based on half- and full-adders) to do addition of
natural numbers represented as 8-bit bytes.

## How to view this repository

This repository presents a sequence of tagged versions of the
prelude library that our class is building. On Github, click on
"Master" for the master branch, then "Tags" to select a tagged
version. You will then see the files from that version when you
browse the directories on Github. 

Going through the sequence of versions in order will animate the
introduction of concepts over the two months we spent building our 
prelude library.

The first version picks up just a few lectures into the course. 
From there, minor version number changes roughly match daily lectures 
and specific concepts (such as programming mechanisms) within broader 
data-type-focused areas. Major version changes corresponding to 
transitions from one major abstract data type to another (unit and 
bool to nat, nat to list, list to dictionary, to state, etc). Note 
that some versions of some files contain more or less extensive 
lecture notes, and that in general these notes disappear from later
versions to keep the code clean. 

## Strategy: Language = Idris

The course is taught using the functional programming language of the
Idris proof assistant. The goal was to have students use a language
with an extremely clean type system, in which they could do ordinary
prorgamming, and that would put them on the path to the type-driven
development of programs and proofs. 

I judged Idris to be a better language than Coq for a CS1 course. For 
example, one can turn off the enforcement of totality checking, which 
is useful if one wants to explore ideas of generative recursions (e.g., 
hailstone sequence, or iterated state transformations for simulations 
or games).

I have also found the ability to give students partial programs with
"holes" to fill in to be incredibly useful. My exams, for instance, are
Idris programs with definitions that have lots of holes to fill in. 
That one can ask the environment about the type of each hole, is very
useful, among other things. This mechanism also supports a beautiful
narrative around top-down functional decomposition as an engineering
design strategy for program implementation.


## Strategy: A Sequence of Major Abstract Data Types

We started by turning off import of all built-in Idris libraries, so
that we could build our own library of "Prelude" types from scratch.
The progression of types is similar to that in Pierce's Software
Foundations book, but with the inclusion of a major section on bit and
byte types, including computer architecture concepts of half and full
adders, their implementation using Boolean algebra, and ultimately the
definition of a recursive function to add bytes.


## Strategy: Programming and Software Engineering Concepts

We used the progression through data types -- from unit, bool, bit,
byte, nat, list, dictionary and others -- to drive the introduction of
a range of programming mechanisms and software engineering concepts.
The software engineering concepts include abstraction, aggregation,
visibility and encapsulation, and information hiding modularity.

The programming mechanisms we introduced are those we needed to do the
job. We'd introduce them when needed. They includ kinds and evaluation
of expressions, unification in during pattern matching, inductive data
definitions, recursive functions, etc.

Woven through the progression of major types we also some qintroduced
fundamental concepts in computer science, including Boolean algebra
and satisfiability, binary arithmetic, including subscripting (of bits
within bytes), a recursive function to add bytes, through concepts of
state, expressions and their evaluation, and imperative commands as
composable state transformers (all implemented in Idris).

## Strategy: Foundations of Imperative Programming as a Major Goal

A goal of the course is to provides students with a foundational
understanding of imperative programming /before/ throwing them into a
complex industrial programming language, while eventually getting
them up and running in such a language.

Therefore, at the point where we introduce state and commands, we have
the students start programming in Python. The first exposure to Python
is /decidedly not/ "Hello World!". Rather, it's an exploration of the
notion of state as an evolving function mapping variables to values,
and the assignment command as a state transformer with a very specific
behavior, namely overriding of that function for one variable. From
there, we will proceed in parallel to build a simple imperative
language in Idris while exploring its full realization in Python. As
of the writing of this documentation (Nov 3, 2016), we are just now
starting down this road, which will take us to the end of the course.
By the end, the students should be able to write simulations, games,
etc., including the use of object-oriented constructs in Python.
