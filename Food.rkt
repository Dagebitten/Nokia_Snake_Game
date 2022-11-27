#lang racket/gui
;File for providing FOOD OBJECT for MAIN CODE

(require "Grid.rkt")
(provide food%)

; Food class
(define food% (class object%
	(define body (random-square))
	(super-new)
	(define/public (draw dc)
		(send dc set-brush "Green" 'solid)
		(draw-square body dc))
	(define/public (get-body)
		body)
	(define/public (move)
		(set! body (random-square)))))