module util

fn (mut q Queue<T>) new_rear_ndx<T>() {
	q.rear = (q.rear + 1) % q.cap
}

fn (mut q Queue<T>) new_front_ndx<T>() {
	q.front = (q.front + 1) % q.cap
}

fn (mut q Queue<T>) inc_size<T>() {
	q.size++
}

fn (mut q Queue<T>) dec_size<T>() {
	q.size--
}

fn (q Queue<T>) get<T>() T {
	return q.field[q.front]
}

fn (mut q Queue<T>) set<T>(value T) {
	q.field[q.rear] = value
}