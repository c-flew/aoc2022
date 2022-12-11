struct ParseError <: Exception
    var::String
end
Base.showerror(io::IO, e::ParseError) = print(io, "parse error: ", e.var)

const Assignment = Tuple{Int, Int}

assignment_contains(a::Assignment, b::Assignment)::Bool = a[1] <= b[1] && a[2] >= b[2]

assignment_noms(a::Assignment, b::Assignment) = assignment_contains(a, b) || assignment_contains(b, a)
assignment_noms((a, b)::Tuple{Assignment, Assignment}) = assignment_noms(a, b)

assignment_overlaps_ow(a::Assignment, b::Assignment)::Bool = (a[1] <= b[1] <= a[2]) || (a[1] <= b[2] <= a[2])
assignment_overlaps(a::Assignment, b::Assignment)::Bool = assignment_overlaps_ow(a, b) || assignment_overlaps_ow(b, a)
assignment_overlaps((a, b)::Tuple{Assignment, Assignment}) = assignment_overlaps(a, b)

function parse_line(line::String)::Union{Tuple{Assignment, Assignment}, ParseError}
    sides = split(line, ",")
    if length(sides) != 2
        return ParseError("too many commas")
    end
    a = split(sides[1], "-")
    b = split(sides[2], "-")

    # i got lazy with proper error handling :(
    return ((parse(Int, a[1]), parse(Int, a[2])), (parse(Int, b[1]), parse(Int, b[2])))
end


open("input4.txt", "r") do io
    lines = readlines(io)
    # part 1
    (l -> l |> parse_line |> assignment_noms).(lines) |> sum |> println

    # part 2
    (l -> l |> parse_line |> assignment_overlaps).(lines) |> sum |> println
end
