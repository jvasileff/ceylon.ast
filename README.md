ceylon.ast
==========

This repository contains several modules to work with a Ceylon Abstract Syntax Tree (AST):

* `ceylon.ast.core` – the Ceylon classes that represent a Ceylon AST. Pure Ceylon (backend-independent).
* `ceylon.ast.create` – utility functions to create some AST nodes in a less verbose way.
* `ceylon.ast.redhat` – transforms a `ceylon.ast.core` AST from + to a RedHat compiler ([ceylon-spec](https://github.com/ceylon/ceylon-spec]) AST, and also contains functions to compile a `ceylon.ast.core` AST from a code string (using the RedHat compiler).
* `ceylon.ast.samples` – sample ASTs, to see how `ceylon.ast` is used and to test your tools that work with a `ceylon.ast` AST.
* a test module for each of these (`test.ceylon...`).

`ceylon.ast.core` allows you to construct a Ceylon AST in your program, which you can then feed into other tools (some tools require the transformed RedHat AST), like the compiler to compile it or the [`ceylon.formatter`](https://github.com/lucaswerkmeister/ceylon.formatter) to write it as code (code generation).

Any and all feedback is welcome – especially before the first release is out, because that’s when we can make changes without breaking everything!
If you’re unhappy with a particular aspect of `ceylon.ast`’s design (perhaps a class or attribute should have a better name, or a class should be split up into several parts?),
please say so now (contact me or create an issue) before it’s fixed in stone.

This was the Google Summer of Code 2014 project of Lucas Werkmeister (@lucaswerkmeister); see [the mailing list thread](https://groups.google.com/forum/#!topic/ceylon-dev/_Uo5P2AgxmA)
or the [project](https://www.google-melange.com/gsoc/project/details/google/gsoc2014/lucaswerkmeister/5741031244955648).
Contributions are of course welcome!

License
=======

The content of this repository is released under the ASL v2.0 as provided in the LICENSE file that accompanied this code.

By submitting a "pull request" or otherwise contributing to this repository, you agree to license your contribution under the license mentioned above.
