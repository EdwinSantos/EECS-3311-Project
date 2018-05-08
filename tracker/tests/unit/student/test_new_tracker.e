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
--		add_boolean_case (agent error1)
--		add_boolean_case (agent error2)
--		add_boolean_case (agent error3)
		add_boolean_case (agent error4)
--		add_boolean_case (agent noError)
	end
feature
--	-- error e1
--	error1 : BOOLEAN
--		local
--		do

--		end
--	-- error e2
--	error2 : BOOLEAN
--		local

--		do

--		end
--	-- error e3
--	error3 : BOOLEAN
--		local
--		do
--			comment("attempted to create a tracker that violated e3")
--		end
	-- error e4
	error4 : BOOLEAN
		local
		errors : ERRORS
		state : STATE
		tracker : TRACKER
		operation : OPERATION
		new_tracker : NEW_TRACKER
		do
			comment("attempted to create a tracker that had max container > max radiation")
			create state.make
			create errors.make
			state.new_tracker (create {VALUE}.make_from_string ("40"), create {VALUE}.make_from_string ("60"))

			Result := new_tracker.error_string.is_equal (errors.e4)
		end
	-- no error
--	/*
--	noError : BOOLEAN
--		local
--		do
--			comment("sucessfully created a new tracker")
--		end






end
