note
	description: "Summary description for {TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRACKER
inherit
	ANY
		redefine out end

create
	make

feature -- attributes
	max_phase_radiation : VALUE
	max_container_radiation : VALUE
	errors : ERRORS

feature {NONE}
	make
		do
			create max_phase_radiation.make_from_int(0)
			create max_container_radiation.make_from_int(0)
			create errors.make
		end

feature {STATE}
	new_maximums (phase_max: VALUE; container_max: VALUE)
		do
			max_phase_radiation := phase_max
			max_container_radiation := container_max
		end

feature
	out : STRING
		do
			create Result.make_from_string("  ")
			Result.append("max_phase_radiation: " + max_phase_radiation.out + ", ")
			Result.append("max_container_radiation: " + max_container_radiation.out + "%N")
		end

end
