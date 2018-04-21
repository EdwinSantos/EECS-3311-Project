note
	description: "Summary description for {MATERIAL_CONTAINER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MATERIAL_CONTAINER
inherit
	ANY
		redefine out end

create
	make

feature
	cid : STRING
	mat : INTEGER_64
	radioac : VALUE
	pid : STRING

	moveToPhase(p:STRING)
		do
			pid := p
		end

feature {NONE}
	make (cont_id: STRING; con: TUPLE[material: INTEGER_64; radioacitivity:VALUE]; ph_id : STRING)
		do
			cid := cont_id
			mat := con.material
			radioac := con.radioacitivity
			pid := ph_id
		end

feature
	out : STRING 
		local
			materialType :STRING
		do
			materialType := ""
			if mat.as_integer_32 = 1 then
				materialType := "glass"
			elseif mat.as_integer_32 = 2 then
				materialType := "metal"
			elseif mat.as_integer_32 = 3 then
				materialType := "plastic"
			elseif mat.as_integer_32 = 4 then
				materialType := "liquid"
			end
			create Result.make_empty
			Result.append(cid+"->"+pid+"->"+materialType+","+radioac.out)
		end
end
