require 'rubygems'
require 'faker'
require 'simple_xlsx'
require 'active_support'

SimpleXlsx::Serializer.new("transactions_#{Time.now.to_i}.xlsx") do |doc|
  doc.add_sheet("Transactions") do |sheet|
    sheet.add_row(
      %w{id client_id client_name description transaction_date quantity}
    )

    dates = (14..30).to_a

    clients = []
    (1..10_000).step(1) do |n|
      clients << [n, Faker::Name.name]
    end

    (1..40_000).step(1) do |n|
      client = clients.sample

      sheet.add_row(
        [
          n,
          client[0], client[1],
          Faker::Lorem.sentence,
          Faker::Time.backward(dates.sample).iso8601,
          Faker::Number.decimal(5, 4)
        ]
      )
    end
  end
end
