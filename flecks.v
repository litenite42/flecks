module main

import ecs
import util as u

fn main() {
	len := 10000
	mut q := u.new_queue<int>(len)
	assert q.is_empty()

	for i in 0 .. len - 1 {
		q = q.enqueue(i + 1)
	}

	assert !q.is_full() && !q.is_empty()

	q = q.enqueue(4)

	assert q.is_full()

	x := q.front() or { panic(err) }
	assert x == 1

	front := q.dequeue() or { panic(err) }
	assert front == 1

	for !q.is_empty() {
		q.dequeue() or { -1 }
	}
	assert q.is_empty()
}
