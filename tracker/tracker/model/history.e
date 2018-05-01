note
	description: "Summary description for {HISTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

create
	make

feature {STATE}
	make
		do
			create {ARRAYED_LIST[OPERATION]}history.make(10)
		end


feature -- history
	history: LIST[OPERATION]
		-- history of used invoked operations

	extend_history(cur_op : OPERATION)
		-- wipe all operations past current point and
		-- extend with `cur_op`
		do
			remove_right
			history.extend (cur_op)
			history.finish
		ensure
			history[history.count] = cur_op
		end

	remove_right
		do
			if not history.islast and not history.after then
				from
					history.forth
				until
					history.after
				loop
					history.remove
				end
			end
		end

	clear
		do
			from
				history.start
			until
				history.after
			loop
				history.remove
			end
		end

	item: OPERATION
		require
			on_item
		do
			Result := history.item
		end

	on_item: BOOLEAN
		do
			Result := history.valid_index(history.index)
		end

	forth
		do
			history.forth
		end

	back
		do
			history.back
		end

	not_last: BOOLEAN
		do
			Result := not history.is_empty and not history.islast
		end

	is_last : BOOLEAN
		do
			Result := history.islast
		end

	is_back_invalid : BOOLEAN
		do
			Result := history.before
		end

	is_first: BOOLEAN
		do
			Result := history.isfirst
		end

	is_empty: BOOLEAN
		do
			Result := history.is_empty
		end
end
