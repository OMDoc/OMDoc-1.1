MACHINE
	booking(max_seat)
CONSTRAINTS
	max_seat : NAT & max_seat >= 10
SETS
	REPORT =  {good,bad}
VARIABLES
	seat
INVARIANT
	seat : 0..max_seat
INITIALISATION
	seat := max_seat
OPERATIONS
report <-- book(nbr) =
	PRE
		nbr : NAT
	THEN
		IF  nbr <= seat
		THEN
			report,seat := good,seat - nbr
		ELSE
			report := bad
		END
	END
;
cancel(nbr) =
	PRE
		nbr : NAT & seat +  nbr <= max_seat
	THEN
		seat := seat + nbr
	END
END


