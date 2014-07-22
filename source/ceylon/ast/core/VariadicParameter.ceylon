"""A variadic parameter.
   
   Examples:
   
       Element+ elements
       String* messages
       "The indexes" Integer+ indexes"""
shared class VariadicParameter(annotations, type, name)
        extends Parameter() {
    
    "The annotations of the parameter."
    shared Annotations annotations;
    "The variadic type of the parameter."
    shared VariadicType type;
    "The name of the parameter."
    shared MemberName name;
    
    shared actual [Annotations, VariadicType, LIdentifier] children = [annotations, type, name];
    
    shared actual Result transform<out Result>(Transformer<Result> transformer)
            => transformer.transformVariadicParameter(this);
    
    shared actual Boolean equals(Object that) {
        if (is VariadicParameter that) {
            return annotations == that.annotations && type == that.type && name == that.name;
        } else {
            return false;
        }
    }
    
    shared actual Integer hash
            => 31 * (annotations.hash + 31 * (type.hash + 31 * name.hash));
    
    shared VariadicParameter copy(Annotations annotations = this.annotations, VariadicType type = this.type, MemberName name = this.name) {
        value ret = VariadicParameter(annotations, type, name);
        copyExtraInfoTo(ret);
        return ret;
    }
}
