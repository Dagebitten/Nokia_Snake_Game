#lang racket/gui
;File for providing GRID HELPER FUNCTIONS for MAIN CODE

(require "Config.rkt")
(provide draw-square collides? random-square grid-max onscreen? remove-tail square-above square-below
         square-left square-right)

; Grid Functions
	; Draw-square: Draws square in grid system
(define (draw-square position dc)
	(let ([x (car position)]
		[y (cdr position)])
		(send dc draw-rectangle (* x SQUARE_SIZE) (* y SQUARE_SIZE) SQUARE_SIZE SQUARE_SIZE)))
	; collides? Check if `list` has any collisions with `point` (check if list contains the point)
(define (collides? arg-list arg-pair)
	(define result #f)
	; Check each body element to see if collides with given pair
	(for ([i arg-list])
		#:break (equal? result #t)
		(when (equal? arg-pair i)
			(set! result #t)))
	; Return the resulting boolean
	result)
	; random-square: gets random square in grid
(define (random-square)
	(cons (random (+ 1 (car (grid-max)))) (random (cdr (grid-max)))))
	; grid-max: returns a pair containing the max x and y values that are onscreen in grid system
(define (grid-max)
	(define pix-width SCREEN_WIDTH)
	(define pix-height SCREEN_HEIGHT)
	(define dc-width (/ pix-width DEFAULT_SCALE))
	(define dc-height (/ pix-height DEFAULT_SCALE))
	(cons (- (/ dc-width SQUARE_SIZE) 1) (- (/ dc-height SQUARE_SIZE) 1)))
	; onscreen?
(define (onscreen? pair)
	(define local-max (grid-max))
	(define x (car pair))
	(define y (cdr pair))
	(define within-x-axis? (and (>= x 0) (<= x (car local-max))))
	(define within-y-axis? (and (>= y 0) (<= y (cdr local-max))))
	(and within-x-axis? within-y-axis?))
	; remove-tail: Remove tail from l and return result
(define (remove-tail l)
	(cond
		[(empty? l) (error "remove-tail: list cannot be empty")]
		[(empty? (cdr l)) empty]
		[else (cons (car l) (remove-tail (cdr l)))]))
; Helper functions for relative square locations
(define (square-above square)
	(cons (car square) (- (cdr square) 1)))

(define (square-below square)
	(cons (car square) (+ (cdr square) 1)))

(define (square-left square)
	(cons (- (car square) 1) (cdr square)))

(define (square-right square)
	(cons (+ (car square) 1) (cdr square)))
