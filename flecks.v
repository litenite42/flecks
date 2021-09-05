module main
import ecs
import util as u

fn main() {
	mut q := u.new_queue<int>(4)
	assert q.is_empty()

	q = q.enqueue(1).enqueue(2).enqueue(3)
	println(q)
	q = q.enqueue(4)
	println(q)
	assert q.is_full()

	x := q.front() or {
		-1
	}

	println('q.front(): '+ x.str())
	front := q.dequeue() or {
		panic(err)
	}

	println('front: ' + front.str())
	q = q.enqueue(5)

	println(q)
}
