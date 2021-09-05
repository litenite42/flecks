module util
import math as m

[heap]
struct Queue<T> {
	mut:
	field []T
	front int
	rear int
	size int
	cap int
}

pub fn new_queue<T>(cap int) &Queue<T>
{
	return &Queue<T>{
		field : []T{len: cap, cap: cap}
		rear : cap-1
		cap : cap
	}
}

pub fn (q Queue<T>) is_full() bool {
	return q.cap == q.size
}

pub fn (q Queue<T>) is_empty() bool {
	return q.size == 0
}

pub fn (q Queue<T>) clone() &Queue<T>{
	return &Queue<T> {
		size : q.size
		rear : q.rear
		front : q.front
		field : q.field.clone()
		cap : q.cap
	}
}

pub fn (q Queue<T>) enqueue<T>(value T) &Queue<T> {
	if q.is_full() {
		return &q
	}

	defer {
		unsafe {
			free(q)
		}
	}

	mut new_q := q.clone()
	
	new_q.new_rear_ndx()
	new_q.inc_size()
	new_q.set(value)

	return new_q
}

pub fn (mut q Queue<T>) dequeue<T>() ?T {
	if q.is_empty()
	{
		return none
	}
	
	item := q.get()	
	q.new_front_ndx()
	q.dec_size()

	return item
}

pub fn (q Queue<T>) front() ?T {
	if q.is_empty() {
		return none
	}

	return q.field[q.front]
}

pub fn (q Queue<T>) rear() ?T {
	if q.is_empty() {
		return none
	}

	return q.field[q.rear]
}