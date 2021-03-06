"A condition.
 
 There are four kinds of conditions:
 - a [[boolean condition|BooleanCondition]] is satisfied when a boolean expression evaluates to [[true]],
 - an [[assignability condition|IsCondition]] is satisfied when a value satisfies a specified type,
 - an [[existence condition|ExistsCondition]] is satisfied when a value is not [[null]], and
 - a [[nonemptiness condition|NonemptyCondition]] is satisfied when a [[sequential|Sequential]] value is not [[null]] and not [[empty]].
 
 Examples:
 
     exists first = string.first
     type in { type_ws, type_comment }
     is Float number
     nonempty members"
shared abstract class Condition()
        of BooleanCondition | IsCondition | ExistsOrNonemptyCondition
        extends Node() {
}
