type ('terminal, 'nonterminal) symbol = 
	| T of 'terminal 
	| N of 'nonterminal;;

(* convert rules *)
let rec grammar_rule_list rules nt = 
	match rules with
	| [] -> []
	| (l, r)::t -> 
		if 	 l = nt 
		then [r] @ (grammar_rule_list t nt)
		else grammar_rule_list t nt;;

let convert_grammar = function
	| (start_symbol, rules) -> (start_symbol, (grammar_rule_list rules));;



(* mutual recursion to implement parser*)
(* and_matcher recursively iterates through rules to see if each rule
 matches a fragment. If any element is a non terminal, it calles or_matcher to 
repeat the algorithm*)
let rec and_matcher rule_list rule accept deriv frag = 
	if rule = [] 			(*rule matches *)
	then accept deriv frag  (*call acceptor with derivation and fragment*)
	else 
	(match_frag rule_list rule accept deriv frag)

(* or_matcher recursively iterates through rules for a given start_symbol to see if
  any rule is valid. Returns one if found one, returns none if not found *)
and or_matcher start_symbol rules rhs accept deriv frag = 
		if rhs = []
		then None
		else 
		(match_rhs start_symbol rules rhs accept deriv frag)

(* helper function, check frag against rules *)
and match_frag rule_list rule accept deriv frag =
	match frag with
		| [] -> None 		(*all fragment has been checked*)
		| h::t -> 			
			match rule with 
			| (N nterm)::tail -> 	(* start mutual recursion*)
									(* accpetor matches suffix and tail*)
				(or_matcher nterm rule_list (rule_list nterm) (and_matcher rule_list tail accept) deriv frag)
			| (T term)::tail -> 
				if h = term 		(* matches, go check next*)
				then (and_matcher rule_list tail accept deriv t)
				else None

(* helper function called by or_matcher *)
and match_rhs start_symbol rules rhs accept deriv frag = 
	match rhs with
		| h::t -> 
			match (and_matcher rules h accept (deriv@[ (start_symbol, h) ]) frag) with
 			| Some(a, b) -> Some(a, b)	(* return and_matcher result*)
			| None -> (or_matcher start_symbol rules t accept deriv frag) (* false, move to next rule*)


let parse_prefix grammar accept frag = 
	match grammar with
	| (start_symbol, rules) -> or_matcher start_symbol rules (rules start_symbol) accept [] frag;;