# Program file: MIPS1_Task3_TomPainadath.asm
#       Author: Tom Painadath
#  Description: Program to allow user to enter 64 byte string via I/O window and save to array. 
#               The string is then copies to array Y

.data
                   prompt:  .asciiz ">>>"                           #label print string that prompts user enter a string
                    error:  .asciiz "Invalid input \n"              #label print string that prints error message
                 no_error:  .asciiz "Valid input \n"                #label print string that prints no error message
                userInput:  .space 65                               #allocate 64 bytes of memory in the data region including null value
                inputSize:  .word 64                                #initialize 64 bytes of allocated space65

.text 
                     main:
                            add $s0, $zero, $zero                   #intitilaize register $s0 by adding 0
                            add $s1, $zero, $zero
                            add $s4, $zero, $zero                   #intitilaize register $s4 by adding 0
                            add $t1, $zero, $zero                   #intitilaize register $t1 by adding 0
                            add $t2, $zero, $zero                   #intitilaize register $t2 by adding 0
                            add $t3, $zero, $zero                   #intitilaize register $t3 by adding 0
                            add $t4, $zero, $zero                   #intitilaize register $t4 by adding 0
                            add $t5, $zero, $zero                   #intitilaize register $t5 by adding 0
                            add $t6, $zero, $zero                   #intitilaize register $t6 by adding 0
                            add $t7, $zero, $zero                   #intitilaize register $t7 by adding 0
                            add $t8, $zero, $zero                   #intitilaize register $t8 by adding 0
                            add $t9, $zero, $zero
                            addi $s4, $zero, 2                      #store constant 2 in register $s4
                            
                            li $v0, 4                               #load constant 4 to $v0 to print
                            la $a0, prompt                          #load the data from data label prompt to register $a0
                            syscall                                 #execute print
          
                            li $v0, 8                               #load constant 8 to $v0 to read input string
                            la $a0, userInput                       #load address of memory to use
                            la $a1, inputSize                       #load the maximum size of the string to read
                            syscall                                 #execute read
          

                   strcpy:
                            addi $sp, $sp, -8                       #adjust stack for 2 item
                            sw   $s0, 0($sp)                        #save $s0
                            sw   $a0, 4($sp)                        #save retun address
                            add  $s0, $zero, $zero                  #i = 0
                       L1:  
                            add $t1, $s0, $a0                       #addr of y[i] in $t1
                            lbu $t2, 0($t1)                         #$st2 = y[i]
                            beq $t2, 33, Print_error                #branch to print error for not allowed char: !
                            beq $t2, 34, Print_error                #branch to print error for not allowed char: "
                            beq $t2, 35, Print_error                #branch to print error for not allowed char: #
                            beq $t2, 36, Print_error                #branch to print error for not allowed char: $
                            beq $t2, 37, Print_error                #branch to print error for not allowed char: %
                            beq $t2, 38, Print_error                #branch to print error for not allowed char: &
                            beq $t2, 39, Print_error                #branch to print error for not allowed char: '
                            beq $t2, 44, Print_error                #branch to print error for not allowed char: ,
                            beq $t2, 46, Print_error                #branch to print error for not allowed char: .
                            beq $t2, 58, Print_error                #branch to print error for not allowed char: :
                            beq $t2, 59, Print_error                #branch to print error for not allowed char: ;
                            beq $t2, 60, Print_error                #branch to print error for not allowed char: <
                            beq $t2, 62, Print_error                #branch to print error for not allowed char: >
                            beq $t2, 63, Print_error                #branch to print error for not allowed char: ?
                            beq $t2, 64, Print_error                #branch to print error for not allowed char: @
                            beq $t2, 91, Print_error                #branch to print error for not allowed char: [
                            beq $t2, 92, Print_error                #branch to print error for not allowed char: \
                            beq $t2, 93, Print_error                #branch to print error for not allowed char: ]
                            beq $t2, 94, Print_error                #branch to print error for not allowed char: ^
                            beq $t2, 95, Print_error                #branch to print error for not allowed char: _
                            beq $t2, 96, Print_error                #branch to print error for not allowed char: `
                            beq $t2, 123, Print_error               #branch to print error for not allowed char: {
                            beq $t2, 124, Print_error               #branch to print error for not allowed char: |
                            beq $t2, 125, Print_error               #branch to print error for not allowed char: }
                            beq $t2, 126, Print_error               #branch to print error for not allowed char: ~
                            beq $t2, 48, digit_after_space_check    #branch if the char is '0' to check if there is a space before it
                            beq $t2, 49, digit_after_space_check    #branch if the char is '1' to check if there is a space before it
                            beq $t2, 50, digit_after_space_check    #branch if the char is '2' to check if there is a space before it
                            beq $t2, 51, digit_after_space_check    #branch if the char is '3' to check if there is a space before it
                            beq $t2, 52, digit_after_space_check    #branch if the char is '4' to check if there is a space before it
                            beq $t2, 53, digit_after_space_check    #branch if the char is '5' to check if there is a space before it
                            beq $t2, 54, digit_after_space_check    #branch if the char is '6' to check if there is a space before it
                            beq $t2, 55, digit_after_space_check    #branch if the char is '7' to check if there is a space before it
                            beq $t2, 56, digit_after_space_check    #branch if the char is '8' to check if there is a space before it
                            beq $t2, 57, digit_after_space_check    #branch if the char is '9' to check if there is a space before it
                  
         operator_tracker:
                            beq $t2, 43, operand_pop                #branch if the char is '+' to load the operand from memory
                            beq $t2, 47, operand_pop                #branch if the char is '/' to load the operand from memory
                            beq $t2, 42, operand_pop                #branch if the char is '*' to load the operand from memory
                            beq $t2, 45, operand_pop                #branch if the char is '+' to load the operand from memory
                    begin:
                            beq $t2, 47, more_error_check           #branch if the char is '/' for more error check 
                            beq $t2, 42, more_error_check           #branch if the char is '*' for more error check 
                            beq $t2, 41, more_error_check           #branch if the char is ')' for more error check 
                            beq $t2, 47, more_error_check           #branch if the char is '/' for more error check 
                            beq $t2, 40, no_operator                #branch if the char is '(' for more error check 
                            beq $t2, 32, digit_before_space_check   #branch if the char is 'space' to check if there is a digit before it
                            add $t8, $zero, $zero                   #reset the space tracker if the space is between a digit and a non digit charcter

                    again:
                            beq $t2, 40, Paranthesis_tracker        #branch if the char is '(' to track number of paranthesis
                            beq $t2, 41, Paranthesis_tracker        #branch if teh char is ')' to track number of paranthesis
          
                 Continue:
                            add $t4, $zero, $t2                     #copy the value in $t2 to $t4          
                            add $t3, $s0, $a1                       #addr of x[i] in $t3
                            sb  $t2, 0($t3)                         #x[i] = y[i]
                            beq $t2, $zero, even_paranthesis_check  #branch if the there are no more characters left to check even paranthesis
                            addi $s0, $s0, 1                        #i = i + 1
                            j L1                                    #next iteration of loop
          
                       L2: 
                            lw  $s0, 0($sp)                         #restore saved $s0
                            addi $sp, $sp, 8                        #pop 2 items from stack
                            jal Evaluate_expression                  #jump and link to print 'valid input' message
       
      Paranthesis_tracker:
                            addi $t6, $t6, 1                        #increment the number of paranthesis
                            jal Continue                            #jump and link continue
          
   even_paranthesis_check:
                            div  $t6, $s4                           #divide the number of paranthesis by 2
                            mfhi $t7                                #move reminder from division to register $t7
                            bne $t7, $zero, Print_error             #branch if the remainder is not equal to 0 to print 'invalid input' message
                            add $t7, $zero, $zero                   #reset the register $t7 to 0
                            jal L2                                  #jump and link L2
          
         more_error_check:
                            sub $t5, $t2, $t4                       #subtract previous character from current character 
                            beq $t5, 7, Print_error                 #branch to print 'Invalid input' message if error ' (/ ' is found  
                            beq $t5, 2, Print_error                 #branch to print 'Invalid input' message if error ' (* ' is found
                            beq $t5, 1, Print_error                 #branch to print 'Invalid input' message if error ' () ' is found
                            beq $t5, -6, Print_error                #branch to print 'Invalid input' message if error ' /) ' is found
                            beq $t5, 0, double_error                #branch to check double if ' // ' and ' ** ' were found
                            beq $t5, -5, Print_error                #branch to print 'Invalid input' message if error ' /* ' is found
                            beq $t5, 4 Print_error                  #branch to print 'Invalid input' message if error ' +/ ' is found
                            beq $t5, -1 Print_error                 #branch to print 'Invalid input' message if error ' +* ' is found
                            beq $t5, -2 Print_error                 #branch to print 'Invalid input' message if error ' +) ' is found
                            beq $t5, 2 Print_error                  #branch to print 'Invalid input' message if error ' -/ ' is found
                            beq $t5, -3 Print_error                 #branch to print 'Invalid input' message if error ' -* ' is found
                            beq $t5, -4 Print_error                 #branch to print 'Invalid input' message if error ' +) ' is found
                            beq $t5, 5, Print_error                 #branch to print 'Invalid input' message if error ' */ ' is found
                            beq $t5, -1, Print_error                #branch to print 'Invalid input' message if error ' */ ' is found
                            add $t5, $zero, $zero                   #reset register $t5 to 0 
                            jal again                               #jump and link again
          
              no_operator:
                            beq $t4, 43, again                      #branch if the current char is ' ( ' and previous char is ' + '   
                            beq $t4, 45, again                      #branch if the current char is ' ( ' and previous char is ' - '                      #branch if the previous char is '+'   
                            beq $t4, 42, again                      #branch if the current char is ' ( ' and previous char is ' * '   
                            beq $t4, 47, again                      #branch if the current char is ' ( ' and previous char is ' / '   
                            beq $t4, 61, again                      #branch if the current char is ' ( ' and previous char is ' = '   
                            beq $t4, $zero, again                   #branch if the current char is ' ( ' and previous char is ' null '   
                            jal Print_error                         #else branch to print 'Invalid input' message 
          
digit_before_space_check:
                           sub $t5, $t4, $t2                        #subtract current char from previous char and store the result in register $t5
                           beq $t5, 16, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 17, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 18, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 19, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 20, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 21, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 22, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 23, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 24, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           beq $t5, 25, space_tracker               #branch to track number space digit combination if the char before space is a digit
                           jal again                                #else jump and link again
          
 digit_after_space_check:  
                           addi $t0, $t0, 1
                           #add $s1, $s1, $t5
                           #beq $t9, 2, Number          
                           sub $t5, $t2, $t4                        #subtract previous char from current char and store the result in register $t5
                           beq $t5, 16, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 17, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 18, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 19, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 20, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 21, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 22, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 23, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 24, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           beq $t5, 25, space_tracker               #branch to track number space digit combination if the char after space is a digit
                           
                           jal begin                                #else jump and link again
          
                Number:
                           #mult $s1, 
          
           space_tracker:
                           addi $t8, $t8, 1                         #increment space tracker
                           beq $t8, 2, Print_error                  #branch to print 'Invalid input' message if space tracker number is 2
                           jal again                                #else jump and link again
          
            double_error:
                           beq $t2, 42, Print_error                 #branch to print 'Invalid input' message if error ' ** ' is found
                           beq $t2, 47, Print_error                 #branch to print 'Invalid input' message if error ' // ' is found
                           jal again                                #else jump and link again

          Print_error:                   
                           add $a0, $zero, $zero                   #clear register $a0 by storing 0 in it
                           li $v0, 4                               #load constant 4 in $v0 to print
                           la $a0, error                           #load the data from data label 'error' to register $a0
                           syscall                                 #execute print
                           j main                                  #jump to main unconditionally
                       
             operand_pop:  
                           addi $t9, $t9, 1
                           beq $t9, 2, second_operator_pop
                           lw $s5, 0($a1)                          
                           move $s3, $s5
                           move $t0, $t2  
                           jal again         
     second_operator_pop:
                           
                         
      Evaluate_expression:  
                           #beq $t0, 
                           lw $s5, 0($a1)
                           move $s6, $s5
                           add $s7, $s5, $s6

                           j main                                 #jump to main unconditionally      
                               

          

