# frozen_string_literal: true

class CashMachine
  FILE_PATH = 'balance.txt'
  DEFAULT_BALANCE = 100.0

  def initialize
    @balance = read_balance
  end

  def display_balance
    puts "======== Ваш текущий баланс: #{@balance} руб. ========"
  end

  def read_balance
    if File.exist?(FILE_PATH)
      File.read(FILE_PATH).to_f
    else
      DEFAULT_BALANCE
    end
  end

  def deposit
    puts 'Введите сумму депозита: '
    amount = gets.chomp.to_f

    while amount <= 0
      puts 'Сумма депозита должна быть больше нуля!'
      amount = gets.chomp.to_f
    end

    @balance += amount
    display_balance
  end

  def withdraw
    puts 'Введите сумму, которую хотите вывести: '
    loop do
      amount = gets.chomp.to_f
      if amount <= 0
        puts 'Введите число больше ноля!'
      elsif amount <= @balance
        @balance -= amount
        puts "Ваш баланс после вывода: #{@balance} руб."
        break
      else
        puts 'Денег на счете недостаточно!'
      end
    end
  end

  def quit
    File.write(FILE_PATH, @balance)
    puts 'До свидания!'
  end

  def self.init
    machine = CashMachine.new
    machine.run
  end

  def run
    loop do
      puts '======== Меню ========='
      puts 'Введите B/b чтобы посмотреть текущий баланс'
      puts 'Введите D/d чтобы пополнить счет'
      puts 'Введите W/w чтобы вывести деньги'
      puts 'Введите Q/q чтобы выйти'

      choice = gets.chomp

      case choice
      when 'B', 'b'
        display_balance
      when 'D', 'd'
        deposit
      when 'W', 'w'
        withdraw
      when 'Q', 'q'
        quit
        break
      else
        puts 'Неправильный выбор!'
      end
    end
  end
end

CashMachine.init
