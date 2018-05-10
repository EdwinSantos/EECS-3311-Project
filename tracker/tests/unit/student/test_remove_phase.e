note
	description: "Summary description for {TEST_REMOVE_PHASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_REMOVE_PHASE

inherit
	ES_TEST
create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case(agent error9)
			add_boolean_case(agent noError)
		end
feature
	error9 : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("e9: phase identifier not in the system")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("RP_error9_P1", "someName", 1, << 1 >>, "", 0, 0)
			operation.execute
			operation := create {REMOVE_PHASE}.make ("NOT_RP_error9_P1", "", 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e9)
		end

	noError : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			create errors.make
			comment("ok: sucessfully removed a phase")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("1"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("RP_noError_P1", "someName", 1, << 1 >>, "", 0, 0)
			operation.execute
			operation := create {REMOVE_PHASE}.make ("RP_noError_P1", "", 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.ok)
		end
end
