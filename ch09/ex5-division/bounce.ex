defmodule Bounce do
	def report do
		receive do
			x -> IO.puts("Divied to #{x / 2}")
			report()
		end
	end
end
