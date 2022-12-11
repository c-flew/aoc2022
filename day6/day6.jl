struct NoMarkerException <: Exception
    var::Int
end
Base.showerror(io::IO, e::NoMarkerException) = print(io, "no marker found for marker length of: ", e.var)

const RT = Union{Int, NoMarkerException}

function marker_start(line::String, n::Int)::RT
    for i in n:length(line)
        length(Set(line[i-(n-1):i])) == n && return i
    end
    return NoMarkerException(10)
end

handle_marker_start(n::Int) = println(n)
handle_marker_start(n::NoMarkerException) = throw(n)

open("input6.txt", "r") do io
    input = read(io, String)
    handle_marker_start(marker_start(input, 4)) # part 1
    handle_marker_start(marker_start(input, 14)) # part 2
    NoMarkerException(10)
end
