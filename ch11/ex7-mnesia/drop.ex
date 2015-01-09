defmodule Drop do

	def drop do
		setup
		handle_drops
	end

	def handle_drops do
		receive do
			{from, planemo, distance} ->
				send(from, {planemo, distance, fall_velocity(planemo, distance)})
				handle_drops
		end
	end

	def fall_velocity(planemo, distance) when distance >= 0 do
		{:atomic, [p | _]} = :mnesia.transaction(fn() ->
			:mnesia.read(Planemo, planemo) end)
		:math.sqrt(2 * p.gravity * distance)
	end

	def setup do
		:mnesia.create_schema([node()])
		:mnesia.start()
		:mnesia.create_table(PlanemoTable, [{:attributes,
      [:name, :gravity, :diameter, :distance_from_sun]},
      {:record_name, :planemo}])
		
		f = fn ->
			:mnesia.write(PlanemoTable, Planemo.planemo(name: :mercury, gravity: 3.7,
        diameter: 4878, distance_from_sun: 57.9), :write)
		end

		:mnesia.transaction(f)
	end
end

