"""An attribute definition, using a specifier.
   
   Examples:
   
       shared actual String string => "``name`` from ``countryOfOrigin`` of age ``age``";
       shared actual Null definition = null;"""
shared class AttributeDefinition(name, type, definition, annotations = Annotations())
        extends AnyAttribute() {
    
    shared actual MemberName name;
    "The type of the attribute.
     
     This can be:
     - a proper [[Type]],
     - a [[’`value`’ modifier|ValueModifier]] to indicate type inference, or
     - a [[’`dynamic`’ modifier|DynamicModifier]] to indicate the absence of a type."
    shared actual Type|ValueModifier|DynamicModifier type;
    "The definition of the attribute."
    shared actual AnySpecifier definition;
    shared actual Annotations annotations;
    
    shared actual [Annotations, Type|ValueModifier|DynamicModifier, LIdentifier, AnySpecifier] children = [annotations, type, name, definition];
    
    shared actual Result transform<out Result>(Transformer<Result> transformer)
            => transformer.transformAttributeDefinition(this);
    
    shared actual Boolean equals(Object that) {
        if (is AttributeDefinition that) {
            return name == that.name && type == that.type && definition == that.definition && annotations == that.annotations;
        } else {
            return false;
        }
    }
    
    shared actual Integer hash
            => 31 * (name.hash + 31 * (type.hash + 31 * (definition.hash + 31 * annotations.hash)));
    
    shared AttributeDefinition copy(MemberName name = this.name, Type|ValueModifier|DynamicModifier type = this.type, AnySpecifier definition = this.definition, Annotations annotations = this.annotations) {
        value ret = AttributeDefinition(name, type, definition, annotations);
        copyExtraInfoTo(ret);
        return ret;
    }
}
