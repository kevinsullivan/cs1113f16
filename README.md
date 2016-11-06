# CS1 Through Type Theory

This repository records the progression of my CS1 course at UVa, 
Fall 2016. I informally call it "A Constructive Approach to CS1" 
or "CS1 Through Type Theory." It draws on lessons from Pierce's 
Software Foundations. With  students it constructs step by step,
starting from the core logic,  a "standard prelude" of data types
for functional programming (unit, bool, byte, nat, list a, etc).

About 2/3 of the way through the semester, again channeling B.
Pierce's pioneering work, it builds a simple imperative language 
based on this library, based on concepts of state, the syntax of,
and the evaluation of expressions and imperative commands. It's
at this point that we bring in Python to explore fundamentals of
imperative programming. We start not with "Hello World!", for
example, but with programs that simple create state and see the
effects of assignment operations in action. (We do introduce the 
Python print statement here, as well, for the first time giving
students a capability that we haven't already built ourselves. 

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
part of the class to understand it very rapidly. The basic data 
types of Python (variables, tuples, dictionaries, etc.), and the
concept of commands as compositions of state transformers. 

The that this is a CS1 course, not an upper division or graduate 
course, imposes a need for very careful attention to the ordering 
and explication of concepts, from programming language mechanisms 
to software design concepts to functional and imperative paradigms. 
The contribution of this class, if there is one, is  the analysis 
and design to produce the specific progression of ideas that you'll 
find here in this repo.

By iterating through the tagged versions of this repository, you
will animate the evolution of a simple Idris prelude library that 
the class and I built. As of this writing (November 3, 2016), we
just turned the corner to the imperative topic. For one lecture, 
eschewing Idris programming but first the first time opening an
online Python REPL, we just talked about state (variable -> value),
commands (state -> state), the assignment command in particular. 

And stay tuned for future episodes.

## How to view this repository

The key to making sense of this repository is to look at the
progression of its tagged versions. (On Github, for example, click on
"Master" for the master branch, then "Tags." Select a tagged
version, then browse the selected version of the code base.) Doing 
this through the sequence of versions will reveal the ordering of 
concepts as we spent two months building our own core library of 
data types, from unit and bool through state, expression, and command. 
The first version in the repo picks up a few lectures into the course. 
From there, minor version number changes roughly match daily lectures 
and specific concepts within broader data-type-focused areas, while 
major version changes corresponding to movement from one major abstract 
data type to another (unit and bool to nat, nat to list, list to 
dictionary, etc). Note that some versions of some files contain more
or less extensive lecture notes, which do not necessarily remain in
later versions of the files.

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
