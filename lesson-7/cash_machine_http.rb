# frozen_string_literal: true

class CashMachine
  FILE_PATH = 'balance.txt'
  DEFAULT_BALANCE = 100.0

  def initialize
    @balance = read_balance
  end

  def deposit(amount)
    unless amount.positive?
      { error: 'Сумма депозита должна быть больше нуля!' }
    else
      @balance += amount
      save_balance
      { success: "Депозит успешно выполнен. Новый баланс: #{@balance} руб." }
    end
  end

  def withdraw(amount)
    # Используем positive? для проверки, что сумма больше нуля
    unless amount.positive?
      return { error: 'Сумма вывода должна быть больше нуля!' }
    end

    # Проверяем, хватает ли средств на счете
    if amount <= @balance
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
