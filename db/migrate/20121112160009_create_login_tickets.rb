class CreateLoginTickets < ActiveRecord::Migration
  def change
    create_table :login_tickets do |t|
      t.string :ticket

      t.timestamps
    end
  end
end
