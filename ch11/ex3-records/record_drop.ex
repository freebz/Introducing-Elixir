defmodule RecordDrop do
	require Tower

	def fall_velocity(Tower.tower(planemo: planemo, height: distance)) do
		fall_velocity(planemo, distance)
	end

	def fall_velocity(:earth, distance) when distance >= 0 do
		:math.sqrt(2 * 9.8 * distance)
	end

	def fall_velocity(:moon, distance) when distance >= 0 do
		:math.sqrt(2 * 1.6 * distance)
	end

	def fall_velocity(:mars, distance) when distance >= 0 do
		:math.sqrt(2 * 3.71 * distance)
	end

end
