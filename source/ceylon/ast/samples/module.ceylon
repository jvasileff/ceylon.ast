"A collection of code samples
 to demonstrate usage of
 [[`ceylon.ast`|module ceylon.ast.core]].
 
 Includes:
 - sample ASTs to demonstrate how to create ASTs
   (with [[ceylon.ast.create|module ceylon.ast.create]]),
 - sample [[ceylon.ast.core::Editor]]s
   to demonstrate how to edit ASTs, and
 - sample [[ceylon.ast.core::Visitor]]s
   to demonstrate how to consume ASTs."
module ceylon.ast.samples "1.1.1" {
    shared import ceylon.ast.core "1.1.1";
    import ceylon.ast.create "1.1.1";
    import ceylon.collection "1.1.1";
}
