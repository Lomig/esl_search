class AddDescpToConsultations < ActiveRecord::Migration[5.0]
  def change
    add_column :consultations, :consult_desc, :text
  end
end
