import std/os/file
import std/os/path

fun unique ( l : list<int> ) : div list<int> {
    match l
        Nil -> []
        Cons(x, xs) -> [x] ++ unique(xs.filter(fn(y) y != x))
}

fun calc-priority( c : char ) : int {
    int(c - (if is-lower(c) then 'a' - 1.char else 'A' - 27.char))
}

fun priority( line : string ) : div int {
    val part = count(line) / 2
    val first = line.list.take(part)
    val second = line.list.drop(part)
    first.filter(fn(x) second.any(fn(y) x == y)).map(calc-priority).unique.sum
}

fun part2( contents : list<string> ) : <div,exn> int {
    match contents
        Nil -> 0
        Cons(x, xs) -> priority2(x.list, xs.head.unjust.list, xs.tail.head.unjust.list) + part2(xs.drop(2))
}

fun priority2( first : list<char>, second : list<char>, third : list<char>) : div int {
    first.filter(fn(x) second.any(fn(y) x == y) && third.any(fn(y) x == y)).map(calc-priority).unique.sum
}

fun main() {
    val contents = read-text-file(cwd() / "input3.txt").split("\n").filter(fn(x) x != "")
    contents.map(priority).sum.println // part 1
    contents.part2.println // part 2
}
