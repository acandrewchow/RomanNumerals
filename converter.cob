*> INSTRUCTIONS TO RUN PROGRAM
*> To compile: cobc -free -x -Wall roman2dec.cob converter.cob
*> To run: ./roman2dec (filename)

identification division.
program-id. converter.

environment division.
input-output section.
data division.

working-storage section.
77 decimal-value pic 9(4). *> length of 5 for largest roman numeral
77 i pic 9(5).
77 input-symbol pic x.
77 current pic 9(4).
77 previous pic 9(4).
77 string-length pic 9(38).
77 flag pic 9(5).
linkage section.
77 input-string pic x(15).

procedure division using input-string.
    *> reset counters
    compute decimal-value = 0
    compute previous = 0
    compute current = 0
    compute flag = 0
    
    *> iterate through the roman numeral
    perform varying i from 1 by 1 until i > length of input-string or input-string(i:1) = ' '
        *> one symbol at a time
        move input-string(i:1) to input-symbol 
        *> illegal roman numeral symbol
        if not (input-symbol = 'I' or input-symbol = 'V' or input-symbol = 'X' or input-symbol = 'L' or input-symbol = 'C' or input-symbol = 'D' or input-symbol = 'M')
            move 1 to flag
        end-if
        if input-symbol = 'I'
            move 1 to current
        end-if
        if input-symbol = 'V'
            move 5 to current
        end-if
        if input-symbol = 'X'
            move 10 to current
        end-if
        if input-symbol = 'L'
            move 50 to current
        end-if
        if input-symbol = 'C'
            move 100 to current
        end-if
        if input-symbol = 'D'
            move 500 to current
        end-if
        if input-symbol = 'M'
            move 1000 to current
        end-if
        *> display "Current: " current
        *> display "Previous: " previous
        if current > previous then
            *> special case where pairs are encountered 
            compute decimal-value = decimal-value - previous + (current - previous)
        else
            compute decimal-value = decimal-value + current
        end-if
       
        move current to previous

    end-perform
        *> invalid numeral
        if flag = 1 then
           display input-string "INVALID ROMAN NUMERAL" 
        else 
           *> decimal value output
           display input-string " " decimal-value
        end-if
 exit program.
