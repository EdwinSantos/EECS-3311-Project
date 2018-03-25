note
	description: "Summary description for {TRACKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TRACKER
create
	make

feature
	max_phase_radiation : VALUE
	max_container_radiation : VALUE

feature {NONE}
	make (phase_max: VALUE; container_max: VALUE)
		do
			max_phase_radiation := phase_max
			max_container_radiation := container_max
		end

end
