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

	make (cid: STRING; cont: TUPLE[material: INTEGER_64; rad: VALUE]; pid: STRING; msg: STRING)
	do
		cont_id.make_from_string(cid)
		con.material = cont.material
		con.radioacitivity = cont.rad
		ph_id:= pid
		-- item := command_name
		new_message := msg
		error_string := ""
	end


feature

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
