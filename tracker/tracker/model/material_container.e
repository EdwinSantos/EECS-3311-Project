note
	description: "Summary description for {MATERIAL_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MATERIAL_CONTAINER
create
	make

feature
	cid : STRING
	c : TUPLE [material: INTEGER_64; radioactivity: VALUE]
	pid : STRING

feature {NONE}
	make (cont_id: STRING; con: TUPLE[material: INTEGER_64; radioacitivity:VALUE]; ph_id : STRING)
		do
			cid := cont_id
			c := con
			pid := ph_id
		end
end
