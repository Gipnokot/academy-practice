# frozen_string_literal: true

class CashMachine
  FILE_PATH = 'balance.txt'
  DEFAULT_BALANCE = 100.0

  def initialize
    @balance = read_balance
  end

  def deposit(amount)
    if amount.positive?
      @balance += amount
      save_balance
      { success: "Депозит успешно выполнен. Новый баланс: #{@balance} руб." }
    else
      { error: 'Сумма депозита должна быть больше нуля!' }
    end
  end

  def withdraw(amount)
    # Используем positive? для проверки, что сумма больше нуля
    return { error: 'Сумма вывода должна быть больше нуля!' } unless amount.positive?

    # Проверяем, хватает ли средств на счете
    if amount <= @balance
      @balance -= amount
      save_balance
      { success: "Вывод успешен. Ваш новый баланс: #{@balance} руб." }
    else
      { error: 'Денег на счете недостаточно!' }
    end
  end

  attr_reader :balance

  private

  def read_balance
    File.exist?(FILE_PATH) ? File.read(FILE_PATH).to_f : DEFAULT_BALANCE
  end

  def save_balance
    File.write(FILE_PATH, @balance)
  end
end
