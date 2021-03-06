import ceylon.ast.core {
    Body,
    ClassBody
}

"Converts a [[stream of declarations and statements|content]]
 to a [[ClassBody]]."
throws (`class AssertionError`, "If the [[content]] is a different kind of content.")
shared ClassBody classBody(BodyIsh content) {
    if (is Body content) {
        "Cannot implicitly convert between different kinds of Body"
        assert (is ClassBody content);
        return content;
    } else {
        return ClassBody(content.sequence());
    }
}
