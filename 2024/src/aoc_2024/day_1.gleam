import gleam/int
import gleam/list
import gleam/result
import gleam/string

fn pars_items(line) {
  line |> string.split("   ") |> list.filter_map(int.parse)
}

fn acc(prev, current) {
  let res = {
    use first <- result.try(list.first(current))
    use last <- result.try(list.last(current))
    Ok(prev + int.absolute_value(first - last))
  }

  case res {
    Ok(num) -> num
    Error(_) -> 0
  }
}

fn check_eq(left: a) {
  fn(right: a) { left == right }
}

pub fn parse(input: String) {
  input
  |> string.split("\n")
  |> list.map(pars_items)
  |> list.transpose
}

pub fn pt_1(input: List(List(Int))) {
  input
  |> list.map(fn(col) { list.sort(col, int.compare) })
  |> list.transpose
  |> list.fold(0, acc)
}

pub fn pt_2(input: List(List(Int))) {
  let assert [left, right] = input

  left
  |> list.map(fn(left_item) {
    left_item * list.count(right, check_eq(left_item))
  })
  |> int.sum
}
