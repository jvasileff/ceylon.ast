import ceylon.collection {
    StringBuilder
}

"Builds a Ceylon expression string for an AST node;
 compiling and evaluating the resulting string will yield
 a copy of the transformed node.
 
 Usage:
 ~~~
 myNode.transform(CeylonExpressionTransformer());
 ~~~"
shared class CeylonExpressionTransformer(String indentLevel = "    ") satisfies NarrowingTransformer<String> {
    
    variable String indent = "";
    
    String transformWithIndent(Node? that) {
        if (exists that) {
            value origIndent = indent;
            indent += indentLevel;
            value ret = that.transform(this);
            indent = origIndent;
            return ret;
        } else {
            return "null";
        }
    }
    
    transformBaseExpression(BaseExpression that) => "BaseExpression(``transformWithIndent(that.nameAndArgs)``)";
    transformBaseMeta(BaseMeta that) => "BaseMeta(``transformWithIndent(that.nameAndArgs)``)";
    transformBaseType(BaseType that) => "BaseType(``transformWithIndent(that.nameAndArgs)``)";
    transformCallableType(CallableType that)
            => "CallableType {
                `` indent + indentLevel ``returnType = ``transformWithIndent(that.returnType)``;
                `` indent + indentLevel ``argumentTypes = ``transformWithIndent(that.argumentTypes)``;
                ``indent``}";
    transformCharacterLiteral(CharacterLiteral that) => "CharacterLiteral(\"\"\"``that.text``\"\"\")";
    transformCompareOperation(CompareOperation that)
            => "CompareOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformCompilationUnit(CompilationUnit that) => "CompilationUnit()";
    transformComplementOperation(ComplementOperation that)
            => "ComplementOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformDefaultedType(DefaultedType that) => "DefaultedType(``transformWithIndent(that.type)``)";
    transformDifferenceOperation(DifferenceOperation that)
            => "DifferenceOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformEntryOperation(EntryOperation that)
            => "EntryOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformEntryType(EntryType that)
            => "EntryType {
                `` indent + indentLevel ``key = ``transformWithIndent(that.key)``;
                `` indent + indentLevel ``item = ``transformWithIndent(that.item)``;
                ``indent``}";
    transformEqualOperation(EqualOperation that)
            => "EqualOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformExistsOperation(ExistsOperation that) => "ExistsOperation(``transformWithIndent(that.child)``)";
    transformExponentiationOperation(ExponentiationOperation that)
            => "ExponentiationOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformFloatLiteral(FloatLiteral that) => "FloatLiteral(\"``that.text``\")";
    transformGivenDec(GivenDec that) => "GivenDec(``transformWithIndent(that.typeParameter)``)";
    transformGroupedExpression(GroupedExpression that) => "GroupedExpression(``transformWithIndent(that.innerExpression)``)";
    transformGroupedType(GroupedType that) => "GroupedType(``transformWithIndent(that.type)``)";
    transformIdenticalOperation(IdenticalOperation that)
            => "IdenticalOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformIdentityOperation(IdentityOperation that) => "IdentityOperation(``transformWithIndent(that.child)``)";
    transformInOperation(InOperation that)
            => "InOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformIntegerLiteral(IntegerLiteral that) => "IntegerLiteral(\"``that.text``\")";
    shared actual String transformIntersectionType(IntersectionType that) {
        StringBuilder code = StringBuilder();
        code.append("IntersectionType([");
        value origIndent = indent;
        indent = indent + indentLevel + indentLevel;
        code.appendNewline();
        code.append(indent);
        code.append(that.children.first.transform(this));
        for (elementType in that.children.rest) {
            code.append(",");
            code.appendNewline();
            code.append(indent);
            code.append(elementType.transform(this));
        }
        code.appendNewline();
        code.append(origIndent + indentLevel);
        code.append("])");
        indent = origIndent;
        return code.string;
    }
    transformIntersectionOperation(IntersectionOperation that)
            => "IntersectionOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformIsOperation(IsOperation that)
            => "IsOperation {
                `` indent + indentLevel ``child = ``transformWithIndent(that.child)``;
                `` indent + indentLevel ``type = ``transformWithIndent(that.type)``;
                ``indent``}";
    transformIterableType(IterableType that) => "IterableType(``transformWithIndent(that.variadicType)``)";
    transformLIdentifier(LIdentifier that) => "LIdentifier(\"``that.name``\", ``that.enforcePrefix``)";
    shared actual String transformMemberNameWithTypeArguments(MemberNameWithTypeArguments that) {
        if (exists typeArguments = that.typeArguments) {
            StringBuilder code = StringBuilder();
            code.append("MemberNameWithTypeArguments {");
            value origIndent = indent;
            indent += indentLevel;
            code.appendNewline();
            code.append(indent);
            code.append("name = ");
            code.append(that.name.transform(this));
            code.append(";");
            code.appendNewline();
            code.append(indent);
            code.append("typeArguments = [");
            code.appendNewline();
            indent += indentLevel;
            code.append(indent);
            code.append(typeArguments.first.transform(this));
            for (argument in typeArguments.rest) {
                code.append(",");
                code.appendNewline();
                code.append(indent);
                code.append(argument.transform(this));
            }
            code.appendNewline();
            code.append(origIndent + indentLevel);
            code.append("];");
            code.appendNewline();
            indent = origIndent;
            code.append(indent);
            code.append("}");
            return code.string;
        } else {
            return "MemberNameWithTypeArguments(``that.name.transform(this)``)";
        }
    }
    transformLargeAsOperation(LargeAsOperation that)
            => "LargeAsOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformLargerOperation(LargerOperation that)
            => "LargerOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformMeasureOperation(MeasureOperation that)
            => "MeasureOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformMemberMeta(MemberMeta that)
            => "MemberMeta {
                `` indent + indentLevel ``qualifier = ``transformWithIndent(that.qualifier)``;
                `` indent + indentLevel ``nameWithArguments = ``transformWithIndent(that.nameAndArgs)``;
                ``indent``}";
    transformNegationOperation(NegationOperation that) => "NegationOperation(``transformWithIndent(that.child)``)";
    transformNonemptyOperation(NonemptyOperation that) => "NonemptyOperation(``transformWithIndent(that.child)``)";
    transformNotEqualOperation(NotEqualOperation that)
            => "NotEqualOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformOfOperation(OfOperation that)
            => "OfOperation {
                `` indent + indentLevel ``child = ``transformWithIndent(that.child)``;
                `` indent + indentLevel ``type = ``transformWithIndent(that.type)``;
                ``indent``}";
    transformOptionalType(OptionalType that) => "OptionalType(``transformWithIndent(that.definiteType)``)";
    transformOuter(Outer that) => "Outer()";
    transformPackage(Package that) => "Package()";
    transformPostfixDecrementOperation(PostfixDecrementOperation that) => "PostfixDecrementOperation(``transformWithIndent(that.child)``)";
    transformPostfixIncrementOperation(PostfixIncrementOperation that) => "PostfixIncrementOperation(``transformWithIndent(that.child)``)";
    transformPrefixDecrementOperation(PrefixDecrementOperation that) => "PrefixDecrementOperation(``transformWithIndent(that.child)``)";
    transformPrefixIncrementOperation(PrefixIncrementOperation that) => "PrefixIncrementOperation(``transformWithIndent(that.child)``)";
    transformProductOperation(ProductOperation that)
            => "ProductOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformQualifiedExpression(QualifiedExpression that)
            => "QualifiedExpression {
                `` indent + indentLevel ``receiverExpression = ``transformWithIndent(that.receiverExpression)``;
                `` indent + indentLevel ``nameAndArgs = ``transformWithIndent(that.nameAndArgs)``;
                ``indent``}";
    transformQualifiedType(QualifiedType that)
            => "QualifiedType {
                `` indent + indentLevel ``qualifyingType = ``transformWithIndent(that.qualifyingType)``;
                `` indent + indentLevel ``nameAndArgs = ``transformWithIndent(that.nameAndArgs)``;
                ``indent``}";
    transformQuotientOperation(QuotientOperation that)
            => "QuotientOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformRemainderOperation(RemainderOperation that)
            => "RemainderOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformScaleOperation(ScaleOperation that)
            => "ScaleOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformSequentialType(SequentialType that) => "SequentialType(``transformWithIndent(that.elementType)``)";
    transformSmallAsOperation(SmallAsOperation that)
            => "SmallAsOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformSmallerOperation(SmallerOperation that)
            => "SmallerOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformSpanOperation(SpanOperation that)
            => "SpanOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformStringLiteral(StringLiteral that) => "StringLiteral(\"\"\"``that.text``\"\"\", ``that.isVerbatim``)";
    transformSumOperation(SumOperation that)
            => "SumOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformSuper(Super that) => "Super()";
    transformThis(This that) => "This()";
    transformTupleType(TupleType that) => "TupleType(``transformWithIndent(that.typeList)``)";
    shared actual String transformTypeList(TypeList that) {
        if (nonempty elements = that.elements) {
            StringBuilder code = StringBuilder();
            code.append("TypeList([");
            value origIndent = indent;
            indent = indent + indentLevel + indentLevel;
            code.appendNewline();
            code.append(indent);
            code.append(elements.first.transform(this));
            for (element in elements.rest) {
                code.append(",");
                code.appendNewline();
                code.append(indent);
                code.append(element.transform(this));
            }
            code.appendNewline();
            indent = origIndent + indentLevel;
            code.append(indent);
            code.append("]");
            if (exists var = that.variadic) {
                code.append(",");
                code.appendNewline();
                code.append(indent);
                code.append(var.transform(this));
            }
            code.append(")");
            indent = origIndent;
            return code.string;
        } else {
            if (exists var = that.variadic) {
                return "TypeList([], ``transformWithIndent(var)``)";
            } else {
                return "TypeList([])";
            }
        }
    }
    shared actual String transformTypeNameWithTypeArguments(TypeNameWithTypeArguments that) {
        if (exists arguments = that.typeArguments) {
            StringBuilder code = StringBuilder();
            code.append("TypeNameWithTypeArguments {");
            value origIndent = indent;
            indent += indentLevel;
            code.appendNewline();
            code.append(indent);
            code.append("name = ");
            code.append(that.name.transform(this));
            code.append(";");
            code.appendNewline();
            code.append(indent);
            code.append("arguments = [");
            code.appendNewline();
            indent += indentLevel;
            code.append(indent);
            code.append(arguments.first.transform(this));
            for (argument in arguments.rest) {
                code.append(",");
                code.appendNewline();
                code.append(indent);
                code.append(argument.transform(this));
            }
            code.appendNewline();
            code.append(origIndent + indentLevel);
            code.append("];");
            code.appendNewline();
            indent = origIndent;
            code.append(indent);
            code.append("}");
            return code.string;
        } else {
            return "TypeNameWithTypeArguments(``that.name.transform(this)``)";
        }
    }
    transformTypeMeta(TypeMeta that) => "TypeMeta(``transformWithIndent(that.type)``)";
    transformUIdentifier(UIdentifier that) => "UIdentifier(\"``that.name``\", ``that.enforcePrefix``)";
    shared actual String transformUnionType(UnionType that) {
        StringBuilder code = StringBuilder();
        code.append("UnionType([");
        value origIndent = indent;
        indent = indent + indentLevel + indentLevel;
        code.appendNewline();
        code.append(indent);
        code.append(that.children.first.transform(this));
        for (elementType in that.children.rest) {
            code.append(",");
            code.appendNewline();
            code.append(indent);
            code.append(elementType.transform(this));
        }
        code.appendNewline();
        code.append(origIndent + indentLevel);
        code.append("])");
        indent = origIndent;
        return code.string;
    }
    transformUnionOperation(UnionOperation that)
            => "UnionOperation {
                `` indent + indentLevel ``leftChild = ``transformWithIndent(that.leftChild)``;
                `` indent + indentLevel ``rightChild = ``transformWithIndent(that.rightChild)``;
                ``indent``}";
    transformVariadicType(VariadicType that)
            => that.isNonempty
            then "VariadicType {
                  `` indent + indentLevel ``elementType = ``transformWithIndent(that.elementType)``;
                  `` indent + indentLevel ``isNonempty = true;
                  ``indent``}"
            else "VariadicType(``transformWithIndent(that.elementType)``)";
}
