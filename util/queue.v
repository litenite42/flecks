module util

// Queue<T> is a heap-allocated circular array implementatin
// of a FIFO structure
[heap]
struct Queue<T> {
mut:
	field []T // items in queue
	front int // where to remove from
	rear  int // where to insert
	size  int // how many are in queue
	cap   int // how many can be in queue
}

// new_queue<T> allocate space for a queue with a capacity of 'cap'
// @param cap int -> how much space to set aside for the queue
// @return &Queue<T> a reference to the allocated space
pub fn new_queue<T>(cap int) &Queue<T> {
	// return the alloted memory
	return &Queue<T>{
		field: []T{len: cap, cap: cap}
		rear: cap - 1
		cap: cap
	}
}

// is_full determine if the queue is full
pub fn (q Queue<T>) is_full() bool {
	return q.cap == q.size
}

// is_empty determine if the queue is empty
pub fn (q Queue<T>) is_empty() bool {
	return q.size == 0
}

pub fn (q Queue<T>) length() int {
	return q.size
}

// clone duplicates a queue's information into a new reference
pub fn (q Queue<T>) clone() &Queue<T> {
	return &Queue<T>{
		size: q.size
		rear: q.rear
		front: q.front
		field: q.field.clone()
		cap: q.cap
	}
}

// enqueue push an item into the queue
// @param value T the item to be placed into queue
// @return &Queue<T> reference to new queue containing result
pub fn (q Queue<T>) enqueue(value T) &Queue<T> {
	// just return the queue if full
	if q.is_full() {
		return &q
	}
	// don't forget to clean up, since we're using a new reference
	defer {
		unsafe {
			free(q)
		}
	}
	// deep clone of queue
	mut new_q := q.clone()
	// update end and size of queue
	new_q.new_rear_ndx()
	new_q.inc_size()

	new_q.set(value)

	return new_q
}

pub fn (mut q Queue<T>) enqueue_m(value T) {
	assert !q.is_full() 
	q.new_rear_ndx()
	q.inc_size()

	q.set(value)
}

// dequeue remove item from front of queue
// @return ?T either item at front of queue or none
pub fn (mut q Queue<T>) dequeue() ?T {
	if q.is_empty() {
		return none
	}
	// get item and update queue metadata
	item := q.get()
	q.new_front_ndx()
	q.dec_size()

	return item
}

// front peek the front of the queue without affecting it
// @return ?T item at front of queue or none
pub fn (q Queue<T>) front() ?T {
	if q.is_empty() {
		return none
	}

	return q.field[q.front]
}

// rear peek the item at the rear of queue without affecting it
// @return ?T item at rear of queue or none
pub fn (q Queue<T>) rear() ?T {
	if q.is_empty() {
		return none
	}

	return q.field[q.rear]
}