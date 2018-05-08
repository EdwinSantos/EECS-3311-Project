note
	description: "Summary description for {TEST_NEW_TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_NEW_TRACKER

inherit
	ES_TEST
create
	make
feature
	make
	do
		add_boolean_case (agent error2)
		add_boolean_case (agent error3)
		add_boolean_case (agent error4)
		add_boolean_case (agent noError)
	end
feature

	-- error e2
	error2 : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			comment("e2: attempted to create a tracker with negative max phase radiation")
			create errors.make
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("-60"), create {VALUE}.make_from_string ("40"), 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e2)
		end
	-- error e3
	error3 : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			comment("e3: attempted to create a tracker with negative max container radiation")
			create errors.make
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("60"), create {VALUE}.make_from_string ("-40"), 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e3)
		end

	-- error e4
	error4 : BOOLEAN
		local
		errors : ERRORS
		operation : OPERATION
		do
			comment("e4: attempted to create a tracker that had max container > max radiation")
			create errors.make
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("40"), create {VALUE}.make_from_string ("60"), 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.e4)
		end

	-- no error
	noError : BOOLEAN
		local
			errors : ERRORS
			operation : OPERATION
		do
			comment("sucessfully created a new tracker")
			create errors.make
			operation := create {NEW_TRACKER}.make (create {VALUE}.make_from_string ("60"), create {VALUE}.make_from_string ("40"), 0, 0)
			operation.error_check
			Result := operation.error_string.is_equal (errors.ok)
		end
end
