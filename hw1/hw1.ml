(* subset a b that returns true if the set represented by the list a is a subset of the set represented by the list b*)
let rec subset a b =
	if a == [] 
		then true
	else ((List.mem (List.hd a) b) && subset (List.tl a) b);;

(* equal_sets a b returns true iff the represented sets are equal. *)
let rec equal_sets a b =
subset a b && subset b a;;

(* set_union a b returns a list representing a∪b. *)
let rec set_union a b =
	match (a, b) with
		  ([], b) -> b
		| (a, []) -> a
		| ( (h1::t1 as a), (h2::t2 as b)) ->
			if h1 == h2 then h1::(set_union t1 t2)
			else h1::(set_union t1 b);;  

(* a b returns a list representing a∩b. *)
let rec set_intersection a b = 
	match (a, b) with
		  ([], b) -> []
		| (a, []) -> []
		| ( (h1::t1 as a), (h2::t2 as b)) ->
			if List.mem h1 b then h1::(set_intersection t1 b)
			else set_intersection t1 b;;

(* set_diff a b returns a list representing a−b, that is, the set of all members of a that are not also members of b. *)
let rec set_diff a b =
	match (a, b) with
		  ([],b) -> []
		| (a,[]) -> a
		| ( (h1::t1 as a), (h2::t2 as b)) ->
			if not (List.mem h1 b) then h1::(set_diff t1 b)
			else set_diff t1 b;;

(* returns the computed fixed point for f with respect to x, assuming that eq is the equality predicate for f's domain. *)
let rec computed_fixed_point eq f x =
	if eq x (f x) then
		x
	else
		computed_fixed_point eq f (f x);;

(* returns the computed periodic point for f with period p and with respect to x, assuming that eq is the equality predicate for f's domain.*)
let rec computed_periodic_point eq f p x = 
	if p = 0 then x 
	else if 
		eq x (f (computed_periodic_point eq f (p-1) (f x)))
	then x 
	else (computed_periodic_point eq f p (f x));;	

(* define symbol type *)
type ('terminal, 'nonterminal) symbol = 
	| T of 'terminal 
	| N of 'nonterminal;;

(* check if subrule is valid. i.e. the subrule can be derived to terminal symbols. *)
let check_RHS known_terminals rhs= 
	match rhs with
    | T r -> true
	| N r -> List.mem r known_terminals;; (* if the symbol is a known terminals*)

(* helper function*)
let rec check_rule_helper known_terminals rule =
	match rule with
	| a::b -> 
	 	if (check_RHS known_terminals a) 
	 	then check_rule_helper known_terminals b 
	    else false
	| [] -> true
	| _ -> false;;

(* check if rule is valid. i.e. each subrule can be derived to terminal symbols *)
let check_this_rule known_terminals rule= 
	if rule = []
	then true
	else check_rule_helper known_terminals rule;;
		
(* helper function *)
let rec update_terminal_helper terminal_rules rules =
	match rules with
	| (ha, hb)::t -> 
		if (check_this_rule terminal_rules hb)
		then ( 
			if (List.mem ha terminal_rules) 
			then update_terminal_helper terminal_rules t 
			else update_terminal_helper (ha::terminal_rules) t)
		else update_terminal_helper terminal_rules t
	| [] -> terminal_rules;;

(* find and update terminal rules*)
let update_terminal_rules terminal_rules rules= 
	if rules = []
	then terminal_rules
	else update_terminal_helper terminal_rules rules;;
 
(* filter out blind-alley rules by checking rule against good rules we computed from previous function *)
let rec filter_rules known_terminals rules = 
	match rules with 
	| [] -> []
	| (a, b)::t -> 
	    if (check_this_rule known_terminals b) 
		then (a, b)::(filter_rules known_terminals t) 
		else filter_rules known_terminals t;;	

(* return the first element in a tuple *)
let returnx str =
	match str with
	| (a, b) -> a;;

(* function to pass to computed_fixed_point *)
let f (known_terminals, rules) =
	((update_terminal_rules known_terminals rules), rules);;
(* equal function to be passed to computed fixed point*)
let eq = fun (a, _) (b, _) -> equal_sets a b;;

(* returns a copy of the grammar g with all blind-alley rules removed. 
 * This function should preserve the order of rules: that is, all rules that are returned should 
 * be in the same order as the rules in g. *)

let filter_blind_alleys  = function
	| (start_symbol, rules) -> 
	  (start_symbol, filter_rules (returnx(computed_fixed_point eq f ([], rules))
	) rules);; 