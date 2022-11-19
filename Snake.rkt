#lang racket/gui
;File for providing SNAKE OBJECT for the MAIN CODE

(require "config.rkt")
(provide snake%)

; Snake Class
(define snake%
  (class object%
    (init [body-arg empty])
    ; This differs from the 2 Cars due to how the "Body" would just be a list/grid
    ; of coordinates within the screen

    (define body 

    (define/public (change-direction)
      (cond
        [(equal? moving-to 'left) (set! moving-to 'right)]
        [(equal? moving-to 'right) (set! moving-to 'left)]
        )
      )
    
    (define car-bitmap
      [read-bitmap
       "Snake.png"
       #:backing-scale 0.5
       ]
      )

    
    (super-new)


    (define/public (draw dc)
       (send dc draw-bitmap car-bitmap x-pos y-pos)
    )
  )
)