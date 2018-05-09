note
	description: "Summary description for {TEST_NEW_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_NEW_CONTAINER
inherit
	ES_TEST
create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent error5)
			add_boolean_case (agent error9)
			add_boolean_case (agent error10)
			add_boolean_case (agent error11)
			add_boolean_case (agent error12)
			add_boolean_case (agent error13)
			add_boolean_case (agent error14)
			add_boolean_case (agent error18)
			add_boolean_case (agent noError)
		end
feature
	error5: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e5: identifiers/names must start with A-Z, a-z or 0..9")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e5_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("_e5_container1", 1, create {VALUE}.make_from_int (1), "e5_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e5)
		end
	error9: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e9: phase identifier not in the system")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e9_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e9_container1", 1, create {VALUE}.make_from_int (1), "Not_e9_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e9)
		end
	error10: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e10: this container identifier already in tracker")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e10_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e10_container1", 1, create {VALUE}.make_from_int (1), "e10_phase", "", 2, 1)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e10_container1", 1, create {VALUE}.make_from_int (1), "e10_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e10)
		end
	error11: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e11: this container will exceed phase capacity")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e11_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e11_cont1", 1, create {VALUE}.make_from_int (1), "e11_phase", "", 2, 1)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e11_cont2", 1, create {VALUE}.make_from_int (1), "e11_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e11)
		end

	error12: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e12: this container will exceed phase safe radiation")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e12_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e12_cont1", 1, create {VALUE}.make_from_int (1), "e12_phase", "", 2, 1)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e12_cont2", 1, create {VALUE}.make_from_int (1), "e12_phase", "", 2, 1)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e12_cont3", 1, create {VALUE}.make_from_int (1), "e12_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e12)
		end
	error13: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e13: phase does not expect this container material")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e13_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e13_cont1", 2, create {VALUE}.make_from_int (1), "e13_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e13)
		end
	error14: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e14: container radiation capacity exceeded")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e14_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e14_cont1", 1, create {VALUE}.make_from_int (100), "e14_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e14)
		end
	error18: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("e18: this container radiation must not be negative")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("e18_phase", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("e18_cont1", 1, create {VALUE}.make_from_int (-1), "e18_phase", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e18)
		end

	noError: BOOLEAN
		local
			operation : OPERATION
			errors: ERRORS
		do
			create errors.make
			comment("ok: container created successfully")
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("2"), create {VALUE}.make_from_string ("1"), 0, 0)
			operation.execute
			operation := create {NEW_PHASE}.make ("NC_NoError", "someName", 1, << 1 >>, "", 1, 0)
			operation.execute
			operation := create {NEW_CONTAINER}.make ("NC_Container1", 1, create {VALUE}.make_from_int (1), "NC_NoError", "", 2, 1)
			operation.error_check
			Result := operation.error_string.is_equal (errors.ok)
		end
end
