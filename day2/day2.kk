import std/os/file
import std/os/path

fun parse-line( line : string ) : exn (int, int) {
  val splited = line.split(" ").map(head-char).map(unjust)
  (int(splited.head.unjust - 'A'), int(splited.drop(1).head.unjust - 'X'))
}

fun calc-score( choices : (int, int) ) : int {
  val move-score = choices.snd + 1
  val game-score = 3 * ((1 - choices.fst + choices.snd) % 3)
  (move-score + game-score)
}

fun rig( choices : (int, int) ) : (int, int) {
  val rig = (choices.snd + (choices.fst - 1)) % 3
  (choices.fst, rig)
}

fun main() {
  val contents = read-text-file(cwd() / "input2.txt")
  val rounds = contents.split("\n").filter(fn(x) x != "").map(parse-line)
  rounds.map(calc-score).sum.println // part 1
  rounds.map(rig).map(calc-score).sum.println // part 2
}
