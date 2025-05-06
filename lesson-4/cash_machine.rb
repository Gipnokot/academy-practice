FILE_PATH = 'balance.txt'
BALANCE = 100.0

def display_balance(current_balance)
  puts "========Ваш текущий баланс: #{current_balance} руб.========"
end

def read_balance
  if File.exist?(FILE_PATH)
    File.read(FILE_PATH).to_f
  else
    BALANCE
  end
end

def deposit(current_balance)
  puts 'Введите сумму депозита: '
  enter_cash = gets.chomp.to_f
  while enter_cash <= 0
    puts 'Сумма депозита должна быть больше нуля!'
    enter_cash = gets.chomp.to_f
  end
  current_balance += enter_cash
  display_balance(current_balance)
  current_balance
end

def withdraw(current_balance)
  puts 'Введите сумму, которую хотите вывести: '
  loop do
    amount_to_withdraw = gets.chomp.to_f
    if amount_to_withdraw.positive?
      if amount_to_withdraw <= current_balance
        current_balance -= amount_to_withdraw
        puts "Ваш баланс после вывода: #{current_balance} руб."
        break
      else
        puts 'Денег на счете недостаточно!'
      end
    else
      puts 'Введите число больше ноля!'
    end
  end
  current_balance
end

def quit(current_balance)
  File.write(FILE_PATH, current_balance)
  puts 'До свидания!'
end

def main
  current_balance = read_balance(FILE_PATH)
  loop do
    puts '======== Меню ========='
    puts 'Введите B/b чтобы посмотреть текущий баланс'
    puts 'Введите D/d чтобы пополнить счет'
    puts 'Введите W/w чтобы вывести деньги'
    puts 'Введите Q/q чтобы выйти'
    choice = gets.chomp
    case choice  
    when 'B', 'b'
      display_balance(current_balance)
    when 'D', 'd'
      current_balance = deposit(current_balance)
    when 'W', 'w'
      current_balance = withdraw(current_balance)
    when 'Q', 'q'
      quit(current_balance)
      break
    else
      puts 'Неправильный выбор!'
    end
  end
end

main
