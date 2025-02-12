# frozen_string_literal: true

require 'rack'
require 'webrick'
require_relative 'cash_machine_http'

class RackApp
  def initialize
    @cash_machine = CashMachine.new
  end

  def call(env)
    req = Rack::Request.new(env)
    path = req.path_info
    params = req.params

    response = process_request(path, params)

    [response[:status], response[:headers], [response[:body]]]
  end

  private

  def process_request(path, params)
    case path
    when '/'
      handle_root_request
    when '/balance'
      handle_balance_request
    when '/deposit'
      handle_deposit_request(params)
    when '/withdraw'
      handle_withdraw_request(params)
    else
      handle_unknown_path
    end
  end

  def handle_root_request
    body = <<~TEXT
    Добро пожаловать в банкомат! Используйте следующие маршруты:
    /balance - Просмотреть баланс
    /deposit?value=СУММА - Внести деньги
    /withdraw?value=СУММА - Снять деньги
  TEXT
    {
      status: 200,
      headers: { 'content-type' => 'text/plain; charset=utf-8' },
      body: body
    }
  end

  def handle_balance_request
    balance = @cash_machine.balance.round(2)
    body = "Ваш баланс: #{balance} RUB"
    {
      status: 200,
      headers: { 'content-type' => 'text/plain; charset=utf-8' },
      body: body
    }
  end

  def handle_deposit_request(params)
    if params['value']
      amount = params['value'].to_f
      if amount.positive?
        @cash_machine.deposit(amount)
        message = "Внесено #{format('%.2f', amount)} RUB."
        status = 200
      else
        message = "Сумма для внесения должна быть положительной."
        status = 400
      end
    else
      message = "Пожалуйста, укажите параметр 'value' для внесения денег.\nПример: /deposit?value=100"
      status = 400
    end
    {
      status: status,
      headers: { 'content-type' => 'text/plain; charset=utf-8' },
      body: message
    }
  end

  def handle_withdraw_request(params)
    if params['value']
      amount = params['value'].to_f
      if amount.positive?
        if @cash_machine.withdraw(amount)
          message = "Снято #{format('%.2f', amount)} RUB."
          status = 200
        else
          message = "Недостаточно средств для снятия #{format('%.2f', amount)} RUB."
          status = 400
        end
      else
        message = "Сумма для снятия должна быть положительной."
        status = 400
      end
    else
      message = "Пожалуйста, укажите параметр 'value' для снятия денег.\nПример: /withdraw?value=50"
      status = 400
    end
    {
      status: status,
      headers: { 'content-type' => 'text/plain; charset=utf-8' },
      body: message
    }
  end

  def handle_unknown_path
    body = 'Неизвестный путь!'
    {
      status: 404,
      headers: { 'content-type' => 'text/plain; charset=utf-8' },
      body: body
    }
  end

end
