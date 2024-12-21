# frozen_string_literal: true

class CashMachine
  FILE_PATH = 'balance.txt'
  DEFAULT_BALANCE = 100.0

  def initialize
    @balance = read_balance
  end

  def deposit(amount)
    if amount <= 0
      { error: 'Сумма депозита должна быть больше нуля!' }
    else
      @balance += amount
      save_balance
      { success: "Депозит успешно выполнен. Новый баланс: #{@balance} руб." }
    end
  end

  def withdraw(amount)
    if amount <= 0
      { error: 'Сумма вывода должна быть больше нуля!' }
    elsif amount <= @balance
      @balance -= amount
      save_balance
      { success: "Вывод успешен. Ваш новый баланс: #{@balance} руб." }
    else
      { error: 'Денег на счете недостаточно!' }
    end
  end

  def balance
    @balance
  end

  private

  def read_balance
    File.exist?(FILE_PATH) ? File.read(FILE_PATH).to_f : DEFAULT_BALANCE
  end

  def save_balance
    File.write(FILE_PATH, @balance)
  end
end
