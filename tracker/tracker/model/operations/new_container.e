note
	description: "Summary description for {NEW_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_CONTAINER
inherit
	OPERATION
create
	make

feature {NONE}

	make (cid_given: STRING; cont_given: TUPLE[material_given: INTEGER_64; rad_given: VALUE]; pid_given: STRING ; msg: STRING)
	do
		cid.make_from_string(cid_given)
		con.material = cont_given.material_given
		con.radioacitivity = cont_given.rad_given
		pid:= pid_given

		item := msg
		error_string := ""

		create error.make
	end


feature
	cid := STRING
	pid := STRING
	container : TUPLE[material :INTEGER_64; rad :VALUE]
	error : ERRORS
	new_message : STRING
	
	error_check
		do

		end

	execute
		do

		end

	undo
		do

		end

	redo
		do

		end
end
