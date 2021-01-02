class AddRequestRefToClaims < ActiveRecord::Migration[6.0]
  def change
    add_reference :claims, :request, foreign_key: true
  end
end
