#lang racket

(require "Config.rkt" "Grid.rkt")
(provide snake%)

; Snake class
(define snake% (class object%
	(init [body-arg empty])
	; Initialize body as the provided list or a random grid location
	; Body is a list of each of the snake's squares, denoted as '(x y) where x and y are the coordinates within grid system
	(define body
		(cond
		[(empty? body-arg) (list (random-square))]
		[else body-arg]))
	(define direction 'right)
	(super-new)
	(define/public (draw dc)
		(send dc set-pen "Black" 0 'transparent)
		(send dc set-brush "Dark Green" 'solid)
		(map (lambda (elem)
			(draw-square elem dc))
			body))
	(define/public (get-body)
		body)
	(define/public (get-head)
		(car body))
	(define/public (set-direction val)
		(set! direction val))
	(define/public (dying?)
		(define offscreen? (not (onscreen? (get-head))))
		; If head is colliding with some other part of the body, dying is true
		(define overlap? (collides? (cdr body) (get-head)))
		(and DEBUG? (printf "offscreen?: ~v~n" offscreen?))
		(and DEBUG? (printf "overlap?: ~v~n" overlap?))
		(or offscreen? overlap?))
	(define/public (eating? food-location)
		(collides? body food-location))
	(define/public (move)
		; 1. Add new head in proper direction
		(grow)
		(and DEBUG? (printf "Moved head: ~v, ~v\n" (car (car body)) (cdr (car body))))
		; 2. Remove tail (unless instructed to grow during this step)
		(set! body (remove-tail body)))
	(define/public (grow)
		; Add one more square to the snake according to direction
		(define new-head (get-head))	
		(cond
			[(eq? direction 'right)
				(set! new-head (square-right new-head))]
			[(eq? direction 'left)
				(set! new-head (square-left new-head))]
			[(eq? direction 'up)
				(set! new-head (square-above new-head))]
			[(eq? direction 'down)
				(set! new-head (square-below new-head))])	
		(set! body (cons new-head body)))))
