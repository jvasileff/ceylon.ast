"An “atomic” expression.
 
 While atoms can wrap and contain other expressions, they never consist of several expressions chained together without any wrapping.
 For example, in `[1, 2, 3]`, the child expressions are wrapped in the surrounding brackets;
 in `1.add`, however, the child expressions are not wrapped.
 Therefore, a [[Tuple]] is an atom, while a [[MemberExpression]] isn’t."
shared abstract class Atom()
        of Literal | SelfReference | GroupedExpression | Iterable | Tuple
        extends Primary() {
}
