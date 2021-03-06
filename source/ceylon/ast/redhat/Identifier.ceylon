import ceylon.ast.core {
    Identifier,
    LIdentifier,
    Node,
    UIdentifier
}
import com.redhat.ceylon.compiler.typechecker.tree {
    JNode=Node,
    Tree {
        JIdentifier=Identifier
    }
}
import com.redhat.ceylon.compiler.typechecker.parser {
    CeylonLexer {
        uidentifier=\iUIDENTIFIER,
        lidentifier=\iLIDENTIFIER,
        pidentifier=\iPIDENTIFIER,
        aidentifier=\iAIDENTIFIER
    }
}
import org.antlr.runtime {
    CommonToken
}

Boolean isPrefixed(CommonToken token) {
    return token.text.size != token.stopIndex - token.startIndex + 1;
}

"Converts a RedHat AST [[Identifier|JIdentifier]] to a `ceylon.ast` [[Identifier]]."
throws (`class AssertionError`, "If the token type is neither `LIDENTIFIER` nor `UIDENTIFIER`.")
shared Identifier identifierToCeylon(JIdentifier identifier, Anything(JNode,Node) update = noop) {
    "Need CommonToken to get length of token (!= text’s length for \\iCONSTANT)"
    assert (is CommonToken token = identifier.mainToken);
    value type = token.type;
    Identifier result;
    if (type == lidentifier) {
        result = LIdentifier(identifier.text, isPrefixed(token));
    } else if (type == uidentifier) {
        result = UIdentifier(identifier.text, isPrefixed(token));
    } else {
        throw AssertionError("Token type of Identifier token must be LIDENTIFIER (``lidentifier``) or UIDENTIFIER (``uidentifier``)");
    }
    update(identifier, result);
    return result;
}

"Converts a RedHat AST [[Identifier|JIdentifier]] to a `ceylon.ast` [[LIdentifier]]."
throws (`class AssertionError`, "If the token type is not `LIDENTIFIER`.")
shared LIdentifier lIdentifierToCeylon(JIdentifier identifier, Anything(JNode,Node) update = noop) {
    "Need CommonToken to get length of token (!= text’s length for \\iCONSTANT)"
    assert (is CommonToken token = identifier.mainToken);
    "Must be LIDENTIFIER token"
    assert (token.type == lidentifier);
    value result = LIdentifier(identifier.text, isPrefixed(token));
    update(identifier, result);
    return result;
}

"Converts a RedHat AST [[Identifier|JIdentifier]] to a `ceylon.ast` [[UIdentifier]]."
throws (`class AssertionError`, "If the token type is not `UIDENTIFIER`.")
shared UIdentifier uIdentifierToCeylon(JIdentifier identifier, Anything(JNode,Node) update = noop) {
    "Need CommonToken to get length of token (!= text’s length for \\iCONSTANT)"
    assert (is CommonToken token = identifier.mainToken);
    "Must be UIDENTIFIER token"
    assert (token.type == uidentifier);
    value result = UIdentifier(identifier.text, isPrefixed(token));
    update(identifier, result);
    return result;
}

"Converts a RedHat AST [[Identifier|JIdentifier]] with token type `PIDENTIFIER` to a `ceylon.ast` [[LIdentifier]].
 
 There’s no syntactical difference between package and lowercase identifiers, but they have different token types."
throws (`class AssertionError`, "If the token type is not `PIDENTIFIER`.")
shared LIdentifier pIdentifierToCeylon(JIdentifier identifier, Anything(JNode,Node) update = noop) {
    "Need CommonToken to get length of token (!= text’s length for \\iCONSTANT)"
    assert (is CommonToken token = identifier.mainToken);
    "Must be PIDENTIFIER token"
    assert (token.type == pidentifier);
    value result = LIdentifier(identifier.text, isPrefixed(token));
    update(identifier, result);
    return result;
}

"Converts a RedHat AST [[Identifier|JIdentifier]] with token type `AIDENTIFIER` to a `ceylon.ast` [[LIdentifier]].
 
 There’s no syntactical difference between annotation and lowercase identifiers, but they have different token types."
throws (`class AssertionError`, "If the token type is not `AIDENTIFIER`.")
shared LIdentifier aIdentifierToCeylon(JIdentifier identifier, Anything(JNode,Node) update = noop) {
    "Need CommonToken to get length of token (!= text’s length for \\iCONSTANT)"
    assert (is CommonToken token = identifier.mainToken);
    "Must be AIDENTIFIER token"
    assert (token.type == aidentifier);
    value result = LIdentifier(identifier.text, isPrefixed(token));
    update(identifier, result);
    return result;
}

"Compiles the given [[code]] for an Identifier
 into an [[Identifier]] using the Ceylon compiler
 (more specifically, the rule for an Import Name)."
shared Identifier? compileIdentifier(String code, Anything(JNode,Node) update = noop) {
    if (exists jidentifier = createParser(code).importName()) {
        return identifierToCeylon(jidentifier, update);
    } else {
        return null;
    }
}

"Compiles the given [[code]] for a Lowercase Identifier
 into an [[LIdentifier]] using the Ceylon compiler
 (more specifically, the rule for a Member Name)."
shared LIdentifier? compileLIdentifier(String code, Anything(JNode,Node) update = noop) {
    if (exists jidentifier = createParser(code).memberName()) {
        return lIdentifierToCeylon(jidentifier, update);
    } else {
        return null;
    }
}

"Compiles the given [[code]] for an Uppercase Identifier
 into a [[UIdentifier]] using the Ceylon compiler
 (more specifically, the rule for a Type Name)."
shared UIdentifier? compileUIdentifier(String code, Anything(JNode,Node) update = noop) {
    if (exists jidentifier = createParser(code).typeName()) {
        return uIdentifierToCeylon(jidentifier, update);
    } else {
        return null;
    }
}

"Compiles the given [[code]] for a Package Identifier
 into an [[LIdentifier]] using the Ceylon compiler
 (more specifically, the rule for a `packageName`)."
shared LIdentifier? compilePIdentifier(String code, Anything(JNode,Node) update = noop) {
    if (exists jidentifier = createParser(code).packageName()) {
        return pIdentifierToCeylon(jidentifier, update);
    } else {
        return null;
    }
}
