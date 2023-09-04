*> Andrew Chow
*> CIS 3190 A3
*> achow04@uoguelph.ca 1088114

*> INSTRUCTIONS TO RUN PROGRAM
*> To compile: cobc -free -x -Wall roman2dec.cob converter.cob
*> To run: ./roman2dec (filename)

identification division.
program-id. roman2dec.

environment division.
input-output section.
file-control.
select data-file assign to dynamic roman-file
       organization is line sequential.

data division.
file section.
fd data-file.
01 data-record pic x(80).

working-storage section.
77 end-of-file pic x value 'n'.
77 roman-file pic x(50) value ' '.
77 input-string pic x(15).
77 temp-string pic x(15).
77 string-length pic 9(2).

procedure division.
    *> reads in the file at stdin
    display "Welcome to Roman Numeral Converter!"
    display "Enter a file containing roman numerals (must be .txt file located in the same directory):"
    accept roman-file
    
    *> Key printed to user
    display "Roman Numeral Legend"
    display "---------------------"
    display " I -> 1 "
    display " V -> 5 "
    display " X -> 10 "
    display " L -> 50 "
    display " C -> 100 "
    display " D -> 500 "
    display " M -> 1000 "
    display "---------------------"
    
    *> open file
    open input data-file

    *> display results
    display "Roman Number Equivalents"
    display "------------------------"
    display "Roman Number  Dec. Equiv."
    display "------------------------"

    move 'n' to end-of-file
    perform until end-of-file = 'y'
        read data-file
            *> finish reading at end of file
            at end
                move 'y' to end-of-file
            not at end
               move data-record to input-string
               *> Convert the roman numerals line by line until the end of the file is reached
               call "converter" using input-string 
               move spaces to input-string *> reset the string after each iteration
        end-read
    end-perform
    close data-file
stop run.
