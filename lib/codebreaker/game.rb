 module Codebreaker
 puts "\n\n\n<<<<<Welcome to logic game Codebreaker>>>>\n\n\n"
  class Game
    def initialize
      @secret_code = ""
      @turns = 5
      @hint = 1
    end

    def generate
      4.times do
        @secret_code += rand(1..6).to_s
      end
    end

    def load
      loop do
        if @turns > 0
          if @turns == 5
            puts "Codebreaker is a logic game in which a code-breaker tries \nto break a secret code created by a code-maker."
            puts "\nYou can use the hint. Just enter 'hint'\n\n"
          end
          
          puts "You have #{@turns} attempts to guess the secret code"
          puts "Enter your code(4 numbers from 1 to 6): "
          input_code = gets.chomp
          if valid?(input_code)
            if user_code(input_code) == "++++"
              save_result("log.txt")
              puts "You won!"
              play_again
              return
            
              else
              puts user_code(input_code)
            end
          elsif input_code == "hint" && @hint > 0
            puts hint
            @hint = 0
          else
            puts "Not valid code.Try again!"
          end
          @turns = @turns-1
        else
          puts "You lose. Code is #{@secret_code} Game over.\n\n"
          play_again
          break
          
           
        end
      end
    end
    
    def user_code(param)
      res = ""

      param.chars.each_with_index do |value, index|
        if value == @secret_code[index]
          res += '+'
        elsif @secret_code.include? value
          res += '-'
        end
      end

      return res
    end

    def hint
      res = ""
      random_hint = rand(0..3)
      @secret_code.chars.each_with_index do |value, index|
        if index == random_hint
          res += value
        else
          res += '*'
        end
      end

      return res
    end

    def save_result(file)
      time = Time.now
      File.open(file, 'a') { |f| f.puts("Пользователь угадал число: #{@secret_code} \n #{time} ") }
    end

    def valid?(code)
      code =~ /^[1-6]{4}$/
    end
            
    def play_again
    puts "Do you want to continue? y/n"
    answer = gets.chomp.downcase
       
    if answer == "y"
    puts "<<<Glad to see you again>>>"
    game = Game.new
    game.generate
    game.load 
    else 
    if answer == "n" then exit
    end
      
       end

    end
  end
  end
